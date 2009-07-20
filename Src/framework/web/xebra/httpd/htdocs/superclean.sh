echo "Deleting all .generated folders..."
find -type d -name .generated | xargs rm -rf
echo "Deleting all EIFGENs folders..."
find -type d -name EIFGENs | xargs rm -rf
echo "Done"
