TOP = ..
OUTDIR = .\LIB
INDIR = .\OBJDIR
RTSRC = .
CC = $cc
CTAGS = ctags
JCFLAGS = $(CFLAGS)  $ccflags $optimize /Fo"$(INDIR)\\" /Fd"$(INDIR)\\" -c 
LIB_EXE = $lib_exe
LN = copy
MAKE = $make
MV = move
RM = del
LINK32 = $link32
DLLFLAGS = $dllflags

CFLAGS = -I. -I$(TOP) -I$(TOP)/idrs -I$(TOP)/console -I$(TOP)/ipc/app
NETWORK = $(TOP)\ipc\app\network.lib

all:: "$(INDIR)" "$(OUTDIR)"

"$(INDIR)" :
    if not exist "$(INDIR)/$(NULL)" mkdir "$(INDIR)"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

LIBDIR=$(OUTDIR)
DLLDIR=$(OUTDIR)

OBJECTS = \
	"$(INDIR)\lmalloc.obj" \
	"$(INDIR)\math.obj" \
	"$(INDIR)\malloc.obj" \
	"$(INDIR)\garcol.obj" \
	"$(INDIR)\local.obj" \
	"$(INDIR)\except.obj" \
	"$(INDIR)\store.obj" \
	"$(INDIR)\retrieve.obj" \
	"$(INDIR)\hash.obj" \
	"$(INDIR)\traverse.obj" \
	"$(INDIR)\hashin.obj" \
	"$(INDIR)\tools.obj" \
	"$(INDIR)\internal.obj" \
	"$(INDIR)\plug.obj" \
	"$(INDIR)\copy.obj" \
	"$(INDIR)\equal.obj" \
	"$(INDIR)\out.obj" \
	"$(INDIR)\timer.obj" \
	"$(INDIR)\urgent.obj" \
	"$(INDIR)\sig.obj" \
	"$(INDIR)\hector.obj" \
	"$(INDIR)\cecil.obj" \
	"$(INDIR)\bits.obj" \
	"$(INDIR)\file.obj" \
	"$(INDIR)\dir.obj" \
	"$(INDIR)\string.obj" \
	"$(INDIR)\misc.obj" \
	"$(INDIR)\pattern.obj" \
	"$(INDIR)\error.obj" \
	"$(INDIR)\umain.obj" \
	"$(INDIR)\memory.obj" \
	"$(INDIR)\argv.obj" \
	"$(INDIR)\boolstr.obj" \
	"$(INDIR)\search.obj" \
	"$(INDIR)\main.obj" \
	"$(INDIR)\option.obj" \
	"$(INDIR)\console.obj" \
	"$(INDIR)\run_idr.obj" \
	"$(INDIR)\path_name.obj" \
	"$(INDIR)\object_id.obj" \
	"$(INDIR)\compress.obj" \
	"$(INDIR)\eif_threads.obj" \
	"$(INDIR)\eif_cond_var.obj" \
	"$(INDIR)\eif_once.obj" \
	"$(INDIR)\eif_project.obj" \
	"$(TOP)\ipc\shared\networku.obj" \
	"$(TOP)\ipc\shared\shword.obj" \
	"$(TOP)\console\econsole.lib" \
	$extra_object_files

