
set T_IRON_DIR=%1
set TMP_CLEAN=0
if "%2" == "--clean" set TMP_CLEAN=1

set T_IRON_BIN=%T_IRON_DIR%\bin
mkdir %T_COMP%
mkdir %T_IRON_BIN%

::echo Update trunk
::svn update --non-interactive %EIFFEL_SRC%
echo Compile IRON controller
if not exist "%T_IRON_BIN%\ironctl.exe" eiffel build --target controller %EIFFEL_SRC%\tools\iron\server\controller.ecf %T_IRON_BIN%\ironctl.exe

echo Compile IRON standalone server
if not exist "%T_IRON_BIN%\irond.exe" eiffel build --target server_standalone %EIFFEL_SRC%\tools\iron\server\server.ecf %T_IRON_BIN%\irond.exe
#echo Compile IRON FCGI server
if not exist "%T_IRON_BIN%\irond-libfcgi.exe" eiffel build --target server_libfcgi %EIFFEL_SRC%\tools\iron\server\server.ecf %T_IRON_BIN%\irond-libfcgi.exe

:EOF
echo Completed.
