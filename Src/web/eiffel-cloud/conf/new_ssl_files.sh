#!/bin/sh

# See Also: https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs

openssl req -newkey rsa:2048 -nodes -keyout local.key -x509 -days 365 -out local.crt 
