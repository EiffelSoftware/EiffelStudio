@echo off
echo ------------------------------------------------------------------------
echo Compiling wel.lib and mtwel.lib
echo ------------------------------------------------------------------------
echo Compiling monothreaded version of the library
%ISE_EIFFEL%\BCC55\bin\make.exe /s /f makefile.bcb > make.log
echo Compiling multithreaded version of the library
%ISE_EIFFEL%\BCC55\bin\make.exe /s /f mt-makefile.bcb >> make.log

echo. 
echo ------------------------------------------------------------------------
echo Compiling wel_hook.dll
echo ------------------------------------------------------------------------
%ISE_EIFFEL%\BCC55\bin\make.exe /s /f makefile_dll.bcb >> make.log

echo. 
echo Compilation done.
echo The result of the compilation is available in "make.log"
