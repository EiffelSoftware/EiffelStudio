#!/bin/sh

apt-get install subversion cvs p7zip-full unzip
apt-get install patch indent
apt-get install apache2
apt-get install php5
apt-get install libapache2-mod-php5
apt-get install php5-gd 
apt-get install mysql-server mysql-client php5-mysql
a2enmod rewrite
#a2enmod ssl

cd /var/www
mkdir eiffeldoc
cd eiffeldoc
mkdir static
mkdir _tools_
chown www-data:www-data -R .
ln -s ~/eiffeldoc/drupal/ _main
ln -s ~/eiffeldoc/drupal_sandbox/drupal/ _sandbox
cd /etc/apache2/sites-enabled
rm *
ln -s ~/eiffeldoc/misc/settings/apache2/eiffeldoc eiffeldoc

/etc/init.d/apache2 restart
cd ~/eiffeldoc/bin
