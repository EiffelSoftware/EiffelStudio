TOP = ..
OUTDIR = .\LIB
INDIR = .\OBJDIR
RTSRC = .
CC = $cc
CTAGS = ctags
OUTPUT_CMD = $output_cmd
INPUT_CMD = $input_cmd
JCFLAGS = $(CFLAGS)  $ccflags $optimize $(INPUT_CMD) $(OUTPUT_CMD)$@ -c
LIB_EXE = $lib_exe
LN = copy
MAKE = $make
MV = move
RM = del
LINK32 = $link32
DLLFLAGS = $dllflags

CFLAGS = -I. -I$(TOP) -I$(TOP)/idrs -I$(TOP)/console -I$(TOP)/ipc/app
NETWORK = $(TOP)\ipc\app\network.lib

all:: $(INDIR) $(OUTDIR)

$(INDIR) :
    if not exist $(INDIR)/$(NULL) mkdir $(INDIR)

$(OUTDIR) :
    if not exist $(OUTDIR)/$(NULL) mkdir $(OUTDIR)

LIBDIR=$(OUTDIR)
DLLDIR=$(OUTDIR)

OBJECTS = \
	$(INDIR)\lmalloc.obj \
	$(INDIR)\math.obj \
	$(INDIR)\malloc.obj \
	$(INDIR)\garcol.obj \
	$(INDIR)\local.obj \
	$(INDIR)\except.obj \
	$(INDIR)\store.obj \
	$(INDIR)\retrieve.obj \
	$(INDIR)\hash.obj \
	$(INDIR)\traverse.obj \
	$(INDIR)\hashin.obj \
	$(INDIR)\tools.obj \
	$(INDIR)\internal.obj \
	$(INDIR)\plug.obj \
	$(INDIR)\copy.obj \
	$(INDIR)\equal.obj \
	$(INDIR)\out.obj \
	$(INDIR)\timer.obj \
	$(INDIR)\urgent.obj \
	$(INDIR)\sig.obj \
	$(INDIR)\hector.obj \
	$(INDIR)\cecil.obj \
	$(INDIR)\bits.obj \
	$(INDIR)\file.obj \
	$(INDIR)\dir.obj \
	$(INDIR)\string.obj \
	$(INDIR)\misc.obj \
	$(INDIR)\pattern.obj \
	$(INDIR)\error.obj \
	$(INDIR)\umain.obj \
	$(INDIR)\memory.obj \
	$(INDIR)\argv.obj \
	$(INDIR)\boolstr.obj \
	$(INDIR)\search.obj \
	$(INDIR)\main.obj \
	$(INDIR)\option.obj \
	$(INDIR)\console.obj \
	$(INDIR)\run_idr.obj \
	$(INDIR)\path_name.obj \
	$(INDIR)\object_id.obj \
	$(INDIR)\compress.obj \
	$(INDIR)\eif_threads.obj \
	$(INDIR)\eif_cond_var.obj \
	$(INDIR)\eif_once.obj \
	$(INDIR)\eif_rw_lock.obj \
	$(INDIR)\eif_project.obj \
	$(INDIR)\gen_conf.obj \
	$(INDIR)\rout_obj.obj \
	$(TOP)\ipc\shared\networku.obj \
	$(TOP)\ipc\shared\shword.obj \
	$(TOP)\console\econsole.lib \
	$extra_object_files

