@ECHO OFF
set PWD=%~dp0

if '%EWEASEL%' == '' echo Environment variable EWEASEL is missing
if '%EWEASEL%' == '' GOTO END

rem Compile eweasel
ec -finalize -config eweasel.ecf -c_compile

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

rem Copy executable
copy EIFGENs\eweasel\F_code\eweasel.exe %EWEASEL%\spec\windows\bin
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
