$SPITSHELL > $PACKAGING_DIR/make_install <<!GROK!THIS!
#!/bin/sh
set -e

echo
echo Welcome to the EiffelStudio installer
echo

export ISE_EIFFEL=""
export ISE_PLATFORM=""

if [ "x\$DISPLAY" = "x" ]; then

	echo "Do you want to precompile EiffelBase (required to compile examples) ? [y/n]"
	read prec_base
	echo "Do you want to precompile EiffelVision (might take a while) ? [y/n]"
	read prec_vision2

	if [ "\$prec_base" = "y" ]; then
		echo Precompile EiffelBase
		cd /usr/lib/$PRODUCT/precomp/spec/unix
		rm -rf /usr/lib/$PRODUCT/precomp/spec/unix/EIFGENs/base*
		/usr/bin/ec -precompile -config base.ecf -c_compile -clean
		/usr/bin/ec -precompile -config base-mt.ecf -c_compile -clean
	fi
	if [ "\$prec_vision2" = "y" ]; then
		echo Precompile EiffelVision
		cd /usr/lib/$PRODUCT/precomp/spec/unix
		rm -rf /usr/lib/$PRODUCT/precomp/spec/unix/EIFGENs/vision2
		/usr/bin/ec -precompile -config vision2.ecf -c_compile -clean
		/usr/bin/ec -precompile -config vision2-mt.ecf -c_compile -clean
	fi
else
	WIZARD=/usr/lib/$PRODUCT/studio/wizards/others/precompile
	\$WIZARD/spec/unix/wizard \$WIZARD
fi

exit 0;

!GROK!THIS!

chmod +x $PACKAGING_DIR/make_install
