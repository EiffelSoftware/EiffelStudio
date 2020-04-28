#!/bin/sh
# Pre processing script
#Delete generated code
echo Removing generated code.
rm simple_header_cpp.h
rm -r generated_wrapper
cd C/
rm -r spec
