#!/bin/bash
# Xebra Installation Script for Ubuntu 9.04
# Adapt variables in the #Constants section
#
#

echo "This script will install Xebra."

#Constants

apache_dir="httpd-2.2.13"
apache_file="$apache_dir.tar.gz"
apache_url="http://www.apache.org/dist/httpd/$apache_file" 
revision=80578

echo "Apache $apache_url will be installed..."
echo "Xebra revision $revision will be installed..."


#Checks
echo "=========================Checking environment..."

if [ ! -x "`which wget`" ]; then
 	echo "Wget cannot be found! Please install wget!"
	exit
fi

if [ ! -x "`which svn`" ]; then
 	echo "Svn cannot be found! Please install svn!"
	exit
fi

if [ ! -x "`which tar`" ]; then
 	echo "Tar cannot be found! Please install tar!"
	exit
fi

if [ ! -x "`which ecb`" ]; then
 	echo "Ecb cannot be found! Please add the Eiffel Studio bin directory to your PATH."
	exit
fi

if [ ! -x "`which vim`" ]; then
 	echo "Vim cannot be found! Please install vim."
	exit
fi

if [ ! -d "$XEBRA_DEV" ]; then
 	echo "XEBRA_DEV is not defined or is not a directory. Please define before running script, e.g. to ~/xebra"
 	exit
fi

if [ ! -d "$ISE_EIFFEL" ]; then
 	echo "ISE_EIFFEL is not defined or is not a directory. Please define before running script."
 	exit
fi


if [ ! -d "$ISE_LIBRARY" ]; then
 	echo "ISE_LIBRARY is not defined or is not a directory. Please define before running script."
 	exit
fi

wget -q --spider $apache_url
if [ ! $? -eq 0 ]; then
	echo "Apache $apache_url does not exist. Please update this script to use the latest apache version."
	exit
fi


#==Setup xebra==
#Create xebra dir
echo "=========================Creating directories..."
mkdir $XEBRA_DEV/apache
mkdir $XEBRA_DEV/bin
mkdir $XEBRA_DEV/www
mkdir $XEBRA_DEV/conf
mkdir $XEBRA_DEV/library
mkdir $XEBRA_DEV/library/framework
mkdir $XEBRA_DEV/upload_tmp


#Set Xebra_library
export XEBRA_LIBRARY=$XEBRA_DEV/eiffel_projects/library


#Checkout needed libraries from framework
echo "=========================Checking out framework libraries..."
cd $XEBRA_DEV
mkdir eiffel_src
cd eiffel_src
mkdir framework
cd framework
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/base base
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/settable_types settable_types
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/string_expander string_expander
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/environment environment
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/peg peg
export EIFFEL_SRC=$XEBRA_DEV/eiffel_src

#Checkout eiffel_projects
echo "=========================Checking out xebra libraries..."
cd $XEBRA_DEV
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/eiffel_projects -r $revision

#Checkout ejson
echo "=========================Checking out ejason..."
cd $XEBRA_DEV
svn export https://svn.origo.ethz.ch/ejson/trunk/json eiffel_projects/library/ejson


#Compile Precompile
echo "=========================Compiling precompile..."
ecb -experiment -config $XEBRA_DEV/eiffel_projects/library/xebra_precompile/xebra_precompile.ecf -target xebra_precompile -c_compile  -precompile -stop -project_path $XEBRA_DEV/eiffel_projects/library/xebra_precompile
if [ ! $? == 0 ]; then
	echo "Error compiling precompile!"
	exit
fi;


#Compile Server
echo "=========================Compiling server..."
ecb -experiment -config $XEBRA_DEV/eiffel_projects/xebra_server/xebra_server.ecf  -target xebra_server -c_compile -finalize -stop -project_path $XEBRA_DEV/eiffel_projects/xebra_server
if [ ! $? == 0 ]; then
	echo "Error compiling server!"
	exit
fi;

#Compile Translator
echo "=========================Compiling translator..."
ecb -experiment -config $XEBRA_DEV/eiffel_projects/xebra_translator/xebra_translator.ecf  -target xebra_translator -c_compile -finalize -stop -project_path $XEBRA_DEV/eiffel_projects/xebra_translator
if [ ! $? == 0 ]; then
	echo "Error compiling translator!"
	exit
fi;

#Copy server and translator
cp $XEBRA_DEV/eiffel_projects/xebra_server/EIFGENs/xebra_server/F_code/xebra_server $XEBRA_DEV/bin
cp $XEBRA_DEV/eiffel_projects/xebra_translator/EIFGENs/xebra_translator/F_code/xebra_translator $XEBRA_DEV/bin

#Checkout webapps
echo "=========================Checking out webapps..."
cd $XEBRA_DEV/www
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/www/helloworld -r $revision helloworld
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/www/demoapplication -r $revision demoapplication
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/www/servercontrol -r $revision servercontrol
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/www/examples -r $revision examples

echo "=========================Setting up webapps..."
#Move xebra libraries
cp -Rf $XEBRA_DEV/eiffel_projects/library $XEBRA_DEV

#Move framework libraries
cp -Rf $EIFFEL_SRC/framework $XEBRA_DEV/library


