setlocal
set T_CWD=%cd%

if "%1" EQU "" (
	set ISE_PLATFORM=win64
) else (
	set ISE_PLATFORM=%1
)
call %~dp0setup_%ISE_PLATFORM%.bat

echo Remove Eiffel User Files
if EXIST "%USERPROFILE%\Documents\Eiffel User Files" rd /q/s "%USERPROFILE%\Documents\Eiffel User Files" 
echo Remove Eiffel installation configurations
if EXIST "%USERPROFILE%\AppData\Local\Eiffel Software\.es" rd /q/s "%USERPROFILE%\AppData\Local\Eiffel Software\.es"

cd %~dp0
call %~dp0build_fix_dotnet.bat
call fix_dotnet.bat
del fix_dotnet.bat
REM
echo Reset Install scripts
cd %~dp0..
svn revert -R install
echo - remove install\binaries
if EXIST install\binaries rd /q/s install\binaries
echo - remove install\bin\studio_gpl_x64 rd
if EXIST install\bin\studio_gpl_x64 rd /q/s install\bin\studio_gpl_x64
echo - remove install\bin\studio_gpl_x86 rd
if EXIST install\bin\studio_gpl_x86 rd /q/s install\bin\studio_gpl_x86
echo - remove install\bin\studio_ent_x64 rd
if EXIST install\bin\studio_ent_x64 rd /q/s install\bin\studio_ent_x64
echo - remove install\bin\studio_ent_x86 rd
if EXIST install\bin\studio_ent_x86 rd /q/s install\bin\studio_ent_x86
echo - make sure to use expected install files - get from svn

cd %T_CWD%
