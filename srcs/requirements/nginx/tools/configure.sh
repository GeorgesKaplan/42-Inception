#!/bin/bash

if [ ! -f /etc/nginx/cert.pem ] || [ ! -f /etc/nginx/cert.key ]; then
	mkdir -p /etc/nginx
	openssl req -x509 -nodes \
		-days 365 \
		-newkey rsa:2048 \
		-keyout  /etc/nginx/cert.key \
		-out /etc/nginx/cert.pem \
		-subj "/C=FR/ST=Paris/L=Orleans/CN=${DOMAIN_NAME}" > /dev/null 2> /dev/null
fi

exec "$@"
