@echo off
echo ------------------------------------------------------------------------
echo Compiling datetime.lib
echo ------------------------------------------------------------------------
%ISE_EIFFEL%\BCC55\bin\make.exe /s /f makefile.bcb > make.log

echo. 
echo Compilation done.
echo The result of the compilation is available in "make.log"
