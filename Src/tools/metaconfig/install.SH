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
echo "Extracting install (with variable substitutions)"
$spitshell >install <<!GROK!THIS!
$startsh
# @(#) Installing script accepting bsd-style arguments

# $Id: install.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.1  1993/08/19  06:42:10  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:08  ram
# Baseline for dist 3.0 netwide release.
#

chown='$chown'
chmod='$chmod'
chgrp='$chgrp'
rm='$rm'
mv='$mv'
test='$test'
sed='$sed'
!GROK!THIS!
$spitshell >>install <<'!NO!SUBS!'

mode=""
dst=""
src=""
dostrip=""
newdir=""
uid=""
gid=""

# simulates mkdir -p
mkdir_p='
name=$1;
create="";
while $test $name; do
	if $test ! -d "$name"; then
		create="$name $create";
		name=`echo $name | $sed -e "s|^[^/]*$||"`;
		name=`echo $name | $sed -e "s|\(.*\)/.*|\1|"`;
	else
		name="";
	fi;
done;
for file in $create; do
	mkdir $file && $test $verbose &&
	echo "install: created directory $file" >&2;
done
'

verbose=''

while $test x$1 != x
do
	case $1 in 
	-c) shift
		continue
		;;
	-m) mode="$2 "
		shift
		shift
		continue
		;;
	-o) uid="$2 "
		shift
		shift
		continue
		;;
	-g) gid="$2 "
		shift
		shift
		continue
		;;
	-s) dostrip="strip"
		shift
		continue
		;;
	-d) newdir="$newdir$2 "
		shift
		shift
		continue
		;;
	-v) verbose='true'
		shift
		;;
	*) if $test x$src = x
		then
			src=$1
		else
			dst=$1
		fi
		shift
		continue
		;;
	esac
done

# if -d option is used, we have to create the path given
if $test ! x$newdir = x
then
	for i in $newdir
	do
		set x $i
		shift
		eval $mkdir_p
	done
	exit 0		# -d is the only action
fi

if $test x$src = x
then
	echo "install: no input file specified" >&2
	exit 1
fi

if $test x$dst = x
then
	echo "install: no destination specified" >&2
	exit 1
fi

srcbase=`basename $src`
dstbase=`basename $dst`

# If the destination is a directory, the target name is srcbase...
if $test -d $dst; then
	dstbase=$srcbase
else
	dst="`echo $dst | sed 's,^\(.*\)/.*$,\1,'`"
	if $test ! -d $dst; then
		dstbase=$dst
		dst="."
	fi
fi

# If the src has a directory, extract the dir name...
if $test "$src" != "$srcbase" -a "$src" != "./$srcbase"; then
	src="`echo $src | sed 's,^\(.*\)/.*$,\1,'`"
else
	src="."
fi

# dst is the destination directory and dstbase the base name.
# srcbase is the base name of source and src the source dir.

srcpth=`(cd $src; pwd)`/$srcbase
destpth=`(cd $dst; pwd)`/$dstbase
if $test x$srcpth = x$destpth; then
	$test $verbose && \
	echo "install: destination and source are identical"
	exit 0
fi

# Do the install
(
	cd $src

	if $test -f $dst/$dstbase; then
		$rm -f $dst/$dstbase && $test $verbose &&
		echo "install: $dst/$dstbase removed"
	fi
	if $test -f $dst/$dstbase; then
		$mv $dst/$dstbase $dst/OLD$dstbase && $test $verbose &&
		echo "install: $dst/$dstbase renamed as OLD$dstbase"
	fi

	cp $srcbase $dst/$dstbase && $test $verbose &&
	echo "install: $srcbase installed as $dst/$dstbase"

	if $test ! x$dostrip = x; then
		strip $dst/$dstbase 2>/dev/null && $test $verbose &&
		echo "install: stripped $dst/$dstbase"
	fi

	if $test ! x$uid = x; then
		$chown $uid $dst/$dstbase
	fi
	if $test ! x$gid = x; then
		$chgrp $gid $dst/$dstbase
	fi
	if $test ! x$mode = x
	then
		$chmod $mode $dst/$dstbase
	fi
)

exit 0
!NO!SUBS!
chmod 755 install
$eunicefix install
