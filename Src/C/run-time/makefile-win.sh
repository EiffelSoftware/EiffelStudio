TOP = ..
DIR = $dir_sep
OUTDIR = .$(DIR)LIB$(DIR)
INDIR = .$(DIR)OBJDIR$(DIR)
RTSRC = .$(DIR)
CC = $cc
CTAGS = ctags
OUTPUT_EXE_CMD = $output_exe_cmd
OUTPUT_CMD = $output_cmd
INPUT_CMD = $input_cmd
JCFLAGS = $(CFLAGS) $ccflags $optimize $(INPUT_CMD) $(OUTPUT_CMD)$@ -c
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize $(INPUT_CMD) $(OUTPUT_CMD)$@ -c
JMTCPPFLAGS = $(CPPFLAGS) $mtcppflags $optimize $(INPUT_CMD) $(OUTPUT_CMD)$@ -c
LIB_EXE = $lib_exe
MAKE = $make
LINK32 = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs

CFLAGS = -I. -I./include -I$(TOP) -I$(TOP)/idrs -I$(TOP)/console -I$(TOP)/ipc/app
CPPFLAGS = -I.
NETWORK = $(TOP)$(DIR)ipc$(DIR)app$(DIR)network.$lib
MT_NETWORK = $(TOP)$(DIR)ipc$(DIR)app$(DIR)mtnetwork.$lib
LIBNAME = ipc.$lib
LIBMTNAME = mtipc.$lib

FINAL_OBJECTS = \
	$(INDIR)lmalloc.$obj \
	$(INDIR)malloc.$obj \
	$(INDIR)offset.$obj \
	$(INDIR)garcol.$obj \
	$(INDIR)local.$obj \
	$(INDIR)except.$obj \
	$(INDIR)store.$obj \
	$(INDIR)retrieve.$obj \
	$(INDIR)hash.$obj \
	$(INDIR)traverse.$obj \
	$(INDIR)hashin.$obj \
	$(INDIR)tools.$obj \
	$(INDIR)internal.$obj \
	$(INDIR)plug.$obj \
	$(INDIR)copy.$obj \
	$(INDIR)equal.$obj \
	$(INDIR)out.$obj \
	$(INDIR)timer.$obj \
	$(INDIR)urgent.$obj \
	$(INDIR)sig.$obj \
	$(INDIR)hector.$obj \
	$(INDIR)cecil.$obj \
	$(INDIR)file.$obj \
	$(INDIR)dir.$obj \
	$(INDIR)misc.$obj \
	$(INDIR)error.$obj \
	$(INDIR)umain.$obj \
	$(INDIR)memory.$obj \
	$(INDIR)memory_analyzer.$obj \
	$(INDIR)argv.$obj \
	$(INDIR)boolstr.$obj \
	$(INDIR)search.$obj \
	$(INDIR)option.$obj \
	$(INDIR)console.$obj \
	$(TOP)$(DIR)idrs$(DIR)idrs.$obj \
	$(INDIR)run_idr.$obj \
	$(INDIR)path_name.$obj \
	$(INDIR)object_id.$obj \
	$(INDIR)compress.$obj \
	$(INDIR)posix_threads.$obj \
	$(INDIR)eif_threads.$obj \
	$(INDIR)eif_project.$obj \
	$(INDIR)gen_conf.$obj \
	$(INDIR)eif_type_id.$obj \
	$(INDIR)rout_obj.$obj \
	$(TOP)$(DIR)ipc$(DIR)shared$(DIR)shword.$obj \
	$(TOP)$(DIR)console$(DIR)winconsole.$lib

OBJECTS = $(FINAL_OBJECTS) \
	$(INDIR)main.$obj

WORKBENCH_OBJECTS = \
	$(INDIR)wlmalloc.$obj \
	$(INDIR)wmalloc.$obj \
	$(INDIR)offset.$obj \
	$(INDIR)wgarcol.$obj \
	$(INDIR)wlocal.$obj \
	$(INDIR)wexcept.$obj \
	$(INDIR)wstore.$obj \
	$(INDIR)wretrieve.$obj \
	$(INDIR)whash.$obj \
	$(INDIR)wtraverse.$obj \
	$(INDIR)whashin.$obj \
	$(INDIR)wtools.$obj \
	$(INDIR)winternal.$obj \
	$(INDIR)wplug.$obj \
	$(INDIR)wcopy.$obj \
	$(INDIR)wequal.$obj \
	$(INDIR)wout.$obj \
	$(INDIR)wtimer.$obj \
	$(INDIR)wurgent.$obj \
	$(INDIR)wsig.$obj \
	$(INDIR)whector.$obj \
	$(INDIR)wcecil.$obj \
	$(INDIR)wfile.$obj \
	$(INDIR)wdir.$obj \
	$(INDIR)wmisc.$obj \
	$(INDIR)werror.$obj \
	$(INDIR)wumain.$obj \
	$(INDIR)wmemory.$obj \
	$(INDIR)wmemory_analyzer.$obj \
	$(INDIR)wargv.$obj \
	$(INDIR)wboolstr.$obj \
	$(INDIR)wsearch.$obj \
	$(INDIR)debug.$obj \
	$(INDIR)interp.$obj \
	$(INDIR)woption.$obj \
	$(INDIR)update.$obj \
	$(INDIR)wbench.$obj \
	$(INDIR)wconsole.$obj \
	$(TOP)$(DIR)idrs$(DIR)idrs.$obj \
	$(INDIR)wrun_idr.$obj \
	$(INDIR)wpath_name.$obj \
	$(INDIR)wobject_id.$obj \
	$(INDIR)compress.$obj \
	$(INDIR)posix_threads.$obj \
	$(INDIR)weif_threads.$obj \
	$(INDIR)weif_project.$obj \
	$(INDIR)wgen_conf.$obj \
	$(INDIR)weif_type_id.$obj \
	$(INDIR)wrout_obj.$obj \
	$(TOP)$(DIR)console$(DIR)wwinconsole.$lib

