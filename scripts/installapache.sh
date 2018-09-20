#!/bin/bash

if [ -f /etc/redhat-release ];then
yum install epel-release
yum install httpd
service httpd start
chkconfig httpd on
else
apt-get update -y
apt-get install -y apache2 lsof
service apache2 start
update-rc.d apache2 enable
fi

[ -f /var/www/html/index.html ] && rm -rf /var/www/html/index.html