WOBJECTS = \
	"$(NETWORK)" \
	"$(INDIR)\wlmalloc.obj" \
	"$(INDIR)\wmath.obj" \
	"$(INDIR)\wmalloc.obj" \
	"$(INDIR)\wgarcol.obj" \
	"$(INDIR)\wlocal.obj" \
	"$(INDIR)\wexcept.obj" \
	"$(INDIR)\wstore.obj" \
	"$(INDIR)\wretrieve.obj" \
	"$(INDIR)\whash.obj" \
	"$(INDIR)\wtravers.obj" \
	"$(INDIR)\whashin.obj" \
	"$(INDIR)\wtools.obj" \
	"$(INDIR)\winterna.obj" \
	"$(INDIR)\wplug.obj" \
	"$(INDIR)\wcopy.obj" \
	"$(INDIR)\wequal.obj" \
	"$(INDIR)\wout.obj" \
	"$(INDIR)\wtimer.obj" \
	"$(INDIR)\wurgent.obj" \
	"$(INDIR)\wsig.obj" \
	"$(INDIR)\whector.obj" \
	"$(INDIR)\wcecil.obj" \
	"$(INDIR)\wbits.obj" \
	"$(INDIR)\wfile.obj" \
	"$(INDIR)\wdir.obj" \
	"$(INDIR)\wstring.obj" \
	"$(INDIR)\wmisc.obj" \
	"$(INDIR)\wpattern.obj" \
	"$(INDIR)\werror.obj" \
	"$(INDIR)\wumain.obj" \
	"$(INDIR)\wmemory.obj" \
	"$(INDIR)\wargv.obj" \
	"$(INDIR)\wboolstr.obj" \
	"$(INDIR)\wsearch.obj" \
	"$(INDIR)\wmain.obj" \
	"$(INDIR)\debug.obj" \
	"$(INDIR)\interp.obj" \
	"$(INDIR)\woption.obj" \
	"$(INDIR)\update.obj" \
	"$(INDIR)\wbench.obj" \
	"$(INDIR)\wconsole.obj" \
	"$(INDIR)\wrun_idr.obj" \
	"$(INDIR)\wpath_name.obj" \
	"$(INDIR)\wobject_id.obj" \
	"$(INDIR)\compress.obj" \
	"$(INDIR)\weif_threads.obj" \
	"$(INDIR)\weif_cond_var.obj" \
	"$(INDIR)\weif_once.obj" \
	"$(INDIR)\weif_project.obj" \
	"$(TOP)\idrs\idr.lib" \
	"$(TOP)\console\econsole.lib" \
	$extra_object_files

EOBJECTS = \
	"$(INDIR)\wlmalloc.obj" \
	"$(INDIR)\wmath.obj" \
	"$(INDIR)\wmalloc.obj" \
	"$(INDIR)\wgarcol.obj" \
	"$(INDIR)\wlocal.obj" \
	"$(INDIR)\bexcept.obj" \
	"$(INDIR)\wstore.obj" \
	"$(INDIR)\wretrieve.obj" \
	"$(INDIR)\whash.obj" \
	"$(INDIR)\wtravers.obj" \
	"$(INDIR)\whashin.obj" \
	"$(INDIR)\wtools.obj" \
	"$(INDIR)\winterna.obj" \
	"$(INDIR)\wplug.obj" \
	"$(INDIR)\wcopy.obj" \
	"$(INDIR)\wequal.obj" \
	"$(INDIR)\wout.obj" \
	"$(INDIR)\wtimer.obj" \
	"$(INDIR)\wurgent.obj" \
	"$(INDIR)\wsig.obj" \
	"$(INDIR)\whector.obj" \
	"$(INDIR)\wcecil.obj" \
	"$(INDIR)\wbits.obj" \
	"$(INDIR)\wfile.obj" \
	"$(INDIR)\wdir.obj" \
	"$(INDIR)\wstring.obj" \
	"$(INDIR)\wmisc.obj" \
	"$(INDIR)\wpattern.obj" \
	"$(INDIR)\werror.obj" \
	"$(INDIR)\wumain.obj" \
	"$(INDIR)\wmemory.obj" \
	"$(INDIR)\wargv.obj" \
	"$(INDIR)\wboolstr.obj" \
	"$(INDIR)\wsearch.obj" \
	"$(INDIR)\bmain.obj" \
	"$(INDIR)\debug.obj" \
	"$(INDIR)\interp.obj" \
	"$(INDIR)\woption.obj" \
	"$(INDIR)\update.obj" \
	"$(INDIR)\wbench.obj" \
	"$(INDIR)\wconsole.obj" \
	"$(INDIR)\wrun_idr.obj" \
	"$(INDIR)\wpath_name.obj" \
	"$(INDIR)\wobject_id.obj" \
	"$(INDIR)\compress.obj" \
	"$(INDIR)\weif_threads.obj" \
	"$(INDIR)\weif_cond_var.obj" \
	"$(INDIR)\weif_once.obj" \
	"$(INDIR)\weif_project.obj" \
	"$(TOP)\ipc\shared\networku.obj" \
	"$(TOP)\console\econsole.lib"

