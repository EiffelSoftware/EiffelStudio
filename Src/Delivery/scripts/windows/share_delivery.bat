echo off

if not EXIST %1 goto not_found


for /f "delims=" %%i in ('echo %1 ^| sed "s/.*Eiffel_[0-9][0-9].[0-9][0-9]_.*_\([0-9][0-9]*\)-.*/\1/" ') do set "TMP_REVISION=%%i"

set T_NIGHTLY=%~dp0nightly\
if "%TMP_REVISION%" NEQ "" (
	set T_NIGHTLY=%T_NIGHTLY%%TMP_REVISION%\
	if not EXIST "%T_NIGHTLY%" mkdir %T_NIGHTLY%
)

REM Check if file is not already in nightly folder
set T_SRC=%~f1
set T_FILENAME=%~n1%~x1
set T_KIND=%2
if "%T_KIND%" EQU "" (
	set T_KIND=enterprise
	ECHO.%T_FILENAME% | FIND /I "_gpl_">Nul && (set T_KIND=community)
	ECHO.%T_FILENAME% | FIND /I "_rev_">Nul && (set T_KIND=standard)
	ECHO.%T_FILENAME% | FIND /I "_branded_">Nul && (set T_KIND=branded)
)
if "%T_KIND%" NEQ "" (
	set T_DST=%T_NIGHTLY%%T_KIND%\%T_FILENAME%
	if not EXIST "%T_NIGHTLY%%T_KIND%" mkdir %T_NIGHTLY%%T_KIND%
) else (
	set T_DST=%T_NIGHTLY%%T_FILENAME%
)

if "%T_SRC%" NEQ "%T_DST%" (
  echo Copy %T_SRC% into nightly folder [%T_DST%] .
  copy %T_SRC% %T_DST%
  dir %T_DST%
) else (
  echo Already from nightly folder!
)

set T_S3=s3://ise.deliv
set T_S3_WWW=http://ise.deliv.s3-website-eu-west-1.amazonaws.com
set T_S3_PATH=nightly
if "%TMP_REVISION%" NEQ "" (
	set T_S3_PATH=%T_S3_PATH%/%TMP_REVISION%
)
if "%T_KIND%" NEQ "" (
	set T_S3_PATH=%T_S3_PATH%/%T_KIND%
)
echo Upload %1 to %T_S3%/%T_S3_PATH%/
echo aws s3 cp --acl public-read %T_DST% %T_S3%/%T_S3_PATH%/%T_FILENAME% 
aws s3 cp --acl public-read %T_DST% %T_S3%/%T_S3_PATH%/%T_FILENAME% > NUL
if EXIST %~dp0notify.bat %~dp0notify.bat "New %ISE_PLATFORM% %T_KIND% release %T_FILENAME% built and uploaded to %T_S3%/%T_S3_PATH%/ or %T_S3_WWW%/%T_S3_PATH%/%T_FILENAME% ."
)

:: echo Upload %1 to eifweb:deliv remote folder
:: scp %1 eifweb:builds/nightly > NUL

goto eof

:not_found
echo ERROR: impossible to share "%1" (file not found)
goto eof

:eof
