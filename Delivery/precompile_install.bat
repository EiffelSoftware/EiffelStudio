echo off
rem Installation of the precompiled libraries for Windows
rem It will precompile
rem - EiffelBase
rem - WEL
rem - EiffelVision2
rem
rem For other precompiled libraries, go through the precompilation
rem wizard in the EiffelStudio environment.

set TEST=

if .%1. == .nt. goto NT
if .%1. == .win9x. goto WINX
goto start
:NT
set RM=%TEST% rd /q /s
goto start
:WINX
set RM=%TEST% deltree
goto start

:start
set MV=%TEST% ren
set DEL=%TEST% del /q
set EC=%TEST% ..\..\..\..\bench\spec\windows\bin\ec.exe
set FF=%TEST% ..\..\..\..\..\..\bench\spec\windows\bin\finish_freezing.exe -silent

echo %DEL% /s *.c >> cleanup.bat
echo %DEL% /s *.obj >> cleanup.bat
echo %DEL% /s Cobj*.lib >> cleanup.bat
echo %DEL% /s Eobj*.lib >> cleanup.bat
echo %DEL% /s finished >> cleanup.bat
echo %DEL% /s Makefile >> cleanup.bat
echo %DEL% /s Makefile.SH >> cleanup.bat
echo %DEL% /s *.bak >> cleanup.bat
echo %DEL% /s *.pdb >> cleanup.bat
echo %DEL% * >> cleanup.bat
echo %DEL% cleanup.bat >> cleanup.bat

rem Precompiling EiffelBase
cd precomp\spec\windows\base
%RM% EIFGEN
%EC% -precompile
cd EIFGEN\W_code
copy ..\..\..\..\..\..\cleanup.bat .
%FF%
call cleanup.bat

if .%2. == .wel. goto wel
if .%2. == .vision2. goto wel
goto END
:wel
rem Precompiling WEL
cd ..\..\..\wel
%RM% EIFGEN
%EC% -precompile
cd EIFGEN\W_code
copy ..\..\..\..\..\..\cleanup.bat .
%FF%
call cleanup.bat

if .%2. == .vision2. goto vision2
goto END
:vision2
rem Precompiling EiffelVision2
cd ..\..\..\vision2
%RM% EIFGEN
%EC% -precompile
cd EIFGEN\W_code
copy ..\..\..\..\..\..\cleanup.bat .
%FF%
call cleanup.bat

:END
cd ..\..\..\..\..\..

%DEL% cleanup.bat
