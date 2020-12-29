#!/bin/bash

T_IRON_DIR=$1
if [ "$2" =  "--clean" ]
  then
    TMP_CLEAN=1
  else
    TMP_CLEAN=0
fi

T_COMP=$T_IRON_DIR/_comp
T_IRON_BIN=$T_IRON_DIR/bin
mkdir -p $T_COMP
mkdir -p $T_IRON_BIN

function eif_generate_exec {
	T_FILE=$1
	T_TARGET=$2
	T_SYSTNAME=$3
	T_EXECNAME=$4

	ec -finalize -c_compile -config $T_FILE -target $T_TARGET -project_path $T_COMP
	cp $T_COMP/EIFGENs/$T_TARGET/F_code/$T_SYSTNAME $T_IRON_BIN/$T_EXECNAME
	if [ "$TMP_CLEAN" -eq  "1" ]
	  then
	    \rm -rf $T_COMP/EIFGENs/$T_TARGET
	fi
}

echo Update trunk
svn update --non-interactive $EIFFEL_SRC
echo Compile IRON controller
eif_generate_exec $EIFFEL_SRC/tools/iron/server/controller.ecf controller ironctl ironctl
echo Compile IRON standalone server
eif_generate_exec $EIFFEL_SRC/tools/iron/server/server.ecf server_standalone irond irond
#echo Compile IRON FCGI server
#eif_generate_exec $EIFFEL_SRC/tools/iron/server/server.ecf server_libfcgi irond irond-libfcgi

if [ "$TMP_CLEAN" -eq  "1" ]
  then
    \rm -rf $T_COMP
fi
