


--translatieren (if eines der .xeb is neuer als einer von /servlet_Gen/*.e)
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -loop -config $XEBRA_DEV/eiffel_projects/xebra_translator//xebra_translator-voidunsafe.ecf < input_translator.txt


--gen_compiliere (if eines der /servlet_gen/*.e is neuer als /servlet_gen/EIFGens/exe)
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -c_compile -config ./servlet_gen/servlet_gen.ecf


--generiere ( if eines von /.e is neuer als  als /servlet_gen_EIFGENS/exe)
$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/ecb -loop -config ./servlet_gen/servlet_gen.ecf < input_servlet_gen.txt


compiliere (if melted aelter als eines der .e oder .ecf)

run 