WOBJECTS = \
	$(NETWORK) \
	$(INDIR)\wlmalloc.obj \
	$(INDIR)\wmath.obj \
	$(INDIR)\wmalloc.obj \
	$(INDIR)\wgarcol.obj \
	$(INDIR)\wlocal.obj \
	$(INDIR)\wexcept.obj \
	$(INDIR)\wstore.obj \
	$(INDIR)\wretrieve.obj \
	$(INDIR)\whash.obj \
	$(INDIR)\wtraverse.obj \
	$(INDIR)\whashin.obj \
	$(INDIR)\wtools.obj \
	$(INDIR)\winternal.obj \
	$(INDIR)\wplug.obj \
	$(INDIR)\wcopy.obj \
	$(INDIR)\wequal.obj \
	$(INDIR)\wout.obj \
	$(INDIR)\wtimer.obj \
	$(INDIR)\wurgent.obj \
	$(INDIR)\wsig.obj \
	$(INDIR)\whector.obj \
	$(INDIR)\wcecil.obj \
	$(INDIR)\wbits.obj \
	$(INDIR)\wfile.obj \
	$(INDIR)\wdir.obj \
	$(INDIR)\wstring.obj \
	$(INDIR)\wmisc.obj \
	$(INDIR)\wpattern.obj \
	$(INDIR)\werror.obj \
	$(INDIR)\wumain.obj \
	$(INDIR)\wmemory.obj \
	$(INDIR)\wargv.obj \
	$(INDIR)\wboolstr.obj \
	$(INDIR)\wsearch.obj \
	$(INDIR)\wmain.obj \
	$(INDIR)\debug.obj \
	$(INDIR)\interp.obj \
	$(INDIR)\woption.obj \
	$(INDIR)\update.obj \
	$(INDIR)\wbench.obj \
	$(INDIR)\wconsole.obj \
	$(INDIR)\wrun_idr.obj \
	$(INDIR)\wpath_name.obj \
	$(INDIR)\wobject_id.obj \
	$(INDIR)\compress.obj \
	$(INDIR)\weif_threads.obj \
	$(INDIR)\weif_cond_var.obj \
	$(INDIR)\weif_once.obj \
	$(INDIR)\eif_rw_lock.obj \
	$(INDIR)\weif_project.obj \
	$(INDIR)\wgen_conf.obj \
	$(INDIR)\wrout_obj.obj \
	$(TOP)\idrs\idr.lib \
	$(TOP)\console\econsole.lib \
	$extra_object_files

EOBJECTS = \
	$(INDIR)\wlmalloc.obj \
	$(INDIR)\wmath.obj \
	$(INDIR)\wmalloc.obj \
	$(INDIR)\wgarcol.obj \
	$(INDIR)\wlocal.obj \
	$(INDIR)\bexcept.obj \
	$(INDIR)\wstore.obj \
	$(INDIR)\wretrieve.obj \
	$(INDIR)\whash.obj \
	$(INDIR)\wtraverse.obj \
	$(INDIR)\whashin.obj \
	$(INDIR)\wtools.obj \
	$(INDIR)\winternal.obj \
	$(INDIR)\wplug.obj \
	$(INDIR)\wcopy.obj \
	$(INDIR)\wequal.obj \
	$(INDIR)\wout.obj \
	$(INDIR)\wtimer.obj \
	$(INDIR)\wurgent.obj \
	$(INDIR)\wsig.obj \
	$(INDIR)\whector.obj \
	$(INDIR)\wcecil.obj \
	$(INDIR)\wbits.obj \
	$(INDIR)\wfile.obj \
	$(INDIR)\wdir.obj \
	$(INDIR)\wstring.obj \
	$(INDIR)\wmisc.obj \
	$(INDIR)\wpattern.obj \
	$(INDIR)\werror.obj \
	$(INDIR)\wumain.obj \
	$(INDIR)\wmemory.obj \
	$(INDIR)\wargv.obj \
	$(INDIR)\wboolstr.obj \
	$(INDIR)\wsearch.obj \
	$(INDIR)\bmain.obj \
	$(INDIR)\debug.obj \
	$(INDIR)\interp.obj \
	$(INDIR)\woption.obj \
	$(INDIR)\update.obj \
	$(INDIR)\wbench.obj \
	$(INDIR)\wconsole.obj \
	$(INDIR)\wrun_idr.obj \
	$(INDIR)\wpath_name.obj \
	$(INDIR)\wobject_id.obj \
	$(INDIR)\compress.obj \
	$(INDIR)\weif_threads.obj \
	$(INDIR)\weif_cond_var.obj \
	$(INDIR)\weif_once.obj \
	$(INDIR)\eif_rw_lock.obj \
	$(INDIR)\weif_project.obj \
	$(INDIR)\wgen_conf.obj \
	$(INDIR)\wrout_obj.obj \
	$(TOP)\ipc\shared\networku.obj \
	$(TOP)\console\econsole.lib

all:: eif_size.h


all:: finalized.lib

finalized.lib: $(OBJECTS)
	$link_line

all:: wkbench.lib

wkbench.lib: $(WOBJECTS)
	$link_wline



dll:: wkbench.dll

DEF_FILE= wkbench.def
LINK32_FLAGS= kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
		advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib wsock32.lib \
	$(DLLFLAGS) \
	/def:$(DEF_FILE) \
	/OUT:$(DLLDIR)\wkbench.dll /IMPLIB:$(DLLDIR)\dll_wkbench.lib