WOBJECTS = $(WORKBENCH_OBJECTS) \
	$(INDIR)wmain.$obj \
	$(NETWORK)

MT_FINAL_OBJECTS = \
	$(INDIR)MTlmalloc.$obj \
	$(INDIR)MTmalloc.$obj \
	$(INDIR)offset.$obj \
	$(INDIR)MTgarcol.$obj \
	$(INDIR)MTlocal.$obj \
	$(INDIR)MTexcept.$obj \
	$(INDIR)MTstore.$obj \
	$(INDIR)MTretrieve.$obj \
	$(INDIR)MThash.$obj \
	$(INDIR)MTtraverse.$obj \
	$(INDIR)MThashin.$obj \
	$(INDIR)MTtools.$obj \
	$(INDIR)MTinternal.$obj \
	$(INDIR)MTplug.$obj \
	$(INDIR)MTcopy.$obj \
	$(INDIR)MTequal.$obj \
	$(INDIR)MTout.$obj \
	$(INDIR)MTtimer.$obj \
	$(INDIR)MTurgent.$obj \
	$(INDIR)MTsig.$obj \
	$(INDIR)MThector.$obj \
	$(INDIR)MTcecil.$obj \
	$(INDIR)MTfile.$obj \
	$(INDIR)MTdir.$obj \
	$(INDIR)MTmisc.$obj \
	$(INDIR)MTerror.$obj \
	$(INDIR)MTumain.$obj \
	$(INDIR)MTmemory.$obj \
	$(INDIR)MTmemory_analyzer.$obj \
	$(INDIR)MTargv.$obj \
	$(INDIR)MTboolstr.$obj \
	$(INDIR)MTsearch.$obj \
	$(INDIR)MToption.$obj \
	$(INDIR)MTconsole.$obj \
	$(TOP)$(DIR)idrs$(DIR)mtidrs.$obj \
	$(INDIR)MTrun_idr.$obj \
	$(INDIR)MTpath_name.$obj \
	$(INDIR)MTobject_id.$obj \
	$(INDIR)MTcompress.$obj \
	$(INDIR)MTposix_threads.$obj \
	$(INDIR)MTeif_threads.$obj \
	$(INDIR)MTeif_project.$obj \
	$(INDIR)MTgen_conf.$obj \
	$(INDIR)MTeif_type_id.$obj \
	$(INDIR)MTrout_obj.$obj \
	$(INDIR)MTscoop.$obj \
	$(INDIR)MTscoop_gc.$obj \
	$(INDIR)MTeif_utils.$obj \
	$(INDIR)MTeveqs.$obj \
	$(INDIR)MTprocessor_registry.$obj \
	$(INDIR)MTnotify_token.$obj \
	$(INDIR)MTprivate_queue.$obj \
	$(INDIR)MTprocessor.$obj \
	$(INDIR)MTqueue_cache.$obj \
	$(INDIR)MTreq_grp.$obj \
	$(TOP)$(DIR)ipc$(DIR)shared$(DIR)MTshword.$obj \
	$(TOP)$(DIR)console$(DIR)mtwinconsole.$lib

MT_OBJECTS = $(MT_FINAL_OBJECTS) \
	$(INDIR)MTmain.$obj

MT_WORKBENCH_OBJECTS = \
	$(INDIR)MTwlmalloc.$obj \
	$(INDIR)MTwmalloc.$obj \
	$(INDIR)offset.$obj \
	$(INDIR)MTwgarcol.$obj \
	$(INDIR)MTwlocal.$obj \
	$(INDIR)MTwexcept.$obj \
	$(INDIR)MTwstore.$obj \
	$(INDIR)MTwretrieve.$obj \
	$(INDIR)MTwhash.$obj \
	$(INDIR)MTwtraverse.$obj \
	$(INDIR)MTwhashin.$obj \
	$(INDIR)MTwtools.$obj \
	$(INDIR)MTwinternal.$obj \
	$(INDIR)MTwplug.$obj \
	$(INDIR)MTwcopy.$obj \
	$(INDIR)MTwequal.$obj \
	$(INDIR)MTwout.$obj \
	$(INDIR)MTwtimer.$obj \
	$(INDIR)MTwurgent.$obj \
	$(INDIR)MTwsig.$obj \
	$(INDIR)MTwhector.$obj \
	$(INDIR)MTwcecil.$obj \
	$(INDIR)MTwfile.$obj \
	$(INDIR)MTwdir.$obj \
	$(INDIR)MTwmisc.$obj \
	$(INDIR)MTwerror.$obj \
	$(INDIR)MTwumain.$obj \
	$(INDIR)MTwmemory.$obj \
	$(INDIR)MTwmemory_analyzer.$obj \
	$(INDIR)MTwargv.$obj \
	$(INDIR)MTwboolstr.$obj \
	$(INDIR)MTwsearch.$obj \
	$(INDIR)MTdebug.$obj \
	$(INDIR)MTinterp.$obj \
	$(INDIR)MTwoption.$obj \
	$(INDIR)MTupdate.$obj \
	$(INDIR)MTwbench.$obj \
	$(INDIR)MTwconsole.$obj \
	$(TOP)$(DIR)idrs$(DIR)mtidrs.$obj \
	$(INDIR)MTwrun_idr.$obj \
	$(INDIR)MTwpath_name.$obj \
	$(INDIR)MTwobject_id.$obj \
	$(INDIR)MTcompress.$obj \
	$(INDIR)MTposix_threads.$obj \
	$(INDIR)MTweif_threads.$obj \
	$(INDIR)MTweif_project.$obj \
	$(INDIR)MTwgen_conf.$obj \
	$(INDIR)MTweif_type_id.$obj \
	$(INDIR)MTwrout_obj.$obj \
	$(INDIR)MTwscoop.$obj \
	$(INDIR)MTwscoop_gc.$obj \
	$(INDIR)MTweif_utils.$obj \
	$(INDIR)MTweveqs.$obj \
	$(INDIR)MTwprocessor_registry.$obj \
	$(INDIR)MTwnotify_token.$obj \
	$(INDIR)MTwprivate_queue.$obj \
	$(INDIR)MTwprocessor.$obj \
	$(INDIR)MTwqueue_cache.$obj \
	$(INDIR)MTwreq_grp.$obj \
	$(TOP)$(DIR)console$(DIR)mtwwinconsole.$lib

