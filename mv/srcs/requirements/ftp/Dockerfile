# Dockerfile for FTP based on Alpine
FROM alpine:3.14

# Install vsftpd
RUN apk update && apk add --no-cache vsftpd

# Copy vsftpd configuration file
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

# Expose FTP port and passive mode ports
EXPOSE 21
EXPOSE 21100-21110

# Configure FTP server, set up user and permissions at runtime
CMD adduser -D -h /var/www/html ftpuser && \
    echo "ftpuser:$(cat /run/secrets/ftp_password)" | chpasswd && \
    chown -R ftpuser:ftpuser /var/www/html && \
    vsftpd /etc/vsftpd/vsftpd.conf
