@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

REM !!!!!!!!!!!!!!!!!!!!!!!!!!
REM REPLACE PATH TO C COMPILER IN LINE BETWEEN ****** BELOW
REM !!!!!!!!!!!!!!!!!!!!!!!!!!

ECHO Setting up libraries

ECHO Compiling WEL C library
CD checkout\library\wel\clib
REM in "checkout\library\wel\clib"
SET ISE_EIFFEL="%1"
CALL make_msc.bat

ECHO Compiling Vision2 C library
CD ..\..\vision2\clib
REM in "checkout\library\vision2\clib"
CALL make_msc.bat

ECHO Compiling CLI writer
CD ..\..\..\Eiffel\library\cli_writer\Clib
REM in "checkout\Eiffel\library\cli_writer\clib"
CALL nmake

ECHO Setting up C libraries
CD ..\..\..\..\C_library\libpng
REM in "checkout\C_library\libpng"
CALL make_msc.bat
COPY %ISE_EIFFEL%\library\vision2\spec\msc\lib\libpng.lib ..\..\library\vision2\spec\msc\lib
CD ..\zlib
REM in "checkout\C_library\zlib"
CALL make_msc.bat
COPY %ISE_EIFFEL%\library\vision2\spec\msc\lib\zlib.lib ..\..\library\vision2\spec\msc\lib

ECHO Setting up runtime
CD ..\..\C
REM in "checkout\C"
REM **************************************************
sed -e "s/d:\\\apps\\\MSVC\\\VC98/C:\\\Progra~1\\\Micros~3\\\VC98/g" config.msh > new_config.msh
REM **************************************************
COPY /Y new_config.msh config.msh
ECHO "\N" | configure win32 m
CD ..
REM in "checkout"

CD ..