MT_WOBJECTS = $(MT_WORKBENCH_OBJECTS) \
	$(INDIR)MTwmain.$obj \
	$(MT_NETWORK)

all:: eif_size.h
all:: $output_libraries

standard:: $(OUTDIR)finalized.$lib $(OUTDIR)wkbench.$lib
mtstandard:: $(OUTDIR)mtfinalized.$lib $(OUTDIR)mtwkbench.$lib

$(OUTDIR)finalized.$lib: $(OBJECTS)
	$alib_line

$(OUTDIR)wkbench.$lib: $(WOBJECTS)
	$alib_line

$(OUTDIR)mtfinalized.$lib: $(MT_OBJECTS)
	$alib_line

$(OUTDIR)mtwkbench.$lib: $(MT_WOBJECTS)
	$alib_line

dll:: $(OUTDIR)wkbench.dll $(OUTDIR)finalized.dll
mtdll:: $(OUTDIR)mtwkbench.dll $(OUTDIR)mtfinalized.dll

$(OUTDIR)mtwkbench.dll : $(MT_WOBJECTS)
	$(LINK32) $(DLL_FLAGS) -IMPLIB:$(OUTDIR)dll_mtwkbench.lib $(MT_WOBJECTS) $(DLL_LIBS)

$(OUTDIR)mtfinalized.dll : $(MT_OBJECTS)
	$(LINK32) $(DLL_FLAGS) -IMPLIB:$(OUTDIR)dll_mtfinalized.lib $(MT_OBJECTS) $(DLL_LIBS)

$(OUTDIR)wkbench.dll : $(WOBJECTS)
	$(LINK32) $(DLL_FLAGS) -IMPLIB:$(OUTDIR)dll_wkbench.lib $(WOBJECTS)  $(DLL_LIBS)

$(OUTDIR)finalized.dll : $(OBJECTS)
	$(LINK32) $(DLL_FLAGS) -IMPLIB:$(OUTDIR)dll_finalized.lib $(OBJECTS) $(DLL_LIBS)

..$(DIR)console$(DIR)winconsole.$lib: ..$(DIR)console$(DIR)econsole.c ..$(DIR)console$(DIR)argcargv.c
	cd ..$(DIR)console
	$(MAKE)
	cd ..$(DIR)run-time

..$(DIR)console$(DIR)mtwinconsole.$lib: ..$(DIR)console$(DIR)econsole.c ..$(DIR)console$(DIR)argcargv.c
	cd ..$(DIR)console
	$(MAKE)
	cd ..$(DIR)run-time

..$(DIR)console$(DIR)wwinconsole.$lib: ..$(DIR)console$(DIR)econsole.c ..$(DIR)console$(DIR)argcargv.c
	cd ..$(DIR)console
	$(MAKE)
	cd ..$(DIR)run-time

..$(DIR)console$(DIR)mtwwinconsole.$lib: ..$(DIR)console$(DIR)econsole.c ..$(DIR)console$(DIR)argcargv.c
	cd ..$(DIR)console
	$(MAKE)
	cd ..$(DIR)run-time

..$(DIR)idrs$(DIR)idrs.$obj:
	cd ..$(DIR)idrs
	$(MAKE)
	cd ..$(DIR)run-time

..$(DIR)idrs$(DIR)mtidrs.$obj:
	cd ..$(DIR)idrs
	$(MAKE)
	cd ..$(DIR)run-time

..$(DIR)ipc$(DIR)app$(DIR)network.$lib: ..$(DIR)ipc$(DIR)app$(DIR)app_proto.c
	cd ..$(DIR)ipc$(DIR)app
	$(MAKE)
	cd ..$(DIR)run-time

..$(DIR)ipc$(DIR)app$(DIR)mtnetwork.$lib: ..$(DIR)ipc$(DIR)app$(DIR)app_proto.c
	cd ..$(DIR)ipc$(DIR)app
	$(MAKE)
	cd ..$(DIR)run-time


all:: x2c.exe runtime_validation.exe

x2c.exe: x2c.c offset.$obj eif_size.h
	$(CC) $ccflags $optimize  -I. -I./include -I$(TOP) -I$(TOP)/idrs $(OUTPUT_EXE_CMD)$@ x2c.c offset.$obj

runtime_validation.exe: runtime_validation.c offset.$obj
	$(CC) $ccflags $optimize  -I. -I./include -I$(TOP) -I$(TOP)/idrs $(OUTPUT_EXE_CMD)$@ runtime_validation.c offset.$obj


$all_dependency

###################
# OBJECTS
###################

$(INDIR)argv.$obj: $(RTSRC)argv.c
	$(CC) $(JCFLAGS) $(RTSRC)argv.c

$(INDIR)boolstr.$obj: $(RTSRC)boolstr.c
	$(CC) $(JCFLAGS) $(RTSRC)boolstr.c

$(INDIR)cecil.$obj: $(RTSRC)cecil.c
	$(CC) $(JCFLAGS) $(RTSRC)cecil.c

