#!/bin/bash

# Default values
t_porterpackage_url=https://ftp.eiffel.com/pub/beta/nightly/PorterPackage_NIGHTLY.tar
t_eif_build_dir=$(pwd)/build_Eiffel_PP
t_eif_install_dir=$(pwd)/Eiffel_PP
t_clean="yes"

echo >&2 "Requires: make gcc bzip2 libxtst-dev libgtk2.0-dev libgtk-3-dev libgdk-pixbuf2.0-dev libssl-dev dotnet6"


TMP_SAFETY_DELAY=10

# This script is meant for quick & easy install via:
#   $ curl -fsSL https://github.com/jocelyn/Eiffel-CI/raw/master/setup/install_eiffelstudio_porterpackage.sh -o get-eiffelstudio.sh
#   $ sh get-eiffelstudio.sh
#
# or
#   $ curl -sSL https://github.com/jocelyn/Eiffel-CI/raw/master/setup/install_eiffelstudio_porterpackage.sh | sh
#
# (Inspired by get.docker.com)

T_CURRENT_DIR=$(pwd)

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

check_environment () {

	has_err=""
	curl=''
	if command_exists curl; then
		curl='curl -sSL'
	elif command_exists wget; then
		curl='wget -qO-'
	elif command_exists busybox && busybox --list-modules | grep -q wget; then
		curl='busybox wget -qO-'
	else
		echo >&2 "Missing curl or wget, please install before."
		has_err="error"
	fi

	if ! command_exists bunzip2; then
		echo >&2 "Missing bunzip2, please install before."
		has_err="error"
	fi

	if ! command_exists make; then
		echo >&2 "Missing make, please install before."
		has_err="error"
	fi
	if ! command_exists gcc; then
		echo >&2 "Missing gcc, please install before."
		has_err="error"
	fi
	if [ "$has_err" = "error" ]; then
		exit 1
	fi
}

get_porterpackage () {
	l_url=$1
	l_build_dir=$2

	echo >&2 "Getting eiffelstudio PorterPackage from $l_url ..."

	curl=''
	if command_exists curl; then
		curl='curl -sSL'
		#curl="$curl -H 'Cache-Control: no-cache'"
	elif command_exists wget; then
		curl='wget -qO-'
	elif command_exists busybox && busybox --list-modules | grep -q wget; then
		curl='busybox wget -qO-'
	fi

	#echo Get PorterPackage archive from $l_url .
	#echo "curl -s -L $l_url | tar x -C $l_build_dir"
	#curl -s -L $l_url | tar x -C $l_build_dir
	echo Download and extract archive  PorterPackage_NIGHTLY.tar into $l_build_dir
	$curl $t_porterpackage_url | tar -x -p -s -C $l_build_dir
	echo >&2 "Extracted into $l_build_dir"
}

compile_porterpackage () {
	l_build_dir=$1
	l_ise_platform=$2
	l_target_ise_eiffel=$3

	echo >&2 "Compile eiffelstudio PorterPackage $l_build_dir for $l_ise_platform ..."
	cd $l_build_dir/PorterPackage
	./compile_exes $l_ise_platform

	echo >&2 "Compilation done in $l_build_dir"
	echo >&2 "Move Eiffel_... to $l_target_ise_eiffel"
	mv $l_build_dir/PorterPackage/Eiffel_*.* $l_target_ise_eiffel

}

do_install() {
	echo >&2 "Executing eiffelstudio PorterPackage install script ... ($ISE_CHANNEL)"

	check_environment

	architecture=$(uname -m)
	if [ -z "$ISE_PLATFORM" ]; then
		case $architecture in
			# officially supported
			amd64|x86_64)
				ISE_PLATFORM=linux-x86-64
				;;
			i386|i686)
				ISE_PLATFORM=linux-x86
				;;
			# unofficially supported with available repositories
			armv6l|armv6)
				ISE_PLATFORM=linux-armv6
				;;
			armv7l|armv7)
				ISE_PLATFORM=linux-armv7
				;;
			*)
				echo >&2 Error: $architecture is not a recognized platform.
				exit 1
				;;
		esac
	else
		echo >&2 Using existing ISE_PLATFORM=$ISE_PLATFORM on architecture $architecture
	fi

	user="$(id -un 2>/dev/null || true)"


	#mkdir -p eiffel; cd eiffel
	ISE_EIFFEL=$t_eif_install_dir

	if [ -d "$ISE_EIFFEL" ]; then
		cat >&2 <<-'EOF'
			Warning: the folder $ISE_EIFFEL already exists!

			This script will remove it, to install a fresh release, which is
			why we're displaying this warning and provide the opportunity to cancel the
			installation.

			If you installed the current EiffelStudio package using this script and are using it
		EOF
		cat >&2 <<-'EOF'

			You may press Ctrl+C now to abort this script.
		EOF
		( set -x; sleep $TMP_SAFETY_DELAY )
		\rm -rf "$ISE_EIFFEL"
	fi

	if [ ! -d "$t_eif_build_dir" ]; then
		mkdir -p $t_eif_build_dir
	fi
	get_porterpackage $t_porterpackage_url $t_eif_build_dir
	compile_porterpackage $t_eif_build_dir $ISE_PLATFORM $t_eif_install_dir

	if [ -d $t_eif_install_dir ]; then
		echo >&2 "Clean PorterPackage compilation..."
		cp $t_eif_build_dir/PorterPackage/compile.log $t_eif_install_dir/PorterPackage.log
		if [ "$t_clean" = "yes" ]; then
			echo Deleting PorterPackage directory.
			echo NOT DONE rm -rf $t_eif_build_dir
		fi

		ISE_RC_FILE="$t_eif_install_dir/init.rc"
		echo \# Setup for EiffelStudio ${ISE_MAJOR_MINOR}.${ISE_BUILD} > $ISE_RC_FILE
		echo export ISE_PLATFORM=$ISE_PLATFORM >> $ISE_RC_FILE
		echo export ISE_EIFFEL=$ISE_EIFFEL >> $ISE_RC_FILE
		echo export PATH=\$ISE_EIFFEL/studio/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/tools/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/library/gobo/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/esbuilder/spec/\$ISE_PLATFORM/bin:\$PATH >> $ISE_RC_FILE
		cat $ISE_RC_FILE
	else
		echo >&2 "Compilation failed !"
		exit 1
	fi


	#export ISE_PLATFORM=$ISE_PLATFORM
	#export ISE_EIFFEL=$ISE_EIFFEL
	#export PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin

	. $ISE_RC_FILE

	if command_exists ecb; then
		echo >&2 EiffelStudio installed in $ISE_EIFFEL
		$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -version  >&2
		echo >&2 Use the file $ISE_RC_FILE to setup your Eiffel environment.
		echo >&2 Happy Eiffeling!
	else
		echo >&2 ERROR: Installation failed !!!
		echo >&2 Check inside ${ISE_EIFFEL}
	fi
}

# wrapped up in a function so that we have some protection against only getting
# half the file during "curl | sh"

do_install

cd $T_CURRENT_DIR
