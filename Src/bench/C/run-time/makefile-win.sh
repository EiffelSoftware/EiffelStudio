TOP = ..
OUTDIR = .\LIB
INDIR = .\OBJDIR
RTSRC = .
CC = $cc
CTAGS = ctags
OUTPUT_CMD = $output_cmd
INPUT_CMD = $input_cmd
JCFLAGS = $(CFLAGS) $ccflags $optimize $(INPUT_CMD) $(OUTPUT_CMD)$@ -c
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize $(INPUT_CMD) $(OUTPUT_CMD)$@ -c
LIB_EXE = $lib_exe
LN = copy
MAKE = $make
MV = move
RM = $del
LINK32 = $link32
DLLFLAGS = $dllflags

CFLAGS = -I. -I$(TOP) -I$(TOP)/idrs -I$(TOP)/console -I$(TOP)/ipc/app
NETWORK = $(TOP)\ipc\app\network.$lib
MT_NETWORK = $(TOP)\ipc\app\mtnetwork.$lib

OBJECTS = \
	$(INDIR)\lmalloc.$obj \
	$(INDIR)\malloc.$obj \
	$(INDIR)\garcol.$obj \
	$(INDIR)\local.$obj \
	$(INDIR)\except.$obj \
	$(INDIR)\store.$obj \
	$(INDIR)\retrieve.$obj \
	$(INDIR)\hash.$obj \
	$(INDIR)\traverse.$obj \
	$(INDIR)\hashin.$obj \
	$(INDIR)\tools.$obj \
	$(INDIR)\internal.$obj \
	$(INDIR)\plug.$obj \
	$(INDIR)\copy.$obj \
	$(INDIR)\equal.$obj \
	$(INDIR)\out.$obj \
	$(INDIR)\timer.$obj \
	$(INDIR)\urgent.$obj \
	$(INDIR)\sig.$obj \
	$(INDIR)\hector.$obj \
	$(INDIR)\cecil.$obj \
	$(INDIR)\bits.$obj \
	$(INDIR)\file.$obj \
	$(INDIR)\dir.$obj \
	$(INDIR)\string.$obj \
	$(INDIR)\misc.$obj \
	$(INDIR)\pattern.$obj \
	$(INDIR)\error.$obj \
	$(INDIR)\umain.$obj \
	$(INDIR)\memory.$obj \
	$(INDIR)\argv.$obj \
	$(INDIR)\boolstr.$obj \
	$(INDIR)\search.$obj \
	$(INDIR)\main.$obj \
	$(INDIR)\option.$obj \
	$(INDIR)\console.$obj \
	$(INDIR)\run_idr.$obj \
	$(INDIR)\path_name.$obj \
	$(INDIR)\object_id.$obj \
	$(INDIR)\compress.$obj \
	$(INDIR)\eif_threads.$obj \
	$(INDIR)\eif_cond_var.$obj \
	$(INDIR)\eif_once.$obj \
	$(INDIR)\eif_rw_lock.$obj \
	$(INDIR)\eif_project.$obj \
	$(INDIR)\gen_conf.$obj \
	$(INDIR)\rout_obj.$obj \
	$(INDIR)\eif_special_table.$obj \
	$(TOP)\ipc\shared\networku.$obj \
	$(TOP)\ipc\shared\shword.$obj \
	$(TOP)\console\winconsole.$lib \

WOBJECTS = \
	$(NETWORK) \
	$(INDIR)\wlmalloc.$obj \
	$(INDIR)\wmalloc.$obj \
	$(INDIR)\wgarcol.$obj \
	$(INDIR)\wlocal.$obj \
	$(INDIR)\wexcept.$obj \
	$(INDIR)\wstore.$obj \
	$(INDIR)\wretrieve.$obj \
	$(INDIR)\whash.$obj \
	$(INDIR)\wtraverse.$obj \
	$(INDIR)\whashin.$obj \
	$(INDIR)\wtools.$obj \
	$(INDIR)\winternal.$obj \
	$(INDIR)\wplug.$obj \
	$(INDIR)\wcopy.$obj \
	$(INDIR)\wequal.$obj \
	$(INDIR)\wout.$obj \
	$(INDIR)\wtimer.$obj \
	$(INDIR)\wurgent.$obj \
	$(INDIR)\wsig.$obj \
	$(INDIR)\whector.$obj \
	$(INDIR)\wcecil.$obj \
	$(INDIR)\wbits.$obj \
	$(INDIR)\wfile.$obj \
	$(INDIR)\wdir.$obj \
	$(INDIR)\wstring.$obj \
	$(INDIR)\wmisc.$obj \
	$(INDIR)\wpattern.$obj \
	$(INDIR)\werror.$obj \
	$(INDIR)\wumain.$obj \
	$(INDIR)\wmemory.$obj \
	$(INDIR)\wargv.$obj \
	$(INDIR)\wboolstr.$obj \
	$(INDIR)\wsearch.$obj \
	$(INDIR)\wmain.$obj \
	$(INDIR)\debug.$obj \
	$(INDIR)\interp.$obj \
	$(INDIR)\woption.$obj \
	$(INDIR)\update.$obj \
	$(INDIR)\wbench.$obj \
	$(INDIR)\wconsole.$obj \
	$(INDIR)\wrun_idr.$obj \
	$(INDIR)\wpath_name.$obj \
	$(INDIR)\wobject_id.$obj \
	$(INDIR)\compress.$obj \
	$(INDIR)\weif_threads.$obj \
	$(INDIR)\weif_cond_var.$obj \
	$(INDIR)\weif_once.$obj \
	$(INDIR)\eif_rw_lock.$obj \
	$(INDIR)\weif_project.$obj \
	$(INDIR)\wgen_conf.$obj \
	$(INDIR)\wrout_obj.$obj \
	$(INDIR)\weif_special_table.$obj \
	$(TOP)\idrs\idr.$lib \
	$(TOP)\console\wwinconsole.$lib \