all:: eif_size.h


all:: finalized.lib

finalized.lib: $(OBJECTS)
	$link_line

all:: wkbench.lib

wkbench.lib: $(WOBJECTS)
	$link_wline



dll:: wkbench.dll

DEF_FILE= "wkbench.def"
LINK32_FLAGS= kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
		advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib wsock32.lib \
	$(DLLFLAGS) \
	/def:"$(DEF_FILE)" \
	/OUT:"$(DLLDIR)\wkbench.dll" /IMPLIB:"$(DLLDIR)\dll_wkbench.lib"

LINK32_OBJS= $(WOBJECTS)
"wkbench.dll" : "$(DLLDIR)" $(DEF_FILE) $(LINK32_OBJS)
	$(RM) "$(DLLDIR)\wkbench.dll"
    $(LINK32) @<<
    $(LINK32_FLAGS) $(LINK32_OBJS)
<<

dll:: finalized.dll

DEF_FILE= "finalized.def"
LINK32_FLAGS= kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
		advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib wsock32.lib \
	$(DLLFLAGS) \
	/def:"$(DEF_FILE)" \
	/OUT:"$(DLLDIR)\finalized.dll" /IMPLIB:"$(DLLDIR)\dll_finalized.lib"

LINK32_OBJS= $(OBJECTS)
"finalized.dll" : "$(DLLDIR)" $(DEF_FILE) $(LINK32_OBJS)
	$(RM) "$(DLLDIR)\finalized.dll"
    $(LINK32) @<<
    $(LINK32_FLAGS) $(LINK32_OBJS)
<<


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
# W__FILES
###################

"$(RTSRC)\wmath.c" : math.c
	$(LN) math.c wmath.c

"$(RTSRC)\wmalloc.c" : malloc.c
	$(LN) malloc.c wmalloc.c

"$(RTSRC)\wgarcol.c" : garcol.c
	$(LN) garcol.c wgarcol.c

"$(RTSRC)\weif_threads.c" : eif_threads.c
	$(LN) eif_threads.c weif_threads.c

"$(RTSRC)\weif_cond_var.c" : eif_cond_var.c
	$(LN) eif_cond_var.c weif_cond_var.c

"$(RTSRC)\weif_once.c" : eif_once.c
	$(LN) eif_once.c weif_once.c

"$(RTSRC)\wlocal.c" : local.c
	$(LN) local.c wlocal.c

"$(RTSRC)\wexcept.c" : except.c
	$(LN) except.c wexcept.c

"$(RTSRC)\wstore.c" : store.c
	$(LN) store.c wstore.c

"$(RTSRC)\wrun_idr.c" : run_idr.c
	$(LN) run_idr.c wrun_idr.c

"$(RTSRC)\wretrieve.c" : retrieve.c
	$(LN) retrieve.c wretrieve.c

"$(RTSRC)\whash.c" : hash.c
	$(LN) hash.c whash.c

"$(RTSRC)\wtravers.c" : traverse.c
	$(LN) traverse.c wtravers.c

"$(RTSRC)\whashin.c" : hashin.c
	$(LN) hashin.c whashin.c

"$(RTSRC)\wtools.c" : tools.c
	$(LN) tools.c wtools.c

"$(RTSRC)\winterna.c" : internal.c
	$(LN) internal.c winterna.c

"$(RTSRC)\wpath_name.c" : path_name.c
	$(LN) path_name.c wpath_name.c

"$(RTSRC)\wplug.c" : plug.c
	$(LN) plug.c wplug.c

"$(RTSRC)\wcopy.c" : copy.c
	$(LN) copy.c wcopy.c

"$(RTSRC)\wequal.c" : equal.c
	$(LN) equal.c wequal.c

"$(RTSRC)\wlmalloc.c" : lmalloc.c
	$(LN) lmalloc.c wlmalloc.c

"$(RTSRC)\wout.c" : out.c
	$(LN) out.c wout.c

"$(RTSRC)\wtimer.c" : timer.c
	$(LN) timer.c wtimer.c