LINK32_OBJS= $(WOBJECTS)
wkbench.dll : $(DLLDIR) $(DEF_FILE) $(LINK32_OBJS)
	$(RM) $(DLLDIR)\wkbench.dll
    $(LINK32) $(LINK32_FLAGS) $(LINK32_OBJS)

dll:: finalized.dll

DEF_FILE= finalized.def
LINK32_FLAGS= kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
		advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib wsock32.lib \
	$(DLLFLAGS) \
	/def:$(DEF_FILE) \
	/OUT:$(DLLDIR)\finalized.dll /IMPLIB:$(DLLDIR)\dll_finalized.lib

LINK32_OBJS= $(OBJECTS)
finalized.dll : $(DLLDIR) $(DEF_FILE) $(LINK32_OBJS)
	$(RM) $(DLLDIR)\finalized.dll
    $(LINK32) $(LINK32_FLAGS) $(LINK32_OBJS)


..\console\econsole.lib: ..\console\econsole.c ..\console\argcargv.c
	cd ..\console
	$(MAKE)
	cd ..\run-time

..\idrs\idr.lib:
	cd ..\idrs
	$(MAKE)
	cd ..\run-time

all:: ebench.lib

..\ipc\app\network.lib: ..\ipc\app\proto.c
	cd ..\ipc\app
	$(MAKE)
	cd ..\..\run-time

ebench.lib: $(EOBJECTS)
	$link_eline

all:: x2c.exe

x2c.exe: x2c.c
	$(CC) x2c.c

all:: 
	@echo WARNING: If you want to generate or to update DLLs : USE "make dll".

all:: eif_config.h eif_portable.h

eif_config.h : $(TOP)\eif_config.h
	$(LN) $(TOP)\eif_config.h .

eif_portable.h : $(TOP)\eif_portable.h
	$(LN) $(TOP)\eif_portable.h .

*.obj: eif_config.h eif_portable.h eif_globals.h eif_eiffel.h eif_macros.h

###################
# OBJECTS
###################

$(INDIR)\argv.obj: $(RTSRC)\argv.c
	$(CC) $(JCFLAGS) $(RTSRC)\argv.c

$(INDIR)\bits.obj: $(RTSRC)\bits.c
	$(CC) $(JCFLAGS) $(RTSRC)\bits.c

$(INDIR)\boolstr.obj: $(RTSRC)\boolstr.c
	$(CC) $(JCFLAGS) $(RTSRC)\boolstr.c

$(INDIR)\cecil.obj: $(RTSRC)\cecil.c
	$(CC) $(JCFLAGS) $(RTSRC)\cecil.c

$(INDIR)\compress.obj: $(RTSRC)\compress.c
	$(CC) $(JCFLAGS) $(RTSRC)\compress.c

$(INDIR)\console.obj: $(RTSRC)\console.c
	$(CC) $(JCFLAGS) $(RTSRC)\console.c

$(INDIR)\copy.obj: $(RTSRC)\copy.c
	$(CC) $(JCFLAGS) $(RTSRC)\copy.c

$(INDIR)\dir.obj: $(RTSRC)\dir.c
	$(CC) $(JCFLAGS) $(RTSRC)\dir.c

$(INDIR)\eif_cond_var.obj: $(RTSRC)\eif_cond_var.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_cond_var.c

$(INDIR)\eif_once.obj: $(RTSRC)\eif_once.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_once.c

$(INDIR)\eif_project.obj: $(RTSRC)\eif_project.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_project.c

$(INDIR)\eif_threads.obj: $(RTSRC)\eif_threads.c
	$(CC) $(JCFLAGS) $(RTSRC)\eif_threads.c

$(INDIR)\equal.obj: $(RTSRC)\equal.c
	$(CC) $(JCFLAGS) $(RTSRC)\equal.c

$(INDIR)\error.obj: $(RTSRC)\error.c
	$(CC) $(JCFLAGS) $(RTSRC)\error.c

$(INDIR)\except.obj: $(RTSRC)\except.c
	$(CC) $(JCFLAGS) $(RTSRC)\except.c

$(INDIR)\file.obj: $(RTSRC)\file.c
	$(CC) $(JCFLAGS) $(RTSRC)\file.c

$(INDIR)\garcol.obj: $(RTSRC)\garcol.c
	$(CC) $(JCFLAGS) $(RTSRC)\garcol.c

$(INDIR)\gen_conf.obj: $(RTSRC)\gen_conf.c
	$(CC) $(JCFLAGS) $(RTSRC)\gen_conf.c

