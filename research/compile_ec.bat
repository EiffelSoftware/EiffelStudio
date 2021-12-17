rem @echo off
set "EIFFEL_SRC=%~dp0..\Src"
set "ISE_LIBRARY=%EIFFEL_SRC%"
call "%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\estudio" "%~dp0extension\autoproof\Eiffel\Ace\ec.ecf"
