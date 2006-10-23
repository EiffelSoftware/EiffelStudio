rem Finalizing new compiler

echo off

if .%1. == .. goto usage
if .%2. == .. goto usage


rd /q /s %1\EIFGENs\bench

%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe -finalize -project_path %1 -config %EIFFEL_SRC%\Eiffel\Ace\ec.ecf -target bench -batch -c_compile

if not exist %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe del %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\old_ec.exe
ren %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\old_ec.exe
copy %1\EIFGENs\bench\F_code\ec.exe %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe

rd /q /s %2\EIFGENs\bench

%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe -freeze -project_path %2 -config %EIFFEL_SRC%\Eiffel\Ace\ec.ecf -target bench -batch -c_compile

goto end

:usage
echo build.bat final_directory workbench_directory

:end

rem Build is complete 
