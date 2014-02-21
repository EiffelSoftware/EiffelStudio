@ECHO OFF
IF "%ISE_EIFFEL%." == "." SET ISE_EIFFEL=C:\apps\Eiffel_14.05
IF "%ISE_PLATFORM%." == "." SET ISE_PLATFORM=win64
IF "%ISE_LIBRARY%." == "." SET ISE_LIBRARY=C:\work\14.05_dev
SET ISE_C_COMPILER=msc

nmake /f Makefile.msc
nmake /f Makefile-mt.msc