$(INDIR)compress.$obj: $(RTSRC)compress.c
	$(CC) $(JCFLAGS) $(RTSRC)compress.c

$(INDIR)console.$obj: $(RTSRC)console.c
	$(CC) $(JCFLAGS) $(RTSRC)console.c

$(INDIR)copy.$obj: $(RTSRC)copy.c
	$(CC) $(JCFLAGS) $(RTSRC)copy.c

$(INDIR)dir.$obj: $(RTSRC)dir.c
	$(CC) $(JCFLAGS) $(RTSRC)dir.c

$(INDIR)eif_project.$obj: $(RTSRC)eif_project.c
	$(CC) $(JCFLAGS) $(RTSRC)eif_project.c

$(INDIR)posix_threads.$obj: $(RTSRC)posix_threads.c
	$(CC) $(JCFLAGS) $(RTSRC)posix_threads.c

$(INDIR)eif_threads.$obj: $(RTSRC)eif_threads.c
	$(CC) $(JCFLAGS) $(RTSRC)eif_threads.c

$(INDIR)equal.$obj: $(RTSRC)equal.c
	$(CC) $(JCFLAGS) $(RTSRC)equal.c

$(INDIR)error.$obj: $(RTSRC)error.c
	$(CC) $(JCFLAGS) $(RTSRC)error.c

$(INDIR)except.$obj: $(RTSRC)except.c
	$(CC) $(JCFLAGS) $(RTSRC)except.c

$(INDIR)file.$obj: $(RTSRC)file.c
	$(CC) $(JCFLAGS) $(RTSRC)file.c

$(INDIR)garcol.$obj: $(RTSRC)garcol.c
	$(CC) $(JCFLAGS) $(RTSRC)garcol.c

$(INDIR)gen_conf.$obj: $(RTSRC)gen_conf.c
	$(CC) $(JCFLAGS) $(RTSRC)gen_conf.c

$(INDIR)eif_type_id.$obj: $(RTSRC)eif_type_id.c
	$(CC) $(JCFLAGS) $(RTSRC)eif_type_id.c

$(INDIR)rout_obj.$obj: $(RTSRC)rout_obj.c
	$(CC) $(JCFLAGS) $(RTSRC)rout_obj.c

$(INDIR)hash.$obj: $(RTSRC)hash.c
	$(CC) $(JCFLAGS) $(RTSRC)hash.c

$(INDIR)hashin.$obj: $(RTSRC)hashin.c
	$(CC) $(JCFLAGS) $(RTSRC)hashin.c

$(INDIR)hector.$obj: $(RTSRC)hector.c
	$(CC) $(JCFLAGS) $(RTSRC)hector.c

$(INDIR)internal.$obj: $(RTSRC)internal.c
	$(CC) $(JCFLAGS) $(RTSRC)internal.c

$(INDIR)lmalloc.$obj: $(RTSRC)lmalloc.c
	$(CC) $(JCFLAGS) $(RTSRC)lmalloc.c

$(INDIR)local.$obj: $(RTSRC)local.c
	$(CC) $(JCFLAGS) $(RTSRC)local.c

$(INDIR)main.$obj: $(RTSRC)main.c
	$(CC) $(JCFLAGS) $(RTSRC)main.c

$(INDIR)malloc.$obj: $(RTSRC)malloc.c
	$(CC) $(JCFLAGS) $(RTSRC)malloc.c

$(INDIR)memory.$obj: $(RTSRC)memory.c
	$(CC) $(JCFLAGS) $(RTSRC)memory.c

$(INDIR)memory_analyzer.$obj: $(RTSRC)memory_analyzer.c
	$(CC) $(JCFLAGS) $(RTSRC)memory_analyzer.c

$(INDIR)misc.$obj: $(RTSRC)misc.c
	$(CC) $(JCFLAGS) $(RTSRC)misc.c

$(INDIR)object_id.$obj: $(RTSRC)object_id.c
	$(CC) $(JCFLAGS) $(RTSRC)object_id.c

$(INDIR)offset.$obj: $(RTSRC)offset.c
	$(CC) $(JCFLAGS) $(RTSRC)offset.c

$(INDIR)option.$obj: $(RTSRC)option.c
	$(CC) $(JCFLAGS) $(RTSRC)option.c

$(INDIR)out.$obj: $(RTSRC)out.c
	$(CC) $(JCFLAGS) $(RTSRC)out.c

$(INDIR)path_name.$obj: $(RTSRC)path_name.c
	$(CC) $(JCFLAGS) $(RTSRC)path_name.c

$(INDIR)plug.$obj: $(RTSRC)plug.c
	$(CC) $(JCFLAGS) $(RTSRC)plug.c

$(INDIR)retrieve.$obj: $(RTSRC)retrieve.c
	$(CC) $(JCFLAGS) $(RTSRC)retrieve.c

$(INDIR)run_idr.$obj: $(RTSRC)run_idr.c
	$(CC) $(JCFLAGS) $(RTSRC)run_idr.c

$(INDIR)search.$obj: $(RTSRC)search.c
	$(CC) $(JCFLAGS) $(RTSRC)search.c

$(INDIR)sig.$obj: $(RTSRC)sig.c
	$(CC) $(JCFLAGS) $(RTSRC)sig.c

$(INDIR)store.$obj: $(RTSRC)store.c
	$(CC) $(JCFLAGS) $(RTSRC)store.c

$(INDIR)timer.$obj: $(RTSRC)timer.c
	$(CC) $(JCFLAGS) $(RTSRC)timer.c

$(INDIR)tools.$obj: $(RTSRC)tools.c
	$(CC) $(JCFLAGS) $(RTSRC)tools.c

$(INDIR)traverse.$obj: $(RTSRC)traverse.c
	$(CC) $(JCFLAGS) $(RTSRC)traverse.c

