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
echo "Extracting makedir (with variable substitutions)"
$spitshell >makedir <<!GROK!THIS!
$startsh
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
# Original Author: Larry Wall <lwall@netlabs.com>
# 
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.1  1994/01/24  14:00:08  ram
# patch16: changed top ln-style config.sh lookup into test-style one
#
# Revision 3.0  1993/08/18  12:04:38  ram
# Baseline for dist 3.0 netwide release.
#

export PATH || (echo "OOPS, this isn't sh.  Desperation time.  I will feed myself to sh."; sh \$0; kill \$\$)

case \$# in
  0)
    $echo "makedir pathname filenameflag"
    exit 1
    ;;
esac

: guarantee one slash before 1st component
case \$1 in
  /*) ;;
  *)  set ./\$1 \$2 ;;
esac

: strip last component if it is to be a filename
case X\$2 in
  X1) set \`$echo \$1 | $sed 's:\(.*\)/[^/]*\$:\1:'\` ;;
  *)  set \$1 ;;
esac

: return reasonable status if nothing to be created
if $test -d "\$1" ; then
    exit 0
fi

list=''
while true ; do
    case \$1 in
    */*)
	list="\$1 \$list"
	set \`echo \$1 | $sed 's:\(.*\)/:\1 :'\`
	;;
    *)
	break
	;;
    esac
done

set \$list

for dir do
    $mkdir \$dir >/dev/null 2>&1
done
!GROK!THIS!
$eunicefix makedir
chmod +x makedir
