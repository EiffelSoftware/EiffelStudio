#!/bin/bash

#
# Please run this script under path-to/C/doc folder
#
echo Get XML data related to the runtime documentation
bash document.sh .. doc_runtime.xml

echo Transform the XML doc into HTML doc
$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin/gexslt --file=c_code.xsl --file=doc_runtime.xml --output=doc_runtime.html

