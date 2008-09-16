#!/bin/sh

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

CWDc=`pwd`
if [ "$EDOC_BINDIR" = "" ]; then
  cd `dirname $0`/..
else
  cd $EDOC_BINDIR
fi
EDOC_BINDIR=`pwd`
cd $CWDc
CWDc=

#echo docbin=$EDOC_BINDIR
EDOC_SCRIPTSDIR=$EDOC_BINDIR/scripts
EDOC_DRUPALDIR=$EDOC_BINDIR/../drupal
EDOC_TMPDIR=$EDOC_BINDIR/tmp

. $EDOC_BINDIR/etc/init_vars.sh