$(INDIR)\rout_obj.obj: $(RTSRC)\rout_obj.c
	$(CC) $(JCFLAGS) $(RTSRC)\rout_obj.c

$(INDIR)\hash.obj: $(RTSRC)\hash.c
	$(CC) $(JCFLAGS) $(RTSRC)\hash.c

$(INDIR)\hashin.obj: $(RTSRC)\hashin.c
	$(CC) $(JCFLAGS) $(RTSRC)\hashin.c

$(INDIR)\hector.obj: $(RTSRC)\hector.c
	$(CC) $(JCFLAGS) $(RTSRC)\hector.c

$(INDIR)\internal.obj: $(RTSRC)\internal.c
	$(CC) $(JCFLAGS) $(RTSRC)\internal.c

$(INDIR)\lmalloc.obj: $(RTSRC)\lmalloc.c
	$(CC) $(JCFLAGS) $(RTSRC)\lmalloc.c

$(INDIR)\local.obj: $(RTSRC)\local.c
	$(CC) $(JCFLAGS) $(RTSRC)\local.c

$(INDIR)\main.obj: $(RTSRC)\main.c
	$(CC) $(JCFLAGS) $(RTSRC)\main.c

$(INDIR)\malloc.obj: $(RTSRC)\malloc.c
	$(CC) $(JCFLAGS) $(RTSRC)\malloc.c

$(INDIR)\math.obj: $(RTSRC)\math.c
	$(CC) $(JCFLAGS) $(RTSRC)\math.c

$(INDIR)\memory.obj: $(RTSRC)\memory.c
	$(CC) $(JCFLAGS) $(RTSRC)\memory.c

$(INDIR)\misc.obj: $(RTSRC)\misc.c
	$(CC) $(JCFLAGS) $(RTSRC)\misc.c

$(INDIR)\object_id.obj: $(RTSRC)\object_id.c
	$(CC) $(JCFLAGS) $(RTSRC)\object_id.c

$(INDIR)\option.obj: $(RTSRC)\option.c
	$(CC) $(JCFLAGS) $(RTSRC)\option.c

$(INDIR)\out.obj: $(RTSRC)\out.c
	$(CC) $(JCFLAGS) $(RTSRC)\out.c

$(INDIR)\path_name.obj: $(RTSRC)\path_name.c
	$(CC) $(JCFLAGS) $(RTSRC)\path_name.c

$(INDIR)\pattern.obj: $(RTSRC)\pattern.c
	$(CC) $(JCFLAGS) $(RTSRC)\pattern.c

$(INDIR)\plug.obj: $(RTSRC)\plug.c
	$(CC) $(JCFLAGS) $(RTSRC)\plug.c

$(INDIR)\retrieve.obj: $(RTSRC)\retrieve.c
	$(CC) $(JCFLAGS) $(RTSRC)\retrieve.c

$(INDIR)\run_idr.obj: $(RTSRC)\run_idr.c
	$(CC) $(JCFLAGS) $(RTSRC)\run_idr.c

$(INDIR)\search.obj: $(RTSRC)\search.c
	$(CC) $(JCFLAGS) $(RTSRC)\search.c

$(INDIR)\sig.obj: $(RTSRC)\sig.c
	$(CC) $(JCFLAGS) $(RTSRC)\sig.c

$(INDIR)\store.obj: $(RTSRC)\store.c
	$(CC) $(JCFLAGS) $(RTSRC)\store.c

$(INDIR)\string.obj: $(RTSRC)\string.c
	$(CC) $(JCFLAGS) $(RTSRC)\string.c

$(INDIR)\timer.obj: $(RTSRC)\timer.c
	$(CC) $(JCFLAGS) $(RTSRC)\timer.c

$(INDIR)\tools.obj: $(RTSRC)\tools.c
	$(CC) $(JCFLAGS) $(RTSRC)\tools.c

$(INDIR)\traverse.obj: $(RTSRC)\traverse.c
	$(CC) $(JCFLAGS) $(RTSRC)\traverse.c

$(INDIR)\umain.obj: $(RTSRC)\umain.c
	$(CC) $(JCFLAGS) $(RTSRC)\umain.c

$(INDIR)\urgent.obj: $(RTSRC)\urgent.c
	$(CC) $(JCFLAGS) $(RTSRC)\urgent.c

$(INDIR)\update.obj: $(RTSRC)\update.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\update.c

$(INDIR)\debug.obj: $(RTSRC)\debug.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\debug.c

