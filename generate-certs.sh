#!/bin/bash

# cd to deploy script directory
cd "$( dirname "${BASH_SOURCE[0]}" )"

# source environment file
. ./.env


# Generate cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certs/${NGINX_PROXY_CERT_NAME}.key -out ./certs/${NGINX_PROXY_CERT_NAME}.crt
