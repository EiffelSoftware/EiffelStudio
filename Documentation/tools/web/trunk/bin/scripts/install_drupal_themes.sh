#!/bin/sh

CWD=`pwd`
. `dirname $0`/common.sh

getdruptheme()
{
  $EDOC_SCRIPTSDIR/get_drupal_theme.sh $1
}

getdruptheme zen-6.x-1.0-beta3.tar.gz

cd $CWD