EOBJECTS = \
	$(INDIR)\wlmalloc.$obj \
	$(INDIR)\wmalloc.$obj \
	$(INDIR)\wgarcol.$obj \
	$(INDIR)\wlocal.$obj \
	$(INDIR)\bexcept.$obj \
	$(INDIR)\wstore.$obj \
	$(INDIR)\wretrieve.$obj \
	$(INDIR)\whash.$obj \
	$(INDIR)\wtraverse.$obj \
	$(INDIR)\whashin.$obj \
	$(INDIR)\wtools.$obj \
	$(INDIR)\winternal.$obj \
	$(INDIR)\wplug.$obj \
	$(INDIR)\wcopy.$obj \
	$(INDIR)\wequal.$obj \
	$(INDIR)\wout.$obj \
	$(INDIR)\wtimer.$obj \
	$(INDIR)\wurgent.$obj \
	$(INDIR)\wsig.$obj \
	$(INDIR)\whector.$obj \
	$(INDIR)\wcecil.$obj \
	$(INDIR)\wbits.$obj \
	$(INDIR)\wfile.$obj \
	$(INDIR)\wdir.$obj \
	$(INDIR)\wstring.$obj \
	$(INDIR)\wmisc.$obj \
	$(INDIR)\wpattern.$obj \
	$(INDIR)\werror.$obj \
	$(INDIR)\wumain.$obj \
	$(INDIR)\wmemory.$obj \
	$(INDIR)\wargv.$obj \
	$(INDIR)\wboolstr.$obj \
	$(INDIR)\wsearch.$obj \
	$(INDIR)\bmain.$obj \
	$(INDIR)\debug.$obj \
	$(INDIR)\interp.$obj \
	$(INDIR)\woption.$obj \
	$(INDIR)\update.$obj \
	$(INDIR)\wbench.$obj \
	$(INDIR)\wconsole.$obj \
	$(INDIR)\wrun_idr.$obj \
	$(INDIR)\wpath_name.$obj \
	$(INDIR)\wobject_id.$obj \
	$(INDIR)\compress.$obj \
	$(INDIR)\weif_threads.$obj \
	$(INDIR)\weif_cond_var.$obj \
	$(INDIR)\weif_once.$obj \
	$(INDIR)\eif_rw_lock.$obj \
	$(INDIR)\weif_project.$obj \
	$(INDIR)\wgen_conf.$obj \
	$(INDIR)\wrout_obj.$obj \
	$(INDIR)\weif_special_table.$obj \
	$(TOP)\ipc\shared\networku.$obj \
	$(TOP)\console\wwinconsole.$lib

MT_OBJECTS = \
	$(INDIR)\MTlmalloc.$obj \
	$(INDIR)\MTmalloc.$obj \
	$(INDIR)\MTgarcol.$obj \
	$(INDIR)\MTlocal.$obj \
	$(INDIR)\MTexcept.$obj \
	$(INDIR)\MTstore.$obj \
	$(INDIR)\MTretrieve.$obj \
	$(INDIR)\MThash.$obj \
	$(INDIR)\MTtraverse.$obj \
	$(INDIR)\MThashin.$obj \
	$(INDIR)\MTtools.$obj \
	$(INDIR)\MTinternal.$obj \
	$(INDIR)\MTplug.$obj \
	$(INDIR)\MTcopy.$obj \
	$(INDIR)\MTequal.$obj \
	$(INDIR)\MTout.$obj \
	$(INDIR)\MTtimer.$obj \
	$(INDIR)\MTurgent.$obj \
	$(INDIR)\MTsig.$obj \
	$(INDIR)\MThector.$obj \
	$(INDIR)\MTcecil.$obj \
	$(INDIR)\MTbits.$obj \
	$(INDIR)\MTfile.$obj \
	$(INDIR)\MTdir.$obj \
	$(INDIR)\MTstring.$obj \
	$(INDIR)\MTmisc.$obj \
	$(INDIR)\MTpattern.$obj \
	$(INDIR)\MTerror.$obj \
	$(INDIR)\MTumain.$obj \
	$(INDIR)\MTmemory.$obj \
	$(INDIR)\MTargv.$obj \
	$(INDIR)\MTboolstr.$obj \
	$(INDIR)\MTsearch.$obj \
	$(INDIR)\MTmain.$obj \
	$(INDIR)\MToption.$obj \
	$(INDIR)\MTconsole.$obj \
	$(INDIR)\MTrun_idr.$obj \
	$(INDIR)\MTpath_name.$obj \
	$(INDIR)\MTobject_id.$obj \
	$(INDIR)\MTcompress.$obj \
	$(INDIR)\MTeif_threads.$obj \
	$(INDIR)\MTeif_cond_var.$obj \
	$(INDIR)\MTeif_once.$obj \
	$(INDIR)\MTeif_rw_lock.$obj \
	$(INDIR)\MTeif_project.$obj \
	$(INDIR)\MTgen_conf.$obj \
	$(INDIR)\MTrout_obj.$obj \
	$(INDIR)\MTeif_special_table.$obj \
	$(TOP)\ipc\shared\MTnetworku.$obj \
	$(TOP)\ipc\shared\MTshword.$obj \
	$(TOP)\console\mtwinconsole.$lib \

