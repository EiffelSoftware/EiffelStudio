#!/bin/sh

COMPILEALL_DIR=$1
COMPILEALL_IGNORE=$2
COMPILEALL_CMD="compile_all -ecb -melt -list_failures -log_verbose -clean -options dotnet=false"

if [ ! -z "$COMPILEALL_IGNORE" ]; 
then
	if [ -f $COMPILEALL_IGNORE ];
	then
		COMPILEALL_CMD="$COMPILEALL_CMD -ignore $COMPILEALL_IGNORE"
	fi
fi
COMPILEALL_CMD="$COMPILEALL_CMD -l $COMPILEALL_DIR"
$COMPILEALL_CMD

