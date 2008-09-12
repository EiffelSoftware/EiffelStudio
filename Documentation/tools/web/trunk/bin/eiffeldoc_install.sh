#!/bin/sh

. `dirname $0`/etc/init_vars.sh

# For CMS daily use
CWD=`pwd`
DRUPALDIR=$CWD/../drupal

safemkdir()
{
  if [ ! -e "$1" ]; then
    echo "Creating $1"
    mkdir $1
  fi
}

wgetit()
{
  A_URLPATH=$1
  A_URLNAME=$2
  if [ ! -e "$A_URLNAME" ]; then
    wget $A_URLPATH/$A_URLNAME
  fi
}

unzipit()
{
  A_ZIPNAME=$1
  A_DIR=$2
  if [ -e "$A_ZIPNAME" ]; then
    tar xzvf $A_ZIPNAME -C $A_DIR
  fi
}

getdrupmod()
{
  URLNAME=$1
  wgetit http://ftp.drupal.org/files/projects $URLNAME
  unzipit $URLNAME $DRUPALDIR/sites/all/modules
}
getdruptheme()
{
  URLNAME=$1
  wgetit http://ftp.drupal.org/files/projects $URLNAME
  unzipit $URLNAME $DRUPALDIR/sites/all/themes
}

getdrupal_themes(){
	getdruptheme zen-6.x-1.0-beta2.tar.gz
}
getdrupal_modules(){
	getdrupmod cck-6.x-2.0-rc7.tar.gz
	getdrupmod diff-6.x-2.0.tar.gz
	getdrupmod freelinking-6.x-1.4.tar.gz
	getdrupmod geshifilter-6.x-1.1.tar.gz
	getdrupmod image-6.x-1.0-alpha3.tar.gz
	getdrupmod imce-6.x-1.1.tar.gz
	getdrupmod img_assist-6.x-1.0-beta1.tar.gz
	getdrupmod lightbox2-6.x-1.8.tar.gz
	getdrupmod pathauto-6.x-1.1.tar.gz
	getdrupmod pearwiki_filter-6.x-1.0-beta1.tar.gz
	getdrupmod persistent_login-6.x-1.4-beta2.tar.gz
	getdrupmod print-6.x-1.0.tar.gz
	getdrupmod recent_changes-6.x-1.x-dev.tar.gz
	getdrupmod tagadelic-6.x-1.0.tar.gz
	getdrupmod community_tags-6.x-1.0-beta1.tar.gz
	getdrupmod talk-6.x-1.4.tar.gz
	getdrupmod textareatabs-6.x-0.1.tar.gz
	getdrupmod token-6.x-1.11.tar.gz
	getdrupmod trash-6.x-1.x-dev.tar.gz
	getdrupmod upload_image-6.x-1.x-dev.tar.gz
	getdrupmod views-6.x-2.0-rc2.tar.gz
	getdrupmod wikitools-6.x-1.0.tar.gz
	getdrupmod flexifilter-6.x-1.1-rc1.tar.gz
	getdrupmod tableofcontents-6.x-2.2.tar.gz
	getdrupmod fckeditor-6.x-1.3-rc1.tar.gz
	getdrupmod opensearchplugin-6.x-1.1.tar.gz
	getdrupmod jtooltips-6.x-1.8.tar.gz
	#getdrupmod xmlcontent-6.x-1.x-dev.tar.gz
	#getdrupmod nice_menus-6.x-1.1.tar.gz
	getdrupmod captcha-6.x-1.0-rc2.tar.gz
	getdrupmod captcha_pack-6.x-1.0-beta2.tar.gz


	# For development purpose
	getdrupmod schema-6.x-1.3.tar.gz
	getdrupmod admin_menu-6.x-1.0.tar.gz
	getdrupmod devel-6.x-1.10.tar.gz
	getdrupmod nodetype-6.x-1.0.tar.gz
	getdrupmod plugin_manager-6.x-1.x-dev.tar.gz
	#getdrupmod coder-6.x-1.x-dev.tar.gz
}

getdrupalcms()
{
	DRUPALZIPNAME=drupal-$1
	wgetit http://ftp.drupal.org/files/projects $DRUPALZIPNAME.tar.gz
	unzipit $DRUPALZIPNAME.tar.gz .
	if [ -e $DRUPALZIPNAME ]; then
		mv $DRUPALZIPNAME/sites $DRUPALZIPNAME/sites.distrib
		mv $DRUPALZIPNAME/* $DRUPALDIR/.
		mv $DRUPALZIPNAME/.* $DRUPALDIR/.
		rmdir $DRUPALZIPNAME
	fi

}
getsf3rd()
{
	MOD3RD=$1
	NAME3RD=$2
	ZIP3RD=$3
	UNZIPPED3RD=$4
	UNZIPCMD=$5

	DIR3RD=$DRUPALDIR/sites/all/modules/$MOD3RD/$NAME3RD
	if [ ! -e "$ZIP3RD" ]; then
		echo "Downloading $ZIP3RD"
		wget http://downloads.sourceforge.net/$NAME3RD/$ZIP3RD?big_mirror=0
	fi
	echo Check existence of $DIR3RD ...
	if [ ! -e "$DIR3RD" ]; then
		echo Install $NAME3RD in module $MOD3RD ...
		echo unzipping: $UNZIPCMD $ZIP3RD  to  $UNZIPPED3RD ...
		$UNZIPCMD $ZIP3RD
		mv $UNZIPPED3RD $DIR3RD
	fi
}

safemkdir tmp
cd tmp
# First get drupal itself
safemkdir drupal
cd drupal
getdrupalcms 6.4
if [ ! -e $DRUPALDIR/sites/default ]; then
	cp -rf $DRUPALDIR/sites.distrib/default $DRUPALDIR/sites/default
fi
if [ ! -e $DRUPALDIR/sites/default/settings.php ]; then
	cp -rf $DRUPALDIR/sites/default/default.settings.php $DRUPALDIR/sites/default/settings.php
fi
if [ ! -e $DRUPALDIR/sites/default/files ]; then
	safemkdir $DRUPALDIR/sites/default/files
	chmod a+w $DRUPALDIR/sites/default/files
fi
if [ -e $DRUPALDIR/sites/default/files ]; then
	cp $CWD/data/* 	$DRUPALDIR/sites/default/files
fi

cd ..

#Get themes
safemkdir themes
cd themes
getdrupal_themes
cd ..

#Get modules
safemkdir modules
cd modules
getdrupal_modules

#Get 3rd party
safemkdir 3rd
cd 3rd

getsf3rd geshifilter geshi geshi-1.0.7.21.tar.gz geshi "tar xzvf"
getsf3rd fckeditor fckeditor FCKeditor_2.6.3.tar.gz fckeditor "tar xzvf"
getsf3rd print dompdf dompdf-0.5.1.tar.gz dompdf-0.5.1 "tar xzvf"
getsf3rd print tcpdf tcpdf_4_0_021.zip tcpdf "unzip"


cd ..
cd ..
cd $DRUPALDIR/sites/all/modules/pearwiki_filter
cvs -d :pserver:cvsread@cvs.php.net:/repository checkout -d Text pear/Text_Wiki/Text

cd $CWD
