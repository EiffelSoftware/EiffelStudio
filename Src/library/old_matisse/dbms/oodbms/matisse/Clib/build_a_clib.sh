#!/bin/csh -f 
#
# EiffelStore C-library builder / used by make_Clib 
# (c) SOL 1993, 1994
#

set current_dir = `dirname $1`

echo ' '
echo Building C-library of directory $current_dir for platform $PLATFORM
cd $current_dir
cp $EIFFEL4/bench/spec/$PLATFORM/include/config.sh .
sh Makefile.SH
make
make clean
rm -f Makefile config.sh
if ( $status != '0' ) then
	echo 'Error!'
	exit
endif

exit
