#!/bin/bash

#Guide reference: https://github.com/Forstman1/inception-42


# #create default folders for serving content
# mkdir /var/www /var/www/html


# cd /var/www/html
# #removing default files if there are ones
# if [ "$(ls -A  /var/www/html)" ]; then
#     echo "Default WP dir is not empty; cleaning..."
#     rm -rf * 

# else
#     echo "Default WP dir already empty"
# fi

# # downloads the WP-CLI PHAR (PHP Archive) file from the GitHub repository. 
# # The -O flag tells curl to save the file with the same name as it has on the server.
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

# chmod +x wp-cli.phar


# #move it to PATH to run from terminal
# mv wp-cli.phar /usr/local/bin/wp #now we can use wp as command

# #download WordPress latest version
# wp core download --allow-root 

# #rename sample
# mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php


# Replace placeholders with actual DB creds
sed  -i -r "s/database_name_here/wordpress/1" wp-config.php
sed  -i -r "s/username_here/$MARIADB_ADMIN_LOGIN/1" wp-config.php
sed  -i -r "s/password_here/$MARIADB_ADMIN_PASSWORD/1" wp-config.php
sed  -i -r "s/localhost/mariadb/1" wp-config.php


cat wp-config.php




