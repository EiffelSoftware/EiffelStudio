@echo off
echo ------------------------------------------------------------------------
echo Compiling datetime.lib
echo ------------------------------------------------------------------------
nmake /NOLOGO /C /S /f makefile.msc > make.log

echo. 
echo Compilation done.
echo The result of the compilation is available in "make.log"
