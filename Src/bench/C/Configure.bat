@echo off
if .%1. == .clean. goto clean
if .%1. == .cleand. goto cleand
if .%1. == .win32. goto win32
if .%1. == .win64. goto win64
:usage
echo make ...
echo     Options:
echo        clean   - remove unecessary files including desc
echo        cleand - remove unecessary files excluding desc
echo        win32 b - build a Win32 run-time for Borland
echo        win32 m - build a Win32 run-time for Microsoft
echo        win64 m - build a Win64 run-time for Microsoft
goto end
:win32
if .%2. == .. goto usage
if NOT .%2. == .b. goto msc
copy CONFIGS\windows-bcb-x86 config.sh
set remove_desc=1
goto process
:msc
if NOT .%2. == .m. goto usage
copy CONFIGS\windows-msc-x86 config.sh
goto process
:win64
if .%2. == .. goto usage
if NOT .%2. == .m. goto usage
copy CONFIGS\windows-msc-x86-64 config.sh
set remove_desc=1
goto process
:process

bash eif_config_h.SH
cd run-time
bash eif_size_h.SH
cd ..

echo @echo off > make.w32
echo $make %%1>> make.w32
rt_converter.exe make.w32 make.w32
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
rem Create OBJDIR, LIB, and FREELIB in run-time
rem
cd run-time
if not exist OBJDIR mkdir OBJDIR
if not exist LIB mkdir LIB
if not exist FREELIB mkdir FREELIB
cd ..
rem
rem Call the converter tranforming the makefile-win.sh to makefile
rem
cd ipc\shared
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\..\run-time
..\rt_converter.exe makefile-win.sh makefile
cd ..\platform
..\rt_converter.exe makefile-win.sh makefile
cd ..\idrs
..\rt_converter.exe makefile-win.sh makefile
cd ..\console
..\rt_converter.exe makefile-win.sh makefile
cd ..\bench
..\rt_converter.exe makefile-win.sh makefile
if not "%remove_desc%" == "1" (
	cd ..\desc
	..\rt_converter.exe makefile-win.sh makefile
)
cd ..\ipc\daemon
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\ewb
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\app
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\shared
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\..
rem
rem Call make
rem
if exist make.bat del make.bat
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
:cleand
set remove_desc=1
:clean
del cleanup.bat
echo del *.err >> cleanup.bat
echo del *.tr2 >> cleanup.bat
echo del *.ob? >> cleanup.bat
echo del *.l?b >> cleanup.bat
echo del *.l?k >> cleanup.bat
echo del *.ex? >> cleanup.bat
echo del *.res >> cleanup.bat
echo del *.map >> cleanup.bat
echo del *.$$$ >> cleanup.bat
echo del *.bak >> cleanup.bat
echo del *.zip >> cleanup.bat
echo del *.pdb >> cleanup.bat
echo del *.pch >> cleanup.bat
echo del *.dll >> cleanup.bat
echo del *.tds >> cleanup.bat
echo del *.o >> cleanup.bat
echo del *.il? >> cleanup.bat
echo del config.sh >> cleanup.bat
echo del makefile >> cleanup.bat
echo del make.bat >> cleanup.bat
echo del cleanup.bat >> cleanup.bat

copy cleanup.bat console\
copy cleanup.bat bench\
if not "%remove_desc%" == "1" (
	copy cleanup.bat desc\
)
copy cleanup.bat ipc\app\
copy cleanup.bat ipc\daemon\
copy cleanup.bat ipc\ewb\
copy cleanup.bat ipc\shared\
copy cleanup.bat platform\
copy cleanup.bat idrs\
copy cleanup.bat run-time\
copy cleanup.bat run-time\OBJDIR\
copy cleanup.bat run-time\LIB\
copy cleanup.bat run-time\FREELIB\

cd bench
call cleanup
cd ..\console
call cleanup
if not "%remove_desc%" == "1" (
	cd ..\desc
	call cleanup
)
cd ..\ipc\app
call cleanup
cd ..\daemon
call cleanup
cd ..\ewb
call cleanup
cd ..\shared
call cleanup
cd ..\..\platform
call cleanup
cd ..\idrs
call cleanup
cd ..\run-time
call cleanup
cd OBJDIR
call cleanup
cd ..\LIB
call cleanup
cd ..\FREELIB
call cleanup
cd ..\..

del run-time\eif_config.h
del run-time\eif_size.h
del run-time\eif_portable.h
del config.sh
del confmagc.h
del eif_config.h
del make.bat
del eif_size.h
del *.$$$

del cleanup.bat

:end
set remove_desc=
echo Make completed
