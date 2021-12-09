echo off
setlocal
:: Usage: prog 21.11 106046 
set CWD=%cd%

set version=%1
set revision=%2

if "%version%" EQU "" goto T_USAGE
if "%revision%" EQU "" goto T_USAGE
goto T_START

:T_USAGE
echo Usage: prog major.min revision
echo   for instance prog  21.11 106046
goto EXIT

:T_START
if EXIST %~dp0\local.bat call %~dp0\local.bat
if "%CMD_7Z%" EQU "" set CMD_7Z="C:\Program Files\7-Zip\7z.exe"
if "%CMD_SIGN%" EQU "" set CMD_SIGN=signtool.exe sign /fd sha256 /tr http://ts.ssl.com /td sha256 /a /sm

echo Code signing the final delivery %version% %revision%

:: DO NOT MODIFY BELOW ::

if not EXIST %CWD%\_EV_CODE_SIGNING_FINAL mkdir %CWD%\_EV_CODE_SIGNING_FINAL
set T_WORKSPACE=%CWD%\_EV_CODE_SIGNING_FINAL\%version%.%revision%
if not EXIST %T_WORKSPACE% mkdir %T_WORKSPACE%

cd %T_WORKSPACE%
set final_dir=%T_WORKSPACE%\_final

if EXIST %final_dir% goto T_DELIV
echo Get release %version%  %revision% from S3 storage
mkdir %final_dir%

:: AWS Configuration
if EXIST %~dp0\..\etc\aws.bat goto T_AWS_S3
goto T_HTTPS

:T_AWS_S3
call %~dp0\..\etc\aws.bat
::aws s3 ls s3://ise.deliv/nightly/%revision%/ 
aws s3 sync s3://ise.deliv/nightly/%revision%/ %final_dir%
goto T_DELIV

:T_HTTPS
mkdir %final_dir%\standard
cd %final_dir%\standard
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/standard/Eiffel_%version%_rev_%revision%-win64.msi
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/standard/Eiffel_%version%_rev_%revision%-windows.msi

mkdir %final_dir%\enterprise
cd %final_dir%\enterprise

curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/enterprise/Eiffel_%version%_ent_%revision%-win64.msi
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/enterprise/Eiffel_%version%_ent_%revision%-windows.msi

mkdir %final_dir%\branded
cd %final_dir%\branded
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/branded/Eiffel_%version%_branded_%revision%-win64.msi
curl -O http://ise.deliv.s3-website-eu-west-1.amazonaws.com/nightly/%revision%/branded/Eiffel_%version%_branded_%revision%-windows.msi
goto T_SIGN

:T_SIGN
cd %deliv_dir%
echo Prepare script to sign all msi files
set  T_SIGN_ALL_FILE=%final_dir%\sign_final.bat
echo REM Sign all ISE msi from "%final_dir%" > %T_SIGN_ALL_FILE%
echo setlocal
echo set CMD_SIGN=%CMD_SIGN% >> %T_SIGN_ALL_FILE%

cd %final_dir%
for /R %%f in (*.msi) do echo %%CMD_SIGN%% "%%f" >> %T_SIGN_ALL_FILE%

echo Now you should call %T_SIGN_ALL_FILE%

cd %CWD%

:EXIT
endlocal
exit /b
