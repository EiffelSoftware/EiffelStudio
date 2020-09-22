@echo on
title Script to automate WrapC development process.

wrap_c --verbose --script_pre_process=pre_script.bat --script_post_process=post_script.bat --output-dir=%cd%/generated_wrapper  --full-header=%cd%/manual_wrapper/c/include/wrapc_testing.h  --config=%cd%/config.xml
