#!/bin/bash

echo "Available services in container:"
service --status-all

echo "Starting MariaDB service..."
service mariadb start

# Wait for MariaDB to fully start
until mysqladmin ping > /dev/null 2>&1; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

# Create the admin user using the environment variables
echo "Creating Admin User:" $MARIADB_ADMIN_LOGIN

mysql -u root -e "CREATE USER IF NOT EXISTS '${MARIADB_ADMIN_LOGIN}'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';" && \
mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;" && \
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_ADMIN_LOGIN}'@'%' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';" && \
mysql -u root -e "FLUSH PRIVILEGES;"

# Stop the MariaDB service to run it safely in the foreground
echo "Stopping MariaDB service..."
service mariadb stop

# Start MariaDB in the foreground using mysqld_safe
echo "Starting MariaDB in safe mode..."
mysqld_safe
