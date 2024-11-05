# Start with a minimal Alpine image
FROM alpine:3.14

# Install PHP and necessary extensions
RUN apk update && apk add --no-cache \
    php7 \
    php7-json \
    php7-session \
    php7-mysqli \
    php7-pdo_mysql \
    php7-mbstring \
    php7-iconv \
    php7-openssl \
    php7-curl \
    curl

RUN mkdir -p /var/www/html && \
    curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o /var/www/html/index.php

# Expose the Adminer port
EXPOSE 8080

# Start PHP's built-in web server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
