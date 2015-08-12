#!/bin/bash

set -e
set -o xtrace

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client
echo "mysql-server mysql-server/root_password password ${PASSWD}" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password ${PASSWD}" | sudo debconf-set-selections
sudo apt-get -y install mysql-server ${PASSWD}
sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n ${PASSWD} ${DB_IP}
sudo ln -s /usr/share/wordpress /var/www/wordpress
echo "ServerName localhost" | sudo tee /etc/apache2/httpd.conf
echo "ServerName localhost" | sudo tee /etc/apache2/conf.d/fqdn