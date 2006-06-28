#!/bin/sh

# set version number in $3 to the latest SVN repository version number.
# $1 = SVN repository
# $2 = pattern to transform
# $3 = file to process if any, otherwise display version on output

svn_revision=`svn info $1 | grep "Last Changed Rev" | sed -e "s/Last Changed Rev: //"`
if [[ -z "$2" || -z "$3" ]]; then
	echo $svn_revision
else
	sed -e "s/$2/$svn_revision/" $3 > tmp
	mv tmp $3
fi