$(INDIR)\interp.obj: $(RTSRC)\interp.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\interp.c

$(INDIR)\eif_rw_lock.obj : $(RTSRC)\eif_rw_lock.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_rw_lock.c

$(INDIR)\wargv.obj: $(RTSRC)\argv.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\argv.c

$(INDIR)\wbench.obj: $(RTSRC)\wbench.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\wbench.c

$(INDIR)\wbits.obj: $(RTSRC)\bits.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\bits.c

$(INDIR)\wboolstr.obj: $(RTSRC)\boolstr.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\boolstr.c

$(INDIR)\wcecil.obj: $(RTSRC)\cecil.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\cecil.c

$(INDIR)\wconsole.obj: $(RTSRC)\console.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\console.c

$(INDIR)\wcopy.obj: $(RTSRC)\copy.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\copy.c

$(INDIR)\wdir.obj: $(RTSRC)\dir.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\dir.c

$(INDIR)\weif_cond_var.obj: $(RTSRC)\eif_cond_var.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_cond_var.c

$(INDIR)\weif_once.obj: $(RTSRC)\eif_once.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_once.c

$(INDIR)\weif_project.obj: $(RTSRC)\eif_project.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_project.c

$(INDIR)\weif_threads.obj: $(RTSRC)\eif_threads.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\eif_threads.c

$(INDIR)\wequal.obj: $(RTSRC)\equal.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\equal.c

$(INDIR)\werror.obj: $(RTSRC)\error.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\error.c

$(INDIR)\wexcept.obj: $(RTSRC)\except.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\except.c

$(INDIR)\wfile.obj: $(RTSRC)\file.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\file.c

$(INDIR)\wgarcol.obj: $(RTSRC)\garcol.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\garcol.c

$(INDIR)\wgen_conf.obj: $(RTSRC)\gen_conf.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\gen_conf.c

$(INDIR)\wrout_obj.obj: $(RTSRC)\rout_obj.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\rout_obj.c

$(INDIR)\whash.obj: $(RTSRC)\hash.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\hash.c

$(INDIR)\whashin.obj: $(RTSRC)\hashin.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\hashin.c

$(INDIR)\whector.obj: $(RTSRC)\hector.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\hector.c

$(INDIR)\winternal.obj: $(RTSRC)\internal.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\internal.c

$(INDIR)\wlmalloc.obj: $(RTSRC)\lmalloc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\lmalloc.c

$(INDIR)\wlocal.obj: $(RTSRC)\local.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\local.c

$(INDIR)\wmain.obj: $(RTSRC)\main.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\main.c

$(INDIR)\wmalloc.obj: $(RTSRC)\malloc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\malloc.c

$(INDIR)\wmath.obj: $(RTSRC)\math.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\math.c

$(INDIR)\wmemory.obj: $(RTSRC)\memory.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\memory.c

$(INDIR)\wmisc.obj: $(RTSRC)\misc.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\misc.c

$(INDIR)\wobject_id.obj: $(RTSRC)\object_id.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\object_id.c

$(INDIR)\woption.obj: $(RTSRC)\option.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\option.c

$(INDIR)\wout.obj: $(RTSRC)\out.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\out.c

$(INDIR)\wpath_name.obj: $(RTSRC)\path_name.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\path_name.c

$(INDIR)\wpattern.obj: $(RTSRC)\pattern.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\pattern.c

$(INDIR)\wplug.obj: $(RTSRC)\plug.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\plug.c

$(INDIR)\wretrieve.obj: $(RTSRC)\retrieve.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\retrieve.c

$(INDIR)\wrun_idr.obj: $(RTSRC)\run_idr.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\run_idr.c

$(INDIR)\wsearch.obj: $(RTSRC)\search.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\search.c

$(INDIR)\wsig.obj: $(RTSRC)\sig.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\sig.c

$(INDIR)\wstore.obj: $(RTSRC)\store.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\store.c

$(INDIR)\wstring.obj: $(RTSRC)\string.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\string.c

$(INDIR)\wtimer.obj: $(RTSRC)\timer.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\timer.c

$(INDIR)\wtools.obj: $(RTSRC)\tools.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\tools.c

$(INDIR)\wtraverse.obj: $(RTSRC)\traverse.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\traverse.c

$(INDIR)\wumain.obj: $(RTSRC)\umain.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\umain.c

$(INDIR)\wurgent.obj: $(RTSRC)\urgent.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(RTSRC)\urgent.c

