FROM alpine:3.24

RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

EXPOSE 3306
COPY ./srcs/MariaDB/conf/ /etc/mysql/

RUN mkdir ./entrypoint-initdb.d
COPY ./utils/init.sql.template /entrypoint-initdb.d
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./utils/entrypoint.sh ./
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["mysqld"]
