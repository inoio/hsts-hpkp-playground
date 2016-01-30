#!/usr/bin/env bash

set -ex

apt-add-repository ppa:nginx/stable #for latest stable nginx version
apt-get update
apt-get install nginx -y

SSL_FOLDER=/etc/nginx/ssl
SHARED_FOLDER=/vagrant/shared

mkdir -p $SSL_FOLDER

rm /etc/nginx/sites-available/default
rm $SSL_FOLDER/ssl-test.matthias-brandt.de.crt
rm $SSL_FOLDER/ssl-test.matthias-brandt.de.key
rm -rf /var/log/nginx

ln -s $SHARED_FOLDER/nginx-config                    /etc/nginx/sites-available/default
ln -s $SHARED_FOLDER/ssl-test.matthias-brandt.de.crt $SSL_FOLDER/ssl-test.matthias-brandt.de.crt
ln -s $SHARED_FOLDER/ssl-test.matthias-brandt.de.key $SSL_FOLDER/ssl-test.matthias-brandt.de.key
ln -s $SHARED_FOLDER/logs                            /var/log/nginx

service nginx restart