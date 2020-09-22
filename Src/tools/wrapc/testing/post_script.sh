#!/bin/sh
# Post processing script

# copy C file is there any
cp ./manual_wrapper/c/src/*.c  ./generated_wrapper/c/src
cp ./manual_wrapper/c/include/*.h  ./generated_wrapper/c/include		

#copy Makefile
cp Makefile.SH  ./generated_wrapper/c/src

cd ./generated_wrapper/eiffel

rm fsid_t_struct_api.e
rm g_fpos_t_struct_api.e
rm stdio_functions_api.e
rm io_codecvt_struct_api.e
rm io_file_struct_api.e
rm io_marker_struct_api.e
rm io_wide_data_struct_api.e
rm mbstate_t_struct_api.e	

cd ..
cd ..


#Compile C glue code.
cd generated_wrapper/c/src/
finish_freezing -library
