#!/bin/sh

mkdir tmp
ecb -config wizard.ecf -target wrapc_wizard -finalize -c_compile -project_path tmp
mkdir -p spec/$ISE_PLATFORM
mv tmp/EIFGENs/wrapc_wizard/F_code/wizard spec/$ISE_PLATFORM/wizard
rm -rf tmp

WIZ_TARGET=$ISE_EIFFEL/studio/wizards/new_projects/wrapc
rm -rf $WIZ_TARGET
mkdir $WIZ_TARGET
cp -r rootdir/resources $WIZ_TARGET/resources
cp -r spec $WIZ_TARGET/spec
cp rootdir/wrapc.dsc $WIZ_TARGET/../wrapc.dsc
rm -rf spec
