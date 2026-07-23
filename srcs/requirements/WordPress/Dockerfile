FROM alpine:3.24.0

# Install required packages
RUN apk update && apk add --no-cache curl php85 php85-mysqli php85-curl php85-dom php85-exif php85-fileinfo php85-mbstring php85-zip php85-gd php85-intl php85-fpm php85-phar php85-iconv php85-pecl-imagick wget shadow ssmtp

COPY config/php-fpm.conf /etc/php85/php-fpm.conf
COPY config/www.conf /etc/php85/php-fpm.d/www.conf
COPY ./utils/install.sh /usr/local/bin/install.sh
RUN chmod +x /usr/local/bin/install.sh

RUN mkdir -p /var/www/html
RUN chgrp -R www-data /var/www/html
RUN chmod -R g+rw /var/www/html
RUN mkdir -p /run/php
RUN adduser -D -H -u 1000 -s /bin/bash www-data -G www-data


EXPOSE 9000
WORKDIR /var/www/html/
ENTRYPOINT ["/usr/local/bin/install.sh"]
CMD ["php-fpm85", "-F"]