$(INDIR)\x2c.obj: $(RTSRC)\x2c.c
	$(CC) $(JCFLAGS) $(RTSRC)\x2c.c

final: finalized.lib
work: wkbench.lib

$(INDIR)\bmain.obj: $(RTSRC)\main.c
	$(CC) $(JCFLAGS) -DWORKBENCH -DNOHOOK $(RTSRC)\main.c

$(INDIR)\bexcept.obj: $(RTSRC)\except.c
	$(CC) $(JCFLAGS) -DWORKBENCH -DNOHOOK $(RTSRC)\except.c

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

$(INDIR)\malloc.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

$(INDIR)\garcol.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_search.h eif_sig.h \
			eif_size.h eif_struct.h eif_timer.h eif_urgent.h

$(INDIR)\local.obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_local.h eif_malloc.h \
			eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

$(INDIR)\except.obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_sig.h eif_size.h eif_struct.h eif_urgent.h

$(INDIR)\store.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h eif_traverse.h

$(INDIR)\retrieve.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_retrieve.h eif_size.h eif_struct.h

$(INDIR)\hash.obj : eif_hash.h eif_tools.h

$(INDIR)\traverse.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h \
			eif_traverse.h

$(INDIR)\hashin.obj : eif_hashin.h eif_malloc.h eif_tools.h

$(INDIR)\tools.obj : eif_tools.h

$(INDIR)\internal.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h

$(INDIR)\plug.obj : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h eif_option.h \
			eif_out.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\copy.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hash.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h eif_traverse.h

$(INDIR)\equal.obj : eif_cecil.h eif_copy.h eif_dir.h eif_equal.h eif_except.h eif_file.h \
			eif_garcol.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_search.h eif_size.h eif_struct.h eif_tools.h eif_traverse.h

$(INDIR)\lmalloc.obj : eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

$(INDIR)\out.obj : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_sig.h eif_size.h eif_struct.h

$(INDIR)\timer.obj : eif_timer.h

$(INDIR)\urgent.obj : eif_urgent.h

$(INDIR)\sig.obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h

$(INDIR)\hector.obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

$(INDIR)\cecil.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h eif_struct.h \
			eif_tools.h

$(INDIR)\bits.obj : eif_bits.h eif_cecil.h eif_except.h eif_garcol.h eif_local.h eif_malloc.h \
			eif_plug.h eif_struct.h

$(INDIR)\file.obj : eif_cecil.h eif_copy.h eif_except.h eif_file.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\dir.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\misc.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_misc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\pattern.obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

$(INDIR)\error.obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

$(INDIR)\memory.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_struct.h

$(INDIR)\argv.obj : eif_malloc.h eif_plug.h

$(INDIR)\search.obj : eif_search.h eif_tools.h

$(INDIR)\x2c.obj : eif_size.h

$(INDIR)\debug.obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hashin.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

$(INDIR)\interp.obj : eif_bits.h eif_cecil.h eif_copy.h eif_debug.h eif_dir.h eif_except.h eif_file.h \
			eif_garcol.h eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h \
			eif_out.h eif_plug.h eif_sig.h eif_size.h eif_struct.h

$(INDIR)\option.obj : eif_option.h eif_struct.h

$(INDIR)\update.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_update.h

$(INDIR)\wbench.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_interp.h eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_wbench.h

$(INDIR)\main.obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

$(INDIR)\wmain.obj : eif_except.h eif_garcol.h main.c eif_malloc.h eif_plug.h eif_sig.h eif_struct.h \
			eif_urgent.h

$(INDIR)\object_id.obj : eif_garcol.h eif_except.h eif_hector.h

$(INDIR)\gen_conf.obj : eif_gen_conf.h eif_struct.h eif_macros.h
$(INDIR)\wgen_conf.obj : eif_gen_conf.h eif_struct.h eif_macros.h

$(INDIR)\rout_obj.obj : eif_rout_obj.h
$(INDIR)\wrout_obj.obj : eif_rout_obj.h

$(INDIR)\eif_threads.obj : eif_threads.h eif_cond_var.h
$(INDIR)\eif_cond_var.obj : eif_cond_var.h
$(INDIR)\eif_once.obj : eif_once.h eif_threads.h

$(INDIR)\weif_threads.obj : eif_threads.h eif_cond_var.h
$(INDIR)\weif_cond_var.obj : eif_cond_var.h
$(INDIR)\weif_once.obj : eif_once.h eif_threads.h
