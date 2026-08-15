FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

COPY tools/maria_init.sh /maria_init.sh
COPY ./conf/server.cnf /etc/mysql/mariadb.conf.d/server.cnf
RUN chmod +x /maria_init.sh

EXPOSE 3306

ENTRYPOINT [ "/maria_init.sh" ]
CMD ["mariadbd"]
