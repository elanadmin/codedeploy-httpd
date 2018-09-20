#!/bin/bash


if [ -f /etc/redhat-release ];then
service httpd restart
chkconfig httpd on
else
service apache2 start
update-rc.d apache2 enable
fi
