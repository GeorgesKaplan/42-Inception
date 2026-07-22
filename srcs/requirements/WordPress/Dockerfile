FROM alpine:3.24

RUN apk update && apk add --no-cache curl php8 php8-cli php8-fpm php8-mysqli && \
	addgroup -S www-data || true && \
	adduser -D -S -G www-data www-data || true && \
	mkdir -p /run/php /etc/php8/php-fpm.d/ && \
	chown -R www-data:www-data /run/php

COPY ./config/www.conf /etc/php8/php-fpm.d/
WORKDIR /var/www/html

COPY ./utils/install.sh .
RUN chmod +x install.sh

EXPOSE 9000

ENTRYPOINT ["/var/www/html/install.sh"]
CMD ["php-fpm8", "-F"]
