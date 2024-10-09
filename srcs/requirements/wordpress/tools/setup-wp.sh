#!/bin/bash

#Guide reference: https://github.com/Forstman1/inception-42


#create default folders for serving content
mkdir /var/www /var/www/html


cd /var/www/html
#removing default files if there are ones
if [ "$(ls -A  /var/www/html)" ]; then
    echo "Default WP dir is not empty; cleaning..."
    rm -rf * 

else
    echo "Default WP dir already empty"
fi


curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 