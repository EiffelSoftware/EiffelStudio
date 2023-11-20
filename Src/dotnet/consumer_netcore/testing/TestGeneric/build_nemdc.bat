set NEMDC_PUB=%cd%\..\..\pub\win64
set ISE_EMDC=%NEMDC_PUB%\nemdc.exe
set CWD=%cd%
cd %~dp0..\..
geant publish
cd %CWD%
