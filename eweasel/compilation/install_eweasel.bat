@ECHO OFF
set PWD=%~dp0

if '%EWEASEL%' == '' echo Environment variable EWEASEL is missing
if '%EWEASEL%' == '' GOTO END

rem Compiling eweasel (single-threaded)
ec -finalize -config eweasel.ecf -target eweasel_st -c_compile

rem Compiling eweasel (multi-threaded)
ec -finalize -config eweasel.ecf -target eweasel_mt -c_compile

rem Create delivery structure
if not exist %EWEASEL%\spec (
	mkdir %EWEASEL%\spec
)
if not exist %EWEASEL%\spec\windows (
	mkdir %EWEASEL%\spec\windows
)
if not exist %EWEASEL%\spec\windows\bin (
	mkdir %EWEASEL%\spec\windows\bin
)

rem Copy executables
copy EIFGENs\eweasel_st\F_code\eweasel.exe %EWEASEL%\spec\windows\bin
copy EIFGENs\eweasel_mt\F_code\eweasel-mt.exe %EWEASEL%\spec\windows\bin
rd /q /s EIFGENs
del eweasel.rc

rem Convert a few test files to DOS format.
cd /d %EWEASEL%\tests\exec081
gvim.exe -c "set ff=dos" -c "wq" output

cd /d %EWEASEL%\tests\freez004
gvim.exe -c "set ff=dos" -c "wq" output

cd /d %PWD%

:END
echo Done.
