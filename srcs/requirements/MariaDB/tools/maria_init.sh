#!/bin/bash

service mariadb start

while ! mysqladmin ping --silent 2>/dev/null; do
	sleep 1
done

mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* to '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root shutdown

while mysqladmin ping --silent 2>/dev/null; do
	sleep 1
done

exec mysqld --user=mysql
