INSTALL)
sudo apt-get install subversion cvs p7zip-full unzip
sudo apt-get install patch indent
sudo apt-get install apache2
sudo apt-get install php5
sudo apt-get install libapache2-mod-php5
sudo apt-get install php5-gd 
sudo apt-get install mysql-server mysql-client php5-mysql
sudo a2enmod rewrite
#sudo a2enmod ssl
sudo /etc/init.d/apache2 restart

cd ~/
svn co https://svn.eiffel.com/eiffelstudio/trunk/Documentation/tools/web/trunk eiffeldoc
cd /var/wwww
ln -s ~/eiffeldoc/drupal/ p
cd ~/
cd eiffeldoc/bin
#edit etc/init_vars.sh  to set adapted values
sh ./eiffeldoc_install.sh

# then restore backup if available
# there is no initial settings yet ... (use the backup)


1) backup and restore
You should execute the eiffeldoc_backup and eiffeldoc_restore scripts using sudo
  in order to preserver the permissions and then the ownership.

2)...

