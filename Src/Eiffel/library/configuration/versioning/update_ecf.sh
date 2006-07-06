#!/bin/sh

gexslt=$EIFFEL_SRC/library/gobo/bin/gexslt
xsl=$EIFFEL_SRC/Eiffel/library/configuration/versioning/conversion-1-0-0.xsl

echo Processing $1
$gexslt --file=$xsl --file=$1 > tmp
mv -f tmp $1