$(INDIR)umain.$obj: $(RTSRC)umain.c
	$(CC) $(JCFLAGS) $(RTSRC)umain.c

$(INDIR)urgent.$obj: $(RTSRC)urgent.c
	$(CC) $(JCFLAGS) $(RTSRC)urgent.c

$(INDIR)update.$obj: $(RTSRC)update.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)update.c

$(INDIR)debug.$obj: $(RTSRC)debug.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)debug.c

$(INDIR)interp.$obj: $(RTSRC)interp.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)interp.c

$(INDIR)wargv.$obj: $(RTSRC)argv.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)argv.c

$(INDIR)wbench.$obj: $(RTSRC)wbench.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)wbench.c

$(INDIR)wboolstr.$obj: $(RTSRC)boolstr.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)boolstr.c

$(INDIR)wcecil.$obj: $(RTSRC)cecil.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)cecil.c

$(INDIR)wconsole.$obj: $(RTSRC)console.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)console.c

$(INDIR)wcopy.$obj: $(RTSRC)copy.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)copy.c

$(INDIR)wdir.$obj: $(RTSRC)dir.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)dir.c

$(INDIR)weif_project.$obj: $(RTSRC)eif_project.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)eif_project.c

$(INDIR)weif_threads.$obj: $(RTSRC)eif_threads.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)eif_threads.c

$(INDIR)wequal.$obj: $(RTSRC)equal.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)equal.c

$(INDIR)werror.$obj: $(RTSRC)error.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)error.c

$(INDIR)wexcept.$obj: $(RTSRC)except.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)except.c

$(INDIR)wfile.$obj: $(RTSRC)file.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)file.c

$(INDIR)wgarcol.$obj: $(RTSRC)garcol.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)garcol.c

$(INDIR)wgen_conf.$obj: $(RTSRC)gen_conf.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)gen_conf.c

$(INDIR)weif_type_id.$obj: $(RTSRC)eif_type_id.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)eif_type_id.c

$(INDIR)wrout_obj.$obj: $(RTSRC)rout_obj.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)rout_obj.c

$(INDIR)whash.$obj: $(RTSRC)hash.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)hash.c

$(INDIR)whashin.$obj: $(RTSRC)hashin.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)hashin.c

$(INDIR)whector.$obj: $(RTSRC)hector.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)hector.c

$(INDIR)winternal.$obj: $(RTSRC)internal.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)internal.c

$(INDIR)wlmalloc.$obj: $(RTSRC)lmalloc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)lmalloc.c

$(INDIR)wlocal.$obj: $(RTSRC)local.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)local.c

$(INDIR)wmain.$obj: $(RTSRC)main.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)main.c

$(INDIR)wmalloc.$obj: $(RTSRC)malloc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)malloc.c

$(INDIR)wmemory.$obj: $(RTSRC)memory.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)memory.c

$(INDIR)wmemory_analyzer.$obj: $(RTSRC)memory_analyzer.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)memory_analyzer.c

$(INDIR)wmisc.$obj: $(RTSRC)misc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)misc.c

$(INDIR)wobject_id.$obj: $(RTSRC)object_id.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)object_id.c

$(INDIR)woption.$obj: $(RTSRC)option.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)option.c

$(INDIR)wout.$obj: $(RTSRC)out.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)out.c

$(INDIR)wpath_name.$obj: $(RTSRC)path_name.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)path_name.c

$(INDIR)wplug.$obj: $(RTSRC)plug.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)plug.c

$(INDIR)wretrieve.$obj: $(RTSRC)retrieve.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)retrieve.c

$(INDIR)wrun_idr.$obj: $(RTSRC)run_idr.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)run_idr.c

$(INDIR)wsearch.$obj: $(RTSRC)search.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)search.c

$(INDIR)wsig.$obj: $(RTSRC)sig.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)sig.c

$(INDIR)wstore.$obj: $(RTSRC)store.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)store.c

$(INDIR)wtimer.$obj: $(RTSRC)timer.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)timer.c

$(INDIR)wtools.$obj: $(RTSRC)tools.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)tools.c

$(INDIR)wtraverse.$obj: $(RTSRC)traverse.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)traverse.c

$(INDIR)wumain.$obj: $(RTSRC)umain.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)umain.c

$(INDIR)wurgent.$obj: $(RTSRC)urgent.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)urgent.c
	
final: finalized.$lib
work: wkbench.$lib

###################
# MT_OBJECTS
###################

$(INDIR)MTmain.$obj: $(RTSRC)main.c
	$(CC) $(JMTCFLAGS) $(RTSRC)main.c

$(INDIR)MTargv.$obj: $(RTSRC)argv.c
	$(CC) $(JMTCFLAGS) $(RTSRC)argv.c

$(INDIR)MTboolstr.$obj: $(RTSRC)boolstr.c
	$(CC) $(JMTCFLAGS) $(RTSRC)boolstr.c

$(INDIR)MTcecil.$obj: $(RTSRC)cecil.c
	$(CC) $(JMTCFLAGS) $(RTSRC)cecil.c

$(INDIR)MTcompress.$obj: $(RTSRC)compress.c
	$(CC) $(JMTCFLAGS) $(RTSRC)compress.c

$(INDIR)MTconsole.$obj: $(RTSRC)console.c
	$(CC) $(JMTCFLAGS) $(RTSRC)console.c

$(INDIR)MTcopy.$obj: $(RTSRC)copy.c
	$(CC) $(JMTCFLAGS) $(RTSRC)copy.c

$(INDIR)MTdir.$obj: $(RTSRC)dir.c
	$(CC) $(JMTCFLAGS) $(RTSRC)dir.c

$(INDIR)MTeif_project.$obj: $(RTSRC)eif_project.c
	$(CC) $(JMTCFLAGS) $(RTSRC)eif_project.c

