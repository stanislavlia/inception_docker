FROM debian:stable-20240926

RUN apt-get update && apt-get install -y mariadb-server procps vim 

# Remove default config
RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/50-server.conf /etc/mysql/mariadb.conf.d
COPY tools/db-setup.sh db-setup.sh

# Make db-setup.sh executable
RUN chmod +x db-setup.sh

# Stop signal for proper shutdown
STOPSIGNAL SIGQUIT

# Expose the default MariaDB port
EXPOSE 3306

# Use the db-setup.sh script as the entry point
ENTRYPOINT [ "sh", "./db-setup.sh" ]


