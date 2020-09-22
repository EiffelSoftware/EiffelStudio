@echo off
title post_process script

rem copy c file is there any
copy .\manual_wrapper\c\src\*.c  .\generated_wrapper\c\src
copy .\manual_wrapper\c\include\*.h  .\generated_wrapper\c\include		

rem copy Makefile script
copy Makefile-win.SH  .\generated_wrapper\c\src

rem deleting unneeded files

cd .\generated_wrapper\eiffel

del /f corecrt_wstdio_functions_api.e
del /f crt_locale_data_struct_api.e
del /f crt_multibyte_data_struct_api.e
del /f iobuf_struct_api.e
del /f mbstatet_struct_api.e
del /f stdio_functions_api.e
del /f crt_locale_pointers_struct_api.e

cd ..
cd ..


rem Compile C glue code.
cd generated_wrapper/c/src/
finish_freezing -library
