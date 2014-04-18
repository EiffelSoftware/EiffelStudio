setlocal
echo off

if "%ISE_PLATFORM%" == "win64" goto build_win64
goto build_win32
goto end

:build_win64
echo Building libfcgi for win64
%~dp0\build_win64.bat
goto end

:build_win32
echo Building libfcgi for win32
%~dp0\build_win32.bat
goto end

:end
endlocal
exit 0
