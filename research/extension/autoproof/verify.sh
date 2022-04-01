#!/bin/bash

# The script finds all .ecf files under the current directory and verifies the respective Eiffel projects with AutoProof.
# If a project fails verification, the script will print the full path to the corresponding .ecf file.
# If a project fails verification, the script will exit with -1 exit code.
# If all projects pass verification, the script will exit with 0 exit code.
# For each project, the script will remove the EIFGENs directory after the verification is done.

starting_dir=$PWD
projects_to_test=`find $PWD -name "*.ecf"`
return_value=0
for project in $projects_to_test
do
	project_dir=`dirname $project`
	ecf_file=`basename $project`
	cd $project_dir
	ec -batch -clean -verify collection:cluster -verify printtime:false -config ${ecf_file} 2>err_log.txt
	if [ $? -ne 0 ]; then
		echo "Verification failed: $project"
		return_value=-1
	fi
	rm -rf EIFGENs
done
exit $return_value
