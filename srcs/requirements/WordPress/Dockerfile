FROM alpine:3.24.0

RUN apk update && apk add --no-cache \
	curl \
	php \
	php-fpm \
	php-cli \
	php-mysqli

# RUN addgroup -S www-data && adduser -D -S -G www-data www-data
RUN mkdir -p /run/php && chgrp www-data:www-data /run/php
COPY ./config/www.conf /etc/php8/php-fpm.d/
WORKDIR /var/www/html

COPY ./utils/install.sh /usr/local/bin/install.sh
RUN chmod +x /usr/local/bin/install.sh

EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/install.sh"]
CMD ["/usr/bin/php-fpm8", "-F"]