MT_WOBJECTS = \
	$(MT_NETWORK) \
	$(INDIR)\MTwlmalloc.$obj \
	$(INDIR)\MTwmalloc.$obj \
	$(INDIR)\MTwgarcol.$obj \
	$(INDIR)\MTwlocal.$obj \
	$(INDIR)\MTwexcept.$obj \
	$(INDIR)\MTwstore.$obj \
	$(INDIR)\MTwretrieve.$obj \
	$(INDIR)\MTwhash.$obj \
	$(INDIR)\MTwtraverse.$obj \
	$(INDIR)\MTwhashin.$obj \
	$(INDIR)\MTwtools.$obj \
	$(INDIR)\MTwinternal.$obj \
	$(INDIR)\MTwplug.$obj \
	$(INDIR)\MTwcopy.$obj \
	$(INDIR)\MTwequal.$obj \
	$(INDIR)\MTwout.$obj \
	$(INDIR)\MTwtimer.$obj \
	$(INDIR)\MTwurgent.$obj \
	$(INDIR)\MTwsig.$obj \
	$(INDIR)\MTwhector.$obj \
	$(INDIR)\MTwcecil.$obj \
	$(INDIR)\MTwbits.$obj \
	$(INDIR)\MTwfile.$obj \
	$(INDIR)\MTwdir.$obj \
	$(INDIR)\MTwstring.$obj \
	$(INDIR)\MTwmisc.$obj \
	$(INDIR)\MTwpattern.$obj \
	$(INDIR)\MTwerror.$obj \
	$(INDIR)\MTwumain.$obj \
	$(INDIR)\MTwmemory.$obj \
	$(INDIR)\MTwargv.$obj \
	$(INDIR)\MTwboolstr.$obj \
	$(INDIR)\MTwsearch.$obj \
	$(INDIR)\MTwmain.$obj \
	$(INDIR)\MTdebug.$obj \
	$(INDIR)\MTinterp.$obj \
	$(INDIR)\MTwoption.$obj \
	$(INDIR)\MTupdate.$obj \
	$(INDIR)\MTwbench.$obj \
	$(INDIR)\MTwconsole.$obj \
	$(INDIR)\MTwrun_idr.$obj \
	$(INDIR)\MTwpath_name.$obj \
	$(INDIR)\MTwobject_id.$obj \
	$(INDIR)\MTcompress.$obj \
	$(INDIR)\MTweif_threads.$obj \
	$(INDIR)\MTweif_cond_var.$obj \
	$(INDIR)\MTweif_once.$obj \
	$(INDIR)\MTeif_rw_lock.$obj \
	$(INDIR)\MTweif_project.$obj \
	$(INDIR)\MTwgen_conf.$obj \
	$(INDIR)\MTwrout_obj.$obj \
	$(INDIR)\MTweif_special_table.$obj \
	$(TOP)\idrs\mtidr.$lib \
	$(TOP)\console\mtwwinconsole.$lib \

all:: eif_size.h
all:: $output_libraries

standard:: $(OUTDIR)\finalized.$lib $(OUTDIR)\wkbench.$lib $(OUTDIR)\ebench.$lib 
mtstandard:: $(OUTDIR)\mtfinalized.$lib $(OUTDIR)\mtwkbench.$lib

$(OUTDIR)\finalized.$lib: $(OBJECTS)
	$(RM) $(OUTDIR)\finalized.$lib
	$link_line

$(OUTDIR)\wkbench.$lib: $(WOBJECTS)
	$(RM) $(OUTDIR)\wkbench.$lib
	$link_wline

$(OUTDIR)\mtfinalized.$lib: $(MT_OBJECTS)
	$(RM) $(OUTDIR)\mtfinalized.$lib
	$link_mtline

$(OUTDIR)\mtwkbench.$lib: $(MT_WOBJECTS)
	$(RM) $(OUTDIR)\mtwkbench.$lib
	$link_mtwline

dll:: $(OUTDIR)\mtwkbench.dll $(OUTDIR)\mtfinalized.dll
dll:: $(OUTDIR)\wkbench.dll $(OUTDIR)\finalized.dll

LINK32_FLAGS= kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
		advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib wsock32.lib \
	$(DLLFLAGS)

$(OUTDIR)\mtwkbench.dll : $(OUTDIR) $(MT_WOBJECTS)
	$(RM) $(OUTDIR)\mtwkbench.dll
	$(LINK32) $(LINK32_FLAGS) -OUT:$(OUTDIR)\mtwkbench.dll \
		-IMPLIB:$(OUTDIR)\dll_mtwkbench.lib $(MT_WOBJECTS)

$(OUTDIR)\mtfinalized.dll : $(OUTDIR) $(MT_OBJECTS)
	$(RM) $(OUTDIR)\mtfinalized.dll
	$(LINK32) $(LINK32_FLAGS) -OUT:$(OUTDIR)\mtfinalized.dll \
		-IMPLIB:$(OUTDIR)\dll_mtfinalized.lib $(MT_OBJECTS)

$(OUTDIR)\wkbench.dll : $(OUTDIR) $(WOBJECTS)
	$(RM) $(OUTDIR)\wkbench.dll
	$(LINK32) $(LINK32_FLAGS) -OUT:$(OUTDIR)\wkbench.dll \
		-IMPLIB:$(OUTDIR)\dll_wkbench.lib $(WOBJECTS) 