$(INDIR)MTposix_threads.$obj: $(RTSRC)posix_threads.c
	$(CC) $(JMTCFLAGS) $(RTSRC)posix_threads.c

$(INDIR)MTeif_threads.$obj: $(RTSRC)eif_threads.c
	$(CC) $(JMTCFLAGS) $(RTSRC)eif_threads.c

$(INDIR)MTequal.$obj: $(RTSRC)equal.c
	$(CC) $(JMTCFLAGS) $(RTSRC)equal.c

$(INDIR)MTerror.$obj: $(RTSRC)error.c
	$(CC) $(JMTCFLAGS) $(RTSRC)error.c

$(INDIR)MTexcept.$obj: $(RTSRC)except.c
	$(CC) $(JMTCFLAGS) $(RTSRC)except.c

$(INDIR)MTfile.$obj: $(RTSRC)file.c
	$(CC) $(JMTCFLAGS) $(RTSRC)file.c

$(INDIR)MTgarcol.$obj: $(RTSRC)garcol.c
	$(CC) $(JMTCFLAGS) $(RTSRC)garcol.c

$(INDIR)MTgen_conf.$obj: $(RTSRC)gen_conf.c
	$(CC) $(JMTCFLAGS) $(RTSRC)gen_conf.c

$(INDIR)MTeif_type_id.$obj: $(RTSRC)eif_type_id.c
	$(CC) $(JMTCFLAGS) $(RTSRC)eif_type_id.c

$(INDIR)MTrout_obj.$obj: $(RTSRC)rout_obj.c
	$(CC) $(JMTCFLAGS) $(RTSRC)rout_obj.c

$(INDIR)MTscoop.$obj: $(RTSRC)scoop.c
	$(CC) $(JMTCFLAGS) $(RTSRC)scoop.c

$(INDIR)MTscoop_gc.$obj: $(RTSRC)scoop_gc.c
	$(CC) $(JMTCFLAGS) $(RTSRC)scoop_gc.c

$(INDIR)MTeif_utils.$obj: $(RTSRC)eif_utils.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)eif_utils.cpp

$(INDIR)MTeveqs.$obj: $(RTSRC)eveqs.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)eveqs.cpp

$(INDIR)MTprocessor_registry.$obj: $(RTSRC)processor_registry.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)processor_registry.cpp

$(INDIR)MTnotify_token.$obj: $(RTSRC)notify_token.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)notify_token.cpp

$(INDIR)MTprivate_queue.$obj: $(RTSRC)private_queue.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)private_queue.cpp

$(INDIR)MTprocessor.$obj: $(RTSRC)processor.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)processor.cpp

$(INDIR)MTqueue_cache.$obj: $(RTSRC)queue_cache.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)queue_cache.cpp

$(INDIR)MTreq_grp.$obj: $(RTSRC)req_grp.cpp
	$(CPP) $(JMTCPPFLAGS) $(RTSRC)req_grp.cpp

$(INDIR)MThash.$obj: $(RTSRC)hash.c
	$(CC) $(JMTCFLAGS) $(RTSRC)hash.c

$(INDIR)MThashin.$obj: $(RTSRC)hashin.c
	$(CC) $(JMTCFLAGS) $(RTSRC)hashin.c

$(INDIR)MThector.$obj: $(RTSRC)hector.c
	$(CC) $(JMTCFLAGS) $(RTSRC)hector.c

$(INDIR)MTinternal.$obj: $(RTSRC)internal.c
	$(CC) $(JMTCFLAGS) $(RTSRC)internal.c

$(INDIR)MTlmalloc.$obj: $(RTSRC)lmalloc.c
	$(CC) $(JMTCFLAGS) $(RTSRC)lmalloc.c

$(INDIR)MTlocal.$obj: $(RTSRC)local.c
	$(CC) $(JMTCFLAGS) $(RTSRC)local.c

$(INDIR)MTmalloc.$obj: $(RTSRC)malloc.c
	$(CC) $(JMTCFLAGS) $(RTSRC)malloc.c

$(INDIR)MTmemory.$obj: $(RTSRC)memory.c
	$(CC) $(JMTCFLAGS) $(RTSRC)memory.c

$(INDIR)MTmemory_analyzer.$obj: $(RTSRC)memory_analyzer.c
	$(CC) $(JMTCFLAGS) $(RTSRC)memory_analyzer.c

$(INDIR)MTmisc.$obj: $(RTSRC)misc.c
	$(CC) $(JMTCFLAGS) $(RTSRC)misc.c

$(INDIR)MTobject_id.$obj: $(RTSRC)object_id.c
	$(CC) $(JMTCFLAGS) $(RTSRC)object_id.c

$(INDIR)MToption.$obj: $(RTSRC)option.c
	$(CC) $(JMTCFLAGS) $(RTSRC)option.c

$(INDIR)MTout.$obj: $(RTSRC)out.c
	$(CC) $(JMTCFLAGS) $(RTSRC)out.c

$(INDIR)MTpath_name.$obj: $(RTSRC)path_name.c
	$(CC) $(JMTCFLAGS) $(RTSRC)path_name.c

$(INDIR)MTplug.$obj: $(RTSRC)plug.c
	$(CC) $(JMTCFLAGS) $(RTSRC)plug.c

$(INDIR)MTretrieve.$obj: $(RTSRC)retrieve.c
	$(CC) $(JMTCFLAGS) $(RTSRC)retrieve.c

$(INDIR)MTrun_idr.$obj: $(RTSRC)run_idr.c
	$(CC) $(JMTCFLAGS) $(RTSRC)run_idr.c

$(INDIR)MTsearch.$obj: $(RTSRC)search.c
	$(CC) $(JMTCFLAGS) $(RTSRC)search.c

