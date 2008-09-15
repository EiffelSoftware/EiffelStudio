#!/bin/sh

CWD=`pwd`
. `dirname $0`/common.sh

getdruptheme()
{
  URLNAME=$1
  wgetit http://ftp.drupal.org/files/projects $URLNAME
  unzipit $URLNAME $EDOC_DRUPALDIR/sites/all/themes
}

safemkdir $EDOC_TMPDIR
cd $EDOC_TMPDIR
safemkdir themes
cd themes

getdruptheme $1

cd $CWD
