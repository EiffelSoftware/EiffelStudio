#!/bin/bash

T_IRON_DIR=$1
T_IRON_PORT=$2
T_IRON_username=$3
T_IRON_password=$4

T_IRON_BIN=$T_IRON_DIR/bin
T_IRON_WEB=$T_IRON_DIR/www

mkdir -p $T_IRON_WEB/_iron
mkdir -p $T_IRON_WEB/_iron/tmp
chmod u+w $T_IRON_WEB/_iron/tmp
cp -rf $EIFFEL_SRC/tools/iron/delivery/resources/node/doc  $T_IRON_WEB/_iron/doc
cp -rf $EIFFEL_SRC/tools/iron/delivery/resources/node/html  $T_IRON_WEB/_iron/html
cp -rf $EIFFEL_SRC/tools/iron/delivery/resources/node/template  $T_IRON_WEB/_iron/template
# Set irond port number.
echo port=$T_IRON_PORT > $T_IRON_WEB/iron.ini

cd $T_IRON_WEB
$T_IRON_BIN/ironctl system initialize
$T_IRON_BIN/ironctl user create "$T_IRON_username" "$T_IRON_password"

