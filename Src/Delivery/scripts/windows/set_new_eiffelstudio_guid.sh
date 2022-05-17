#!/bin/bash

function check_requirements() {
	if ! [ -x "$(command -v svn)" ]; then
		echo "error: svn is not installed! (on debian use > sudo apt install subversion)" >&2
	fi
	if ! [ -x "$(command -v uuidgen)" ]; then
		echo "error: uuidgen is not installed! (on debian use > sudo apt install uuid-runtime)" >&2
	fi
	if ! [ -x "$(command -v awk)" ]; then
		echo "error: awk is not installed!" >&2
	fi
	if ! [ -x "$(command -v sed)" ]; then
		echo "error: sed is not installed!" >&2
	fi
}

function new_uuid() {
	# note: on debian uuidgen comes with package "uuid-runtime"
	#     > sudo apt-get install "uuid-runtime"
	if [ -x "$(command -v uuidgen)" ]; then
		echo $(uuidgen) | awk '{print toupper($0)}'
	else
		echo "error: uuidgen is not installed. (on debian use > sudo apt install uuid-runtime)" >&2
		echo $(od -x /dev/urandom | head -1 | awk '{OFS="-"; print $2$3,$4,$5,$6,$7$8$9}' | awk '{print toupper($0)}')
	fi
}

function do_sed {
	echo sed -i -e "$1" "$2" 
	sed -i -e "$1" "$2" 
}

echo Update EiffelStudio GUIDs
check_requirements

if [ -z "$EIFFEL_SRC" ]; then
	if [ -z "$EIF_DELIV_SCRIPTS_DIR" ]; then
		EIF_DELIV_SCRIPTS_DIR_WINDOWS=`pwd -P`
	else
		EIF_DELIV_SCRIPTS_DIR_WINDOWS=$EIF_DELIV_SCRIPTS_DIR/windows
	fi
else
	EIF_DELIV_SCRIPTS_DIR_WINDOWS=$EIFFEL_SRC/Delivery/scripts/windows
fi

# $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
svn revert "$EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi"

line=37
do_sed "$((line+1))s/\(ProductGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+2))s/\(RegistriesGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+3))s/\(ShortcutsGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi


do_sed "$((line+5))s/\(ProductGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+6))s/\(RegistriesGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+7))s/\(ShortcutsGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi

do_sed "$((line+9))s/\(UpgradeGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi

#svn diff "$EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi"
#echo Check the lines are still the same
