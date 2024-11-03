#!/bin/sh
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal

    echo "Starting temporary MariaDB server..."
    mysqld --skip-networking --user=mysql --datadir=/var/lib/mysql &
    temp_pid=$!

    echo "Waiting for MariaDB to be ready..."
    for i in {30..0}; do
        if mysqladmin --socket=/run/mysqld/mysqld.sock ping &> /dev/null; then
            break
        fi
        sleep 1
    done
    if [ "$i" = 0 ]; then
        echo >&2 "MariaDB startup failed"
        exit 1
    fi

    echo "Setting up MariaDB users..."
    mysql --socket=/run/mysqld/mysqld.sock -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/db_root_password)';"
    mysql --socket=/run/mysqld/mysqld.sock -u root -p"$(cat /run/secrets/db_root_password)" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql --socket=/run/mysqld/mysqld.sock -u root -p"$(cat /run/secrets/db_root_password)" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';"
    mysql --socket=/run/mysqld/mysqld.sock -u root -p"$(cat /run/secrets/db_root_password)" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

    echo "Shutting down temporary MariaDB server..."
    mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"$(cat /run/secrets/db_root_password)" shutdown

    wait "$temp_pid"
fi

echo "Starting MariaDB server..."
exec "$@"
