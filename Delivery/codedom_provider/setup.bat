@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

REM !!!!!!!!!!!!!!!!!!!!!!!!!!
REM REPLACE PATH TO C COMPILER IN LINE BETWEEN ****** BELOW
REM !!!!!!!!!!!!!!!!!!!!!!!!!!

ECHO Setting up C libraries
CD checkout\C_library\libpng
REM in "checkout\C_library\libpng"
CALL make_msc.bat
COPY %ISE_EIFFEL%\library\vision2\spec\msc\lib\libpng.lib ..\..\library\vision2\spec\msc\lib\libpng.lib
CD ..\zlib
REM in "checkout\C_library\zlib"
CALL make_msc.bat
COPY %ISE_EIFFEL%\library\vision2\spec\msc\lib\zlib.lib ..\..\library\vision2\spec\msc\lib\zlib.lib

ECHO Setting up libraries

ECHO Compiling WEL C library
CD ..\..\library\wel\clib
REM in "checkout\library\wel\clib"
CALL make_msc.bat

ECHO Compiling Vision2 C library
CD ..\..\vision2\clib
REM in "checkout\library\vision2\clib"
CALL make_msc.bat

ECHO Compiling EiffelCOM C library
CD ..\..\com\clib
REM in "checkout\library\com\clib"
CALL make_msc.bat

ECHO Compiling EiffelCOM C Runtime library
CD ..\clib_runtime
REM in "checkout\library\com\clib_runtime"
CALL make_msc.bat

ECHO Compiling CLI writer
CD ..\..\..\Eiffel\library\cli_writer\Clib
REM in "checkout\Eiffel\library\cli_writer\clib"
CALL nmake

ECHO Setting up runtime
CD ..\..\..\..\C
REM in "checkout\C"
REM **************************************************
sed -e "s/d:\\\apps\\\MSVC\\\VC98/C:\\\Progra~1\\\Micros~3\\\VC98/g" config.msh > new_config.msh
REM **************************************************
COPY /Y new_config.msh config.msh
ECHO "\N" | configure win32 m
CD ..
REM in "checkout"

ECHO Setting up documentation manager
CD dotnet\VisualStudio\tools\documentation_manager\
REM in "checkout\dotnet\VisualStudio\tools\documentation_manager"
CALL make_client
CD ..\..\..\..\
REM in "checkout"

ECHO Compiling compiler
CD com_compiler
REM in "checkout\com_compiler"
CALL make.bat /dll

CD ..\..