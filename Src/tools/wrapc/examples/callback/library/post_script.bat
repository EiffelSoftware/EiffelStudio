@echo off
title post_process script

rem copy c file is there any
copy .\manual_wrapper\c\src\*.c  .\generated_wrapper\c\src
copy .\manual_wrapper\c\include\*.h  .\generated_wrapper\c\include		

rem copy Makefile script
copy Makefile-win.SH  .\generated_wrapper\c\src


rem Compile C glue code.
cd generated_wrapper/c/src/
finish_freezing -library
