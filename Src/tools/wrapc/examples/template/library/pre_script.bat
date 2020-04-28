@echo on
title pre_process script
echo Removing generated code.

set current_dir = %~dp0
del /f $GENERATED_TEMPLATE_HEADER
rd /s /q generated_wrapper
cd %current_dir%C/
rd /s /q spec
cd ..
