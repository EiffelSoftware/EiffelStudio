:: Get the Eiffel version MAJOR.MINOR from install scripts, and set variable named %1 with it.
::
for /f "delims=" %%i in ('cat %~dp0..\install\includes\Preprocessors.wxi ^| findstr /i /c:"ProductKey" ^| head -1 ^| sed "s/.*\([0-9][0-9]\.[0-9][0-9]\).*/\1/g"') do set "%1=%%i"

