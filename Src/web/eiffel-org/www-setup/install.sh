#!/bin/bash

# This script is meant for quick & easy install via:
#   $ curl -fsSL https://svn.eiffel.com/eiffelstudio/trunk/Src/web/eiffel-org/www-setup/install.sh -o get-eiffelstudio.sh
#   $ sh get-eiffelstudio.sh
#
# or
#   $ curl -sSL https://svn.eiffel.com/eiffelstudio/trunk/Src/web/eiffel-org/www-setup/install.sh | bash -s --
#
# (Inspired by get.docker.com)
#
# Optional arguments:
#
# --platform {ise_platform}: set the targetted platform (linux-x86, linux-x86-64, ...)
# --install-dir: location for the targetted $ISE_EIFFEL
# --dir: parent location for the targetted $ISE_EIFFEL based on major.minor values (it should be writable).
# --url url-to-eiffel-installation-archive: url to installation archive for instance from the ftp.eiffel.com
# --channel latest|beta|nightly|major.minor.build: choose the channel, latest stable version, beta or nightly, 
#					or directly the stable $major.$minor.$build
#
# Notes:
#   the default value for --channel is latest.
#   the platform value is taken from $ISE_PLATFORM or guessed from the architecture.
#
# Examples when script available via https://www.eiffel.org/setup/install.sh :
#  $ curl -sSL https://www.eiffel.org/setup/install.sh | bash -s -- --channel nightly --dir /opt/eiffel
#  $ curl -sSL https://www.eiffel.org/setup/install.sh | bash -s -- --channel nightly --install-dir /opt/eiffel/nightly --dir /opt/eiffel
#  $ curl -sSL https://www.eiffel.org/setup/install.sh | bash -s -- --url https://ftp.eiffel.com/pub/beta/nightly/Eiffel_20.05_rev_104521-linux-x86-64.tar.bz2 --install-dir /opt/eiffel/test --dir /opt/eiffel

# Default values
ISE_MAJOR_MINOR_LATEST=20.05
ISE_BUILD_LATEST=104521
ISE_TYPE_LATEST=rev

ISE_MAJOR_MINOR_NIGHTLY=20.05
ISE_BUILD_NIGHTLY=104521
ISE_TYPE_NIGHTLY=rev

ISE_MAJOR_MINOR_BETA=20.05
ISE_BUILD_BETA=104521
ISE_TYPE_BETA=rev
#ISE_BETA_DOWNLOAD_URL=http://downloads.sourceforge.net/eiffelstudio

# predefined
T_CURRENT_DIR=$(pwd)
ISE_SF_DOWNLOAD_URL=http://downloads.sourceforge.net/eiffelstudio

# Arguments
POSITIONAL=()
while [[ $# -gt 0 ]]
do
	key=$1
	case $key in
		--channel)
			ISE_CHANNEL=$2
			shift
			shift
		;;
		--url)
			ISE_CUSTOM_URL=$2
			if [ -z "$ISE_CHANNEL" ]; then
				ISE_CHANNEL=$2
			fi
			shift
			shift
		;;
		--platform)
			ISE_PLATFORM=$2
			shift
			shift
		;;
		--install-dir)
			ISE_INSTALL_DIR=$2
			shift
			shift
		;;
		--dir)
			T_CURRENT_DIR=$2
			shift
			shift
		;;
		*)
			POSITIONAL+=("$1") # save it in an array for later
			shift
		;;
	esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters
while true; do
	case $1 in
		--*)
			echo >&2 Ignore argument "$1"
			shift || break
			;;
		*)
			if [ -z "$ISE_CHANNEL" ]; then
				#echo >&2 "Set ISE_CHANNEL with $1"
				ISE_CHANNEL=$1
				shift || break
			else
				if [ -z "$ISE_PLATFORM" ]; then
					#echo >&2 "Set ISE_PLATFORM with $1"
					ISE_PLATFORM=$1
					shift || break
				else
					#if [ ! -z "$1" ]; then
						#echo >&2 "Ignore argument \"$1\""
					#fi
					shift || break
				fi
			fi
		;;
	esac
done

TMP_SAFETY_DELAY=10


# This value will automatically get changed for:
#   * latest
#	* specific release, using major.minor.build (such as 17.05.100416)
#   * beta
#   * nightly

DEFAULT_ISE_CHANNEL_VALUE="latest"
if [ -z "$ISE_CHANNEL" ]; then
    ISE_CHANNEL=$DEFAULT_ISE_CHANNEL_VALUE
fi

