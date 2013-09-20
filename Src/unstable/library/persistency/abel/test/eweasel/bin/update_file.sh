#!/bin/sh
# Process $1 excluding all content of .svn directory.
# Update action below to do what you want.

if echo "$1" | grep -v ".svn" >/dev/null 2>&1; then
	echo Processing $1
	sed -e "s/\$EWEASEL_DOTNET_SETTING/\$EWEASEL_DOTNET_SETTING\n/g" $1 > tmp
	mv -f tmp $1
fi
