# Nginx-proxy

Working on multiple docker applications on different ports can become confusing and annoying when there are conflicting ports.

[nginx-proxy](https://github.com/jwilder/nginx-proxy) allows access to multiple containers through different hostnames on the same HTTP(S) port.

A wrapper script (`run.sh`) and a dedicated docker-compose file (`docker-compose.yml`) are included.

## Nginx-proxy usage

* Configure `NGINX_PROXY_` variables in `.env`

```dotenv
# Generate certificate for nginx-proxy (needs openssl)
NGINX_PROXY_GEN_CERT=true

# nginx-proxy sites path (relative to this directory, or absolute)
NGINX_PROXY_SITES_PATH=./nginx-proxy/sites

# nginx-proxy certificates path (relative to this directory, or absolute)
NGINX_PROXY_CERT_PATH=./nginx-proxy/certs

# nginx-proxy vhost-specific configuration files path (relative to this directory, or absolute)
NGINX_PROXY_VHOSTS_PATH=./nginx-proxy/vhosts

# nginx-proxy certificate name (vhosts TLD)
NGINX_PROXY_CERT_NAME=docker
```

* Configure your container hostnames in `.env`:
  * `DOCKER_APP_VHOST=my-project.docker`
  * `ADMINER_VHOST=adminer.docker`
  * `MAILDEV_VHOST=maildev.docker`


* Map these hostnames in your `hosts` file (`/etc/hosts` or `\Windows\System32\drivers\etc\hosts`)

```
127.0.0.1 adminer.docker
127.0.0.1 maildev.docker
127.0.0.1 my-project.docker
```

* Start the *nginx-proxy* container with the provided wrapper script:

```bash
run.sh
```

For convenience, *nginx-proxy* binds to the standard HTTP(S) port(s).

You can then access your containers through the hostnames :
* http://adminer.docker
* http://maildev.docker
* http://my-project.docker

The proxy will be automatically reloaded when containers with configured hostnames are started or stopped.
 
### SSL support

If you enable `NGINX_PROXY_GEN_CERT`, a SSL certificate will be generated in the `NGINX_PROXY_CERT_PATH` directory.

The name of the certificate (`NGINX_PROXY_CERT_NAME`) should be related to your virtualhost names <br> 
(the tld is enough, ie for `myapp.docker`, you can use `docker`) <br>
https://github.com/jwilder/nginx-proxy#ssl-support

If there is a certificate corresponding to your hostname, the virtualhost will be configured to use HTTPS.  

For more information, see https://github.com/jwilder/nginx-proxy
