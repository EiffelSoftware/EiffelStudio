@echo off
setlocal

set T_INSTALL_DIR=%~f1
if "%T_INSTALL_DIR%" == "" set T_INSTALL_DIR=%ISE_EIFFEL%
echo Install iron into %T_INSTALL_DIR%

set T_HERE=%cd%
set TARGET_EIFGENS_EXE=%~dp0EIFGENs\es_iron\F_code\iron.exe

if "%ISE_PLATFORM%" == "" goto failure

echo Compile iron executable
echo Clean previous EIFGENS
rd /q/s %~dp0EIFGENs\es_iron
if not exist "%TARGET_EIFGENS_EXE%" "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ecb.exe" -config "%~dp0..\client\client.ecf" -target es_iron -finalize -c_compile -project_path .

if not exist "%TARGET_EIFGENS_EXE%" goto failure
echo Install the iron executable in the %T_INSTALL_DIR%\tools\.. installation
if not exist "%T_INSTALL_DIR%\tools\spec\%ISE_PLATFORM%\bin" mkdir "%T_INSTALL_DIR%\tools\spec\%ISE_PLATFORM%\bin"
copy %TARGET_EIFGENS_EXE% "%T_INSTALL_DIR%\tools\spec\%ISE_PLATFORM%\bin\iron.exe"

if exist "%T_INSTALL_DIR%\tools\iron" rd /q/s "%T_INSTALL_DIR%\tools\iron"
if not exist "%T_INSTALL_DIR%\tools" mkdir "%T_INSTALL_DIR%\tools"

echo Install the iron resources in the %T_INSTALL_DIR%\tools\iron location
xcopy /I /E /Y "%~dp0iron" "%T_INSTALL_DIR%\tools\iron"

echo Cleaning the spec folder
rd /q/s "%T_INSTALL_DIR%\tools\iron\spec\unix"
cd "%T_INSTALL_DIR%\tools\iron\spec"
move windows %ISE_PLATFORM%
cd "%T_HERE%"

echo Compile and install iron commands executables.
call ..\client\commands\install.bat

goto end
:failure
echo failed!
endlocal
exit /B 0

:end
endlocal
exit /B 0

