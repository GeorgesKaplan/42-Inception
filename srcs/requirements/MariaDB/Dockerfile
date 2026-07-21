FROM alpine:3.24

RUN apk update && apk add --no-cache mariadb mariadb-client && \
    mkdir -p /run/mysqld /docker-entrypoint-initdb.d && \
    chown -R mysql:mysql /run/mysqld

COPY ./srcs/requirements/MariaDB/config/ /etc/mysql/
COPY ./srcs/requirements/MariaDB/utils/init.sql.template /docker-entrypoint-initdb.d/
COPY ./srcs/requirements/MariaDB/utils/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]