"$(RTSRC)\wurgent.c" : urgent.c
	$(LN) urgent.c wurgent.c

"$(RTSRC)\wsig.c" : sig.c
	$(LN) sig.c wsig.c

"$(RTSRC)\whector.c" : hector.c
	$(LN) hector.c whector.c

"$(RTSRC)\wcecil.c" : cecil.c
	$(LN) cecil.c wcecil.c

"$(RTSRC)\wbits.c" : bits.c
	$(LN) bits.c wbits.c

"$(RTSRC)\wconsole.c" : console.c
	$(LN) console.c wconsole.c

"$(RTSRC)\wfile.c" : file.c
	$(LN) file.c wfile.c

"$(RTSRC)\wdir.c" : dir.c
	$(LN) dir.c wdir.c

"$(RTSRC)\wstring.c" : string.c
	$(LN) string.c wstring.c

"$(RTSRC)\wmisc.c" : misc.c
	$(LN) misc.c wmisc.c

"$(RTSRC)\wpattern.c" : pattern.c
	$(LN) pattern.c wpattern.c

"$(RTSRC)\werror.c" : error.c
	$(LN) error.c werror.c

"$(RTSRC)\wumain.c" : umain.c
	$(LN) umain.c wumain.c

"$(RTSRC)\wmemory.c" : memory.c
	$(LN) memory.c wmemory.c

"$(RTSRC)\woption.c" : option.c
	$(LN) option.c woption.c

"$(RTSRC)\wargv.c" : argv.c
	$(LN) argv.c wargv.c

"$(RTSRC)\wboolstr.c" : boolstr.c
	$(LN) boolstr.c wboolstr.c

"$(RTSRC)\wsearch.c" : search.c
	$(LN) search.c wsearch.c

"$(RTSRC)\wmain.c" : main.c
	$(LN) main.c wmain.c

"$(RTSRC)\wobject_id.c" : object_id.c
	$(LN) object_id.c wobject_id.c

"$(RTSRC)\weif_project.c" : eif_project.c
	$(LN) eif_project.c weif_project.c

###################
# OBJECTS
###################

"$(INDIR)\argv.obj" :	"$(RTSRC)\argv.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\argv.c"

"$(INDIR)\bits.obj" :	"$(RTSRC)\bits.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\bits.c"

"$(INDIR)\boolstr.obj" :	"$(RTSRC)\boolstr.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\boolstr.c"

"$(INDIR)\cecil.obj" :	"$(RTSRC)\cecil.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\cecil.c"

"$(INDIR)\compress.obj" :	"$(RTSRC)\compress.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\compress.c"

"$(INDIR)\console.obj" :	"$(RTSRC)\console.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\console.c"

"$(INDIR)\copy.obj" :	"$(RTSRC)\copy.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\copy.c"

"$(INDIR)\dir.obj" :	"$(RTSRC)\dir.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\dir.c"

"$(INDIR)\eif_cond_var.obj" :	"$(RTSRC)\eif_cond_var.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\eif_cond_var.c"

"$(INDIR)\eif_once.obj" :	"$(RTSRC)\eif_once.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\eif_once.c"

"$(INDIR)\eif_project.obj" :	"$(RTSRC)\eif_project.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\eif_project.c"

"$(INDIR)\eif_threads.obj" :	"$(RTSRC)\eif_threads.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\eif_threads.c"

"$(INDIR)\equal.obj" :	"$(RTSRC)\equal.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\equal.c"

"$(INDIR)\error.obj" :	"$(RTSRC)\error.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\error.c"

"$(INDIR)\except.obj" :	"$(RTSRC)\except.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\except.c"

"$(INDIR)\file.obj" :	"$(RTSRC)\file.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\file.c"

"$(INDIR)\garcol.obj" :	"$(RTSRC)\garcol.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\garcol.c"

"$(INDIR)\hash.obj" :	"$(RTSRC)\hash.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\hash.c"

"$(INDIR)\hashin.obj" :	"$(RTSRC)\hashin.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\hashin.c"

"$(INDIR)\hector.obj" :	"$(RTSRC)\hector.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\hector.c"

"$(INDIR)\internal.obj" :	"$(RTSRC)\internal.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\internal.c"

