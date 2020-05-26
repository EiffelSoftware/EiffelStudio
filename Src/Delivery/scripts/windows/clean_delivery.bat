
echo reset environment
if "%ISE_PLATFORM%" == "" set ISE_PLATFORM=win64
if "%ISE_PLATFORM%" == "windows" Call %~dp0bin\reset_eiffel_env.bat windows
if "%ISE_PLATFORM%" == "win64" Call %~dp0bin\reset_eiffel_env.bat win64

echo Remove build folder
call %~dp0init.btm
if EXIST "%DELIV_DIR%" rd /q/s "%DELIV_DIR%"
