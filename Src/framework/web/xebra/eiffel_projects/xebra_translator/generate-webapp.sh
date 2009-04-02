#/home/sandrod/local/EIFGENs/xebra_translator/F_code/xebra_translator $1 $2 $2 $2servlet_gen/

echo "Compile xebra_translator"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -c_compile -config $XEBRA_DEV/eiffel_projects/xebra_translator/xebra_translator.ecf
echo "Generate servlet_gen"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -loop -config $XEBRA_DEV/eiffel_projects/xebra_translator/xebra_translator.ecf < input_translator.txt
echo "Compile servlet_gen"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -c_compile -config $XEBRA_DEV/websites/$1/servlet_gen/servlet_gen.ecf
echo "Generate servlets"
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -loop -config $XEBRA_DEV/websites/$1/servlet_gen/servlet_gen.ecf < input_servlet_gen.txt