"$(INDIR)\lmalloc.obj" :	"$(RTSRC)\lmalloc.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\lmalloc.c"

"$(INDIR)\local.obj" :	"$(RTSRC)\local.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\local.c"

"$(INDIR)\main.obj" :	"$(RTSRC)\main.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\main.c"

"$(INDIR)\malloc.obj" :	"$(RTSRC)\malloc.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\malloc.c"

"$(INDIR)\math.obj" :	"$(RTSRC)\math.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\math.c"

"$(INDIR)\memory.obj" :	"$(RTSRC)\memory.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\memory.c"

"$(INDIR)\misc.obj" :	"$(RTSRC)\misc.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\misc.c"

"$(INDIR)\object_id.obj" :	"$(RTSRC)\object_id.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\object_id.c"

"$(INDIR)\option.obj" :	"$(RTSRC)\option.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\option.c"

"$(INDIR)\out.obj" :	"$(RTSRC)\out.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\out.c"

"$(INDIR)\path_name.obj" :	"$(RTSRC)\path_name.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\path_name.c"

"$(INDIR)\pattern.obj" :	"$(RTSRC)\pattern.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\pattern.c"

"$(INDIR)\plug.obj" :	"$(RTSRC)\plug.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\plug.c"

"$(INDIR)\retrieve.obj" :	"$(RTSRC)\retrieve.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\retrieve.c"

"$(INDIR)\run_idr.obj" :	"$(RTSRC)\run_idr.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\run_idr.c"

"$(INDIR)\search.obj" :	"$(RTSRC)\search.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\search.c"

"$(INDIR)\sig.obj" :	"$(RTSRC)\sig.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\sig.c"

"$(INDIR)\store.obj" :	"$(RTSRC)\store.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\store.c"

"$(INDIR)\string.obj" :	"$(RTSRC)\string.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\string.c"

"$(INDIR)\timer.obj" :	"$(RTSRC)\timer.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\timer.c"

"$(INDIR)\tools.obj" :	"$(RTSRC)\tools.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\tools.c"

"$(INDIR)\traverse.obj" :	"$(RTSRC)\traverse.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\traverse.c"

"$(INDIR)\umain.obj" :	"$(RTSRC)\umain.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\umain.c"

"$(INDIR)\urgent.obj" :	"$(RTSRC)\urgent.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\urgent.c"

"$(INDIR)\update.obj" :	"$(RTSRC)\update.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\update.c"

"$(INDIR)\debug.obj" :	"$(RTSRC)\debug.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\debug.c"

"$(INDIR)\interp.obj" :	"$(RTSRC)\interp.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\interp.c"

"$(INDIR)\wargv.obj" :	"$(RTSRC)\wargv.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wargv.c"

"$(INDIR)\wbench.obj" :	"$(RTSRC)\wbench.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wbench.c"

"$(INDIR)\wbits.obj" :	"$(RTSRC)\wbits.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wbits.c"

"$(INDIR)\wboolstr.obj" :	"$(RTSRC)\wboolstr.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wboolstr.c"

"$(INDIR)\wcecil.obj" :	"$(RTSRC)\wcecil.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wcecil.c"

"$(INDIR)\wconsole.obj" :	"$(RTSRC)\wconsole.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wconsole.c"

"$(INDIR)\wcopy.obj" :	"$(RTSRC)\wcopy.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wcopy.c"

"$(INDIR)\wdir.obj" :	"$(RTSRC)\wdir.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wdir.c"

"$(INDIR)\weif_cond_var.obj" :	"$(RTSRC)\weif_cond_var.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\weif_cond_var.c"

"$(INDIR)\weif_once.obj" :	"$(RTSRC)\weif_once.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\weif_once.c"

"$(INDIR)\weif_project.obj" :	"$(RTSRC)\weif_project.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\weif_project.c"

"$(INDIR)\weif_threads.obj" :	"$(RTSRC)\weif_threads.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\weif_threads.c"

"$(INDIR)\wequal.obj" :	"$(RTSRC)\wequal.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wequal.c"

"$(INDIR)\werror.obj" :	"$(RTSRC)\werror.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\werror.c"

