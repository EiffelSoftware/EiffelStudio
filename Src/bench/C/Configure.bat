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
if NOT .%2. == .w. goto usage
copy config.w32w eif_config.h
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
echo $make %%1>> make.w32
rt-converter.exe make.w32 make.w32
del run-time\eif_config.h
rem
rem Copy the config 
rem
copy eif_config.h run-time
copy eif_portable.h run-time
copy config.sh bench
copy make.w32 bench\make.bat
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
copy run-time\size.win run-time\eif_size.h
copy run-time\size.win eif_size.h
rem
rem Call the converter tranforming the makefile-win.sh to makefile
rem
cd ipc\shared
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\..\run-time
..\rt-converter.exe makefile-win.sh makefile
cd ..\parsing\shared
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\eiffel
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\lace
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\..\platform
..\rt-converter.exe makefile-win.sh makefile
cd ..\idrs
..\rt-converter.exe makefile-win.sh makefile
cd ..\console
..\rt-converter.exe makefile-win.sh makefile
cd ..\bench
..\rt-converter.exe makefile-win.sh makefile
cd ..\ipc\daemon
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\ewb
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\app
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\shared
..\..\rt-converter.exe makefile-win.sh makefile
cd ..\..\desc
..\rt-converter.exe makefile-win.sh makefile
cd ..
rem
rem Call make
rem
del make.bat
echo cd ipc\shared>> make.bat
echo call make>> make.bat
echo cd ..\..\run-time>> make.bat
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
echo cd ..\bench >> make.bat
echo call make >> make.bat
echo cd ..>> make.bat
echo cd ipc\daemon>> make.bat
echo call make>> make.bat
echo cd ..\ewb>> make.bat
echo call make>> make.bat
echo cd ..\..\desc>> make.bat
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
echo del config.sh >> cleanup.bat
echo del makefile >> cleanup.bat
echo del make.bat >> cleanup.bat
echo del cleanup.bat >> cleanup.bat

copy cleanup.bat console\
copy cleanup.bat bench\
copy cleanup.bat desc\
copy cleanup.bat ipc\app\
copy cleanup.bat ipc\daemon\
copy cleanup.bat ipc\ewb\
copy cleanup.bat ipc\shared\
copy cleanup.bat parsing\eiffel\
copy cleanup.bat parsing\lace\
copy cleanup.bat parsing\shared\
copy cleanup.bat platform\
copy cleanup.bat idrs\
copy cleanup.bat run-time\
copy cleanup.bat run-time\OBJDIR\
copy cleanup.bat run-time\LIB\

cd bench
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
cd ..\..\parsing\eiffel
call cleanup
cd ..\lace
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

del parsing\lace\lace_y.c
del parsing\lace\lace_y.h
del parsing\eiffel\y_tab.*
del parsing\eiffel\parser.c
del parsing\eiffel\parser.h
del parsing\eiffel\wpstore.c
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

del run-time\bexcept.c
del run-time\bmain.c

del run-time\wargv.c
del run-time\wbits.c
del run-time\wboolstr.c
del run-time\wcecil.c
del run-time\wconsole.c
del run-time\wcopy.c
del run-time\wdir.c
del run-time\wdle.c
del run-time\weif_threads.c
del run-time\weif_cond_var.c
del run-time\weif_once.c
del run-time\weif_project.c
del run-time\wequal.c
del run-time\werror.c
del run-time\wexcept.c
del run-time\wfile.c
del run-time\wgarcol.c
del run-time\whash.c
del run-time\whashin.c
del run-time\whector.c
del run-time\winterna.c
del run-time\wlocal.c
del run-time\wmain.c
del run-time\wmalloc.c
del run-time\wlmalloc.c
del run-time\wmath.c
del run-time\wmemory.c
del run-time\wmisc.c
del run-time\wobject_id.c
del run-time\woption.c
del run-time\wout.c
del run-time\wpath_name.c
del run-time\wpattern.c
del run-time\wplug.c
del run-time\wretrieve.c
del run-time\wrun_idr.c
del run-time\wsearch.c
del run-time\wsig.c
del run-time\wstore.c
del run-time\wstring.c
del run-time\wtimer.c
del run-time\wtools.c
del run-time\wtravers.c
del run-time\wumain.c
del run-time\wurgent.c
del run-time\wurgent.c
del run-time\wgen_conf.c
del run-time\wrout_obj.c
del cleanup.bat

:end
echo Make completed
