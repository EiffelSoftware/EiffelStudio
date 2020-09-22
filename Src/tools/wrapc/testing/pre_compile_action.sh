#!/bin/sh

set CWD=`pwd`
cd ../../library

if [ -d "./generated_wrapper" ] 
then
    echo "generated code exists." 
else
$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin/wrap_c --verbose --script_pre_process=pre_script.sh --script_post_process=post_script.sh --output-dir=generated_wrapper  --full-header=./manual_wrapper/c/include/wrapc_testing.h  --config=config.xml
cd $CWD
fi

exit 0
