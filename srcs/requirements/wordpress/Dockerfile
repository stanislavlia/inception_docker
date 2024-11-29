# Dockerfile for WordPress based on Alpine with WP-CLI
FROM alpine:3.14

# Install necessary packages for WordPress and WP-CLI
RUN apk update && \
    apk add --no-cache php7 php7-fpm php7-tokenizer php7-mysqli php7-json php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-mbstring php7-gd php7-session \
    php7-dom php7-xmlreader curl bash mysql-client

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create a directory for WordPress and set permissions
RUN mkdir -p /var/www/html && chown -R nobody:nobody /var/www/html

# Configure PHP-FPM to listen on all interfaces and pass environment variables
RUN sed -i 's/listen = 127\.0\.0\.1:9000/listen = 9000/' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/;clear_env = yes/clear_env = no/' /etc/php7/php-fpm.d/www.conf

# Copy custom wp-config.php with database and Redis settings
COPY ./conf/wp-config.php /var/www/html/wp-config.php

# Copy entrypoint script for WP-CLI setup
COPY ./conf/wp-entrypoint.sh /usr/local/bin/wp-entrypoint.sh
RUN chmod +x /usr/local/bin/wp-entrypoint.sh

# Expose the necessary port for PHP-FPM
EXPOSE 9000

# Start WP-CLI setup with the entrypoint script
ENTRYPOINT ["wp-entrypoint.sh"]
CMD ["php-fpm7", "-F"]
