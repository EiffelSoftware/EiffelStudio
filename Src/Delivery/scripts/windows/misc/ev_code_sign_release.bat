echo off
setlocal
:: Usage: prog 21.11 106046 win64
:: Usage: prog 21.11 106046 windows
set CWD=%cd%

set version=%1
set revision=%2
set platform=%3

if "%version%" EQU "" goto T_USAGE
if "%revision%" EQU "" goto T_USAGE
if "%platform%" EQU "" goto T_USAGE
goto T_START

:T_USAGE
echo Usage: prog major.min revision
echo   for instance prog  21.11 106046 win64
echo   platform: win64 or windows
goto EXIT

:T_START
if EXIST %~dp0\local.bat call %~dp0\local.bat
if "%CMD_7Z%" EQU "" set CMD_7Z="C:\Program Files\7-Zip\7z.exe"
if "%CMD_SIGN%" EQU "" set CMD_SIGN=signtool.exe sign /fd sha256 /tr http://ts.ssl.com /td sha256 /a /sm

echo Code signing the delivery %version% %revision%

:: DO NOT MODIFY BELOW ::

if not EXIST %CWD%\_EV_CODE_SIGNING mkdir %CWD%\_EV_CODE_SIGNING
set T_WORKSPACE=%CWD%\_EV_CODE_SIGNING\%version%.%revision%
if not EXIST %T_WORKSPACE% mkdir %T_WORKSPACE%

cd %T_WORKSPACE%
set rel_dir=%T_WORKSPACE%\_release

if EXIST %rel_dir% goto T_DELIV
echo Get release %version%  %revision% from S3 storage
mkdir %rel_dir%

:: AWS Configuration
if EXIST %~dp0\..\etc\aws.bat goto T_AWS_S3
goto T_HTTPS

:T_AWS_S3
call %~dp0\..\etc\aws.bat
::aws s3 ls s3://ise.deliv/nightly/%revision%/ 
aws s3 sync s3://ise.deliv/nightly/%revision%/ %rel_dir%
goto T_DELIV

:T_HTTPS
mkdir %rel_dir%\standard
cd %rel_dir%\standard
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/standard/Eiffel_%version%_rev_%revision%-%platform%.7z

mkdir %rel_dir%\enterprise
cd %rel_dir%\enterprise
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/enterprise/Eiffel_%version%_ent_%revision%-%platform%.7z

mkdir %rel_dir%\branded
cd %rel_dir%\branded
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/branded/Eiffel_%version%_branded_%revision%-%platform%.7z
goto T_DELIV

:T_DELIV
echo Extract EiffelStudio from standard archive.
set deliv_dir=%T_WORKSPACE%\_deliv_%platform%
mkdir %deliv_dir%
cd %deliv_dir%
mkdir build
mkdir tmpdev
mkdir Eiffel_%version%
cd Eiffel_%version%
if EXIST EiffelStudio goto T_RELEASE
set TMP_ARCHIVE=%rel_dir%\standard\Eiffel_%version%_rev_%revision%-%platform%.7z
%CMD_7Z% x "%TMP_ARCHIVE%"
rename Eiffel_%version% EiffelStudio

goto T_RELEASE
goto EXIT

:T_RELEASE
echo Extract delivery files from archives.
cd %deliv_dir%
mkdir releases

:T_RELEASE_STANDARD
set TMP_ARCHIVE=%rel_dir%\standard\Eiffel_%version%_rev_%revision%-%platform%.7z
if not EXIST "%TMP_ARCHIVE%" goto T_RELEASE_STANDARD_END
cd %deliv_dir%\Eiffel_%version%
set TMP_DIR=releases\standard_version
if EXIST %TMP_DIR% goto T_RELEASE_STANDARD_END
echo Extract standard files
mkdir %TMP_DIR%
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\studio\spec\%platform%\bin\ec.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\studio\spec\%platform%\bin\ecb.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\LICENSE"
:T_RELEASE_STANDARD_END

:T_RELEASE_BRANDED
set TMP_ARCHIVE=%rel_dir%\branded\Eiffel_%version%_branded_%revision%-%platform%.7z
if not EXIST "%TMP_ARCHIVE%" goto T_RELEASE_BRANDED_END
cd %deliv_dir%\Eiffel_%version%
set TMP_DIR=releases\branded_version
if EXIST %TMP_DIR% goto T_RELEASE_BRANDED_END
echo Extract branded files
mkdir %TMP_DIR%
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\studio\spec\%platform%\bin\ec.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\studio\spec\%platform%\bin\ecb.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\LICENSE"
:T_RELEASE_BRANDED_END

:T_RELEASE_ENTERPRISE
set TMP_ARCHIVE=%rel_dir%\enterprise\Eiffel_%version%_ent_%revision%-%platform%.7z
if not EXIST "%TMP_ARCHIVE%" goto T_RELEASE_ENTERPRISE_END
cd %deliv_dir%\Eiffel_%version%
set TMP_DIR=releases\enterprise_version
if EXIST %TMP_DIR% goto T_RELEASE_ENTERPRISE_END
echo Extract enterprise files
mkdir %TMP_DIR%
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\studio\spec\%platform%\bin\ec.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\studio\spec\%platform%\bin\ecb.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_%version%\LICENSE"
:T_RELEASE_ENTERPRISE_END


:T_SETUPS
echo Prepare setups folder
cd %deliv_dir%
::echo releases\gdiplus.dll
mkdir setups
mkdir setups\standard
mkdir setups\branded
mkdir setups\enterprise

cd %deliv_dir%
echo Prepare script to sign all executables
set  T_SIGN_ALL_FILE=%deliv_dir%\sign_all.bat
echo REM Sign all ISE exe and dll from "%deliv_dir%\Eiffel_%version%" > %T_SIGN_ALL_FILE%
echo setlocal
echo set CMD_SIGN=%CMD_SIGN% >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\studio\spec
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%
for /R %%f in (*.dll) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\studio\wizards
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%
for /R %%f in (*.dll) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\esbuilder\spec
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\tools
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%
for /R %%f in (*.dll) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\rb
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\vision2_demo\spec
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\wizards
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\eweasel
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\library\gobo\spec
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

cd %deliv_dir%\Eiffel_%version%\releases
for /R %%f in (*.exe) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

echo Now you should call %T_SIGN_ALL_FILE%

cd %CWD%

:EXIT
endlocal
exit /b
