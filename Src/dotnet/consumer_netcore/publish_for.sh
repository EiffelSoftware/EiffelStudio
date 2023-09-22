#!/bin/sh

ARG_PLATFORM=$1

echo Publish MD consumer NETCore "nemdc" for platform $ARG_PLATFORM
TMP_OPTS=
case $ARG_PLATFORM in
	win64)
		TMP_OPTS="--self-contained --runtime win-x64"
		;;
	windows)
		TMP_OPTS="--self-contained --runtime win-x86"
		;;
	linux-x86-64)
		TMP_OPTS="--self-contained --runtime linux-x64"
		;;
	linux-arm64)
		TMP_OPTS="--self-contained --runtime linux-arm64"
		;;
	macosx-x86-64)
		TMP_OPTS="--self-contained --runtime osx-x64"
		;;
	*)
		TMP_OPTS="--self-contained --use-current-runtime"
		;;
esac

dotnet publish cs/md_consumer_app/app.csproj --configuration Release $TMP_OPTS --output "pub/$ARG_PLATFORM"
