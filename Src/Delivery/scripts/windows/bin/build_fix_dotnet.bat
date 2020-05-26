@echo off
setlocal
rem Output a set of command to remove EiffelSoftware regasm-registered dll.
rem removing the related reg key helps fixing dotnet Eiffel compilation.
rem
rem Usage: build_fix_dotnet.bat 
rem   - edit, check and modify if needed, the "fix_dotnet.bat" script
rem   - then execute "fix_dotnet.bat" following the requirements.
rem Requirements:
rem   - have ISE_EIFFEL and ISE_PLATFORM set, in order to perform new registration using regasm.
rem   - run "fix_dotnet.bat" in administration mode.

set TMP_SCRIPT_FILENAME=fix_dotnet.bat

echo REM Build script to fix dotnet Eiffel environment...

echo REM Fix dotnet Eiffel environment  > %TMP_SCRIPT_FILENAME%

reg query HKCR > %TMP_SCRIPT_FILENAME%.tmp
for /f %%f in ('findstr "EiffelSoftware" %TMP_SCRIPT_FILENAME%.tmp') do call :getclsid %%f
del %TMP_SCRIPT_FILENAME%.tmp

set ESPAWN_OPTS=--nologo
REM if "%ISE_PLATFORM%" EQU "windows" set ESPAWN_OPTS=%ESPAWN_OPTS% --x86

echo %ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin\espawn.exe %ESPAWN_OPTS% "regasm %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\EiffelSoftware.Runtime.dll" >> %TMP_SCRIPT_FILENAME%
echo %ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin\espawn.exe %ESPAWN_OPTS% "regasm %ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin\EiffelSoftware.MetadataConsumer.dll" >> %TMP_SCRIPT_FILENAME%

echo REM completed, see %TMP_SCRIPT_FILENAME%

goto end


:getclsid
::echo getclsid %1
reg query "%1\CLSID" > %TMP_SCRIPT_FILENAME%.tmp2
for /f "tokens=3*" %%a in ('findstr "Default" %TMP_SCRIPT_FILENAME%.tmp2') do call :delclsid %%a
del %TMP_SCRIPT_FILENAME%.tmp2

echo REG DELETE %1 /f 
echo REG DELETE %1 /f >> %TMP_SCRIPT_FILENAME%
goto :EOF

:delclsid
echo REG DELETE HKCR\CLSID\%1 /f 
echo REG DELETE HKCR\CLSID\%1 /f >> %TMP_SCRIPT_FILENAME%
goto :EOF

:end
goto :EOF
