#!/bin/sh

# Generate a self-signed SSL certificate if it doesn't exist
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "Generating self-signed SSL certificate..."
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=$CERT_COUNTRY/ST=$CERT_STATE/L=$CERT_CITY/O=$CERT_ORG/CN=$DOMAIN_NAME"
fi

# Replace placeholder in NGINX config with the value of DOMAIN_NAME environment variable
sed -i "s/<server_name_placeholder>/${DOMAIN_NAME:-localhost}/g" /etc/nginx/http.d/default.conf

# Start NGINX in the foreground
echo "Starting NGINX..."
nginx -g "daemon off;"
