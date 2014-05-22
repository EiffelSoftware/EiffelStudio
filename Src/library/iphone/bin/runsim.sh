#!/bin/bash
#
# runsim   Install and run apps in the iOS Simulator
#
# Copyright (c) 2012 Psellos   http://psellos.com/
# Licensed under the MIT License:
#     http://www.opensource.org/licenses/mit-license.php
#
USAGE='usage:  runsim  [ -i { phone | pad } ] [ -srdl ]  executable  file ...'
#
# -iphone   Install as iPhone app
# -ipad     Install as iPad app
# -s        Start iOS Simulator
# -r        Run the app in the simulator
# -d        Delete the installed app
# -l        List names of installed apps
#
# file ...  Additional files to install with the executable
#
# Default flags are -iphone -s (install as iPhone app and start simulator).
#
# Currently the -r flag uses Instruments and thus requires
# authentication as a member of the _developer group.
#
VERSION=2.0.0

INSTALL=n
START=n
RUN=n
DELETE=n
LIST=n
while getopts i:srdl opt; do
    case "$opt" in
    i)
        INSTALL=y
        case "$OPTARG" in
        phone) FAMILY=1 ;;
        pad) FAMILY=2 ;;
        *)
            echo "runsim: unrecognized device family: $OPTARG" >&2
            echo "$USAGE" >&2
            exit 1
            ;;
        esac
        ;;
    s) START=y ;;
    r) RUN=y ;;
    d) DELETE=y ;;
    l) LIST=y ;;
    ?) echo "$USAGE" >&2; exit 1 ;;
    esac
done
shift $(($OPTIND - 1))

case "$INSTALL$START$RUN$DELETE$LIST" in nnnnn)
    INSTALL=y
    FAMILY=1
    START=y
esac

