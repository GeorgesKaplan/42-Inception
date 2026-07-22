FROM alpine:3.24

RUN apk update && apk add --no-cache mariadb mariadb-client gettext su-exec && \
	mkdir -p /run/mysqld /docker-entrypoint-initdb.d /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./config/server.cnf /etc/mysql/my.cnf
COPY ./utils/init.sql.template /docker-entrypoint-initdb.d/
RUN mkdir -p /usr/local/bin/
COPY ./utils/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mariadbd"]
