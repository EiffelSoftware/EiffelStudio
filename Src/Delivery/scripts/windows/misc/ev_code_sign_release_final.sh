#!/bin/bash

# Usage: prog 21.11 106046
CWD=`pwd`

version=$1
revision=$2

usage () {
	echo Usage: prog major.min revision
	echo   for instance prog  21.11 106046
	exit 0
}
safe_mkdir() {
	if [ -d "$1" ]; then
		echo Directory $1 already exists
	else
		echo Create directory $1
		mkdir -p "$1" 
	fi
}

if [ -z "${version}" ]; then 
	usage 
fi
if [ -z "${revision}" ]; then 
	usage 
fi

if [ -f $CWD/local.rc ]; then
	. $CWD/local.rc
fi

if [ -z "$CMD_7Z" ]; then 
	CMD_7Z=7z 
fi
if [ -z "$CMD_SIGN" ]; then 
	CMD_SIGN=./es_signtool 
fi

echo Code signing the final delivery $version $revision

if [ ! -d "$CWD/_EV_CODE_SIGNING_FINAL" ]; then
	safe_mkdir $CWD/_EV_CODE_SIGNING_FINAL
fi

T_WORKSPACE=$CWD/_EV_CODE_SIGNING_FINAL/${version}.${revision}
if [ ! -d "$T_WORKSPACE" ]; then 
	safe_mkdir $T_WORKSPACE 
fi

cd $T_WORKSPACE
final_dir=$T_WORKSPACE/_final

download_setup() {
	kind=$1
	platform=$2
	case $kind in
		standard)
			k="rev"
			;;
		enterprise)
			k="ent"
			;;
		*)
			k=$kind
			;;
	esac
	swith 
	safe_mkdir ${final_dir}/${kind}
	cd ${final_dir}/${kind}
	tmp_fn=Eiffel_${version}_${k}_${revision}-${platform}.msi
	echo curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/${revision}/${kind}/${tmp_fn}
	curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/${revision}/${kind}/${tmp_fn}
	f_size=`stat -c %s "$tmp_fn"`
	if [ $f_size -le 1000 ]; then
		rm $tmp_fn
	fi
}

if [ ! -d "${final_dir}" ]; then
	safe_mkdir ${final_dir}

	# AWS Configuration
	if [ -f "$CWD/../etc/aws.rc" ]; then
		echo Get release ${version}  ${revision} from S3 storage
		. $CWD/../etc/aws.rc
		#::aws s3 ls s3://ise.deliv/nightly/${revision}/ 
		aws s3 sync s3://ise.deliv/nightly/${revision}/ ${final_dir}
	else
		echo Get release ${version}  ${revision} from HTTPS site
		#:T_HTTPS
		download_setup "standard" "win64"
		download_setup "enterprise" "win64"
		download_setup "branded" "win64"
	fi
fi

echo "Prepare script to sign all setup files (*.msi)"
T_SIGN_ALL_FILE=$final_dir/sign_all.sh
echo \#Sign all ISE msi from "$final_dir" > $T_SIGN_ALL_FILE
echo "sign_file() {" >> $T_SIGN_ALL_FILE
echo "	$CMD_SIGN \$1;" >> $T_SIGN_ALL_FILE
echo "}" >> $T_SIGN_ALL_FILE

cd $final_dir
echo final_dir=$final_dir
for f in `find . -type f -name "*.msi"` 
do
	echo sign_file "$final_dir/$f" >> $T_SIGN_ALL_FILE 
done

echo Now you should call $T_SIGN_ALL_FILE

cd $CWD
