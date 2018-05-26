#!/bin/bash

# cd to current script directory
cd "$( dirname "${BASH_SOURCE[0]}" )"

# source environment file
. ./.env

# Generate SSL certificate
if [ $NGINX_PROXY_GEN_CERT = true ] && [ ! -f "${NGINX_PROXY_CERT_PATH}/${NGINX_PROXY_CERT_NAME}.crt" ]; then
    ./generate-certs.sh
fi

# Run nginx-proxy
docker-compose up -d
