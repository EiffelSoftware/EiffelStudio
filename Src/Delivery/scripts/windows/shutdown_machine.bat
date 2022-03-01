echo off
setlocal

if "%1" EQU "cancel" (
	shutdown -a
	goto EOF
)
if "%1" EQU "now" (
	set tmp_delay=0
	echo "Set delay to %tmp_delay% = now"
	goto shutdown_in_delay
)
if "%1" EQU "" (
	set tmp_delay=7200
	rem 2 hours=2 * 60 * 60 seconds
) else (
	set tmp_delay=%1
)
goto shutdown_in_delay

:shutdown_in_delay
if "%tmp_delay%" EQU "0" (
	rem No notification when shutdown is immediate
) else (
	call %~dp0notify.bat "Going to shutdown Windows deliv AWS machine in %tmp_delay% seconds!"
)

echo Shutdown the machine %COMPUTERNAME% in %tmp_delay% seconds
echo To Cancel:
echo shutdown -a
shutdown -a 2> nul
shutdown -s -t %tmp_delay%

endlocal
