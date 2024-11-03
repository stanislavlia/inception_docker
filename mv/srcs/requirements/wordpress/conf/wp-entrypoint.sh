#!/bin/sh

# Wait until the database is ready
echo "Waiting for MariaDB to be ready..."
for i in {30..0}; do
    if mysqladmin ping -h mariadb -u"${MYSQL_USER}" -p"$(cat /run/secrets/db_password)" --silent; then
        break
    fi
    echo 'MariaDB is unavailable - sleeping'
    sleep 1
done
if [ "$i" = 0 ]; then
    echo >&2 'MariaDB did not become available in time.'
    exit 1
fi

# Debugging: Check database variables
echo "Database Name: ${MYSQL_DATABASE}"
echo "Database User: ${MYSQL_USER}"
echo "Database Password: $(cat /run/secrets/db_password)"
echo "Database Host: mariadb"

# Check and create WordPress directory if it doesn't exist
if [ ! -d "/var/www/html" ]; then
  mkdir -p /var/www/html
  chown -R nobody:nobody /var/www/html
fi

# Navigate to the WordPress directory
cd /var/www/html

# Download WordPress core if not already installed
if [ ! -f index.php ]; then
  wp core download --allow-root --locale=en_US
fi

# Create wp-config.php using WP-CLI with database credentials from secrets
if [ ! -f wp-config.php ]; then
  wp config create --allow-root \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=$(cat /run/secrets/db_password) \
    --dbhost=mariadb
fi

# Install WordPress with basic configuration if not already installed
if ! wp core is-installed --allow-root; then
  wp core install --allow-root \
    --url=${WP_URL} \
    --title="Inception Project" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=$(cat /run/secrets/wp_admin_password) \
    --admin_email=${WP_ADMIN_EMAIL}
fi

# Configure Redis Cache settings for WordPress
wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root

# Start PHP-FPM to serve requests
exec php-fpm7 -F