#Replace '$EIFFEL_SRC' in ecfs with '$XEBRA_LIBRARY'
cd $XEBRA_DEV/library
a='$EIFFEL_SRC'
b='$XEBRA_LIBRARY'
for f in `find  -type f -name "*.ecf"`;
 do
  if grep $a $f;
  then
   cp $f $f.bak
#   echo "The string $a will be replaced with $b in $f"
   sed s/$a/$b/g < $f.bak > $f
   rm $f.bak
  fi
 done

#Write server config file
echo '{' > $XEBRA_DEV/conf/config.srv
echo '  "finalize_webapps": "false",' >> $XEBRA_DEV/conf/config.srv
echo '  "compiler": "$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ec",' >> $XEBRA_DEV/conf/config.srv
echo '  "translator": "$XEBRA_DEV/bin/xebra_translator",' >> $XEBRA_DEV/conf/config.srv
echo '  "managed_webapps": "$XEBRA_DEV/www",' >> $XEBRA_DEV/conf/config.srv
echo '  "library": "$XEBRA_LIBRARY",' >> $XEBRA_DEV/conf/config.srv
echo ' "compiler_flags": "-experiment",' >> $XEBRA_DEV/conf/config.srv
echo '  "unmanaged_webapps":' >> $XEBRA_DEV/conf/config.srv
echo '  [' >> $XEBRA_DEV/conf/config.srv
echo '  ]' >> $XEBRA_DEV/conf/config.srv
echo '}' >> $XEBRA_DEV/conf/config.srv



#==Install Apache==
# mkdir httpd
echo "=========================Installing apache..."
cd $XEBRA_DEV
mkdir httpd_tmp
cd $XEBRA_DEV/httpd_tmp
wget $apache_url
tar -xf $apache_file
cd $XEBRA_DEV/httpd_tmp/$apache_dir
./configure --prefix=$XEBRA_DEV/apache --with-port=55000
if [ ! $? == 0 ]; then
	echo "Error installing apache!"
	exit
fi;
make
if [ ! $? == 0 ]; then
	echo "Error installing apache!"
	exit
fi;
make install
if [ ! $? == 0 ]; then
	echo "Error installing apache!"
	exit
fi;
rm -Rf $XEBRA_DEV/httpd_tmp

# Compile and install xebra module
echo "=========================Installing mod_xebra..."
cd $XEBRA_DEV
svn export https://svn.origo.ethz.ch/eiffelstudio/trunk/Src/framework/web/xebra/c_projects -r $revision c_projects
cd $XEBRA_DEV/c_projects/apache_mod_xebra
$XEBRA_DEV/apache/bin/apxs -c mod_xebra.c mod_xebra.h
$XEBRA_DEV/apache/bin/apxs -i mod_xebra.la
echo "LoadModule xebra_module modules/mod_xebra.so" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "ServerName XebraServer" >> $XEBRA_DEV/apache/conf/httpd.conf
echo "AddHandler mod_xebra .xeb" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "AddHandler mod_xebra .xrpc" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "XebraServer_port \"55001\"" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "XebraServer_host \"localhost\"" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "XebraServer_max_upload_size 10000000" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "XebraServer_upload_path $XEBRA_DEV/upload_tmp" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "LogLevel debug" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "DirectoryIndex index.xeb" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo '<Files ~ "\.(wapp|e|ecf)$">' >> $XEBRA_DEV/apache/conf/httpd.conf 
echo " Order allow,deny" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo " Deny from all" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "</Files>" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo '<Directory ~ "EIFGENs">' >> $XEBRA_DEV/apache/conf/httpd.conf 
echo " Order allow,deny" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo " Deny from all" >> $XEBRA_DEV/apache/conf/httpd.conf 
echo "</Directory>" >> $XEBRA_DEV/apache/conf/httpd.conf 

#Replace all '$XEBRA_DEV/apache/htdocs' with '$XEBRA_DEV/www' in httpd.conf
echo $XEBRA_DEV > xebra_path
vim -c "s/\\//\\\\\\//g" -c "wq" xebra_path
sed -e "s/`cat xebra_path`\/apache\/htdocs/`cat xebra_path`\/www/g" -i $XEBRA_DEV/apache/conf/httpd.conf
rm xebra_path

#Creating launcher
echo "cd $XEBRA_DEV/bin
./xebra_server ../conf/config.srv"> $XEBRA_DEV/bin/launch_server.sh
chmod +x $XEBRA_DEV/bin/launch_server.sh
echo "cd $XEBRA_DEV/bin
./xebra_server ../conf/config.srv -d 6"> $XEBRA_DEV/bin/launch_server_debug.sh
chmod +x $XEBRA_DEV/bin/launch_server_debug.sh
echo "$XEBRA_DEV/apache/bin/apachectl start"> $XEBRA_DEV/bin/launch_apache.sh
chmod +x $XEBRA_DEV/bin/launch_apache.sh



#==Clean Up==
#Delete checkout dir
rm -Rf $XEBRA_DEV/eiffel_src
rm -Rf $XEBRA_DEV/eiffel_projects
rm -Rf $XEBRA_DEV/c_projects
rm -Rf $XEBRA_DEV/library/xebra_precompile/EIFGENs

#Start apache
echo "Starting apache..."
$XEBRA_DEV/apache/bin/apachectl start

echo "Installation complete. Please define XEBRA_LIBRARY to $XEBRA_DEV/library. "


