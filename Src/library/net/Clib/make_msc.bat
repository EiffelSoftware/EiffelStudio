@echo off
echo -------------------------------------------------------------------------
echo - Building EiffelNET C-library                                          -
echo -------------------------------------------------------------------------
nmake /NOLOGO /C /S /f makefile.m
nmake /NOLOGO /C /S /f makefile.il
nmake /NOLOGO /C /S /f makefile.mmt
del *.obj
del *.lib
echo EiffelNET C-library compiled.