$(OUTDIR)\finalized.dll : $(OUTDIR) $(OBJECTS)
	$(RM) $(OUTDIR)\finalized.dll
	$(LINK32) $(LINK32_FLAGS) -OUT:$(OUTDIR)\finalized.dll \
		-IMPLIB:$(OUTDIR)\dll_finalized.lib $(OBJECTS)

..\console\winconsole.$lib: ..\console\econsole.c ..\console\argcargv.c
	cd ..\console
	$(MAKE)
	cd ..\run-time

..\console\mtwinconsole.$lib: ..\console\econsole.c ..\console\argcargv.c
	cd ..\console
	$(MAKE)
	cd ..\run-time

..\console\wwinconsole.$lib: ..\console\econsole.c ..\console\argcargv.c
	cd ..\console
	$(MAKE)
	cd ..\run-time

..\console\mtwwinconsole.$lib: ..\console\econsole.c ..\console\argcargv.c
	cd ..\console
	$(MAKE)
	cd ..\run-time

..\idrs\idr.$lib:
	cd ..\idrs
	$(MAKE)
	cd ..\run-time

..\idrs\mtidr.$lib:
	cd ..\idrs
	$(MAKE)
	cd ..\run-time

..\ipc\app\network.$lib: ..\ipc\app\app_proto.c
	cd ..\ipc\app
	$(MAKE)
	cd ..\..\run-time

..\ipc\app\mtnetwork.$lib: ..\ipc\app\app_proto.c
	cd ..\ipc\app
	$(MAKE)
	cd ..\..\run-time

$(OUTDIR)\ebench.$lib: $(EOBJECTS)
	$(RM) $(OUTDIR)\ebench.$lib
	$link_eline

all:: x2c.exe

x2c.exe: x2c.c
	$(CC) -I$(TOP) x2c.c -ox2c.exe

all:: eif_config.h eif_portable.h

eif_config.h : $(TOP)\eif_config.h
	$(LN) $(TOP)\eif_config.h .

eif_portable.h : $(TOP)\eif_portable.h
	$(LN) $(TOP)\eif_portable.h .

$all_dependency

###################
# OBJECTS
###################

$(INDIR)\argv.$obj: $(RTSRC)\argv.c
	$(CC) $(JCFLAGS) $(RTSRC)\argv.c

$(INDIR)\bits.$obj: $(RTSRC)\bits.c
	$(CC) $(JCFLAGS) $(RTSRC)\bits.c

$(INDIR)\boolstr.$obj: $(RTSRC)\boolstr.c
	$(CC) $(JCFLAGS) $(RTSRC)\boolstr.c

$(INDIR)\cecil.$obj: $(RTSRC)\cecil.c
	$(CC) $(JCFLAGS) $(RTSRC)\cecil.c

$(INDIR)\compress.$obj: $(RTSRC)\compress.c
	$(CC) $(JCFLAGS) $(RTSRC)\compress.c

$(INDIR)\console.$obj: $(RTSRC)\console.c
	$(CC) $(JCFLAGS) $(RTSRC)\console.c

$(INDIR)\copy.$obj: $(RTSRC)\copy.c
	$(CC) $(JCFLAGS) $(RTSRC)\copy.c

$(INDIR)\dir.$obj: $(RTSRC)\dir.c
	$(CC) $(JCFLAGS) $(RTSRC)\dir.c

$(INDIR)\eif_cond_var.$obj: $(RTSRC)\eif_cond_var.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_cond_var.c

$(INDIR)\eif_once.$obj: $(RTSRC)\eif_once.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_once.c

$(INDIR)\eif_project.$obj: $(RTSRC)\eif_project.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_project.c

$(INDIR)\eif_threads.$obj: $(RTSRC)\eif_threads.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_threads.c

$(INDIR)\equal.$obj: $(RTSRC)\equal.c
	$(CC) $(JCFLAGS) $(RTSRC)\equal.c

$(INDIR)\error.$obj: $(RTSRC)\error.c
	$(CC) $(JCFLAGS) $(RTSRC)\error.c

$(INDIR)\except.$obj: $(RTSRC)\except.c
	$(CC) $(JCFLAGS) $(RTSRC)\except.c

$(INDIR)\file.$obj: $(RTSRC)\file.c
	$(CC) $(JCFLAGS) $(RTSRC)\file.c

$(INDIR)\garcol.$obj: $(RTSRC)\garcol.c
	$(CC) $(JCFLAGS) $(RTSRC)\garcol.c

$(INDIR)\gen_conf.$obj: $(RTSRC)\gen_conf.c
	$(CC) $(JCFLAGS) $(RTSRC)\gen_conf.c

$(INDIR)\rout_obj.$obj: $(RTSRC)\rout_obj.c
	$(CC) $(JCFLAGS) $(RTSRC)\rout_obj.c

$(INDIR)\eif_special_table.$obj: $(RTSRC)\eif_special_table.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_special_table.c

$(INDIR)\hash.$obj: $(RTSRC)\hash.c
	$(CC) $(JCFLAGS) $(RTSRC)\hash.c

$(INDIR)\hashin.$obj: $(RTSRC)\hashin.c
	$(CC) $(JCFLAGS) $(RTSRC)\hashin.c

$(INDIR)\hector.$obj: $(RTSRC)\hector.c
	$(CC) $(JCFLAGS) $(RTSRC)\hector.c

$(INDIR)\internal.$obj: $(RTSRC)\internal.c
	$(CC) $(JCFLAGS) $(RTSRC)\internal.c

$(INDIR)\lmalloc.$obj: $(RTSRC)\lmalloc.c
	$(CC) $(JCFLAGS) $(RTSRC)\lmalloc.c

