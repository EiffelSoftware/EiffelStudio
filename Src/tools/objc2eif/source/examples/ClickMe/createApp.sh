#!/bin/sh

APP_NAME=`/usr/libexec/PlistBuddy -c "Print :CFBundleName" Resources/Info.plist`
EXECUTABLE_NAME=`/usr/libexec/PlistBuddy -c "Print :CFBundleExecutable" Resources/Info.plist`
NIB_NAME=`/usr/libexec/PlistBuddy -c "Print :NSMainNibFile" Resources/Info.plist`

mkdir -p "$APP_NAME.app/Contents/MacOS"
mkdir -p "$APP_NAME.app/Contents/Resources"

cp Resources/Info.plist "$APP_NAME.app/Contents/"
echo "APPL????" > "$APP_NAME.app/Contents/PkgInfo"
cp "EIFGENs/$EXECUTABLE_NAME/W_code/$EXECUTABLE_NAME" "$APP_NAME.app/Contents/MacOS/"
ibtool "Resources/$NIB_NAME.xib" --compile "Resources/$NIB_NAME.nib"
mv "Resources/$NIB_NAME.nib" "$APP_NAME.app/Contents/Resources/"