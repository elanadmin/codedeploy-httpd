#!/bin/bash

###############WEBTYPE##################
#webtype:
#  RedHat Family Options: [httpd|nginx]
#  Ubuntu Family Options: [httpd|nginx]
########################################

# Restart WebServer.
webtype=httpd
hname=$(hostname -f)
date=$(date +%Y%m%d_%H%M%S)

echo -e "\nRunning WebServer Setup on $hname ...\n"

systemd_path=$(which systemctl)

########################################################################################

Service_OS() {

  echo -e "\nDetected OperatingSystem : $OS for $hname ...\n"

  service=$1
  action=$2
  atboot=$3

  if [ "$OS" = "RedHat" ];then
    if [ -n "$systemd_path" ];then
      systemctl $action $service
      systemctl $atboot $service
    else
      [ "$atboot" = "enable" ] && atboots=on || atboots=off
      service $service $action
      chkconfig $service $atboots
    fi
  elif [ "$OS" = "Ubuntu" ];then
    if [ -n "$systemd_path" ];then
      systemctl $action $service
      systemctl $atboot $service
    else
      service  $service $action
      update-rc.d $service $atboot
    fi
  fi
}

RedHat_Web() {
  yum repolist
  yum -y install $webtype lsof ruby2.0 aws-cli curl
  Service_OS $webtype restart enable
}

Ubuntu_Web() {
  apt-get update
  apt-get install -y $webtype lsof ruby2.0 awscli curl
  Service_OS $webtype restart enable
}

###########################################################################################
#Install WebServer

if [ -f /etc/redhat-release ];then
  export OS=RedHat
  RedHat_Web
elif [ -f /etc/debconf.conf ];then
  if [ $webtype = "httpd" ];then
    export webtype=apache2
  fi
  export OS=Ubuntu
  Ubuntu_Web
else
  echo -e "Web Install NOT Supported on this Platform ...\n"
  export OS=unknown
  exit
fi

if [ "$webtype" = "nginx" ];then
  index="/usr/share/nginx/html"
else
  index="/var/www/html"
fi

for var in webtype hname date
do
 eval sed -i "s/$var/\$${var}/g" $index/index.html
done

###########################################################################################