$(INDIR)\local.$obj: $(RTSRC)\local.c
	$(CC) $(JCFLAGS) $(RTSRC)\local.c

$(INDIR)\main.$obj: $(RTSRC)\main.c
	$(CC) $(JCFLAGS) $(RTSRC)\main.c

$(INDIR)\malloc.$obj: $(RTSRC)\malloc.c
	$(CC) $(JCFLAGS) $(RTSRC)\malloc.c

$(INDIR)\memory.$obj: $(RTSRC)\memory.c
	$(CC) $(JCFLAGS) $(RTSRC)\memory.c

$(INDIR)\misc.$obj: $(RTSRC)\misc.c
	$(CC) $(JCFLAGS) $(RTSRC)\misc.c

$(INDIR)\object_id.$obj: $(RTSRC)\object_id.c
	$(CC) $(JCFLAGS) $(RTSRC)\object_id.c

$(INDIR)\option.$obj: $(RTSRC)\option.c
	$(CC) $(JCFLAGS) $(RTSRC)\option.c

$(INDIR)\out.$obj: $(RTSRC)\out.c
	$(CC) $(JCFLAGS) $(RTSRC)\out.c

$(INDIR)\path_name.$obj: $(RTSRC)\path_name.c
	$(CC) $(JCFLAGS) $(RTSRC)\path_name.c

$(INDIR)\pattern.$obj: $(RTSRC)\pattern.c
	$(CC) $(JCFLAGS) $(RTSRC)\pattern.c

$(INDIR)\plug.$obj: $(RTSRC)\plug.c
	$(CC) $(JCFLAGS) $(RTSRC)\plug.c

$(INDIR)\retrieve.$obj: $(RTSRC)\retrieve.c
	$(CC) $(JCFLAGS) $(RTSRC)\retrieve.c

$(INDIR)\run_idr.$obj: $(RTSRC)\run_idr.c
	$(CC) $(JCFLAGS) $(RTSRC)\run_idr.c

$(INDIR)\search.$obj: $(RTSRC)\search.c
	$(CC) $(JCFLAGS) $(RTSRC)\search.c

$(INDIR)\sig.$obj: $(RTSRC)\sig.c
	$(CC) $(JCFLAGS) $(RTSRC)\sig.c

$(INDIR)\store.$obj: $(RTSRC)\store.c
	$(CC) $(JCFLAGS) $(RTSRC)\store.c

$(INDIR)\string.$obj: $(RTSRC)\string.c
	$(CC) $(JCFLAGS) $(RTSRC)\string.c

$(INDIR)\timer.$obj: $(RTSRC)\timer.c
	$(CC) $(JCFLAGS) $(RTSRC)\timer.c

$(INDIR)\tools.$obj: $(RTSRC)\tools.c
	$(CC) $(JCFLAGS) $(RTSRC)\tools.c

$(INDIR)\traverse.$obj: $(RTSRC)\traverse.c
	$(CC) $(JCFLAGS) $(RTSRC)\traverse.c

$(INDIR)\umain.$obj: $(RTSRC)\umain.c
	$(CC) $(JCFLAGS) $(RTSRC)\umain.c

$(INDIR)\urgent.$obj: $(RTSRC)\urgent.c
	$(CC) $(JCFLAGS) $(RTSRC)\urgent.c

$(INDIR)\update.$obj: $(RTSRC)\update.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\update.c

$(INDIR)\debug.$obj: $(RTSRC)\debug.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\debug.c

$(INDIR)\interp.$obj: $(RTSRC)\interp.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\interp.c

$(INDIR)\eif_rw_lock.$obj : $(RTSRC)\eif_rw_lock.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_rw_lock.c

$(INDIR)\wargv.$obj: $(RTSRC)\argv.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\argv.c

$(INDIR)\wbench.$obj: $(RTSRC)\wbench.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\wbench.c

$(INDIR)\wbits.$obj: $(RTSRC)\bits.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\bits.c

$(INDIR)\wboolstr.$obj: $(RTSRC)\boolstr.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\boolstr.c

$(INDIR)\wcecil.$obj: $(RTSRC)\cecil.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\cecil.c

$(INDIR)\wconsole.$obj: $(RTSRC)\console.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\console.c

$(INDIR)\wcopy.$obj: $(RTSRC)\copy.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\copy.c

$(INDIR)\wdir.$obj: $(RTSRC)\dir.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\dir.c

$(INDIR)\weif_cond_var.$obj: $(RTSRC)\eif_cond_var.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_cond_var.c

$(INDIR)\weif_once.$obj: $(RTSRC)\eif_once.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_once.c

$(INDIR)\weif_project.$obj: $(RTSRC)\eif_project.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_project.c

$(INDIR)\weif_threads.$obj: $(RTSRC)\eif_threads.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_threads.c

$(INDIR)\wequal.$obj: $(RTSRC)\equal.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\equal.c

$(INDIR)\werror.$obj: $(RTSRC)\error.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\error.c

$(INDIR)\wexcept.$obj: $(RTSRC)\except.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\except.c

$(INDIR)\wfile.$obj: $(RTSRC)\file.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\file.c

$(INDIR)\wgarcol.$obj: $(RTSRC)\garcol.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\garcol.c

$(INDIR)\wgen_conf.$obj: $(RTSRC)\gen_conf.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\gen_conf.c

$(INDIR)\weif_special_table.$obj: $(RTSRC)\eif_special_table.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_special_table.c

$(INDIR)\wrout_obj.$obj: $(RTSRC)\rout_obj.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\rout_obj.c