"$(INDIR)\wexcept.obj" :	"$(RTSRC)\wexcept.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wexcept.c"

"$(INDIR)\wfile.obj" :	"$(RTSRC)\wfile.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wfile.c"

"$(INDIR)\wgarcol.obj" :	"$(RTSRC)\wgarcol.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wgarcol.c"

"$(INDIR)\whash.obj" :	"$(RTSRC)\whash.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\whash.c"

"$(INDIR)\whashin.obj" :	"$(RTSRC)\whashin.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\whashin.c"

"$(INDIR)\whector.obj" :	"$(RTSRC)\whector.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\whector.c"

"$(INDIR)\winterna.obj" :	"$(RTSRC)\winterna.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\winterna.c"

"$(INDIR)\wlmalloc.obj" :	"$(RTSRC)\wlmalloc.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wlmalloc.c"

"$(INDIR)\wlocal.obj" :	"$(RTSRC)\wlocal.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wlocal.c"

"$(INDIR)\wmain.obj" :	"$(RTSRC)\wmain.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wmain.c"

"$(INDIR)\wmalloc.obj" :	"$(RTSRC)\wmalloc.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wmalloc.c"

"$(INDIR)\wmath.obj" :	"$(RTSRC)\wmath.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wmath.c"

"$(INDIR)\wmemory.obj" :	"$(RTSRC)\wmemory.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wmemory.c"

"$(INDIR)\wmisc.obj" :	"$(RTSRC)\wmisc.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wmisc.c"

"$(INDIR)\wobject_id.obj" :	"$(RTSRC)\wobject_id.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wobject_id.c"

"$(INDIR)\woption.obj" :	"$(RTSRC)\woption.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\woption.c"

"$(INDIR)\wout.obj" :	"$(RTSRC)\wout.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wout.c"

"$(INDIR)\wpath_name.obj" :	"$(RTSRC)\wpath_name.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wpath_name.c"

"$(INDIR)\wpattern.obj" :	"$(RTSRC)\wpattern.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wpattern.c"

"$(INDIR)\wplug.obj" :	"$(RTSRC)\wplug.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wplug.c"

"$(INDIR)\wretrieve.obj" :	"$(RTSRC)\wretrieve.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wretrieve.c"

"$(INDIR)\wrun_idr.obj" :	"$(RTSRC)\wrun_idr.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wrun_idr.c"

"$(INDIR)\wsearch.obj" :	"$(RTSRC)\wsearch.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wsearch.c"

"$(INDIR)\wsig.obj" :	"$(RTSRC)\wsig.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wsig.c"

"$(INDIR)\wstore.obj" :	"$(RTSRC)\wstore.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wstore.c"

"$(INDIR)\wstring.obj" :	"$(RTSRC)\wstring.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wstring.c"

"$(INDIR)\wtimer.obj" :	"$(RTSRC)\wtimer.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wtimer.c"

"$(INDIR)\wtools.obj" :	"$(RTSRC)\wtools.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wtools.c"

"$(INDIR)\wtravers.obj" :	"$(RTSRC)\wtravers.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wtravers.c"

"$(INDIR)\wumain.obj" :	"$(RTSRC)\wumain.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wumain.c"

"$(INDIR)\wurgent.obj" :	"$(RTSRC)\wurgent.c"
	$(CC) $(JCFLAGS) -DWORKBENCH "$(RTSRC)\wurgent.c"

"$(INDIR)\x2c.obj" :	"$(RTSRC)\x2c.c"
	$(CC) $(JCFLAGS) "$(RTSRC)\x2c.c"


final: finalized.lib
work: wkbench.lib

"$(RTSRC)\bmain.c" : main.c
	$(LN) main.c bmain.c

"$(INDIR)\bmain.obj" :	"$(RTSRC)\bmain.c"
	$(CC) $(JCFLAGS) -DWORKBENCH -DNOHOOK "$(RTSRC)\bmain.c"

"$(RTSRC)\bexcept.c" : except.c
	$(LN) except.c bexcept.c

"$(INDIR)\bexcept.obj" :	"$(RTSRC)\bexcept.c"
	$(CC) $(JCFLAGS) -DWORKBENCH -DNOHOOK "$(RTSRC)\bexcept.c"


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

