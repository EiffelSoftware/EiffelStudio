#!/bin/sh
# Post processing script

# copy C file is there any
cp ./manual_wrapper/c/src/*.c  ./generated_wrapper/c/src
cp ./manual_wrapper/c/include/*.h  ./generated_wrapper/c/include		

#copy Makefile
cp Makefile.SH  ./generated_wrapper/c/src


#Compile C glue code.
cd generated_wrapper/c/src/
finish_freezing -library