$(INDIR)MTsig.$obj: $(RTSRC)sig.c
	$(CC) $(JMTCFLAGS) $(RTSRC)sig.c

$(INDIR)MTstore.$obj: $(RTSRC)store.c
	$(CC) $(JMTCFLAGS) $(RTSRC)store.c

$(INDIR)MTtimer.$obj: $(RTSRC)timer.c
	$(CC) $(JMTCFLAGS) $(RTSRC)timer.c

$(INDIR)MTtools.$obj: $(RTSRC)tools.c
	$(CC) $(JMTCFLAGS) $(RTSRC)tools.c

$(INDIR)MTtraverse.$obj: $(RTSRC)traverse.c
	$(CC) $(JMTCFLAGS) $(RTSRC)traverse.c

$(INDIR)MTumain.$obj: $(RTSRC)umain.c
	$(CC) $(JMTCFLAGS) $(RTSRC)umain.c

$(INDIR)MTurgent.$obj: $(RTSRC)urgent.c
	$(CC) $(JMTCFLAGS) $(RTSRC)urgent.c

$(INDIR)MTupdate.$obj: $(RTSRC)update.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)update.c

$(INDIR)MTdebug.$obj: $(RTSRC)debug.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)debug.c

$(INDIR)MTinterp.$obj: $(RTSRC)interp.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)interp.c

$(INDIR)MTwargv.$obj: $(RTSRC)argv.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)argv.c

$(INDIR)MTwbench.$obj: $(RTSRC)wbench.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)wbench.c

$(INDIR)MTwboolstr.$obj: $(RTSRC)boolstr.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)boolstr.c

$(INDIR)MTwcecil.$obj: $(RTSRC)cecil.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)cecil.c

$(INDIR)MTwconsole.$obj: $(RTSRC)console.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)console.c

$(INDIR)MTwcopy.$obj: $(RTSRC)copy.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)copy.c

$(INDIR)MTwdir.$obj: $(RTSRC)dir.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)dir.c

$(INDIR)MTweif_project.$obj: $(RTSRC)eif_project.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)eif_project.c

$(INDIR)MTweif_threads.$obj: $(RTSRC)eif_threads.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)eif_threads.c

$(INDIR)MTwequal.$obj: $(RTSRC)equal.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)equal.c

$(INDIR)MTwerror.$obj: $(RTSRC)error.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)error.c

$(INDIR)MTwexcept.$obj: $(RTSRC)except.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)except.c

$(INDIR)MTwfile.$obj: $(RTSRC)file.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)file.c

$(INDIR)MTwgarcol.$obj: $(RTSRC)garcol.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)garcol.c

$(INDIR)MTwgen_conf.$obj: $(RTSRC)gen_conf.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)gen_conf.c

$(INDIR)MTweif_type_id.$obj: $(RTSRC)eif_type_id.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)eif_type_id.c

$(INDIR)MTwrout_obj.$obj: $(RTSRC)rout_obj.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)rout_obj.c

$(INDIR)MTwscoop.$obj: $(RTSRC)scoop.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)scoop.c

$(INDIR)MTwscoop_gc.$obj: $(RTSRC)scoop_gc.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)scoop_gc.c

$(INDIR)MTweif_utils.$obj: $(RTSRC)eif_utils.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)eif_utils.cpp

$(INDIR)MTweveqs.$obj: $(RTSRC)eveqs.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)eveqs.cpp

$(INDIR)MTwprocessor_registry.$obj: $(RTSRC)processor_registry.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)processor_registry.cpp

$(INDIR)MTwnotify_token.$obj: $(RTSRC)notify_token.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)notify_token.cpp

$(INDIR)MTwprivate_queue.$obj: $(RTSRC)private_queue.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)private_queue.cpp

$(INDIR)MTwprocessor.$obj: $(RTSRC)processor.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)processor.cpp

$(INDIR)MTwqueue_cache.$obj: $(RTSRC)queue_cache.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)queue_cache.cpp

$(INDIR)MTwreq_grp.$obj: $(RTSRC)req_grp.cpp
	$(CPP) $(JMTCPPFLAGS) -DWORKBENCH $(RTSRC)req_grp.cpp

$(INDIR)MTwhash.$obj: $(RTSRC)hash.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)hash.c

$(INDIR)MTwhashin.$obj: $(RTSRC)hashin.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)hashin.c

$(INDIR)MTwhector.$obj: $(RTSRC)hector.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)hector.c

$(INDIR)MTwinternal.$obj: $(RTSRC)internal.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)internal.c

$(INDIR)MTwlmalloc.$obj: $(RTSRC)lmalloc.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)lmalloc.c

$(INDIR)MTwlocal.$obj: $(RTSRC)local.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)local.c

$(INDIR)MTwmain.$obj: $(RTSRC)main.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)main.c

$(INDIR)MTwmalloc.$obj: $(RTSRC)malloc.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)malloc.c

$(INDIR)MTwmemory.$obj: $(RTSRC)memory.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)memory.c

$(INDIR)MTwmemory_analyzer.$obj: $(RTSRC)memory_analyzer.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)memory_analyzer.c

$(INDIR)MTwmisc.$obj: $(RTSRC)misc.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)misc.c

$(INDIR)MTwobject_id.$obj: $(RTSRC)object_id.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)object_id.c

$(INDIR)MTwoption.$obj: $(RTSRC)option.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)option.c

$(INDIR)MTwout.$obj: $(RTSRC)out.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)out.c

$(INDIR)MTwpath_name.$obj: $(RTSRC)path_name.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)path_name.c

$(INDIR)MTwplug.$obj: $(RTSRC)plug.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)plug.c

$(INDIR)MTwretrieve.$obj: $(RTSRC)retrieve.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)retrieve.c

