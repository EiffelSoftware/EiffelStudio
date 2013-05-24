@echo off
setlocal

set T_HERE=%cd%
set TARGET_EIFGENS_EXE=%~dp0EIFGENs\client\F_code\iron.exe

if "%ISE_PLATFORM%" == "" goto failure

echo Compile iron executable
if not exist "%TARGET_EIFGENS_EXE%" "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ecb.exe" -config "%~dp0..\client\client.ecf" -target client -finalize -c_compile -project_path .

if not exist "%TARGET_EIFGENS_EXE%" goto failure
echo Install the iron executable in the %ISE_EIFFEL%\tools\.. installation
copy %TARGET_EIFGENS_EXE% "%ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin\iron.exe"

if exist "%ISE_EIFFEL%\tools\iron" rd /q/s "%ISE_EIFFEL%\tools\iron"
if not exist "%ISE_EIFFEL%\tools" mkdir "%ISE_EIFFEL%\tools"

echo Install the iron resources in the %ISE_EIFFEL%\tools\iron location
xcopy /I /E /Y "%~dp0iron" "%ISE_EIFFEL%\tools\iron"

echo Cleaning the spec folder
rd /q/s "%ISE_EIFFEL%\tools\iron\spec\unix"
cd "%ISE_EIFFEL%\tools\iron\spec"
move windows %ISE_PLATFORM%
cd "%T_HERE%"

goto end
:failure
echo failed!
endlocal
exit /B 0

:end
endlocal
exit /B 0

