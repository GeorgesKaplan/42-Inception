#!/bin/sh
set -eu

RED='\033[0;31m'
GREEN='\033[0;32m'
BWHITE='\033[1;37m'
DEFAULT='\033[0m'

# echo "=== TEST: curl ==="
# if command -v curl >/dev/null 2>&1; then
#   curl --version | head -n 1
# else
#   echo "curl is not installed"
#   exit 1
# fi

# echo "=== TEST: php ==="
# if command -v php85 >/dev/null 2>&1; then
#   php85 -v | head -n 1
# else
#   echo "php is not installed"
#   exit 1
# fi

# Install WP-CLI only once so the container can manage WordPress from the shell.
if [ ! -f /usr/local/bin/wp ]; then
	echo -e "${BWHITE}> Installing WP-CLI...${DEFAULT}"
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	if [ ! -f /usr/local/bin/wp ]; then
		echo -e "${RED}WP-CLI installation failed.${DEFAULT}"
	else
		echo -e "${GREEN}WP-CLI successfully installed.${DEFAULT}"
	fi
fi

# Download and extract WordPress if the application has not been installed yet.
if [ ! -f /var/www/html/wordpress/index.php ]; then
	echo -e "${BWHITE}> Installing Wordpress...${DEFAULT}"
	curl -O https://wordpress.org/latest.tar.gz
	mv latest.tar.gz /tmp/wordpress.tar.gz
	tar xf /tmp/wordpress.tar.gz -C /var/www/html && rm /tmp/wordpress.tar.gz

	if [ ! -f /var/www/html/wordpress/index.php ]; then
		echo -e "${RED}WordPress installation failed.${DEFAULT}"
	else
		echo -e "${GREEN}Wordpress successfully installed.${DEFAULT}"
	fi
fi

# ./wp-cli.phar core download --allow-root
# ./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --allow-root
# ./wp-cli.phar core install --url=$DOMAIN_NAME --title=inception --admin_user=$WP_USER --admin_password=$WP_PASS --admin_email=$WP_MAIL --allow-root
# ./wp-cli.phar user create $WP_USER2 $WP_MAIL2 --role=author --user_pass=$WP_PASS2 --allow-root
# ./wp-cli.phar user set-role 2 editor --allow-root

# ./wp-cli.phar plugin install redis-cache --activate --allow-root
# ./wp-cli.phar config set WP_REDIS_HOST redis --allow-root
# ./wp-cli.phar config set WP_REDIS_PORT 6379 --allow-root

# ./wp-cli.phar plugin update --all --allow-root
# ./wp-cli.phar redis enable --allow-root

exec "$@"
