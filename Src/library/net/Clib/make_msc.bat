@echo off
echo -------------------------------------------------------------------------
echo - Building EiffelNET C-library                                          -
echo -------------------------------------------------------------------------
nmake /NOLOGO /C /S /f makefile.m > make.log
nmake /NOLOGO /C /S /f makefile.mmt >> make.log
del *.obj >> make.log
echo EiffelNET C-library compiled.