$(INDIR)\whash.$obj: $(RTSRC)\hash.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\hash.c

$(INDIR)\whashin.$obj: $(RTSRC)\hashin.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\hashin.c

$(INDIR)\whector.$obj: $(RTSRC)\hector.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\hector.c

$(INDIR)\winternal.$obj: $(RTSRC)\internal.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\internal.c

$(INDIR)\wlmalloc.$obj: $(RTSRC)\lmalloc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\lmalloc.c

$(INDIR)\wlocal.$obj: $(RTSRC)\local.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\local.c

$(INDIR)\wmain.$obj: $(RTSRC)\main.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\main.c

$(INDIR)\wmalloc.$obj: $(RTSRC)\malloc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\malloc.c

$(INDIR)\wmemory.$obj: $(RTSRC)\memory.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\memory.c

$(INDIR)\wmisc.$obj: $(RTSRC)\misc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\misc.c

$(INDIR)\wobject_id.$obj: $(RTSRC)\object_id.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\object_id.c

$(INDIR)\woption.$obj: $(RTSRC)\option.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\option.c

$(INDIR)\wout.$obj: $(RTSRC)\out.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\out.c

$(INDIR)\wpath_name.$obj: $(RTSRC)\path_name.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\path_name.c

$(INDIR)\wpattern.$obj: $(RTSRC)\pattern.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\pattern.c

$(INDIR)\wplug.$obj: $(RTSRC)\plug.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\plug.c

$(INDIR)\wretrieve.$obj: $(RTSRC)\retrieve.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\retrieve.c

$(INDIR)\wrun_idr.$obj: $(RTSRC)\run_idr.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\run_idr.c

$(INDIR)\wsearch.$obj: $(RTSRC)\search.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\search.c

$(INDIR)\wsig.$obj: $(RTSRC)\sig.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\sig.c

$(INDIR)\wstore.$obj: $(RTSRC)\store.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\store.c

$(INDIR)\wstring.$obj: $(RTSRC)\string.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\string.c

$(INDIR)\wtimer.$obj: $(RTSRC)\timer.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\timer.c

$(INDIR)\wtools.$obj: $(RTSRC)\tools.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\tools.c

$(INDIR)\wtraverse.$obj: $(RTSRC)\traverse.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\traverse.c

$(INDIR)\wumain.$obj: $(RTSRC)\umain.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\umain.c

$(INDIR)\wurgent.$obj: $(RTSRC)\urgent.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\urgent.c

$(INDIR)\x2c.$obj: $(RTSRC)\x2c.c
	$(CC) $(JCFLAGS) $(RTSRC)\x2c.c

final: finalized.$lib
work: wkbench.$lib

$(INDIR)\bmain.$obj: $(RTSRC)\main.c
	$(CC) $(JCFLAGS) -DWORKBENCH -DNOHOOK $(RTSRC)\main.c

$(INDIR)\bexcept.$obj: $(RTSRC)\except.c
	$(CC) $(JCFLAGS) -DWORKBENCH -DNOHOOK $(RTSRC)\except.c

###################
# MT_OBJECTS
###################

$(INDIR)\MTargv.$obj: $(RTSRC)\argv.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\argv.c

$(INDIR)\MTbits.$obj: $(RTSRC)\bits.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\bits.c

$(INDIR)\MTboolstr.$obj: $(RTSRC)\boolstr.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\boolstr.c

$(INDIR)\MTcecil.$obj: $(RTSRC)\cecil.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\cecil.c

$(INDIR)\MTcompress.$obj: $(RTSRC)\compress.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\compress.c

$(INDIR)\MTconsole.$obj: $(RTSRC)\console.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\console.c

$(INDIR)\MTcopy.$obj: $(RTSRC)\copy.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\copy.c

$(INDIR)\MTdir.$obj: $(RTSRC)\dir.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\dir.c

$(INDIR)\MTeif_cond_var.$obj: $(RTSRC)\eif_cond_var.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\eif_cond_var.c

$(INDIR)\MTeif_once.$obj: $(RTSRC)\eif_once.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\eif_once.c

$(INDIR)\MTeif_project.$obj: $(RTSRC)\eif_project.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\eif_project.c

$(INDIR)\MTeif_threads.$obj: $(RTSRC)\eif_threads.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\eif_threads.c

$(INDIR)\MTequal.$obj: $(RTSRC)\equal.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\equal.c

$(INDIR)\MTerror.$obj: $(RTSRC)\error.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\error.c

$(INDIR)\MTexcept.$obj: $(RTSRC)\except.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\except.c

$(INDIR)\MTfile.$obj: $(RTSRC)\file.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\file.c

$(INDIR)\MTgarcol.$obj: $(RTSRC)\garcol.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\garcol.c

$(INDIR)\MTgen_conf.$obj: $(RTSRC)\gen_conf.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\gen_conf.c

$(INDIR)\MTrout_obj.$obj: $(RTSRC)\rout_obj.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\rout_obj.c

$(INDIR)\MTeif_special_table.$obj: $(RTSRC)\eif_special_table.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\eif_special_table.c

$(INDIR)\MThash.$obj: $(RTSRC)\hash.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\hash.c

$(INDIR)\MThashin.$obj: $(RTSRC)\hashin.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\hashin.c

$(INDIR)\MThector.$obj: $(RTSRC)\hector.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\hector.c

$(INDIR)\MTinternal.$obj: $(RTSRC)\internal.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\internal.c

$(INDIR)\MTlmalloc.$obj: $(RTSRC)\lmalloc.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\lmalloc.c

