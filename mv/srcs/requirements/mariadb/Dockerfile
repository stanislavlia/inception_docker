FROM alpine:3.14

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY ./conf/mariadb.conf /etc/my.cnf

COPY ./conf/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

COPY ./conf/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

EXPOSE 3306

#ENV MYSQL_DATABASE=wordpress_db
#ENV MYSQL_USER=wordpress_user

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql"]






