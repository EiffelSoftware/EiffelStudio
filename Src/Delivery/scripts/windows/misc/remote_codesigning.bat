setlocal

set CWD=%cd%
set remote_machine=codesigning

set version=%1
set revision=%2
set platform=%3
set es_deliv_setups=%4
echo Sign release %version%.%revision% platform=%platform% from the %remote_machine% server

if "%es_deliv_setups%" EQU "" set es_deliv_setups=\es-deliv\%version%\%platform%.VC110_VC140\Eiffel_%version%\setups

set archive_fn=%version%.%revision%-%platform%-content_signed.7z
if EXIST %archive_fn% goto APPLY_SIGNED_CONTENT

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
ssh %remote_machine% "cd %remote_dir%; mkdir -p setups/standard/; mkdir -p setups/enterprise/; mkdir -p setups/branded/"
scp -r setups/standard/*.7z %remote_machine%:%remote_dir%/setups/standard/
scp -r setups/enterprise/*.7z %remote_machine%:%remote_dir%/setups/enterprise/
scp -r setups/branded/*.7z %remote_machine%:%remote_dir%/setups/branded/

cd %CWD%

set remote_archive_fn=%remote_dir%/%archive_fn%

ssh %remote_machine% "cd %remote_dir%/bin; /bin/bash ./ev_code_sign_setups.sh %version% %revision% %platform% %remote_dir%/setups %remote_dir% %remote_dir%/bin %remote_archive_fn%"

scp %remote_machine%:%remote_archive_fn% %archive_fn%
goto APPLY_SIGNED_CONTENT

:APPLY_SIGNED_CONTENT
echo Found %archive_fn%
cd %es_deliv_setups%
cd ..
7z x %CWD%\%archive_fn%
goto EOF

:EOF
