# Dockerfile for Adminer based on Alpine
FROM alpine:3.14

# Install PHP, curl, and necessary extensions
RUN apk update && apk add --no-cache php7 php7-json php7-session php7-mysqli curl

# Download Adminer
RUN mkdir -p /var/www/html && \
    curl -o /var/www/html/index.php https://www.adminer.org/latest.php

# Expose the necessary port for internal Docker network only (no external binding)
EXPOSE 8080

# Start PHP server for Adminer
CMD ["php", "-S", "127.0.0.1:8080", "-t", "/var/www/html"]
