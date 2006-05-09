#!/bin/sh

# set version number in $3 to the latest SVN repository version number.
# $1 = SVN repository
# $2 = pattern to transform
# $3 = file to process

svn_revision=`svn info $1 | grep Revision | sed -e "s/Revision: //"`
sed -e "s/$2/$svn_revision/" $3 > tmp
mv tmp $3