$(INDIR)\MTlocal.$obj: $(RTSRC)\local.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\local.c

$(INDIR)\MTmain.$obj: $(RTSRC)\main.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\main.c

$(INDIR)\MTmalloc.$obj: $(RTSRC)\malloc.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\malloc.c

$(INDIR)\MTmemory.$obj: $(RTSRC)\memory.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\memory.c

$(INDIR)\MTmisc.$obj: $(RTSRC)\misc.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\misc.c

$(INDIR)\MTobject_id.$obj: $(RTSRC)\object_id.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\object_id.c

$(INDIR)\MToption.$obj: $(RTSRC)\option.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\option.c

$(INDIR)\MTout.$obj: $(RTSRC)\out.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\out.c

$(INDIR)\MTpath_name.$obj: $(RTSRC)\path_name.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\path_name.c

$(INDIR)\MTpattern.$obj: $(RTSRC)\pattern.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\pattern.c

$(INDIR)\MTplug.$obj: $(RTSRC)\plug.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\plug.c

$(INDIR)\MTretrieve.$obj: $(RTSRC)\retrieve.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\retrieve.c

$(INDIR)\MTrun_idr.$obj: $(RTSRC)\run_idr.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\run_idr.c

$(INDIR)\MTsearch.$obj: $(RTSRC)\search.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\search.c

$(INDIR)\MTsig.$obj: $(RTSRC)\sig.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\sig.c

$(INDIR)\MTstore.$obj: $(RTSRC)\store.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\store.c

$(INDIR)\MTstring.$obj: $(RTSRC)\string.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\string.c

$(INDIR)\MTtimer.$obj: $(RTSRC)\timer.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\timer.c

$(INDIR)\MTtools.$obj: $(RTSRC)\tools.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\tools.c

$(INDIR)\MTtraverse.$obj: $(RTSRC)\traverse.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\traverse.c

$(INDIR)\MTumain.$obj: $(RTSRC)\umain.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\umain.c

$(INDIR)\MTurgent.$obj: $(RTSRC)\urgent.c
	$(CC) $(JMTCFLAGS) $(RTSRC)\urgent.c

$(INDIR)\MTupdate.$obj: $(RTSRC)\update.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\update.c

$(INDIR)\MTdebug.$obj: $(RTSRC)\debug.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\debug.c

$(INDIR)\MTinterp.$obj: $(RTSRC)\interp.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\interp.c

$(INDIR)\MTeif_rw_lock.$obj : $(RTSRC)\eif_rw_lock.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\eif_rw_lock.c

$(INDIR)\MTwargv.$obj: $(RTSRC)\argv.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\argv.c

$(INDIR)\MTwbench.$obj: $(RTSRC)\wbench.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\wbench.c

$(INDIR)\MTwbits.$obj: $(RTSRC)\bits.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\bits.c

$(INDIR)\MTwboolstr.$obj: $(RTSRC)\boolstr.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\boolstr.c

$(INDIR)\MTwcecil.$obj: $(RTSRC)\cecil.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\cecil.c

$(INDIR)\MTwconsole.$obj: $(RTSRC)\console.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\console.c

$(INDIR)\MTwcopy.$obj: $(RTSRC)\copy.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\copy.c

$(INDIR)\MTwdir.$obj: $(RTSRC)\dir.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\dir.c

$(INDIR)\MTweif_cond_var.$obj: $(RTSRC)\eif_cond_var.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\eif_cond_var.c

$(INDIR)\MTweif_once.$obj: $(RTSRC)\eif_once.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\eif_once.c

$(INDIR)\MTweif_project.$obj: $(RTSRC)\eif_project.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\eif_project.c

$(INDIR)\MTweif_threads.$obj: $(RTSRC)\eif_threads.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\eif_threads.c

$(INDIR)\MTwequal.$obj: $(RTSRC)\equal.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\equal.c

$(INDIR)\MTwerror.$obj: $(RTSRC)\error.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\error.c

$(INDIR)\MTwexcept.$obj: $(RTSRC)\except.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\except.c

$(INDIR)\MTwfile.$obj: $(RTSRC)\file.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\file.c

$(INDIR)\MTwgarcol.$obj: $(RTSRC)\garcol.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\garcol.c

$(INDIR)\MTwgen_conf.$obj: $(RTSRC)\gen_conf.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\gen_conf.c

$(INDIR)\MTweif_special_table.$obj: $(RTSRC)\eif_special_table.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\eif_special_table.c

$(INDIR)\MTwrout_obj.$obj: $(RTSRC)\rout_obj.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\rout_obj.c

$(INDIR)\MTwhash.$obj: $(RTSRC)\hash.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\hash.c

$(INDIR)\MTwhashin.$obj: $(RTSRC)\hashin.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\hashin.c

$(INDIR)\MTwhector.$obj: $(RTSRC)\hector.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\hector.c

$(INDIR)\MTwinternal.$obj: $(RTSRC)\internal.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\internal.c

$(INDIR)\MTwlmalloc.$obj: $(RTSRC)\lmalloc.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\lmalloc.c

$(INDIR)\MTwlocal.$obj: $(RTSRC)\local.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\local.c

$(INDIR)\MTwmain.$obj: $(RTSRC)\main.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\main.c

$(INDIR)\MTwmalloc.$obj: $(RTSRC)\malloc.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\malloc.c

$(INDIR)\MTwmemory.$obj: $(RTSRC)\memory.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\memory.c

$(INDIR)\MTwmisc.$obj: $(RTSRC)\misc.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\misc.c

$(INDIR)\MTwobject_id.$obj: $(RTSRC)\object_id.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\object_id.c

