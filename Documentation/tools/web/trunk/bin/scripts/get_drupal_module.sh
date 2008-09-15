#!/bin/sh

CWD=`pwd`
. `dirname $0`/common.sh

getdrupmod()
{
  URLNAME=$1
  wgetit http://ftp.drupal.org/files/projects $URLNAME
  unzipit $URLNAME $EDOC_DRUPALDIR/sites/all/modules
}

safemkdir $EDOC_TMPDIR
cd $EDOC_TMPDIR
safemkdir modules
cd modules

getdrupmod $1

cd $CWD
