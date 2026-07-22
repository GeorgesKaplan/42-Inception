FROM alpine:3.24

RUN apk update && apk add --no-cache curl php-fpm php-mysqli && \
	mkdir -p /run/php && \
	chown www-data:www-data /run/php

COPY ./config/www.cnf /etc/php/8.2/fpm/pool.d
WORKDIR /var/www/html

COPY ./utils/install.sh .
RUN chmod +x install.sh

EXPOSE 9000

ENTRYPOINT ["/var/www/html/install.sh"]
CMD ["php-fpm8.2", "-F"]
