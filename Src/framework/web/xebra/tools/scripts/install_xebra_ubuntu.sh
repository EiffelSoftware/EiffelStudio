# install_xebra_ubuntu.sh

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


# Checkout xebra
cd $XEBRA_DEV
svn co https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/c_projects
svn co https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/eiffel_projects
svn co https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/tools
svn co https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/httpd

# Install apache
# mkdir httpd
mkdir httpd_tmp
cd $XEBRA_DEV/httpd_tmp
wget http://mirrors.directorymix.com/apache/httpd/httpd-2.2.11.tar.bz2
tar -xf httpd-2.2.11.tar.bz2 
cd $XEBRA_DEV/httpd_tmp/httpd-2.2.11
./configure --prefix=$XEBRA_DEV/httpd
make
make install
rm -Rf $XEBRA_DEV/httpd_tmp

# Compile and install xebra module
cd $XEBRA_DEV/c_projects/apache_mod_xebra
$XEBRA_DEV/httpd/bin/apxs -c -I$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/include mod_xebra.c mod_xebra.h
$XEBRA_DEV/httpd/bin/apxs -i mod_xebra.la
echo "LoadModule xebra_module modules/mod_xebra.so" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "AddHandler mod_xebra .xeb" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "AddHandler mod_xebra .xrpc" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "XebraServer_port \"55001\"" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "XebraServer_host \"localhost\"" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "XebraServer_max_upload_size 10000000" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "LogLevel debug" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "DirectoryIndex index.xeb" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo '<Files ~ "\.(ini|e|ecf)$">' >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo " Order allow,deny" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo " Deny from all" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "</Files>" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo '<Directory ~ "EIFGENs">' >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo " Order allow,deny" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo " Deny from all" >> $XEBRA_DEV/httpd/conf/httpd.conf 
echo "</Directory>" >> $XEBRA_DEV/httpd/conf/httpd.conf 
sed -e 's/Listen 80/Listen 55000/' -i $XEBRA_DEV/httpd/conf/httpd.conf 

$XEBRA_DEV/httpd/bin/apachectl start


# Compile xebra translator
cd $XEBRA_DEV/eiffel_projects/xebra_translator/
ec -config xebra_translator-voidunsafe.ecf  -target xebra_translator -c_compile -clean -finalize

# Compile xebra server
cd $XEBRA_DEV/eiffel_projects/xebra_server
ec -config xebra_server-voidunsafe.ecf -target xebra_server -c_compile -clean -finalize

echo "Installation complete."




