setlocal

set CWD=%cd%
set remote_machine=codesigning

set version=%1
set revision=%2
set platform=%3
set es_deliv_setups=%4
echo Sign MSI release %version%.%revision% platform=%platform% from the %remote_machine% server

if "%es_deliv_setups%" EQU "" set es_deliv_setups=\es-deliv\%version%\%platform%.VC110_VC140\Eiffel_%version%\setups

set T_SIGNED_FILES_DIR=_files_signed_%version%_%revision%

if EXIST "%T_SIGNED_FILES_DIR%" goto MSI_SIGNED

set remote_dir=~/_data/%version%.%revision%-%platform%

::ssh %remote_machine% "rm -rf _data; mkdir _data"
ssh %remote_machine% "rm -rf %remote_dir%; mkdir -p %remote_dir%/bin/"

scp -r es_sign* *.sh %remote_machine%:%remote_dir%/bin/
scp -r jsign %remote_machine%:%remote_dir%/bin/jsign
ssh %remote_machine% "cd %remote_dir%/bin/jsign; /bin/sh ./setup.sh"

cd %es_deliv_setups%
cd ..

if EXIST setups goto UPLOAD_SETUPS
echo "Missing setups dir"
goto EOF

:UPLOAD_SETUPS
ssh %remote_machine% "cd %remote_dir%; mkdir -p files/standard/; mkdir -p files/enterprise/; mkdir -p files/branded/"
scp -r setups/standard/*.msi %remote_machine%:%remote_dir%/files/standard/
scp -r setups/enterprise/*.msi %remote_machine%:%remote_dir%/files/enterprise/
scp -r setups/branded/*.msi %remote_machine%:%remote_dir%/files/branded/

cd %CWD%

ssh %remote_machine% "cd %remote_dir%/bin; /bin/bash ./ev_code_sign_setups_msi.sh %remote_dir%"
echo #!/bin/sh > _msi.sh
echo cd %remote_dir%/bin; >> _msi.sh
echo /bin/bash ./ev_code_sign_setups_msi.sh %remote_dir% >> _msi.sh

scp _msi.sh %remote_machine%:%remote_dir%/_msi.sh
rm _msi.sh
ssh %remote_machine% sh %remote_dir%/_msi.sh

scp -r %remote_machine%:%remote_dir%/files_signed %T_SIGNED_FILES_DIR%
copy upload_final.bat %T_SIGNED_FILES_DIR%\upload_to_s3.bat
goto MSI_SIGNED

:MSI_SIGNED
cd %T_SIGNED_FILES_DIR%
upload_to_s3.bat %revision%

:EOF
