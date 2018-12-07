#!/bin/bash

function new_uuid() {
	echo $(od -x /dev/urandom | head -1 | awk '{OFS="-"; print $2$3,$4,$5,$6,$7$8$9}' | awk '{print toupper($0)}')
}

function do_sed {
	echo sed -i -e "$1" "$2" 
	sed -i -e "$1" "$2" 
}

echo Update EiffelStudio GUIDs

if [ -z "$EIFFEL_SRC"]; then
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

line=32
do_sed "$((line+1))s/\(ProductGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+2))s/\(RegistriesGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+3))s/\(ShortcutsGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi


do_sed "$((line+5))s/\(ProductGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+6))s/\(RegistriesGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi
do_sed "$((line+7))s/\(ShortcutsGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi

do_sed "$((line+9))s/\(UpgradeGuid\s*=\s*\)\"[0-9A-Fa-f-]*\"/\1\"$(new_uuid)\"/g" $EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi

#svn diff "$EIF_DELIV_SCRIPTS_DIR_WINDOWS/install/includes/Preprocessors.wxi"
#echo Check the lines are still the same
