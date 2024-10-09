FROM debian:stable-20240926

WORKDIR /

RUN apt-get -y update &&\
    apt-get install -y php-fpm  php-mysql curl procps vim


COPY ./tools/setup-wp.sh /setup-wp.sh

RUN chmod +x setup-wp.sh

STOPSIGNAL SIGQUIT 


ENTRYPOINT [ "bash", "setup-wp.sh" ]
