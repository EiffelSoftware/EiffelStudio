rem Finalizing new compiler

echo off

if .%1. == .. goto usage
if .%2. == .. goto usage

set OLD_ISE_EIFFEL=%ISE_EIFFEL%
set NEW_ISE_EIFFEL=%ISE_EIFFEL%_wkbench
set TMP_PATH=%cd%

rd /q /s %1\EIFGENs\bench

%OLD_ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe -finalize -project_path %1 -config %EIFFEL_SRC%\Eiffel\Ace\ec.ecf -target bench -batch -c_compile


rem Use new delivery to compile the workbench compiler

set ISE_EIFFEL=%NEW_ISE_EIFFEL%

if not exist %NEW_ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe del %NEW_ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\old_ec.exe
ren %NEW_ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe %NEW_ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\old_ec.exe
copy %1\EIFGENs\bench\F_code\ec.exe %NEW_ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe

rd /q /s %2\EIFGENs\bench

%NEW_ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec.exe -freeze -project_path %2 -config %EIFFEL_SRC%\Eiffel\Ace\ec.ecf -target bench -batch -c_compile

cd /d %ISE_EIFFEL
cd ..
ren %OLD_ISE_EIFFEL% %ISE_EIFFEL%_backup
ren %NEW_ISE_EIFFEL% %ISE_EIFFEL%
ren %ISE_EIFFEL%_backup %NEW_ISE_EIFFEL%

cd /d %TMP_PATH%

goto end

:usage
echo build.bat final_directory workbench_directory

:end

rem Build is complete 
