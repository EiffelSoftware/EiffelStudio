@echo off
if .%1. == .clean. goto clean
if .%1. == .win32. goto win32
if .%1. == .win31. goto win31
:usage
echo make ...
echo     Options:
echo        clean   - remove unecessary files
echo        win32 b - build a Win32 run-time for Borland
echo        win32 g - build a Win32 run-time for GCC-cygwin
echo        win32 l - build a Win32 run-time for lcc
echo        win32 m - build a Win32 run-time for Microsoft
echo        win32 w - build a Win32 run-time for Watcom
echo        win32 s - build a Win32 run-time for Symantec
echo        win31   - build a Windows 3.1 run-time
goto end
:win31
echo Not fully implemented yet
copy config.win eif_config.h
copy confmagi.h confmagc.h
del run-time\eif_config.h
rem We may be run on a 32 bit machine
copy eif_confmagic.h confmagc.h
cd run-time
copy makefile.win makefile
wmake
goto end
:win32
if .%2. == .. goto usage
if NOT .%2. == .b. goto msoft
copy config.w32b eif_config.h
copy config.bsh config.sh
goto process
:msoft
if NOT .%2. == .m. goto symantec
copy config.w32m eif_config.h
copy config.msh config.sh
goto process
:symantec
if NOT .%2. == .s. goto watcom
copy config.w32s eif_config.h
copy config.ssh config.sh
goto process
:watcom
if NOT .%2. == .w. goto gcc
copy config.w32w eif_config.h
copy config.wsh config.sh
goto process
:gcc
if NOT .%2. == .g. goto lcc
copy config.w32m eif_config.h
copy config.gsh config.sh
goto process
:lcc
if NOT .%2. == .l. goto usage
copy config.w32m eif_config.h
copy config.lsh config.sh
goto process
:process
type config.sh
echo The above is the configuration file for the
echo chosen C++ compiler. If the above configurations
echo are incorrect, then abort this program (control + break and then
echo press any key) and edit the configuration file:
echo     - config.msh (Configuration file for Visual C++)
echo     - config.bsh (Configuration file for Borland C++)
echo     - config.wsh (Configuration file for Watcom C++)
echo     - config.ssh (Configuration file for Symantec C++)
pause
echo @echo off > make.w32
echo $make %%1>> make.w32
rt_converter.exe make.w32 make.w32
del run-time\eif_config.h
rem
rem Copy the config 
rem
copy eif_config.h run-time
copy eif_portable.h run-time
copy config.sh bench
copy make.w32 bench\make.bat
copy config.sh minilzo
copy make.w32 minilzo\make.bat
copy config.sh console
copy make.w32 console\make.bat
copy config.sh desc
copy make.w32 desc\make.bat
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
copy run-time\size.win run-time\eif_size.h
copy run-time\size.win eif_size.h
rem
rem Create OBJDIR and LIB in run-time
rem
cd run-time
mkdir OBJDIR
mkdir LIB
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
cd ..\minilzo
..\rt_converter.exe makefile-win.sh makefile
cd ..\ipc\daemon
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\ewb
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\app
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\shared
..\..\rt_converter.exe makefile-win.sh makefile
cd ..\..\desc
..\rt_converter.exe makefile-win.sh makefile
cd ..
rem
rem Call make
rem
del make.bat
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
echo cd ..\minilzo >> make.bat
echo call make >> make.bat
echo cd ..\desc>> make.bat
echo call make>> make.bat
echo cd ..>> make.bat
call make
goto end
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
echo del config.sh >> cleanup.bat
echo del makefile >> cleanup.bat
echo del make.bat >> cleanup.bat
echo del cleanup.bat >> cleanup.bat

copy cleanup.bat console\
copy cleanup.bat bench\
copy cleanup.bat minilzo\
copy cleanup.bat desc\
copy cleanup.bat ipc\app\
copy cleanup.bat ipc\daemon\
copy cleanup.bat ipc\ewb\
copy cleanup.bat ipc\shared\
copy cleanup.bat platform\
copy cleanup.bat idrs\
copy cleanup.bat run-time\
copy cleanup.bat run-time\OBJDIR\
copy cleanup.bat run-time\LIB\

cd bench
call cleanup
cd ..\minilzo
call cleanup
cd ..\console
call cleanup
cd ..\desc
call cleanup
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
cd ..\..

del run-time\eif_config.h
del run-time\eif_size.h
del run-time\eif_portable.h
del config.sh
del confmagc.h
del eif_config.h
del make.w32
del make.bat
del eif_size.h
del *.$$$

del cleanup.bat

:end
echo Make completed
