#!/bin/bash

mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/dnantet.42.fr.crt ] || [ ! -f /etc/nginx/ssl/dnantet.42.fr.key ]; then
	openssl req -x509 -nodes \
		-days 365 \
		-newkey rsa:2048 \
		-keyout /etc/nginx/ssl/dnantet.42.fr.key \
		-out /etc/nginx/ssl/dnantet.42.fr.crt \
		-subj "/C=FR/ST=Charente/L=Angouleme/O=42/OU=student/CN=dnantet.42.fr" > /dev/null 2> /dev/null
fi

exec "$@"
