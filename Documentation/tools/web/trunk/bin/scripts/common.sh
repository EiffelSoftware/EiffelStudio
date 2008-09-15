#!/bin/sh

EDOC_BINDIR=`dirname $0`/../
EDOC_SCRIPTSDIR=$EDOC_BINDIR/scripts/
EDOC_ETCDIR=$EDOC_BINDIR/etc/
EDOC_DRUPALDIR=$EDOC_BINDIR/../drupal/
EDOC_TMPDIR=$EDOC_BINDIR/tmp/

. $EDOC_ETCDIR/init_vars.sh

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

