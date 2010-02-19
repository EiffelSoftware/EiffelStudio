rd /Q /S %TEMP%\vision2_precompile
mkdir %TEMP%\vision2_precompile
%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec -config vision2.ecf -local -project_path %TEMP%\vision2_precompile

REM Create flatshort directory
MD .\flatshort

REM now perform generation based on "flatshort_instructions.txt"
type flatshort_instructions.txt | %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\ec -config vision2.ecf -local -project_path %TEMP%\vision2_precompile -loop

REM remove vision2_precompile directory.
rd /Q /S %TEMP%\vision2_precompile
