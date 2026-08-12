FROM alpine:3.24

RUN apk update && apk add --no-cache bash nginx openssl

COPY tools/configure.sh /tmp/
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

RUN chmod +x /tmp/configure.sh

ENTRYPOINT ["ash", "/tmp/configure.sh"]
CMD [ "nginx", "-g", "daemon off;" ]
