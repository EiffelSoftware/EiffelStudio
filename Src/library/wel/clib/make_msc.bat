@echo off
echo ------------------------------------------------------------------------
echo Compiling wel.lib and mtwel.lib
echo ------------------------------------------------------------------------
echo Compiling monothreaded version of the library
nmake /NOLOGO /C /S /f makefile.msc > make.log
echo Compiling multithreaded version of the library
nmake /NOLOGO /C /S /f mt-makefile.msc >> make.log

echo. 
echo ------------------------------------------------------------------------
echo Compiling wel_hook.dll
echo ------------------------------------------------------------------------
nmake /NOLOGO /C /S /f makefile_dll.msc >> make.log

echo. 
echo Compilation done.
echo The result of the compilation is available in "make.log"
