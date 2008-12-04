@echo off
set OLD_PATH=%PATH%
set OLD_COMSPEC=%COMSPEC%
set PATH=%~dp0\shell\bin;%PATH%

if .%1. == .clean. goto clean
if .%1. == .win32. goto win32
if .%1. == .win64. goto win64
:usage
echo make ...
echo     Options:
echo        clean          - remove unecessary files including desc
echo        win32 b        - build a Win32 run-time for Borland
echo        win32 g        - build a Win32 run-time for MinGW
echo        win32 m  [dll] - build a Win32 run-time for Microsoft C++ 2005 [as DLL if specified]
echo        win32 m6 [dll] - build a Win32 run-time for Microsoft C++ 6.0 [as DLL if specified]
echo        win64 m  [dll] - build a Win64 run-time for Microsoft C++ 2005 [as DLL if specified]
echo        win64 l        - build a Win64 run-time for LCC
goto end
:win32
if .%2. == .. goto usage
if NOT .%2. == .b. goto mingw
set PATH=%ISE_EIFFEL%\BCC55\bin;%PATH%
copy CONFIGS\windows-x86-bcb config.sh
set remove_desc=1
goto process
:mingw
if NOT .%2. == .g. goto msc
copy CONFIGS\windows-x86-mingw config.sh
set remove_desc=1
goto process
:msc
if NOT .%2. == .m. goto msc6
copy CONFIGS\windows-x86-msc config.sh
goto process
:msc6
if NOT .%2. == .m6. goto usage
copy CONFIGS\windows-x86-msc6 config.sh
goto process
:win64
if .%2. == .. goto usage
if NOT .%2. == .m. goto lcc
copy CONFIGS\windows-x86-64-msc config.sh
set remove_desc=1
goto process
:lcc
if NOT .%2. == .l. goto usage
copy CONFIGS\windows-x86-64-lcc config.sh
set remove_desc=1
:process

rem A workaround for getting MSYS tools run on all x64 Windows platform.
rem See http://www.mingw.org/MinGWiki/index.php/MsysShell for more details.
rem Only needed when executing: sh, mv, sed
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	SET COMSPEC=%WINDIR%\SysWOW64\cmd.exe
)

if .%3. == .dll. (
	shell\bin\sed -e "s/\-W4/\-DEIF_MAKE_DLL\ \-W4/g" config.sh >> config.sh.modif
	shell\bin\mv config.sh.modif config.sh
	shell\bin\sed -e "s/standard\ mtstandard/dll\ mtdll/g" config.sh >> config.sh.modif
	shell\bin\mv config.sh.modif config.sh
)

"%COMSPEC%" /c shell\bin\sh.exe eif_config_h.SH
cd run-time
"%COMSPEC%" /c ..\shell\bin\sh.exe eif_size_h.SH
cd ..

rem Get the actual make name
echo echo $make > make_name.bat
shell\bin\rt_converter.exe make_name.bat make_name.bat
rem Replace $(XX) into %X%
shell\bin\sed -e "s/\$(\([^)]*\))/%%\1%%/g" make_name.bat >> make_name.modif
shell\bin\mv make_name.modif make_name.bat

rem Generate the make.w32 file with the above name
echo @echo off > make.w32 
call make_name.bat >> make.w32
del make_name.bat
rem Replace all / by \
shell\bin\sed -e "s/\//\\\/g" make.w32 >> make.w32.modif
shell\bin\mv make.w32.modif make.w32

if exist run-time\eif_config.h del run-time\eif_config.h
rem
rem Copy the config 
rem
copy eif_config.h run-time
copy eif_portable.h run-time
copy config.sh bench
copy make.w32 bench\make.bat
copy config.sh console
copy make.w32 console\make.bat
if not "%remove_desc%" == "1" (
	copy config.sh desc
	copy make.w32 desc\make.bat
)
copy config.sh ipc\app
copy make.w32 ipc\app\make.bat
copy config.sh ipc\daemon
copy make.w32 ipc\daemon\make.bat
copy config.sh ipc\ewb
copy make.w32 ipc\ewb\make.bat
copy config.sh ipc\shared
copy make.w32 ipc\shared\make.bat
copy config.sh platform
copy make.w32 platform\make.bat
copy config.sh idrs
copy make.w32 idrs\make.bat
copy config.sh run-time
copy make.w32 run-time\make.bat
del make.w32
rem
rem Create OBJDIR, LIB in run-time
rem
cd run-time
if not exist OBJDIR mkdir OBJDIR
if not exist LIB mkdir LIB
cd ..
rem
rem Call the converter tranforming the makefile-win.sh to Makefile
rem
cd ipc\shared
..\..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\..\run-time
..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\platform
..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\idrs
..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\console
..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\bench
..\shell\bin\rt_converter.exe makefile-win.sh Makefile
if not "%remove_desc%" == "1" (
	cd ..\desc
	..\shell\bin\rt_converter.exe makefile-win.sh Makefile
)
cd ..\ipc\daemon
..\..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\ewb
..\..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\app
..\..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\shared
..\..\shell\bin\rt_converter.exe makefile-win.sh Makefile
cd ..\..
rem
rem Call make
rem
echo @echo off > make.bat
echo cd console>> make.bat
echo call make>> make.bat
echo cd ..\idrs>> make.bat
echo call make>> make.bat
echo cd ..\ipc\shared>> make.bat
echo call make>> make.bat
echo cd ..\app>> make.bat
echo call make>> make.bat
echo cd ..\ewb>> make.bat
echo call make>> make.bat
echo cd ..\daemon>> make.bat
echo call make>> make.bat
echo cd ..\..\run-time>> make.bat
echo call make>> make.bat
echo cd ..>> make.bat
echo cd platform>> make.bat
echo call make>> make.bat
echo cd ..\bench >> make.bat
echo call make >> make.bat
if not "%remove_desc%" == "1" (
	echo cd ..\desc>> make.bat
	echo call make>> make.bat
)
echo cd ..>> make.bat
call make
goto end
:clean
copy cleanup.bat console\
copy cleanup.bat bench\
copy cleanup.bat desc\
copy cleanup.bat ipc\app\
copy cleanup.bat ipc\daemon\
copy cleanup.bat ipc\ewb\
copy cleanup.bat ipc\shared\
copy cleanup.bat platform\
copy cleanup.bat idrs\
copy cleanup.bat run-time\
if exist run-time\OBJDIR copy cleanup.bat run-time\OBJDIR\
if exist run-time\LIB copy cleanup.bat run-time\LIB\

cd bench
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\console
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\desc
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\ipc\app
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\daemon
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\ewb
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\shared
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\..\platform
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\idrs
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..\run-time
call cleanup.bat
if exist cleanup.bat del cleanup.bat
if exist OBJDIR (
cd OBJDIR
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..
)
if exist LIB (
cd LIB
call cleanup.bat
if exist cleanup.bat del cleanup.bat
cd ..
)
cd ..

if exist run-time\eif_config.h del run-time\eif_config.h
if exist run-time\eif_size.h del run-time\eif_size.h
if exist run-time\eif_portable.h del run-time\eif_portable.h
if exist config.sh del config.sh
if exist confmagc.h del confmagc.h
if exist eif_config.h del eif_config.h
if exist make.bat del make.bat
if exist eif_size.h del eif_size.h

:end
set PATH=%OLD_PATH%
set COMSPEC=%OLD_COMSPEC%
set remove_desc=
echo Make completed
