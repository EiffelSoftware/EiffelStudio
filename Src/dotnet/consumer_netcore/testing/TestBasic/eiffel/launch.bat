if "%1" EQU "-reset" GOTO reset
goto main

:reset
rd /q/s "\users\jfiat\Documents\Eiffel User Files\23.09\dotnet"
shift
goto main

:main
set ISE_EMDC=%EIFFEL_SRC%\dotnet\consumer_netcore\pub\win64\nemdc.exe
ec -config test_generic.ecf %1 %2 %3 %4 %5 %6 %7 %8 %9

goto EOF

:EOF
