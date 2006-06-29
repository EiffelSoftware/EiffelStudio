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
echo "Extracting pat/patindex (with variable substitutions)"
$spitshell >patindex <<!GROK!THIS!
$startsh

# $Id: patindex.SH 78389 2004-11-30 00:17:17Z manus $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# Original Author: Larry Wall <lwall@netlabs.com>
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.1  1993/08/19  06:42:37  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:44  ram
# Baseline for dist 3.0 netwide release.
#

zcat='$zcat'
test='$test'
sed='$sed'
grep='$grep'

!GROK!THIS!
$spitshell >>patindex <<'!NO!SUBS!'
if test -d bugs; then
	cd bugs
fi
for i in patch? patch??; do
	if $test -f $i; then
		echo "=== $i ==="
		$grep '^Subject: ' $i | $sed 's/^patch\(.*\):Subject/\1/'
	fi
done
for i in patch?.Z patch??.Z; do
	if $test -f $i; then
		name=`echo $i | $sed "s|\.Z$||"`
		echo "=== $name ==="
		$zcat $i | $grep '^Subject: ' | $sed 's/^patch\(.*\):Subject/\1/'
	fi
done
!NO!SUBS!
chmod 755 patindex
$eunicefix patindex
