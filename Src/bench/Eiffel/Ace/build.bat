rem Finalizing new compiler

cdd %1
rd /q /s EIFGEN

%ISE_EIFFEL%\studio\spec\windows\bin\ec.exe -finalize -project_path %1 -ace %EIFFEL_SRC%\Eiffel\Ace\newbench.mswin.ace -batch

cdd EIFGEN\F_code

%ISE_EIFFEL%\studio\spec\windows\bin\finish_freezing.exe -silent

cdd %ISE_EIFFEL%\studio\spec\windows\bin
ren ec.exe old_ec.exe
copy %1\EIFGEN\F_code\ec.exe .

cdd %2
rd /q /s EIFGEN

%ISE_EIFFEL%\studio\spec\windows\bin\ec.exe -freeze -project_path %2 -ace %EIFFEL_SRC%\Eiffel\Ace\newbench.mswin.ace -batch

cdd EIFGEN\W_code

%ISE_EIFFEL%\studio\spec\windows\bin\finish_freezing.exe -silent
