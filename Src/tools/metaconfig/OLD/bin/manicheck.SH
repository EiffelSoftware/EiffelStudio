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
echo "Extracting bin/manicheck (with variable substitutions)"
$spitshell >manicheck <<!GROK!THIS!
$startsh
!GROK!THIS!
$spitshell >>manicheck <<'!NO!SUBS!'
# $Id: manicheck.SH 78389 2004-11-30 00:17:17Z manus $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# Original Author: Harlan Stenn <harlan@mumps.pfcs.com>
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.1  1993/08/19  06:41:51  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:02  ram
# Baseline for dist 3.0 netwide release.
#

find . ! -type d -print | sed -e '
s|^./||
/RCS\//d
/UU\//d
/core$/d
/\.bak$/d
/\.orig$/d
' | sort > check.present

manifest=''
if test -r MANIFEST.new; then
	manifest='MANIFEST.new'
else
	if test -r MANIFEST; then
		manifest='MANIFEST'
	else
		echo "No MANIFEST.new or MANIFEST file--don't know what to look for."
	fi
fi

awk '{print $1}' $manifest | sort > check.expected

comm -23 check.expected check.present > check.want
comm -13 check.expected check.present > check.extra

rm -f check.expected check.present

if test -s check.want; then
	echo "Some files listed in $manifest are missing; see check.want."
else
	rm check.want
fi

if test -s check.extra; then
	echo "Some files not listed in $manifest are present; see check.extra."
else
	rm check.extra
fi
!NO!SUBS!
chmod 755 manicheck
$eunicefix manicheck
