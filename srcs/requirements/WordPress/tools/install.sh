#!/bin/bash

while ! mariadb -h mariadb -u $DB_USER -p$DB_PASS -e "SELECT 1;" &> /dev/null; do
	sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar

	./wp-cli.phar core download --allow-root
	./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --allow-root
	./wp-cli.phar core install --url=$DOMAIN_NAME --title=Inception --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL --allow-root
	./wp-cli.phar user create $WP_USER2 $WP_MAIL2 --role=author --user_pass=$WP_PASS2 --allow-root
	./wp-cli.phar user set-role $WP_USER2 editor --allow-root
	./wp-cli.phar theme install astra --activate --allow-root
fi

chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

exec php-fpm8.2 -F
