FROM debian:stable-20240926

WORKDIR /

#to make it stoppable
STOPSIGNAL SIGQUIT 

RUN apt-get -y update &&\
    apt-get install -y php-fpm  php-mysql curl procps vim


#create default folders for serving content
RUN mkdir /var/www /var/www/html
WORKDIR  /var/www/html

#removing default files if there are ones
RUN rm -rf * 


# downloads the WP-CLI PHAR (PHP Archive) file from the GitHub repository. 
# The -O flag tells curl to save the file with the same name as it has on the server.
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

RUN chmod +x wp-cli.phar


#move it to PATH to run from terminal
RUN mv wp-cli.phar /usr/local/bin/wp


#download WordPress latest version
RUN wp core download --allow-root 

#rename sample
RUN mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php



COPY ./tools/setup-wp.sh /setup-wp.sh

RUN chmod +x /setup-wp.sh

ENTRYPOINT [ "bash", "/setup-wp.sh" ]
