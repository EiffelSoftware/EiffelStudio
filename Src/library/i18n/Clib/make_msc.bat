@echo off
echo -------------------------------------------------------------------------
echo - Building i18n C-library                                          -
echo -------------------------------------------------------------------------
nmake /NOLOGO /C /S /f makefile.m
del *.obj
del *.lib
echo i18n C-library compiled.
