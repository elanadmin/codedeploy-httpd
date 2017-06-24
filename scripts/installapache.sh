#!/bin/bash

apt-get update -y
apt-get install -y apache2 lsof

service apache2 start
update-rc.d apache2 enable

[ -f /var/www/html/index.html ] && rm -rf /var/www/html/index.html
