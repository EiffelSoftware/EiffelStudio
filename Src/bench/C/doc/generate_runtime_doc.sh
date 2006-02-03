#!/bin/bash

#
# Please run this script under path-to/C/doc folder
#
echo Get XML data related to the runtime documentation
cd ..
bash document.sh . doc/doc_runtime.xml

cd doc
echo Transform the XML doc into HTML doc
gexslt --file=c_code.xsl --file=doc_runtime.xml --output=doc_runtime.html