"$(INDIR)\malloc.obj" : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

"$(INDIR)\garcol.obj" : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_search.h eif_sig.h \
			eif_size.h eif_struct.h eif_timer.h eif_urgent.h

"$(INDIR)\local.obj" : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_local.h eif_malloc.h \
			eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

"$(INDIR)\except.obj" : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_sig.h eif_size.h eif_struct.h eif_urgent.h

"$(INDIR)\store.obj" : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h eif_traverse.h

"$(INDIR)\retrieve.obj" : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_retrieve.h eif_size.h eif_struct.h

"$(INDIR)\hash.obj" : eif_hash.h eif_tools.h

"$(INDIR)\traverse.obj" : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h \
			eif_traverse.h

"$(INDIR)\hashin.obj" : eif_hashin.h eif_malloc.h eif_tools.h

"$(INDIR)\tools.obj" : eif_tools.h

"$(INDIR)\internal.obj" : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h

"$(INDIR)\plug.obj" : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h eif_option.h \
			eif_out.h eif_plug.h eif_size.h eif_struct.h

"$(INDIR)\copy.obj" : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hash.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h eif_traverse.h

"$(INDIR)\equal.obj" : eif_cecil.h eif_copy.h eif_dir.h eif_equal.h eif_except.h eif_file.h \
			eif_garcol.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_search.h eif_size.h eif_struct.h eif_tools.h eif_traverse.h

"$(INDIR)\lmalloc.obj" : eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

"$(INDIR)\out.obj" : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_sig.h eif_size.h eif_struct.h

"$(INDIR)\timer.obj" : eif_timer.h

"$(INDIR)\urgent.obj" : eif_urgent.h

"$(INDIR)\sig.obj" : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h

"$(INDIR)\hector.obj" : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

"$(INDIR)\cecil.obj" : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h eif_struct.h \
			eif_tools.h

"$(INDIR)\bits.obj" : eif_bits.h eif_cecil.h eif_except.h eif_garcol.h eif_local.h eif_malloc.h \
			eif_plug.h eif_struct.h

"$(INDIR)\file.obj" : eif_cecil.h eif_copy.h eif_except.h eif_file.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

"$(INDIR)\dir.obj" : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

"$(INDIR)\misc.obj" : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_misc.h eif_plug.h eif_size.h eif_struct.h

"$(INDIR)\pattern.obj" : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

"$(INDIR)\error.obj" : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

"$(INDIR)\memory.obj" : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_struct.h

"$(INDIR)\argv.obj" : eif_malloc.h eif_plug.h

"$(INDIR)\search.obj" : eif_search.h eif_tools.h

"$(INDIR)\x2c.obj" : eif_size.h

"$(INDIR)\debug.obj" : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hashin.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

"$(INDIR)\interp.obj" : eif_bits.h eif_cecil.h eif_copy.h eif_debug.h eif_dir.h eif_except.h eif_file.h \
			eif_garcol.h eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h \
			eif_out.h eif_plug.h eif_sig.h eif_size.h eif_struct.h

"$(INDIR)\option.obj" : eif_option.h eif_struct.h

"$(INDIR)\update.obj" : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_update.h

"$(INDIR)\wbench.obj" : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_interp.h eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_wbench.h

"$(INDIR)\main.obj" : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

"$(INDIR)\wmain.obj" : eif_except.h eif_garcol.h main.c eif_malloc.h eif_plug.h eif_sig.h eif_struct.h \
			eif_urgent.h

"$(INDIR)\object_id.obj" : eif_garcol.h eif_except.h eif_hector.h

"$(INDIR)\eif_threads.obj" : eif_threads.h eif_cond_var.h
"$(INDIR)\eif_cond_var.obj" : eif_cond_var.h
"$(INDIR)\eif_once.obj" : eif_once.h eif_threads.h

"$(INDIR)\weif_threads.obj" : eif_threads.h eif_cond_var.h
"$(INDIR)\weif_cond_var.obj" : eif_cond_var.h
"$(INDIR)\weif_once.obj" : eif_once.h eif_threads.h
