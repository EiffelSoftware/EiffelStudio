#!/bin/bash

usage () {
	echo "Usage: prog major.min revision platform path-to-setups-dir workspace_dir bin_dir result_archive  "
	echo   platform: win64 or windows
	exit 0
}

CWD=`pwd`

version=$1
revision=$2
platform=$3
setups_dir=$4
workspace_dir=$5
bin_dir=$6
result_archive=$7

safe_mkdir() {
	if [ -d "$1" ]; then
		echo Directory $1 already exists
	else
		echo Create directory $1
		mkdir -p "$1" 
	fi
}

if [ -z "${setups_dir}" ]; then 
	usage 
fi
if [ -z "${revision}" ]; then 
	usage 
fi
if [ -z "${platform}" ]; then 
	usage 
fi
if [ ! -z "${result_archive}" ]; then 
	a=$result_archive
	d=$(dirname "$result_archive")
	if [ ! -d "$d" ]; then
		mkdir -p "$d"
	fi
	result_archive=$(cd "$d"; pwd)/$(basename "$a")
fi

if [ -f ${bin_dir}/local.rc ]; then
	. ${bin_dir}/local.rc
fi

if [ -z "$CMD_7Z" ]; then 
	CMD_7Z=7z 
fi
if [ -z "$CMD_SIGN" ]; then 
	CMD_SIGN=${bin_dir}/es_signtool 
fi

echo Code signing the setups at ${setups_dir}

T_WORKSPACE=${workspace_dir}/_EV_CODE_SIGNING/${version}.${revision}
if [ ! -d "$T_WORKSPACE" ]; then 
	safe_mkdir $T_WORKSPACE 
fi


cd $T_WORKSPACE
rel_dir=${setups_dir}
case ${rel_dir} in
	*/)
		;;
	*)
		rel_dir=${rel_dir}/
		;;
esac

echo Extract EiffelStudio from standard archive.
deliv_dir=$T_WORKSPACE/_deliv_${platform}
safe_mkdir $deliv_dir
cd $deliv_dir
#safe_mkdir build
#safe_mkdir tmpdev
safe_mkdir Eiffel_${version}
cd Eiffel_${version}
if [ ! -d EiffelStudio ]; then 
	TMP_ARCHIVE=${rel_dir}standard/Eiffel_${version}_rev_${revision}-${platform}.7z
	$CMD_7Z x "$TMP_ARCHIVE"
	mv Eiffel_${version} EiffelStudio
fi

echo Extract delivery files from archives.
cd $deliv_dir
#safe_mkdir releases
safe_mkdir $deliv_dir/Eiffel_${version}/releases

TMP_ARCHIVE=${rel_dir}standard/Eiffel_${version}_rev_${revision}-${platform}.7z
if [ -f "$TMP_ARCHIVE" ]; then
	cd $deliv_dir/Eiffel_${version}
	TMP_DIR=releases/standard_version
	if [ ! -d "$TMP_DIR" ]; then
		echo Extract standard files
		safe_mkdir $TMP_DIR
		echo $CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/studio/spec/${platform}/bin/ec.exe"
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/studio/spec/${platform}/bin/ec.exe"
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/studio/spec/${platform}/bin/ecb.exe"
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/LICENSE"
	fi
fi

TMP_ARCHIVE=${rel_dir}branded/Eiffel_${version}_branded_${revision}-${platform}.7z
if [ -f "$TMP_ARCHIVE" ]; then
	cd $deliv_dir/Eiffel_${version}
	TMP_DIR=releases/branded_version
	if [ ! -d "$TMP_DIR" ]; then
		echo Extract branded files
		safe_mkdir $TMP_DIR
		echo - get branded ec.exe
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/studio/spec/${platform}/bin/ec.exe"
		echo - get branded ecb.exe
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/studio/spec/${platform}/bin/ecb.exe"
		echo - get branded LICENSE
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/LICENSE"
	fi
fi

TMP_ARCHIVE=${rel_dir}enterprise/Eiffel_${version}_ent_${revision}-${platform}.7z
if [ -f "$TMP_ARCHIVE" ]; then
	cd $deliv_dir/Eiffel_${version}
	TMP_DIR=releases/enterprise_version
	if [ ! -d "$TMP_DIR" ]; then
		echo Extract enterprise files
		safe_mkdir $TMP_DIR
		echo - get ent ec.exe
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/studio/spec/${platform}/bin/ec.exe"
		echo - get ent ecb.exe
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/studio/spec/${platform}/bin/ecb.exe"
		echo - get ent LICENSE
		$CMD_7Z e "$TMP_ARCHIVE" -o$TMP_DIR "Eiffel_${version}/LICENSE"
	fi
fi

echo Prepare setups folder
cd $deliv_dir
#echo releases/gdiplus.dll
safe_mkdir setups
safe_mkdir setups/standard
safe_mkdir setups/branded
safe_mkdir setups/enterprise

cd $deliv_dir
echo Prepare script to sign all executables
T_SIGN_ALL_FILE=$deliv_dir/sign_all.sh
echo \#Sign all ISE exe and dll from "$deliv_dir/Eiffel_${version}" > $T_SIGN_ALL_FILE
echo "sign_file() {" >> $T_SIGN_ALL_FILE
echo "	$CMD_SIGN \$1;" >> $T_SIGN_ALL_FILE
echo "}" >> $T_SIGN_ALL_FILE

list_exe_files() {
	for f in `find . -type f -name "*.exe"` 
	do
		echo sign_file "`pwd`/$f" >> $T_SIGN_ALL_FILE 
	done
}
list_dll_files() {
	for f in `find . -type f -name "*.dll"` 
	do
		echo sign_file "`pwd`/$f" >> $T_SIGN_ALL_FILE 
	done
}

cd $deliv_dir/Eiffel_${version}/EiffelStudio/studio/spec
list_exe_files
list_dll_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/studio/wizards
list_exe_files
list_dll_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/esbuilder/spec
list_exe_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/tools
list_exe_files
list_dll_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/rb
list_exe_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/vision2_demo/spec
list_exe_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/wizards
list_exe_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/eweasel
list_exe_files

cd $deliv_dir/Eiffel_${version}/EiffelStudio/library/gobo/spec
list_exe_files

cd $deliv_dir/Eiffel_${version}/releases
list_exe_files

cd $CWD

echo Call now: $T_SIGN_ALL_FILE
. $T_SIGN_ALL_FILE

if [ -n "$result_archive" ]; then
	cd $deliv_dir/Eiffel_${version}
	echo Build the archive $result_archive ...
	$CMD_7Z a $result_archive *
	echo Archive completed.
fi

cd $CWD
