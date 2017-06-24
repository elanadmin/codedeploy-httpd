#!/bin/bash

service apache2 restart || service httpd restart
update-rc.d apache2 enable || chkconfig httpd on