$(INDIR)MTwrun_idr.$obj: $(RTSRC)run_idr.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)run_idr.c

$(INDIR)MTwsearch.$obj: $(RTSRC)search.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)search.c

$(INDIR)MTwsig.$obj: $(RTSRC)sig.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)sig.c

$(INDIR)MTwstore.$obj: $(RTSRC)store.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)store.c

$(INDIR)MTwtimer.$obj: $(RTSRC)timer.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)timer.c

$(INDIR)MTwtools.$obj: $(RTSRC)tools.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)tools.c

$(INDIR)MTwtraverse.$obj: $(RTSRC)traverse.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)traverse.c

$(INDIR)MTwumain.$obj: $(RTSRC)umain.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)umain.c

$(INDIR)MTwurgent.$obj: $(RTSRC)urgent.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)urgent.c
	
TESTS = mram gram lram eram sram

test : $(TESTS)
	mram >test 2>&1
	gram >>test 2>&1
	lram >>test 2>&1
	eram >>test 2>&1
	sram >>test 2>&1

mram.exe: malloc.c
	wcl386 $(JCFLAGS) -DTEST  -oleantimr -5r malloc.c

gram.exe: garcol.c
	wcl386 $(JCFLAGS) -DTEST -d+ -oleantimr -5r garcol.c

lram: local.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ local.c

eram: except.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ except.c

sram: sig.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ sig.c

$(INDIR)malloc.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

$(INDIR)garcol.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h include$(DIR)rt_search.h eif_sig.h \
			eif_size.h eif_struct.h include$(DIR)rt_timer.h include$(DIR)rt_urgent.h

$(INDIR)local.$obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_local.h eif_malloc.h \
			eif_plug.h eif_sig.h eif_struct.h include$(DIR)rt_urgent.h

$(INDIR)except.$obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_sig.h eif_size.h eif_struct.h include$(DIR)rt_urgent.h

$(INDIR)store.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h eif_traverse.h

$(INDIR)retrieve.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h include$(DIR)rt_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_retrieve.h eif_size.h eif_struct.h

$(INDIR)hash.$obj : include/rt_hash.h include/rt_tools.h

$(INDIR)traverse.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h include$(DIR)rt_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h \
			eif_traverse.h

$(INDIR)hashin.$obj : include$(DIR)rt_hashin.h eif_malloc.h include/rt_tools.h

$(INDIR)tools.$obj : include/rt_tools.h

$(INDIR)internal.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h

$(INDIR)plug.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			include$(DIR)rt_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h eif_option.h \
			eif_out.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)copy.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			include/rt_hash.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h eif_traverse.h

$(INDIR)equal.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_equal.h eif_except.h eif_file.h \
			eif_garcol.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			include$(DIR)rt_search.h eif_size.h eif_struct.h include/rt_tools.h eif_traverse.h

$(INDIR)lmalloc.$obj : eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

$(INDIR)out.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			include$(DIR)rt_hashin.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_sig.h eif_size.h eif_struct.h

$(INDIR)timer.$obj : include$(DIR)rt_timer.h

$(INDIR)urgent.$obj : include$(DIR)rt_urgent.h

$(INDIR)sig.$obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h

$(INDIR)hector.$obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

$(INDIR)cecil.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h eif_struct.h \
			include/rt_tools.h

$(INDIR)file.$obj : eif_cecil.h eif_copy.h eif_except.h eif_file.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)dir.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)misc.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_misc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)error.$obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

$(INDIR)memory.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)argv.$obj : eif_malloc.h eif_plug.h

$(INDIR)search.$obj : include$(DIR)rt_search.h include/rt_tools.h

$(INDIR)debug.$obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h include$(DIR)rt_hashin.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

$(INDIR)interp.$obj : eif_cecil.h eif_copy.h eif_debug.h eif_dir.h eif_except.h eif_file.h \
			eif_garcol.h include$(DIR)rt_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h \
			eif_out.h eif_plug.h eif_sig.h eif_size.h eif_struct.h

$(INDIR)option.$obj : eif_option.h eif_struct.h

$(INDIR)update.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h include$(DIR)rt_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h include$(DIR)rt_update.h

$(INDIR)wbench.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h include$(DIR)rt_hashin.h eif_hector.h \
			eif_interp.h eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_wbench.h

$(INDIR)main.$obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h include$(DIR)rt_urgent.h

$(INDIR)wmain.$obj : eif_except.h eif_garcol.h main.c eif_malloc.h eif_plug.h eif_sig.h eif_struct.h \
			include$(DIR)rt_urgent.h

$(INDIR)object_id.$obj : eif_garcol.h eif_except.h eif_hector.h

$(INDIR)gen_conf.$obj : eif_gen_conf.h eif_struct.h
$(INDIR)wgen_conf.$obj : eif_gen_conf.h eif_struct.h

$(INDIR)eif_type_id.$obj : eif_gen_conf.h eif_struct.h eif_cecil.h
$(INDIR)weif_type_id.$obj : eif_gen_conf.h eif_struct.h eif_cecil.h

$(INDIR)rout_obj.$obj : eif_rout_obj.h
$(INDIR)wrout_obj.$obj : eif_rout_obj.h

$(INDIR)eif_threads.$obj : eif_threads.h eif_posix_threads.h include/rt_threads.h
$(INDIR)MTeif_threads.$obj : eif_threads.h eif_posix_threads.h include/rt_threads.h
$(INDIR)posix_threads.$obj : eif_posix_threads.h

$(INDIR)weif_threads.$obj : eif_threads.h eif_posix_threads.h include/rt_threads.h
$(INDIR)MTweif_threads.$obj : eif_threads.h eif_posix_threads.h include/rt_threads.h
$(INDIR)MTposix_threads.$obj : eif_posix_threads.h
