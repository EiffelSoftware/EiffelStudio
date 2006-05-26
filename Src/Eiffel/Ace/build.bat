rem Finalizing new compiler

echo off

if .%1. == .. goto usage
if .%2. == .. goto usage

cdd %1
rd /q /s EIFGENs\bench

%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe -finalize -local -project_path %1 -config %EIFFEL_SRC%\Eiffel\Ace\ec.ecf -target bench -batch -c_compile

cdd %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin
if not exist ec.exe del old_ec.exe
ren ec.exe old_ec.exe
copy %1\EIFGENs\bench\F_code\ec.exe .

cdd %2
rd /q /s EIFGENs\bench

%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe -freeze -local -project_path %2 -config %EIFFEL_SRC%\Eiffel\Ace\ec.ecf -target bench -batch -c_compile

goto end

:usage
echo build.bat final_directory workbench_directory

:end

rem Build is complete 
