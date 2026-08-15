FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install -y curl php-fpm php-mysql mariadb-client

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d
COPY ./tools/install.sh /usr/local/bin/install.sh
RUN chmod +x /usr/local/bin/install.sh

RUN mkdir -p /run/php && chown www-data:www-data /run/php

EXPOSE 9000
WORKDIR /var/www/html/
ENTRYPOINT ["/usr/local/bin/install.sh"]
