setlocal

if "%1" EQU "" (
	set tmp_delay=600
) else (
	set tmp_delay=%1
)
call %~dp0notify.bat "Going to shutdown Windows deliv AWS machine in %tmp_delay% seconds!"

echo Shutdown the machine %COMPUTERNAME% in %tmp_delay% seconds
echo To Cancel:
echo shutdown -a
shutdown -a
shutdown -s -t %tmp_delay%

endlocal
