#!/bin/bash

# Display available services in the container
echo "Available services in container:"
service --status-all

# Start MariaDB service in the background
echo "Starting MariaDB service..."
service mariadb start

# Wait for MariaDB to fully start
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

# Create the admin user using environment variables
echo "Creating Admin User:" $MARIADB_ADMIN_LOGIN

mysql -u root -e "CREATE USER IF NOT EXISTS '${MARIADB_ADMIN_LOGIN}'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_ADMIN_LOGIN}'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Stop MariaDB service (optional, depending on how you want the container to behave)
echo "Stopping MariaDB service..."
service mariadb stop

# Start MariaDB in the foreground using mysqld_safe to keep the container alive
echo "Starting MariaDB in safe mode..."
exec mysqld_safe 
