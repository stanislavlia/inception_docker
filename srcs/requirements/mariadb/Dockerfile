FROM debian:stable-20240926


RUN apt-get update && apt-get install -y mariadb-server procps vim 

# Remove default config
RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/50-server.conf /etc/mysql/mariadb.conf.d
COPY tools/db-setup.sh db-setup.sh

# make it executable
RUN chmod +x db-setup.sh


ENTRYPOINT [ "sh", "./db-setup.sh" ]






