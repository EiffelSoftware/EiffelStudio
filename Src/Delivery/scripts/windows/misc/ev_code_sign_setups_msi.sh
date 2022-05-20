#!/bin/bash

usage () {
	echo "Usage: prog workspace_dir" 
	exit 0
}

CWD=`pwd`

workspace_dir=$1
files_dir=${workspace_dir}/files
bin_dir=${workspace_dir}/bin

safe_mkdir() {
	if [ -d "$1" ]; then
		echo Directory $1 already exists
	else
		echo Create directory $1
		mkdir -p "$1" 
	fi
}

if [ -z "${files_dir}" ]; then 
	usage 
fi

if [ -f ${bin_dir}/local.rc ]; then
	. ${bin_dir}/local.rc
fi
if [ -z "$CMD_SIGN" ]; then 
	CMD_SIGN=${bin_dir}/es_signtool 
fi

echo Code signing the msi files at ${files_dir}

T_SIGNED_DIR=${workspace_dir}/files_signed
if [ ! -d "$T_SIGNED_DIR" ]; then 
	safe_mkdir $T_SIGNED_DIR 
fi


case ${files_dir} in
	*/)
		;;
	*)
		files_dir=${files_dir}/
		;;
esac


cd $T_SIGNED_DIR

echo Prepare script to sign all msi
T_SIGN_ALL_FILE=$workspace_dir/sign_all_msi.sh
echo \#Sign all ISE msi from "$files_dir" > $T_SIGN_ALL_FILE
echo "sign_file() {" >> $T_SIGN_ALL_FILE
echo "	$CMD_SIGN \$1;" >> $T_SIGN_ALL_FILE
echo "}" >> $T_SIGN_ALL_FILE

process_msi_files() {
	for f in `find . -type f -name "*.msi"` 
	do
		d=`dirname $f`
		if [ ! -d "${T_SIGNED_DIR}/$d" ]; then
			mkdir -p "${T_SIGNED_DIR}/$d"
		fi
		cp "$f" ${T_SIGNED_DIR}/$f
		echo sign_file "${T_SIGNED_DIR}/$f" >> $T_SIGN_ALL_FILE 
	done
}

cd $files_dir
process_msi_files

cd $CWD

echo Call now: $T_SIGN_ALL_FILE
. $T_SIGN_ALL_FILE

cd $CWD
