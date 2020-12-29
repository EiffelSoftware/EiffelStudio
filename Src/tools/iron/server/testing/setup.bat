setlocal
set CWD=%cd%
cd %~dp0scripts
set EIF_IRON_DIR=%~dp0\..
call iron_install.bat %EIF_IRON_DIR% 9090 ironman eiffel123 --clean

cd %CWD%
