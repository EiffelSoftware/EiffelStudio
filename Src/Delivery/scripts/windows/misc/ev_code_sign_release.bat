echo Code signing the delivery 21.11 106026
setlocal

REM Usage: prog 21.11 106026 win64|windows

set version=21.11
set revision=106026
set kind=win64

set version=%1
set revision=%2
set kind=%3

set CWD=%cd%

:: AWS Configuration
if EXIST %~dp0\..\etc\aws.bat call %~dp0\..\etc\aws.bat

set CMD_7Z="C:\Program Files\7-Zip\7z.exe"
set CMD_SIGN="signtool.exe" sign /fd sha256 /tr http://ts.ssl.com /td sha256 /a

:: DO NOT MODIFY BELOW ::

if not EXIST %CWD%\_EV_CODE_SIGNING mkdir %CWD%\_EV_CODE_SIGNING
set T_WORKSPACE=%CWD%\_EV_CODE_SIGNING\%version%.%revision%
if not EXIST %T_WORKSPACE% mkdir %T_WORKSPACE%

cd %T_WORKSPACE%
set rel_dir=%T_WORKSPACE%\_release

if EXIST %rel_dir% goto T_DELIV
echo Get release %version%  %revision% from S3 storage
mkdir %rel_dir%
::aws s3 ls s3://ise.deliv/nightly/%revision%/ 
aws s3 sync s3://ise.deliv/nightly/%revision%/ %rel_dir%

:T_DELIV
echo Extract EiffelStudio from standard archive.
mkdir %rel_dir%
set deliv_dir=%T_WORKSPACE%\_deliv_%kind%
mkdir %deliv_dir%
cd %deliv_dir%
mkdir build
mkdir tmpdev
mkdir Eiffel_%version%
cd Eiffel_%version%
if EXIST EiffelStudio goto T_RELEASE
set TMP_ARCHIVE=%rel_dir%\standard\Eiffel_%version%_rev_%revision%-%kind%.7z
%CMD_7Z% x "%TMP_ARCHIVE%"
rename Eiffel_%version% EiffelStudio

goto T_RELEASE
goto EXIT

:T_RELEASE
echo Extract delivery files from archives.
cd %deliv_dir%
mkdir releases

:T_RELEASE_STANDARD
set TMP_ARCHIVE=%rel_dir%\standard\Eiffel_%version%_rev_%revision%-%kind%.7z
if not EXIST "%TMP_ARCHIVE%" goto T_RELEASE_STANDARD_END
cd %deliv_dir%\Eiffel_%version%
set TMP_DIR=releases\standard_version
if EXIST %TMP_DIR% goto T_RELEASE_STANDARD_END
echo Extract standard files
mkdir %TMP_DIR%
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\studio\spec\%kind%\bin\ec.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\studio\spec\%kind%\bin\ecb.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\LICENSE"
:T_RELEASE_STANDARD_END

:T_RELEASE_BRANDED
set TMP_ARCHIVE=%rel_dir%\branded\Eiffel_%version%_branded_%revision%-%kind%.7z
if not EXIST "%TMP_ARCHIVE%" goto T_RELEASE_BRANDED_END
cd %deliv_dir%\Eiffel_%version%
set TMP_DIR=releases\branded_version
if EXIST %TMP_DIR% goto T_RELEASE_BRANDED_END
echo Extract branded files
mkdir %TMP_DIR%
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\studio\spec\%kind%\bin\ec.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\studio\spec\%kind%\bin\ecb.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\LICENSE"
:T_RELEASE_BRANDED_END

:T_RELEASE_ENTERPRISE
set TMP_ARCHIVE=%rel_dir%\enterprise\Eiffel_%version%_ent_%revision%-%kind%.7z
if not EXIST "%TMP_ARCHIVE%" goto T_RELEASE_ENTERPRISE_END
cd %deliv_dir%\Eiffel_%version%
set TMP_DIR=releases\enterprise_version
if EXIST %TMP_DIR% goto T_RELEASE_ENTERPRISE_END
echo Extract enterprise files
mkdir %TMP_DIR%
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\studio\spec\%kind%\bin\ec.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\studio\spec\%kind%\bin\ecb.exe"
%CMD_7Z% e "%TMP_ARCHIVE%" -o%TMP_DIR% "Eiffel_21.11\LICENSE"
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
echo "REM Sign all ISE exe and dll from %deliv_dir%\Eiffel_%version%" > %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\studio\spec
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat
for /R %%f in (*.dll) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\studio\wizards
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat
for /R %%f in (*.dll) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\esbuilder\spec
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\tools
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat
for /R %%f in (*.dll) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\rb
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\vision2_demo\spec
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\wizards
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\eweasel
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\EiffelStudio\library\gobo\spec
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %deliv_dir%\Eiffel_%version%\releases
for /R %%f in (*.exe) do echo %CMD_SIGN% "%%f" >> %deliv_dir%\sign_all.bat

cd %CWD%

:EXIT
exit /b
