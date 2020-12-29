#!/bin/bash

T_IRON_DIR=$1
T_IRON_PORT=$2
T_IRON_username=$3
T_IRON_password=$4

T_IRON_VERSION=trunk

T_IRON_BIN=$T_IRON_DIR/bin
T_IRON_WEB=$T_IRON_DIR/www

mkdir -p $T_IRON_WEB/_iron/repo/versions/$T_IRON_VERSION
cd $T_IRON_WEB
#Launch the irond server for the building time.
$T_IRON_BIN/irond &

mkdir -p $T_IRON_DIR/scripts/upload/VERSIONS/
cp -rf $EIFFEL_SRC/tools/iron/delivery/upload/VERSIONS/alter $T_IRON_DIR/scripts/upload/VERSIONS/alter

iron repository -a http://localhost:$T_IRON_PORT/$T_IRON_VERSION

cd $T_IRON_DIR/scripts/upload/
#Build trunk.cfg
echo -e  "# Iron uploading config" 		> trunk.cfg
echo -e  "username=${T_IRON_username}" >> trunk.cfg
echo -e  "password=${T_IRON_password}" >> trunk.cfg
echo -e  "repository=http://localhost:${T_IRON_PORT}/${T_IRON_VERSION}" >> trunk.cfg
echo -e  "branch=${T_IRON_VERSION}" >> trunk.cfg

python ${EIFFEL_SRC}/tools/iron/delivery/upload/ise_upload_version.py trunk.cfg

#Kill previous irond for the building time.
pkill -9 irond

