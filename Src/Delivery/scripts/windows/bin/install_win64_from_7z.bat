echo off
setlocal
REM Usage: install_from_7z.bat ..\nightly\Eiffel_19.04_gpl_103069-win64.7z
REM
set E_ARCHIVE=%~dpnx1
set CWD=%cd%
chdir %~dp0

for /f "delims=" %%i in ('echo %E_ARCHIVE% ^| sed -e "s/.*Eiffel_\([0-9][0-9]\.[0-9][0-9]\).*/\1/"') do set E_VERSION=%%i
set ISE_PLATFORM=win64

echo Install archive %E_ARCHIVE% as Eiffel_%E_VERSION% compiler

if NOT EXIST "%E_ARCHIVE%" (
	echo File not found "%E_ARCHIVE%"
	goto ERROR
)
if EXIST %ISE_PLATFORM% (
    echo Clean previous compiler
    rd /q/s %ISE_PLATFORM%
)
mkdir %ISE_PLATFORM%
echo Extract archive
%~dp07z x %E_ARCHIVE% -O%ISE_PLATFORM%

echo remove junction eiffel_%ISE_PLATFORM%
rd eiffel_%ISE_PLATFORM%

echo create new junction
mklink /J eiffel_%ISE_PLATFORM% %ISE_PLATFORM%\Eiffel_%E_VERSION%

call %~dp0reset_eiffel_env.bat %ISE_PLATFORM%


goto EOF

:ERROR
echo ERROR 
goto EOF

:EOF
cd %CWD%
echo on
