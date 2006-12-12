@echo off
echo -------------------------------------------------------------------------
echo - Building i18n C-library                                          -
echo -------------------------------------------------------------------------
%ISE_EIFFEL%\BCC55\bin\make -f makefile.b
del *.obj
del *.lib
echo i18n C-library compiled.
