#!/bin/sh

dir=$1
export EWEASEL_OUTPUT=$2

#Usage ci-eweasel.sh current-dir eweasel-output
#requirement:
# Eiffel environment setup  (ISE_EIFFEL, ...)
# EWEASEL, EWEASEL_OUTPUT set


export ISE_PRECOMP=$dir/precomp
export PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$EWEASEL/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin

echo "  - hack the Eiffel installation to replace ec by ecb"
mv $ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ec $ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ec-dist
ln -s $ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb $ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ec
echo "  - set EC_NAME=ecb"
export EC_NAME=ecb

#Compile eweasel
echo Compile eweasel
failure=0
cd $EWEASEL/compilation
./install_eweasel || failure=1
if [ $failure -eq 1 ]; then
	echo Eweasel compilation failed
    exit 1
fi

#Create the precompilation directory
#Not needed as calling `install_eweasel' above has the side effect of creating it.
#mkdir $ISE_PRECOMP
#cp -f $ISE_EIFFEL/precomp/spec/$ISE_PLATFORM/*.ecf $ISE_PRECOMP/
echo Clean eweasel workspace
if [ -d $ISE_PRECOMP ]; then
	\rm -rd $ISE_PRECOMP
fi
mkdir $ISE_PRECOMP


#Prepare the precompile libraries
$EWEASEL/bin/run_eweasel no -clean

failure=0
$EWEASEL/spec/$ISE_PLATFORM/bin/eweasel-mt -order -max_threads 7 -define EWEASEL $EWEASEL \
-define INCLUDE $EWEASEL/control -define ISE_EIFFEL $ISE_EIFFEL -define ISE_PLATFORM \
$ISE_PLATFORM -define ISE_LIBRARY $ISE_LIBRARY -define UNIX 1 -define PLATFORM_TYPE unix \
-init $EWEASEL/control/init -output $EWEASEL_OUTPUT -keep failed -filter "kw pass" \
-catalog $EWEASEL/control/catalog || failure=1


if [ $failure -eq 1 ]; then
    echo eweasel tests failed
    exit 1
else
  # Cleanup ?
fi

