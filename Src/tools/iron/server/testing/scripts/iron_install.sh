#!/bin/bash

T_IRON_DIR=$1
T_IRON_PORT=$2
T_IRON_user=$3
T_IRON_pass=$4
T_IRON_option=$5

./iron_prepare.sh $T_IRON_DIR $T_IRON_option
./iron_init.sh $T_IRON_DIR $T_IRON_PORT $T_IRON_user $T_IRON_pass

