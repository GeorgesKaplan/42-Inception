FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl
RUN rm /etc/nginx/sites-enabled/default
RUN mkdir -p /etc/nginx/ssl

COPY tools/configure.sh /tmp/configure.sh
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

RUN chmod +x /tmp/configure.sh

ENTRYPOINT ["/bin/bash", "/tmp/configure.sh"]
CMD [ "nginx", "-g", "daemon off;" ]