iseverParse() {
	major="${1%%.*}"
	minor="${1#$major.}"
	minor="${minor%%.*}"
	build="${1#$major.$minor.}"
}

iseverParseName() {
	f=$1
	t="${f#*_}"
	major="${t%%.*}"
	t="${t#*.}"
	minor="${t%%_*}"
	t="${t#*_}"
	lic="${t%%_*}"
	t="${t#*_}"
	build="${t%%-*}"
}

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

do_install() {
	echo >&2 "Executing eiffelstudio install script ... ($ISE_CHANNEL)"

	if [ -n "$HOSTTYPE" ]; then
		architecture=$HOSTTYPE
	else
		architecture=$(uname -m)
	fi
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
			# not supported armv7 ...
			*)
				echo >&2 Error: $architecture is not a recognized platform.
				exit 1
				;;
		esac
		echo >&2 Using ISE_PLATFORM=$ISE_PLATFORM on architecture $architecture
	else
		echo >&2 Using existing ISE_PLATFORM=$ISE_PLATFORM on architecture $architecture
	fi

	case $ISE_CHANNEL in
		nightly)
			if [ "$ISE_MAJOR_MINOR_NIGHTLY.$ISE_BUILD_NIGHTLY" = "$ISE_MAJOR_MINOR_LATEST.$ISE_BUILD_LATEST" ]; then
				# Use latest release!
				echo >&2 Nightly is same as latest release.
				ISE_CHANNEL="latest"
			elif [ "$ISE_MAJOR_MINOR_NIGHTLY.$ISE_BUILD_NIGHTLY" = "$ISE_MAJOR_MINOR_BETA.$ISE_BUILD_BETA" ]; then
				# Use beta release!
				echo >&2 Nightly is same as beta release.
				ISE_CHANNEL="beta"
			fi
			;;
		beta)
			if [ "$ISE_MAJOR_MINOR_BETA.$ISE_BUILD_BETA" = "$ISE_MAJOR_MINOR_LATEST.$ISE_BUILD_LATEST" ]; then
				# Use latest release!
				echo >&2 Beta is same as latest release.
				ISE_CHANNEL="latest"
			fi
			;;
		*)
			;;
	esac


	case $ISE_CHANNEL in
		latest)
			#Use defaults .. see above.
			echo >&2 Use latest release.
			ISE_MAJOR_MINOR=$ISE_MAJOR_MINOR_LATEST
			ISE_BUILD=$ISE_BUILD_LATEST
			ISE_DOWNLOAD_FILE=Eiffel_${ISE_MAJOR_MINOR}_${ISE_TYPE_LATEST}_${ISE_BUILD}-${ISE_PLATFORM}.tar.bz2
			ISE_DOWNLOAD_URL=${ISE_SF_DOWNLOAD_URL}/$ISE_DOWNLOAD_FILE
			iseverParse $ISE_MAJOR_MINOR.$ISE_BUILD
			echo >&2 Version=$major.$minor.$build
			;;
		beta)
			echo >&2 Use beta release.
			ISE_MAJOR_MINOR=$ISE_MAJOR_MINOR_BETA
			ISE_BUILD=$ISE_BUILD_BETA
			ISE_DOWNLOAD_FILE=Eiffel_${ISE_MAJOR_MINOR}_${ISE_TYPE_BETA}_${ISE_BUILD}-${ISE_PLATFORM}.tar.bz2
			if [ -z "$ISE_BETA_DOWNLOAD_URL" ]; then
				ISE_DOWNLOAD_URL=https://ftp.eiffel.com/pub/beta/$ISE_MAJOR_MINOR/$ISE_DOWNLOAD_FILE
			else
				ISE_DOWNLOAD_URL=$ISE_BETA_DOWNLOAD_URL/$ISE_DOWNLOAD_FILE
			fi
			iseverParse $ISE_MAJOR_MINOR.$ISE_BUILD
			echo >&2 Version=$major.$minor.$build
			;;
		nightly)

			echo >&2 Use nighlty release.
			ISE_MAJOR_MINOR=$ISE_MAJOR_MINOR_NIGHTLY
			ISE_BUILD=$ISE_BUILD_NIGHTLY
			ISE_DOWNLOAD_FILE=Eiffel_${ISE_MAJOR_MINOR}_${ISE_TYPE_NIGHTLY}_${ISE_BUILD}-${ISE_PLATFORM}.tar.bz2
			ISE_DOWNLOAD_URL=https://ftp.eiffel.com/pub/beta/nightly/$ISE_DOWNLOAD_FILE
			iseverParse $ISE_MAJOR_MINOR.$ISE_BUILD
			echo >&2 Version=$major.$minor.$build
			;;
		*)
			if [ -z "$ISE_CUSTOM_URL" ]; then
				echo >&2 Use custom release $ISE_CHANNEL if any
				iseverParse $ISE_CHANNEL
				echo >&2 $major.$minor.$build
				ISE_MAJOR_MINOR=$major.$minor
				ISE_BUILD=$build
				ISE_DOWNLOAD_FILE=Eiffel_${ISE_MAJOR_MINOR}_rev_${ISE_BUILD}-${ISE_PLATFORM}.tar.bz2
				ISE_DOWNLOAD_URL=https://ftp.eiffel.com/pub/download/$ISE_MAJOR_MINOR/$ISE_DOWNLOAD_FILE
			else
				echo >&2 Use custom url $ISE_CUSTOM_URL 
				ISE_CHANNEL=`basename $ISE_CHANNEL` 
				if [ "`echo $ISE_CHANNEL | tr -d -c '.' | wc -c`" = "2" ]; then
					iseverParse $ISE_CHANNEL
				else
					iseverParseName $ISE_CHANNEL
				fi
				echo >&2 $major.$minor.$build
				ISE_MAJOR_MINOR=$major.$minor
				ISE_BUILD=$build
				ISE_DOWNLOAD_URL=$ISE_CUSTOM_URL
			fi
			;;
	esac

	if command_exists ecb; then
		cat >&2 <<-'EOF'
			Warning: the "ecb" command appears to already exist on this system.

			If you already have EiffelStudio installed, this script can cause trouble, which is
			why we're displaying this warning and provide the opportunity to cancel the
			installation.

			If you installed the current EiffelStudio package using this script and are using it
		EOF
		#FIXME: check if conflict may exists!
		cat >&2 <<-'EOF'
		again to update EiffelStudio, you can safely ignore this message.
		EOF

		cat >&2 <<-'EOF'

			You may press Ctrl+C now to abort this script.
		EOF
		( set -x; sleep $TMP_SAFETY_DELAY )
	fi
		
	user="$(id -un 2>/dev/null || true)"

	curl=''
	if command_exists curl; then
		curl='curl -sSL'
		#curl="$curl -H 'Cache-Control: no-cache'"
	elif command_exists wget; then
		curl='wget -qO-'
	elif command_exists busybox && busybox --list-modules | grep -q wget; then
		curl='busybox wget -qO-'
	fi

	#mkdir -p eiffel; cd eiffel
	if [ -n "$ISE_INSTALL_DIR" ]; then
		ISE_EIFFEL=$ISE_INSTALL_DIR
	else
		ISE_EIFFEL=$T_CURRENT_DIR/Eiffel_$ISE_MAJOR_MINOR
	fi

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

	echo >&2 Get $ISE_DOWNLOAD_URL
	if [ -z "$ISE_DOWNLOAD_URL" ]; then
		echo >&2 No download url !!!
		exit 1
	fi

	if [ -n "$ISE_INSTALL_DIR" ]; then
		tdir=$(mktemp -d /tmp/eiffel.XXXXXXXXX)
		cd ${tdir}
		$curl $ISE_DOWNLOAD_URL | tar -x -p -s --bzip2
		mv ${tdir}/Eiffel_$ISE_MAJOR_MINOR $ISE_INSTALL_DIR
		\rm -rf ${tdir}
	else
		#Should be inside $ISE_EIFFEL=$T_CURRENT_DIR/Eiffel_$ISE_MAJOR_MINOR
		$curl $ISE_DOWNLOAD_URL | tar -x -p -s --bzip2
	fi

	ISE_RC_FILE="$ISE_EIFFEL/setup.rc"
	echo \# Setup for EiffelStudio ${ISE_MAJOR_MINOR}.${ISE_BUILD} > $ISE_RC_FILE
	echo export ISE_PLATFORM=$ISE_PLATFORM >> $ISE_RC_FILE
	echo export ISE_EIFFEL=$ISE_EIFFEL >> $ISE_RC_FILE
	echo export PATH=\$ISE_EIFFEL/studio/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/tools/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/library/gobo/spec/\$ISE_PLATFORM/bin:\$ISE_EIFFEL/esbuilder/spec/\$ISE_PLATFORM/bin:\$PATH >> $ISE_RC_FILE
	cat $ISE_RC_FILE

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
	cd $T_CURRENT_DIR
}

# wrapped up in a function so that we have some protection against only getting
# half the file during "curl | sh"

do_install

