#!/usr/bin/env bash

set -ex

apt-add-repository ppa:nginx/stable #for latest stable nginx version
apt-get update
apt-get install nginx -y

SSL_FOLDER=/etc/nginx/ssl
SHARED_FOLDER=/vagrant/shared

mkdir -p $SSL_FOLDER

#remove files which will be linked from our shared folder
for i in \
/etc/nginx/sites-available/default \
$SSL_FOLDER/ssl-test.matthias-brandt.de.crt \
$SSL_FOLDER/ssl-test.matthias-brandt.de.key \
/var/log/nginx \
; do
    [ -e $i ] && rm -rf $i
done

ln -s $SHARED_FOLDER/nginx-config                    /etc/nginx/sites-available/default
ln -s $SHARED_FOLDER/ssl-test.matthias-brandt.de.crt $SSL_FOLDER/ssl-test.matthias-brandt.de.crt
ln -s $SHARED_FOLDER/ssl-test.matthias-brandt.de.key $SSL_FOLDER/ssl-test.matthias-brandt.de.key
ln -s $SHARED_FOLDER/logs                            /var/log/nginx

service nginx restart