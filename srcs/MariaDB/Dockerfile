FROM alpine:3.24

RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

COPY ./srcs/MariaDB/conf/ /etc/mysql/

EXPOSE 3306

# Start MariaDB server when container launches
CMD ["mysqld"]
