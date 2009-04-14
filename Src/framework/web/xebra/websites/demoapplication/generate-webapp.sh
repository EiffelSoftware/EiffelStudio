#!/bin/bash
echo ">>>>>>>>>>Compile xebra_translator"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -c_compile -config $XEBRA_DEV/eiffel_projects/xebra_translator/xebra_translator-voidunsafe.ecf
echo ">>>>>>>>>>Generate servlet_gen"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -loop -config $XEBRA_DEV/eiffel_projects/xebra_translator//xebra_translator-voidunsafe.ecf < input_translator.txt
echo ">>>>>>>>>>Compile servlet_gen"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -c_compile -config ./servlet_gen/servlet_gen.ecf
echo ">>>>>>>>>>Generate servlets"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -loop -config ./servlet_gen/servlet_gen.ecf < input_servlet_gen.txt
echo "done"
