# install.sh
echo "This script does not work at the moment.";
exit;


if [ -x "$XEBRA_DEV" ]; then
	:
else
 	echo "XEBRA_DEV is not defined. Please define before running script.";
 	exit;
fi;

if [ -x "$EIFFEL_SRC" ]; then
	:
else
 	echo "EIFFEL_SRC is not defined. Please define before running script.";
 	exit;
fi;

if [ -x "$ISE_EIFFEL" ]; then
	:
else
 	echo "ISE_EIFFEL is not defined. Please define before running script.";
 	exit;
fi;


if [ -x "$ISE_LIBRARY" ]; then
	:
else
 	echo "ISE_LIBRARYis not defined. Please define before running script.";
 	exit;
fi;

# Install apache
sudo apt-get install apache2
sudo apt-get install apache2-threaded-dev
sudo apache2ctl stop

# Checkout xebra
cd $XEBRA_DEV
svn co https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/\

# Download and install the latest apr and apr-util
mkdir temp
cd temp
wget http://mirrors.directorymix.com/apache/apr/apr-1.3.3.tar.bz2
tar -xf apr-1.3.3.tar.bz2
cd apr-1.3.3
./configure --prefix=/usr
make
sudo make install
wget http://mirror.cc.columbia.edu/pub/software/apache/apr/apr-util-1.3.4.tar.bz2
tar -xf apr-util-1.3.4.tar.bz2
cd apr-util-1.3.4
./configure --prefix=/usr --with-apr=/usr/lib
make
sudo make install

# Compile the xebra module
cd $XEBRA_DEV/c_projects/mod_xebra
apxs2 -c -Wc,-ggdb -I$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/include mod_xebra.c mod_xebra.h
sudo apxs2 -i mod_xebra.la

# Add xebra module config to httpd.config
sudo su
echo "LoadModule xebra_module /usr/lib/apache2/modules/mod_xebra.so" > /etc/apache2/mods-available/xebra.load
echo "AddHandler mod_xebra .xeb" > /etc/apache2/mods-available/xebra.conf
echo "XebraServer_port \"55000\"" >> /etc/apache2/mods-available/xebra.conf
echo "XebraServer_host \"localhost\"" >> /etc/apache2/mods-available/xebra.conf
echo "LogLevel debug" >> /etc/apache2/mods-available/xebra.conf
ln -s /etc/apache2/mods-available/xebra.conf /etc/apache2/mods-enabled/xebra.conf
ln -s /etc/apache2/mods-available/xebra.load /etc/apache2/mods-enabled/xebra.load 
exit
sudo apache2ctl start

#Copy files for demoapp
mkdir $XEBRA_DEV/httpd/htdocs/demoapplication
cp -r $XEBRA_DEV/websites/demoapplication/html/images $XEBRA_DEV/httpd/htdocs/demoapplication
cp $XEBRA_DEV/websites/demoapplication/html/style.css $XEBRA_DEV/httpd/htdocs/demoapplication

#Copy files for xebrawebapp
mkdir $XEBRA_DEV/httpd/htdocs/xebrawebapp


# Compile xebra translator
cd $XEBRA_DEV/eiffel_projects/xebra_translator/
ec -config xebra_translator-voidunsafe.ecf  -target xebra_translator -c_compile
echo "Installation complete. Please edit $XEBRA_DEV/eiffel_projects/xebra_server/config.ini to match your configuration."





