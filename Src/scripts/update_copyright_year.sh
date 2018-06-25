#!/bin/bash

curr_year=`date +%Y`

function do_sed {
	echo sed -i -e "$1" "$2" 
	sed -i -e "$1" "$2" 
}

function doall_sed {
	for filename in $2*; do
		echo sed -i -e "$1" "$filename" 
		sed -i -e "$1" "$filename" 
	done
}

if [ -z "$EIFFEL_SRC" ]; then export EIFFEL_SRC=$(readlink -n -q -m `pwd`/..) ; fi

echo Update copyright year to $curr_year.
echo EIFFEL_SRC=$EIFFEL_SRC

# $EIFFEL_SRC/framework/environment/interface/eiffel_env.e
do_sed "s/\(copyright_year: STRING = \"\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/framework/environment/interface/eiffel_env.e

# $EIFFEL_SRC/tools/eweasel_converter/argument_parser.e
do_sed "s/\(Copyright Eiffel Software [0-9][0-9][0-9][0-9]-\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/tools/eweasel_converter/argument_parser.e

# $EIFFEL_SRC/web/eiffel-org/modules/eiffel_community/site/templates/block_eiffel_copyright.tpl
do_sed "s/\(Copyright [0-9][0-9][0-9][0-9]\)/\1$curr_year/g" $EIFFEL_SRC/web/eiffel-org/modules/eiffel_community/site/templates/block_eiffel_copyright.tpl
do_sed "s/\(Copyright [0-9][0-9][0-9][0-9]\)/\1$curr_year/g" $EIFFEL_SRC/web/eiffel-org/site/modules/eiffel_community/templates/block_eiffel_copyright.tpl

