#!/bin/sh
set -eu

if [ -f /docker-entrypoint-initdb.d/init.sql.template ]; then
  envsubst < /docker-entrypoint-initdb.d/init.sql.template > /etc/mysql/init.sql
  rm /docker-entrypoint-initdb.d/init.sql.template
fi

if [ "$1" = "mariadbd" ]; then
  if [ ! -d /var/lib/mysql/mysql ]; then
    mkdir -p /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql
    su-exec mysql mariadb-install-db --datadir=/var/lib/mysql --rpm
  fi
  exec su-exec mysql "$@"
fi

exec "$@"
