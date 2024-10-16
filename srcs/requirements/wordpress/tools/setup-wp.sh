#!/bin/bash

# Replace placeholders with actual DB creds
sleep 5 #wait for db

sed  -i -r "s/database_name_here/wordpress/1" wp-config.php
sed  -i -r "s/username_here/$MARIADB_ADMIN_LOGIN/1" wp-config.php
sed  -i -r "s/password_here/$MARIADB_ADMIN_PASSWORD/1" wp-config.php
sed  -i -r "s/localhost/mariadb/1" wp-config.php


#Install & setup Wordpress
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD \
                --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root



#install different Wordpress themes
wp theme install oceanwp --activate --allow-root

#List available php-fpm installation

echo "Starting php-fpm server on port 9000"
#Run FPM server
exec /usr/sbin/php-fpm8.2 -F 
