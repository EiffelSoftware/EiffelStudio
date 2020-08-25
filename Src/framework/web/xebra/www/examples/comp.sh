#!/bin/sh

export MY_WAPP=examples
export EC_MODE=F_code

echo TRANSLATE
$XEBRA_DEV/eiffel_projects/xebra_translator/EIFGENs/xebra_translator/$EC_MODE/xebra_translator -n $MY_WAPP -i . -o . -l $XEBRA_DEV/eiffel_projects/xebra_translator -f
 
echo COMPILE servlet_gen
ec -config .generated/servlet_gen/servlet_gen.ecf -target servlet_gen -c_compile -stop -project_path .generated/servlet_gen -clean

echo Execute servlet_gen
.generated/servlet_gen/EIFGENs/servlet_gen/W_code/servlet_gen -o .

echo COMPILE webapp
ec -config $MY_WAPP.ecf -target $MY_WAPP -c_compile -stop -project_path . -clean
