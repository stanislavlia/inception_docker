#!/bin/bash

# Display available services in the container
echo "Available services in container:"
service --status-all

# Start MariaDB service
echo "Starting MariaDB service..."
service mariadb start

# Wait for MariaDB to fully start
echo "Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

# Create the admin user using environment variables
echo "Creating Admin User: $MARIADB_ADMIN_LOGIN"
mysql -u root -e "CREATE USER IF NOT EXISTS '${MARIADB_ADMIN_LOGIN}'@'%' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO '${MARIADB_ADMIN_LOGIN}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Leave MariaDB running in the foreground
echo "MariaDB setup complete. Running MariaDB in the foreground."

exec mysqld_safe
