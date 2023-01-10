#!/bin/bash

curr_year=`date +%Y`

function do_sed {
	echo sed -i -e "$1" "$2" 
	sed -i -e "$1" "$2" 
	svn diff "$2"
	echo $2 >> file_for_year_changes.log
	echo $2 \\ >> commit_year_changes.sh
}

function doall_sed {
	for filename in $2*; do
		echo sed -i -e "$1" "$filename" 
		sed -i -e "$1" "$filename" 
		svn diff "$filename"
		echo $filename >> file_for_year_changes.log
		echo $filename \\ >> commit_year_changes.sh
	done
}
function do_update_copyright_eiffel_software {
	do_sed "s/\(Copyright Eiffel Software [0-9][0-9][0-9][0-9]-\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" "$1"
}

if [ -z "$EIFFEL_SRC" ]; then export EIFFEL_SRC=$(readlink -n -q -m `pwd`/..) ; fi

echo Update copyright year to $curr_year.
echo EIFFEL_SRC=$EIFFEL_SRC
echo  > file_for_year_changes.log
echo  echo Update to year $curr_year > commit_year_changes.sh
echo  export EIFFEL_SRC=#EIFFEL_SRC >> commit_year_changes.sh
echo  svn commit \\ >> commit_year_changes.sh

# $EIFFEL_SRC/framework/environment/interface/eiffel_env.e
do_sed "s/\(copyright_year: STRING = \"\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/framework/environment/interface/eiffel_env.e

# $EIFFEL_SRC/tools/iron/
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/iron/client/application/iron_arguments.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/iron/client/application/iron_constants.e


# $EIFFEL_SRC/tools/*/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/eweasel_converter/argument_parser.e
#do_update_copyright_eiffel_software $EIFFEL_SRC/tools/compile_all/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/com_wizard/root/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/dotnet_reference_builder/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/ecf_builder/src/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/ecf_tool/src/application_command_argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/ecf_updater/src/application_argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/eiffel_echo/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/eiffel_matrix_code_generator/main/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/hallow/main/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/eiffel_routine_trans/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/espawn/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/eweasel_converter/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/library_index/src/library_indexer_arguments.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/parse_benchmark/main/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/reg2wix/main/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/syntax_updater/syntax_updater.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/unicode/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/visitor_factory/main/argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/tools/vsafeconv/main/argument_parser.e


# $EIFFEL_SRC/web/eiffel-org/modules/eiffel_community/site/templates/block_eiffel_copyright.tpl
do_sed "s/\(Copyright \)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/web/eiffel-org/modules/eiffel_community/site/templates/block_eiffel_copyright.tpl
do_sed "s/\(Copyright \)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/web/eiffel-org/site/modules/eiffel_community/templates/block_eiffel_copyright.tpl


# $EIFFEL_SRC/tools/*/

do_sed "s/\(Copyright (C) [0-9][0-9][0-9][0-9]-\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/tools/resource_bench/tos/table_of_symbols_structure.e
do_sed "s/\(Copyright (C) [0-9][0-9][0-9][0-9]-\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/tools/resource_bench/tos/tds_dialog.e

# $EIFFEL_SRC/framework/web/xebra
do_update_copyright_eiffel_software $EIFFEL_SRC/framework/web/xebra/eiffel_projects/library/xebra_tags/xtag_argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/framework/web/xebra/eiffel_projects/library/xebra_web_application/xwa_argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/framework/web/xebra/eiffel_projects/xebra_server/utilities/xs_argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/framework/web/xebra/eiffel_projects/xebra_translator/xt_argument_parser.e
do_update_copyright_eiffel_software $EIFFEL_SRC/framework/web/xebra/tools/installer/win/xebra_deployer/xd_argument_parser.e

# sqlite3 examples
do_update_copyright_eiffel_software $EIFFEL_SRC/unstable/library/persistency/database/sqlite3/examples/liteterm/argument_parser.e

# esbuilder
do_sed "s/\(Copyright (C) [0-9][0-9][0-9][0-9]-\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/build/Constants/gb_about_dialog_constants.e

# dotnet consumer
do_update_copyright_eiffel_software $EIFFEL_SRC/dotnet/consumer/main/argument_parser.e

# finish_freezing
do_sed "s/\(Copyright Eiffel Software [0-9][0-9][0-9][0-9]-\)[0-9][0-9][0-9][0-9]/\1$curr_year/g" $EIFFEL_SRC/Delivery/studio/spec/unix/finish_freezing

sort -u file_for_year_changes.log -o file_for_year_changes.log
sed -i -e  "s~$EIFFEL_SRC~\$EIFFEL_SRC~g" file_for_year_changes.log

echo  -m \"chore: Updated to year $curr_year .\"  >> commit_year_changes.sh

sed -i -e  "s~$EIFFEL_SRC~  \$EIFFEL_SRC~g" commit_year_changes.sh
sed -i -e  "s~#EIFFEL_SRC~$EIFFEL_SRC~g" commit_year_changes.sh

echo "Files to commit (in file_for_year_changes.log):"
cat file_for_year_changes.log

