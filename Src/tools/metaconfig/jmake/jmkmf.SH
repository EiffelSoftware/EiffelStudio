case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting jmake/jmkmf (with variable substitutions)"
$spitshell >jmkmf <<!GROK!THIS!
$startsh
!GROK!THIS!
$spitshell >>jmkmf <<'!NO!SUBS!'
# @(#) Generates a Makefile from a Jmakefile

# $Id: jmkmf.SH 78389 2004-11-30 00:17:17Z manus $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.1  1993/08/19  06:42:14  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:19  ram
# Baseline for dist 3.0 netwide release.
#

usage="usage:  $0 [top_of_sources_pathname [current_directory]]"

topdir=.
curdir=.

case $# in 
    0) ;;
    1) topdir=$1 ;;
    2) topdir=$1  curdir=$2 ;;
    *) echo "$usage" 1>&2; exit 1 ;;
esac

case "$topdir" in
    -*) echo "$usage" 1>&2; exit 1 ;;
esac

if test -f Makefile.SH; then 
    echo mv Makefile.SH Makefile.SH~
    mv Makefile.SH Makefile.SH~
fi

args="-DTOPDIR=$topdir -DCURDIR=$curdir"

echo jmake $args
jmake $args
echo sh Makefile.SH
sh Makefile.SH
!NO!SUBS!
chmod 755 jmkmf
$eunicefix jmkmf
