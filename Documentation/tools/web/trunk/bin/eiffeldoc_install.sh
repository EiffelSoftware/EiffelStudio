#!/bin/sh

#include
EDOC_BINDIR=`dirname $0`
. `dirname $0`/scripts/common.sh

$EDOC_SCRIPTSDIR/install_drupal_cms.sh 6.4
$EDOC_SCRIPTSDIR/install_drupal_themes.sh
$EDOC_SCRIPTSDIR/install_drupal_modules.sh
$EDOC_SCRIPTSDIR/install_drupal_3rd.sh

cd $EDOC_BINDIR
