#!/bin/sh
# Pre processing script
#Delete generated code
echo Removing generated code.
rm $GENERATED_TEMPLATE_HEADER
rm -r generated_wrapper
cd C/
rm -r spec
