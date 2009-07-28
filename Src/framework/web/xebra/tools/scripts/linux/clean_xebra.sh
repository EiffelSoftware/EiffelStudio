if [ -x "$XEBRA_DEV" ]; then
	:
else
 	echo "XEBRA_DEV is not defined. Please define before running script.";
 	exit;
fi;
cd $XEBRA_DEV
echo "Deleting all .generated folders..."
find -type d -name .generated | xargs rm -rf
echo "Deleting all EIFGENs folders..."
find -type d -name EIFGENs | xargs rm -rf
echo "Done"