$(INDIR)\MTwoption.$obj: $(RTSRC)\option.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\option.c

$(INDIR)\MTwout.$obj: $(RTSRC)\out.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\out.c

$(INDIR)\MTwpath_name.$obj: $(RTSRC)\path_name.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\path_name.c

$(INDIR)\MTwpattern.$obj: $(RTSRC)\pattern.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\pattern.c

$(INDIR)\MTwplug.$obj: $(RTSRC)\plug.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\plug.c

$(INDIR)\MTwretrieve.$obj: $(RTSRC)\retrieve.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\retrieve.c

$(INDIR)\MTwrun_idr.$obj: $(RTSRC)\run_idr.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\run_idr.c

$(INDIR)\MTwsearch.$obj: $(RTSRC)\search.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\search.c

$(INDIR)\MTwsig.$obj: $(RTSRC)\sig.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\sig.c

$(INDIR)\MTwstore.$obj: $(RTSRC)\store.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\store.c

$(INDIR)\MTwstring.$obj: $(RTSRC)\string.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\string.c

$(INDIR)\MTwtimer.$obj: $(RTSRC)\timer.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\timer.c

$(INDIR)\MTwtools.$obj: $(RTSRC)\tools.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\tools.c

$(INDIR)\MTwtraverse.$obj: $(RTSRC)\traverse.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\traverse.c

$(INDIR)\MTwumain.$obj: $(RTSRC)\umain.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\umain.c

$(INDIR)\MTwurgent.$obj: $(RTSRC)\urgent.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(RTSRC)\urgent.c

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

$(INDIR)\malloc.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

$(INDIR)\garcol.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_search.h eif_sig.h \
			eif_size.h eif_struct.h eif_timer.h eif_urgent.h

$(INDIR)\local.$obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_local.h eif_malloc.h \
			eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

$(INDIR)\except.$obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_sig.h eif_size.h eif_struct.h eif_urgent.h

$(INDIR)\store.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h eif_traverse.h

$(INDIR)\retrieve.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_retrieve.h eif_size.h eif_struct.h

$(INDIR)\hash.$obj : eif_hash.h eif_tools.h

$(INDIR)\traverse.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h \
			eif_traverse.h

$(INDIR)\hashin.$obj : eif_hashin.h eif_malloc.h eif_tools.h

$(INDIR)\tools.$obj : eif_tools.h

$(INDIR)\internal.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h

$(INDIR)\plug.$obj : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h eif_option.h \
			eif_out.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\copy.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hash.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h eif_traverse.h

$(INDIR)\equal.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_equal.h eif_except.h eif_file.h \
			eif_garcol.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_search.h eif_size.h eif_struct.h eif_tools.h eif_traverse.h

$(INDIR)\lmalloc.$obj : eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

$(INDIR)\out.$obj : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_sig.h eif_size.h eif_struct.h

$(INDIR)\timer.$obj : eif_timer.h

$(INDIR)\urgent.$obj : eif_urgent.h

$(INDIR)\sig.$obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h

$(INDIR)\hector.$obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

$(INDIR)\cecil.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h eif_struct.h \
			eif_tools.h

$(INDIR)\bits.$obj : eif_bits.h eif_cecil.h eif_except.h eif_garcol.h eif_local.h eif_malloc.h \
			eif_plug.h eif_struct.h

$(INDIR)\file.$obj : eif_cecil.h eif_copy.h eif_except.h eif_file.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\dir.$obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\misc.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_misc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\pattern.$obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

$(INDIR)\error.$obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

$(INDIR)\memory.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\argv.$obj : eif_malloc.h eif_plug.h

$(INDIR)\search.$obj : eif_search.h eif_tools.h

$(INDIR)\x2c.$obj : eif_size.h

$(INDIR)\debug.$obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hashin.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

$(INDIR)\interp.$obj : eif_bits.h eif_cecil.h eif_copy.h eif_debug.h eif_dir.h eif_except.h eif_file.h \
			eif_garcol.h eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h \
			eif_out.h eif_plug.h eif_sig.h eif_size.h eif_struct.h

$(INDIR)\option.$obj : eif_option.h eif_struct.h

$(INDIR)\update.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_update.h

$(INDIR)\wbench.$obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_interp.h eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_wbench.h

$(INDIR)\main.$obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

$(INDIR)\wmain.$obj : eif_except.h eif_garcol.h main.c eif_malloc.h eif_plug.h eif_sig.h eif_struct.h \
			eif_urgent.h

$(INDIR)\object_id.$obj : eif_garcol.h eif_except.h eif_hector.h

$(INDIR)\gen_conf.$obj : eif_gen_conf.h eif_struct.h
$(INDIR)\wgen_conf.$obj : eif_gen_conf.h eif_struct.h

$(INDIR)\rout_obj.$obj : eif_rout_obj.h
$(INDIR)\wrout_obj.$obj : eif_rout_obj.h

$(INDIR)\eif_special_table.$obj : eif_special_table.h
$(INDIR)\eif_special_table.$obj : eif_special_table.h

$(INDIR)\eif_threads.$obj : eif_threads.h eif_cond_var.h
$(INDIR)\eif_cond_var.$obj : eif_cond_var.h
$(INDIR)\eif_once.$obj : eif_once.h eif_threads.h

$(INDIR)\weif_threads.$obj : eif_threads.h eif_cond_var.h
$(INDIR)\weif_cond_var.$obj : eif_cond_var.h
$(INDIR)\weif_once.$obj : eif_once.h eif_threads.h
