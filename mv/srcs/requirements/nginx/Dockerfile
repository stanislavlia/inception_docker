FROM alpine:3.14

# Install NGINX and OpenSSL for TLS support
RUN apk update && \
    apk add --no-cache nginx openssl && \
    mkdir -p /run/nginx

# Copy NGINX configuration file to container
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf
COPY ./conf/fastcgi_params /etc/nginx/fastcgi_params

# # Generate a self-signed SSL certificate for NGINX
# RUN mkdir -p /etc/nginx/ssl && \
#     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#         -keyout /etc/nginx/ssl/nginx.key \
#         -out /etc/nginx/ssl/nginx.crt \
#         -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=localhost"


COPY ./conf/nginx-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port 443 for HTTPS
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
