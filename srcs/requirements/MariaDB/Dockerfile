FROM alpine:3.24

RUN apk update && apk add --no-cache mariadb mariadb-client gettext && \
	mkdir -p /run/mysqld /docker-entrypoint-initdb.d && \
	chown -R mysql:mysql /run/mysqld

COPY ./config/ /etc/mysql/
COPY ./utils/init.sql.template /docker-entrypoint-initdb.d/
RUN mkdir -p /usr/local/bin/
COPY ./utils/entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN ls /usr/local/bin/entrypoint.sh > /home/dnantet/Documents/test.log

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mariadbd"]
