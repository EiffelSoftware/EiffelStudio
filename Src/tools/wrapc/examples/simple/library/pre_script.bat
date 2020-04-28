@echo on
title pre_process script
echo Removing generated code.

set current_dir = %~dp0
del /f simple_header_cpp.h
rd /s /q generated_wrapper
cd %current_dir%C/
rd /s /q spec
cd ..
