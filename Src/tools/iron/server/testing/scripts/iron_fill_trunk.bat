setlocal

set T_IRON_DIR=%1
set T_IRON_PORT=%2
set T_IRON_username=%3
set T_IRON_password=%4

set T_IRON_VERSION=trunk

set T_IRON_BIN=%T_IRON_DIR%\bin
set T_IRON_WEB=%T_IRON_DIR%

mkdir %T_IRON_WEB%\_iron\repo\versions\%T_IRON_VERSION%
::cd %T_IRON_WEB%
::#Launch the irond server for the building time.
::%T_IRON_BIN%\irond &

mkdir  %T_IRON_DIR%\scripts\upload\VERSIONS\
cp -rf %EIFFEL_SRC%\tools\iron\delivery\upload\VERSIONS\alter %T_IRON_DIR%\scripts\upload\VERSIONS\alter

iron repository -a http://localhost:%T_IRON_PORT%/%T_IRON_VERSION%

cd %T_IRON_DIR%\scripts\upload\
::#Build trunk.cfg
echo # Iron uploading config 	> trunk.cfg
echo username=%T_IRON_username%>> trunk.cfg
echo password=%T_IRON_password%>> trunk.cfg
echo repository=http://localhost:%T_IRON_PORT%/%T_IRON_VERSION%>> trunk.cfg
echo revision=HEAD>> trunk.cfg
echo branch=%T_IRON_VERSION%>> trunk.cfg

echo Current dir=%CD%
python %EIFFEL_SRC%\tools\iron\delivery\upload\ise_upload_version.py trunk.cfg

::#Kill previous irond for the building time.
::pkill -9 irond

