#!/bin/bash

apt-get update -y || yum -y update
apt-get install -y apache2 lsof || yum -y install httpd lsof

service apache2 start || service httpd start
update-rc.d apache2 enable || chkconfig httpd on
