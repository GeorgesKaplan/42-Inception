FROM alpine:3.24

RUN apk update && apk add --no-cache curl php-fpm php-mysqli && \
	addgroup -S www-data || true && \
	adduser -D -S -G www-data www-data || true && \
	mkdir -p /run/php /etc/php/8.2/fpm/pool.d && \
	chown -R www-data:www-data /run/php

COPY ./config/www.cnf /etc/php/8.2/fpm/pool.d
WORKDIR /var/www/html

COPY ./utils/install.sh .
RUN chmod +x install.sh

EXPOSE 9000

ENTRYPOINT ["/var/www/html/install.sh"]
CMD ["php-fpm8.2", "-F"]
