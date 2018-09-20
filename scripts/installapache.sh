#!/bin/bash

if [ -f /etc/redhat-release ];then
yum install -y epel-release
yum install -y httpd
service httpd start
chkconfig httpd on
else
apt-get update -y
apt-get install -y apache2 lsof
service apache2 start
update-rc.d apache2 enable
fi

if [ -f /var/www/html/index.html ];then
rm -rf /var/www/html/index.html
fi
