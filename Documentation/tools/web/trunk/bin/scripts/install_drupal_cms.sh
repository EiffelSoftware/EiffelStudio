#!/bin/sh

CWD=`pwd`

#include
. `dirname $0`/common.sh

DRUPALVERSION=$1

getdrupalcms()
{
	DRUPALZIPNAME=drupal-$1
	wgetit http://ftp.drupal.org/files/projects $DRUPALZIPNAME.tar.gz
	unzipit $DRUPALZIPNAME.tar.gz .
	if [ -e $DRUPALZIPNAME ]; then
		mv $DRUPALZIPNAME/sites $DRUPALZIPNAME/sites.distrib
		mv $DRUPALZIPNAME/* $EDOC_DRUPALDIR/.
		mv $DRUPALZIPNAME/.* $EDOC_DRUPALDIR/.
		rmdir $DRUPALZIPNAME
	fi
}

safemkdir $EDOC_TMPDIR
cd $EDOC_TMPDIR
# First get drupal itself
safemkdir drupal
cd drupal
getdrupalcms $DRUPALVERSION

if [ ! -e $EDOC_DRUPALDIR/sites/default ]; then
	cp -rf $EDOC_DRUPALDIR/sites.distrib/default $EDOC_DRUPALDIR/sites/default
fi
if [ ! -e $EDOC_DRUPALDIR/sites/default/settings.php ]; then
	cp -rf $EDOC_DRUPALDIR/sites/default/default.settings.php $EDOC_DRUPALDIR/sites/default/settings.php
fi
if [ ! -e $EDOC_DRUPALDIR/sites/default/files ]; then
	safemkdir $EDOC_DRUPALDIR/sites/default/files
	chmod a+w $EDOC_DRUPALDIR/sites/default/files
fi
if [ -e $EDOC_DRUPALDIR/sites/default/files ]; then
	cp $EDOC_BINDIR/data/* 	$EDOC_DRUPALDIR/sites/default/files
fi

cd $CWD
