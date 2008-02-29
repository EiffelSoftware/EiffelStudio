# $Id$
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
# Revision 3.0.1.1  1994/01/24  14:00:00  ram
# patch16: changed top ln-style config.sh lookup into test-style one
#
# Revision 3.0  1993/08/18  12:04:36  ram
# Baseline for dist 3.0 netwide release.
#

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
case "$errnolistc" in
'') ;;
*)
	echo "Making $errnolistc ..."
	awk -f errnolist.a < /usr/include/sys/errno.h > $errnolistc
	echo "It would be a good idea to make sure that $errnolistc is correct."
esac

