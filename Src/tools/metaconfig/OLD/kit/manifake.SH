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
echo "Extracting kit/manifake (with variable substitutions)"
$spitshell >manifake <<!GROK!THIS!
$startperl
	eval "exec perl -i~ -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: manifake.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.1  1993/08/19  06:42:18  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:32  ram
# Baseline for dist 3.0 netwide release.
#

!GROK!THIS!
$spitshell >>manifake <<'!NO!SUBS!'
$NEWMANI = 'MANIFEST.new';
$MANI = 'MANIFEST';

&manifake;

!NO!SUBS!
chmod 755 manifake
$grep -v '^;#' ../pl/manifake.pl >> manifake
$eunicefix manifake
