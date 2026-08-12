#!/bin/sh
set -eu

RED='\033[0;31m'
GREEN='\033[0;32m'
BWHITE='\033[1;37m'
DEFAULT='\033[0m'

# TEST PURPOSES ONLY!!! TODO: REMOVE BEFORE FINAL PUSH!
MYSQL_DATABASE=wordpressdb
MYSQL_USER=wordpressdbuser
MYSQL_PASSWORD=wordpressdbpassword
MYSQL_HOSTNAME=mariadb
DOMAIN_NAME=localhost
TITLE=Inception
WP_ADMIN_USER=admin
WP_ADMIN_PASS=adminpassword
WP_USER=user
WP_PASS=userpassword

# Define the target path for WP-CLI operations so it works inside the WordPress directory.
AV_PATH="--path=/var/www/html/wordpress"

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

# Generate an actual wp-config.php from the sample file using environment variables.
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/html/wordpress/wp-config-sample.php
	cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
fi

# Install WordPress using the configured domain and admin credentials.
wp core install --url=https://"${DOMAIN_NAME}" --title="${TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASS}" --admin_email=dnantet@student.42angouleme.fr --allow-root ${AV_PATH}

# Create a regular contributor user for the site.
wp user create "${WP_USER}" "${WP_USER}@inception.42angouleme.fr" --user_pass="${WP_PASS}"  --role=contributor ${AV_PATH} 2>/dev/null

# Replace the shell with the original container command so PHP-FPM starts normally.
exec "$@"
