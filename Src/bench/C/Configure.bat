@echo off
if .%1. == .clean. goto clean
if .%1. == .win32. goto win32
if .%1. == .win31. goto win31
:usage
echo make ...
echo     Options:
echo        clean   - remove unecessary files
echo        win32 b - build a Win32 run-time for Borland
echo        win32 m - build a Win32 run-time for Microsoft
echo        win32 w - build a Win32 run-time for Watcom
echo        win32 s - build a Win32 run-time for Symantec
echo        win31   - build a Windows 3.1 run-time
goto end
:win31
echo Not fully implemented yet
copy config.win config.h
copy confmagi.h confmagc.h
del run-time\config.h
rem We may be run on a 32 bit machine
copy confmagic.h confmagc.h
cd run-time
copy makefile.win makefile
wmake
goto end
:win32
if .%2. == .. goto usage
if NOT .%2. == .b. goto msoft
copy config.w32b config.h
copy config.bsh config.sh
goto process
:msoft
if NOT .%2. == .m. goto symantec
copy config.w32m config.h
copy config.msh config.sh
goto process
:symantec
if NOT .%2. == .s. goto watcom
copy config.w32s config.h
copy config.ssh config.sh
goto process
:watcom
if NOT .%2. == .w. goto usage
copy config.w32w config.h
copy config.wsh config.sh
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
echo set INCLUDE=$include_path>> make.w32
echo set LIB=$lib_path>> make.w32
echo $make>> make.w32
rt-converter make.w32 make.w32
del run-time\config.h
rem
rem Copy the config 
rem
copy config.sh extra\win32\console
copy make.w32 extra\win32\console\make.bat
copy config.sh extra\win32\desc
copy make.w32 extra\win32\desc\make.bat
copy config.sh extra\win32\ipc\app
copy make.w32 extra\win32\ipc\app\make.bat
copy config.sh extra\win32\ipc\daemon
copy make.w32 extra\win32\ipc\daemon\make.bat
copy config.sh extra\win32\ipc\ewb
copy make.w32 extra\win32\ipc\ewb\make.bat
copy config.sh extra\win32\ipc\shared
copy make.w32 extra\win32\ipc\shared\make.bat
copy config.sh extra\win32\networku
copy make.w32 extra\win32\networku\make.bat
copy config.sh parsing\eiffel
copy make.w32 parsing\eiffel\make.bat
copy config.sh parsing\lace
copy make.w32 parsing\lace\make.bat
copy config.sh parsing\shared
copy make.w32 parsing\shared\make.bat
copy config.sh platform
copy make.w32 platform\make.bat
copy config.sh idrs
copy make.w32 idrs\make.bat
copy config.sh run-time
copy make.w32 run-time\make.bat
copy run-time\size.win run-time\size.h
copy run-time\size.win size.h
rem
rem Call the converter tranforming the makefile-win.sh to makefile
rem
cd extra\win32\ipc\shared
..\..\..\..\rt-converter makefile-win.sh makefile
cd ..\..\..\..\run-time
..\rt-converter makefile-win.sh makefile
cd ..\parsing\shared
..\..\rt-converter makefile-win.sh makefile
cd ..\eiffel
..\..\rt-converter makefile-win.sh makefile
cd ..\lace
..\..\rt-converter makefile-win.sh makefile
cd ..\..
cd platform
..\rt-converter makefile-win.sh makefile
cd ..
cd idrs
..\rt-converter makefile-win.sh makefile
cd ..
cd extra\win32\console
..\..\..\rt-converter makefile-win.sh makefile
cd ..\networku
..\..\..\rt-converter makefile-win.sh makefile
cd ..\ipc\daemon
..\..\..\..\rt-converter makefile-win.sh makefile
cd ..\ewb
..\..\..\..\rt-converter makefile-win.sh makefile
cd ..\app
..\..\..\..\rt-converter makefile-win.sh makefile
cd ..\shared
..\..\..\..\rt-converter makefile-win.sh makefile
cd ..\..\..\..
rem
rem Call make
rem
echo cd extra\win32\ipc\shared>> make.bat
echo call make>> make.bat
echo cd ..\..\..\..\run-time>> make.bat
echo call make>> make.bat
echo cd ..\parsing\shared>> make.bat
echo call make>> make.bat
echo cd ..\eiffel>> make.bat
echo call make>> make.bat
echo cd ..\lace>> make.bat
echo call make>> make.bat
echo cd ..\..>> make.bat
echo cd platform>> make.bat
echo call make>> make.bat
echo cd ..>> make.bat
echo cd extra\win32\ipc\daemon>> make.bat
echo call make>> make.bat
echo cd ..\ewb>> make.bat
echo call make>> make.bat
echo cd ..\..\..\..>> make.bat
call make
goto end
:clean
del cleanup.bat
echo @echo off > cleanup.bat
echo rem created by Make clean in $Eiffel3\c
echo del %%1\*.err >> cleanup.bat
echo del %%1\make.bat >> cleanup.bat
echo del %%1\*.tr2 >> cleanup.bat
echo del %%1\*.ob? >> cleanup.bat
echo del %%1\*.l?b >> cleanup.bat
echo del %%1\*.l?k >> cleanup.bat
echo del %%1\*.ex? >> cleanup.bat
echo del %%1\*.res >> cleanup.bat
echo del %%1\*.map >> cleanup.bat
echo del %%1\*.$$$ >> cleanup.bat
echo del %%1\*.bak >> cleanup.bat
echo del %%1\*.zip >> cleanup.bat
echo del %%1\*.pdb >> cleanup.bat
echo del %%1\*.pch >> cleanup.bat
echo del %%1\makefile >> cleanup.bat
call cleanup extra\mswin\console
call cleanup extra\mswin\desc
call cleanup extra\mswin\ipc
call cleanup extra\mswin\networku
call cleanup extra\mswin\precompd
call cleanup extra\win32\console
call cleanup extra\win32\desc
call cleanup extra\win32\ipc\app
call cleanup extra\win32\ipc\daemon
call cleanup extra\win32\ipc\ewb
call cleanup extra\win32\ipc\shared
call cleanup extra\win32\networku
call cleanup parsing\eiffel
call cleanup parsing\lace
call cleanup parsing\shared
call cleanup platform
call cleanup idrs
call cleanup run-time
del extra\win32\desc\w32msc\ise_desc.*
rmdir extra\win32\desc\w32msc
del parsing\lace\lace_y.c
del parsing\lace\lace_y.h
del parsing\eiffel\y_tab.*
del parsing\eiffel\parser.c
del parsing\eiffel\parser.h
del run-time\config.h
del run-time\size.h
del run-time\makefile
del run-time\portable.h
del confmagc.h
del config.h
del make.w32
del make.bat
del size.h
del *.$$$
:end
echo Make completed
