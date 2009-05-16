# install_xebra_ubuntu.sh

if [ -x "$XEBRA_DEV" ]; then
	:
else
 	echo "XEBRA_DEV is not defined. Please define before running script.";
fi;

if [ -x "$EIFFEL_SRC" ]; then
	:
else
 	echo "EIFFEL_SRC is not defined. Please define before running script.";
fi;

if [ -x "$ISE_EIFFEL" ]; then
	:
else
 	echo "ISE_EIFFEL is not defined. Please define before running script.";
fi;


if [ -x "$ISE_LIBRARY" ]; then
	:
else
 	echo "ISE_LIBRARYis not defined. Please define before running script.";
fi;


sudo apache2ctl stop
cd $XEBRA_DEV
svn co https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/
mkdir httpd
mkdir httpd_tmp
cd $XEBRA_DEV/httpd_tmp
wget http://mirrors.directorymix.com/apache/httpd/httpd-2.2.11.tar.bz2
tar -xf httpd-2.2.11.tar.bz2 
cd $XEBRA_DEV/httpd_tmp/httpd-2.2.11
./configure --prefix=$XEBRA_DEV/httpd
make
make install
rm -Rf $XEBRA_DEV/httpd_tmp
cd $XEBRA_DEV/c_projects/mod_xebra
$XEBRA_DEV/httpd/bin/apxs -c -I$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/include mod_xebra.c mod_xebra.h
$XEBRA_DEV/httpd/bin/apxs -i mod_xebra.la
echo "LoadModule xebra_module modules/mod_xebra.so" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "AddHandler mod_xebra .xeb" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "XebraServer_port \"55000\"" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "XebraServer_host \"localhost\"" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "LogLevel debug" >> $XEBRA_DEV/httpd/conf/httpd.conf 
sudo $XEBRA_DEV/httpd/bin/apachectl start
cd $XEBRA_DEV/eiffel_projects/xebra_translator/
ec -config xebra_translator-voidunsafe.ecf  -target xebra_translator -c_compile
echo "Installation compelte. Please edit $XEBRA_DEV/eiffel_projects/xebra_server/config.ini to match your configuration."




