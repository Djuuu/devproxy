#!/bin/bash

# cd to deploy script directory
cd "$( dirname "${BASH_SOURCE[0]}" )"

# source environment file
. ./.env

# Create directories
[ ! -d "${NGINX_PROXY_SITES_PATH}" ]  && mkdir -p ${NGINX_PROXY_SITES_PATH}
[ ! -d "${NGINX_PROXY_VHOSTS_PATH}" ] && mkdir -p ${NGINX_PROXY_VHOSTS_PATH}
[ ! -d "${NGINX_PROXY_CERT_PATH}" ]   && mkdir -p ${NGINX_PROXY_CERT_PATH}

# Generate SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout ${NGINX_PROXY_CERT_PATH}/${NGINX_PROXY_CERT_NAME}.key \
        -out    ${NGINX_PROXY_CERT_PATH}/${NGINX_PROXY_CERT_NAME}.crt
