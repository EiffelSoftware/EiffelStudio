set T_IRON_DIR=%1
set T_IRON_PORT=%2
set T_IRON_username=%3
set T_IRON_password=%4

set T_IRON_BIN=%T_IRON_DIR%\bin
set T_IRON_WEB=%T_IRON_DIR%

mkdir %T_IRON_WEB%\_iron
mkdir %T_IRON_WEB%\_iron\tmp

mkdir %T_IRON_WEB%\_iron\doc
xcopy /I /E /Y %EIFFEL_SRC%\tools\iron\delivery\resources\node\doc  %T_IRON_WEB%\_iron\doc

mkdir %T_IRON_WEB%\_iron\html
xcopy /I /E /Y %EIFFEL_SRC%\tools\iron\delivery\resources\node\html  %T_IRON_WEB%\_iron\html

mkdir %T_IRON_WEB%\_iron\template
xcopy /I /E /Y %EIFFEL_SRC%\tools\iron\delivery\resources\node\template  %T_IRON_WEB%\_iron\template

::# Set irond port number.
echo port=%T_IRON_PORT% > %T_IRON_WEB%\iron.ini

:: Config
echo #Iron configuration file > %T_IRON_WEB%\_iron\config 
echo #admin.email.from=no-reply@eiffel.org >> %T_IRON_WEB%\_iron\config
echo # Log level - for now unused >> %T_IRON_WEB%\_iron\config
echo log.level=0 >> %T_IRON_WEB%\_iron\config

cd %T_IRON_WEB%
call %T_IRON_BIN%\ironctl.exe system initialize
call %T_IRON_BIN%\ironctl.exe user create "%T_IRON_username%" "%T_IRON_password%"

