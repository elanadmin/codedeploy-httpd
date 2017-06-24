#!/bin/bash

apt-get update -y
apt-get install -y apache2 lsof

service apache2 start
update-rc.d apache2 enable