if [ "$INSTALL$RUN$DELETE" != nnn -a $# -lt 1 ]; then
    echo 'runsim: need an executable name for -i -r or -d' >&2
    echo "$USAGE" >&2
    exit 1
fi
EXEC="$1"
shift

APPDIR="$HOME/Library/Application Support/iPhone Simulator/7.1-64/Applications"

TRCSUB=Contents/Applications/Instruments.app\
/Contents/PlugIns/AutomationInstrument.bundle\
/Contents/Resources/Automation.tracetemplate

xcodeloc() {
    # Get location of Xcode, otherwise use default
    if [ -f runsim.xcloc ]; then
        cat runsim.xcloc
    else
        echo /Applications/Xcode.app
    fi
}

appuuid() {
    # Get UUID for an app. If installed, re-use existing one. Otherwise
    # create a new one and return it.
    #
    for f in "$APPDIR"/*/"$1.app" ; do
        if [ -d "$f" ]; then
            basename "$(dirname "$f")"
            return 0
        fi
    done
    uuidgen
}

install() {
    # Install executable $EXEC and associated files into simulator's
    # file system.
    #

    # Figure out startup file, if any. If a nibfile or storyboard file
    # is given, the first one is the startup file. Otherwise if there's
    # a file $EXEC.nib or $EXEC.storyboard, that is the startup file.
    # Otherwise there is no startup file.
    #
    NIBFILE=
    STORYFILE=
    if [ -f "$EXEC.nib" ]; then
        NIBFILE="$EXEC"
    elif [ -f "$EXEC.storyboard" ]; then
        STORYFILE="$EXEC"
    fi
    for f ; do
        case "$f" in
        *.nib)
            STORYFILE=; NIBFILE="$(basename "$f" .nib)"; break ;;
        *.storyboard)
            NIBFILE=; STORYFILE="$(basename "$f" .storyboard)"; break ;;
        esac
    done

    UUID=$(appuuid "$EXEC")

    # Install app and associated files.
    #
    TOPDIR="$APPDIR/$UUID"
    mkdir -p "$TOPDIR"
    mkdir -p "$TOPDIR/Documents"
    mkdir -p "$TOPDIR/Library"
    mkdir -p "$TOPDIR/tmp"
    mkdir -p "$TOPDIR/$EXEC.app"

    cp "$EXEC" "$TOPDIR/$EXEC.app"

    if [ "$NIBFILE" != "" ]; then
        cp "$NIBFILE.nib" "$TOPDIR/$EXEC.app"
    elif [ "$STORYFILE" != "" ]; then
        cp "$STORYFILE.storyboard" "$TOPDIR/$EXEC.app"
    fi

    # If an Info.plist exists, use it.  Otherwise make one.
    if [ -f Info.plist ] ; then
        plutil -convert xml1 -o "$TOPDIR/$EXEC.app/Info.plist" Info.plist
    else
        cat > "$TOPDIR/$EXEC.app/Info.plist" <<HERE1
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>CFBundleDevelopmentRegion</key>
        <string>en</string>
        <key>CFBundleDisplayName</key>
        <string>$EXEC</string>
        <key>CFBundleExecutable</key>
        <string>$EXEC</string>
        <key>CFBundleIconFile</key>
        <string>Icon.png</string>
        <key>CFBundleIdentifier</key>
        <string>com.eiffel.$EXEC</string>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleName</key>
        <string>$EXEC</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleSignature</key>
        <string>????</string>
        <key>CFBundleShortVersionString</key>
        <string>1.0</string>
        <key>CFBundleVersion</key>
        <string>1.0.0</string>
        <key>UIStatusBarStyle</key>
        <string>UIStatusBarStyleBlackOpaque</string>
        <key>LSRequiresIPhoneOS</key>
        <true/>
		<key>UILaunchImages</key>
		<array>
			<dict>
				<key>UILaunchImageMinimumOSVersion</key>
				<string>7.0</string>
			</dict>
		</array>
		<key>UISupportedInterfaceOrientations</key>
		<array>
			<string>UIInterfaceOrientationPortrait</string>
			<string>UIInterfaceOrientationLandscapeLeft</string>
			<string>UIInterfaceOrientationLandscapeRight</string>
		</array>

HERE1
        if [ "$NIBFILE" != "" ]; then
            cat >> "$TOPDIR/$EXEC.app/Info.plist" << HERE2
        <key>NSMainNibFile</key>
        <string>$NIBFILE</string>
HERE2
        elif [ "$STORYFILE" != "" ]; then
            cat >> "$TOPDIR/$EXEC.app/Info.plist" << HERE3
        <key>NSMainStoryboardFile</key>
        <string>$STORYFILE</string>
HERE3
        fi
        cat >> "$TOPDIR/$EXEC.app/Info.plist" <<HERE4
</dict>
</plist>
HERE4
    fi

    # Add device specifications to Info.plist (normally done by Xcode).
    # Without these, Instruments reports the app as AWOL.
    #
    python -c '
import plistlib
import sys
p = plistlib.readPlist(sys.argv[1])
p["CFBundleSupportedPlatforms"] = ["iPhoneSimulator"]
p["DTPlatformName"] = "iphonesimulator"
p["DTSDKName"] = "iphonesimulator7.1"
p["UIDeviceFamily"] = ['$FAMILY']
plistlib.writePlist(p, sys.argv[1])
' "$TOPDIR/$EXEC.app/Info.plist"

    echo -n 'AAPL????' > "$TOPDIR/$EXEC.app/PkgInfo"

    # Install conventional image files if they exist.
    #
    if [ -f Icon.png ]; then
        cp Icon.png "$TOPDIR/$EXEC.app"
    fi
    if [ -f Default.png ]; then
        cp Default.png "$TOPDIR/$EXEC.app"
    fi

    # Install any other given files.
    #
    for f; do
        if [ "$f" = "$NIBFILE.nib" ]; then continue; fi
        if [ "$f" = "$STORYFILE.storyboard" ]; then continue; fi
        cp "$f" "$TOPDIR/$EXEC.app"
    done
}


start() {
    # Start the iOS Simulator
    #
    #open "$(xcodeloc)"/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app --args -SimulateApplication $APPDIR/$(appuuid "$EXEC")/$EXEC.app
    open "$(xcodeloc)"/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app
}


run() {
    # Run the app inside iOS Simulator by asking Instruments to trace it
    # with null trace. If you haven't agreed to the licensing terms of
    # Xcode, this will fail until you do.  The first time in each login
    # session, this will ask for authentication as an admin or
    # developer.
    #
    TOPDIR="$APPDIR/$(appuuid "$EXEC")"
    if [ ! -d "$TOPDIR/$EXEC.app" ]; then
        echo "runsim: app \"$EXEC\" not installed" >&2
        exit 1
    fi
    (instruments -D /tmp/runsim$$.trace -t "$(xcodeloc)/$TRCSUB" \
            "$TOPDIR/$EXEC.app" < /dev/null 2>&1 > /dev/null | \
            grep 'xcodebuild -license' >&2 ; \
        rm -rf /tmp/runsim$$.trace) &
}

delete() {
    # Delete an installed app.
    #
    TOPDIR="$APPDIR/$(appuuid "$EXEC")"
    if [ ! -d "$TOPDIR" ]; then
        echo "runsim: app \"$EXEC\" not installed" >&2
        exit 1
    fi
    rm -rf "$TOPDIR"
}

list() {
    # List installed apps.
    #
    for f in "$APPDIR"/*/*.app ; do
        if [ -d "$f" ]; then
            basename "$f" .app
        fi
    done
}


case $INSTALL in y) install "$@" ;; esac
case $START in y) start ;; esac
case $RUN in y) run ;; esac
case $DELETE in y) delete ;; esac
case $LIST in y) list ;; esac
