#!/bin/sh
platform=/Developer/Platforms/iPhoneOS.platform
allocate=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate
CODESIGN_ALLOCATE=$platform/Developer/usr/bin/codesign_allocate
export CODESIGN_ALLOCATE
codesign -fs "Iphone Developer: Emmanuel Stapf" $1
