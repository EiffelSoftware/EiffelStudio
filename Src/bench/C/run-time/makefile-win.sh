TOP = ..
CC = $cc
CTAGS = ctags
JCFLAGS = $(CFLAGS) -c $ccflags $optimize
LIB_EXE = $lib_exe
LN = copy
MAKE = $make
MV = move
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

CFLAGS = -I. -I$(TOP) -I$(TOP)/idrs -I$(TOP)/console -I$(TOP)/ipc/app

NETWORK = $(TOP)\ipc\app\network.lib

OBJECTS = lmalloc.obj math.obj malloc.obj garcol.obj local.obj except.obj store.obj \
	retrieve.obj hash.obj traverse.obj hashin.obj tools.obj internal.obj \
	plug.obj copy.obj equal.obj out.obj timer.obj urgent.obj \
	sig.obj hector.obj cecil.obj bits.obj file.obj dir.obj string.obj \
	misc.obj pattern.obj error.obj umain.obj memory.obj argv.obj \
	boolstr.obj search.obj main.obj dle.obj option.obj \
	console.obj run_idr.obj  $(TOP)\ipc\shared\networku.obj \
	path_name.obj object_id.obj $(TOP)\console\econsole.lib \
	compress.obj eif_threads.obj eif_cond_var.obj $extra_object_files

WOBJECTS = $(NETWORK) wlmalloc.obj wmath.obj wmalloc.obj wgarcol.obj wlocal.obj wexcept.obj \
	wstore.obj wretrieve.obj whash.obj wtravers.obj whashin.obj wtools.obj \
	winterna.obj wplug.obj wcopy.obj wequal.obj wout.obj \
	wtimer.obj wurgent.obj wsig.obj whector.obj wcecil.obj wbits.obj \
	wfile.obj wdir.obj wstring.obj wmisc.obj wpattern.obj werror.obj \
	wumain.obj wmemory.obj wargv.obj wboolstr.obj wsearch.obj wmain.obj \
	debug.obj interp.obj woption.obj update.obj wbench.obj  \
	wconsole.obj wrun_idr.obj wdle.obj $(TOP)\idrs\idr.lib wpath_name.obj \
	wobject_id.obj $(TOP)\console\econsole.lib \
	compress.obj weif_threads.obj weif_cond_var.obj $extra_object_files

EOBJECTS = wlmalloc.obj wmath.obj wmalloc.obj wgarcol.obj wlocal.obj bexcept.obj wstore.obj \
	wretrieve.obj whash.obj wtravers.obj whashin.obj wtools.obj winterna.obj \
	wplug.obj wcopy.obj wequal.obj wout.obj wtimer.obj \
	wurgent.obj wsig.obj whector.obj wcecil.obj wbits.obj wfile.obj wdir.obj \
	wstring.obj wmisc.obj wpattern.obj werror.obj wumain.obj wmemory.obj \
	wargv.obj wboolstr.obj wsearch.obj bmain.obj debug.obj interp.obj \
	woption.obj update.obj wbench.obj wconsole.obj wrun_idr.obj \
	$(TOP)\ipc\shared\networku.obj wdle.obj \
	wpath_name.obj wobject_id.obj $(TOP)\console\econsole.lib \
	compress.obj weif_threads.obj weif_cond_var.obj

all:: eif_size.h

all:: finalized.lib

finalized.lib: $(OBJECTS)
	$(RM) $@
	$link_line

all:: wkbench.lib

wkbench.lib: $(WOBJECTS)
	$(RM) $@
	$link_wline

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
	$(RM) $@
	$link_eline

all:: x2c.exe

x2c.exe: x2c.c
	$(RM) $@
	$(CC) x2c.c

all:: eif_config.h eif_portable.h

eif_config.h : $(TOP)\eif_config.h
	$(RM) $@
	$(LN) $(TOP)\eif_config.h .

eif_portable.h : $(TOP)\eif_portable.h
	$(RM) $@
	$(LN) $(TOP)\eif_portable.h .

wmath.c : math.c
	$(RM) wmath.c
	$(LN) math.c wmath.c

wmalloc.c : malloc.c
	$(RM) wmalloc.c
	$(LN) malloc.c wmalloc.c

wgarcol.c : garcol.c
	$(RM) wgarcol.c
	$(LN) garcol.c wgarcol.c

weif_threads.c : eif_threads.c
	$(RM) weif_threads.c
	$(LN) eif_threads.c weif_threads.c

weif_cond_var.c : eif_cond_var.c
	$(RM) weif_cond_var.c
	$(LN) eif_cond_var.c weif_cond_var.c

wlocal.c : local.c
	$(RM) wlocal.c
	$(LN) local.c wlocal.c

wexcept.c : except.c
	$(RM) wexcept.c
	$(LN) except.c wexcept.c

wstore.c : store.c
	$(RM) wstore.c
	$(LN) store.c wstore.c

wrun_idr.c : run_idr.c
	$(RM) wrun_idr.c
	$(LN) run_idr.c wrun_idr.c

wretrieve.c : retrieve.c
	$(RM) wretriev.c
	$(LN) retrieve.c wretrieve.c

whash.c : hash.c
	$(RM) whash.c
	$(LN) hash.c whash.c

wtravers.c : traverse.c
	$(RM) wtravers.c
	$(LN) traverse.c wtravers.c

whashin.c : hashin.c
	$(RM) whashin.c
	$(LN) hashin.c whashin.c

wtools.c : tools.c
	$(RM) wtools.c
	$(LN) tools.c wtools.c

winterna.c : internal.c
	$(RM) winterna.c
	$(LN) internal.c winterna.c

wpath_name.c : path_name.c
	$(RM) wpath_name.c
	$(LN) path_name.c wpath_name.c

wplug.c : plug.c
	$(RM) wplug.c
	$(LN) plug.c wplug.c

wcopy.c : copy.c
	$(RM) wcopy.c
	$(LN) copy.c wcopy.c

wequal.c : equal.c
	$(RM) wequal.c
	$(LN) equal.c wequal.c

wlmalloc.c : lmalloc.c
	$(RM) wlmalloc.c
	$(LN) lmalloc.c wlmalloc.c

wout.c : out.c
	$(RM) wout.c
	$(LN) out.c wout.c

wtimer.c : timer.c
	$(RM) wtimer.c
	$(LN) timer.c wtimer.c

wurgent.c : urgent.c
	$(RM) wurgent.c
	$(LN) urgent.c wurgent.c

wsig.c : sig.c
	$(RM) wsig.c
	$(LN) sig.c wsig.c

whector.c : hector.c
	$(RM) whector.c
	$(LN) hector.c whector.c

wcecil.c : cecil.c
	$(RM) wcecil.c
	$(LN) cecil.c wcecil.c

wbits.c : bits.c
	$(RM) wbits.c
	$(LN) bits.c wbits.c

wconsole.c : console.c
	$(RM) wconsole.c
	$(LN) console.c wconsole.c

wfile.c : file.c
	$(RM) wfile.c
	$(LN) file.c wfile.c

wdir.c : dir.c
	$(RM) wdir.c
	$(LN) dir.c wdir.c

wstring.c : string.c
	$(RM) wstring.c
	$(LN) string.c wstring.c

wmisc.c : misc.c
	$(RM) wmisc.c
	$(LN) misc.c wmisc.c

wpattern.c : pattern.c
	$(RM) wpattern.c
	$(LN) pattern.c wpattern.c

werror.c : error.c
	$(RM) werror.c
	$(LN) error.c werror.c

wumain.c : umain.c
	$(RM) wumain.c
	$(LN) umain.c wumain.c

wmemory.c : memory.c
	$(RM) wmemory.c
	$(LN) memory.c wmemory.c

woption.c : option.c
	$(RM) woption.c
	$(LN) option.c woption.c

wargv.c : argv.c
	$(RM) wargv.c
	$(LN) argv.c wargv.c

wboolstr.c : boolstr.c
	$(RM) wboolstr.c
	$(LN) boolstr.c wboolstr.c

wsearch.c : search.c
	$(RM) wsearch.c
	$(LN) search.c wsearch.c

wmain.c : main.c
	$(RM) wmain.c
	$(LN) main.c wmain.c

wobject_id.c : object_id.c
	$(RM) wobject_id.c
	$(LN) object_id.c wobject_id.c

wdle.c : dle.c
	$(RM) wdle.c
	$(LN) dle.c wdle.c

wmath.obj : wmath.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wmalloc.obj : wmalloc.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wgarcol.obj : wgarcol.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

weif_threads.obj : weif_threads.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

weif_cond_var.obj : weif_cond_var.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wlocal.obj : wlocal.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wexcept.obj : wexcept.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wrun_idr.obj : wrun_idr.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wstore.obj : wstore.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wretrieve.obj : wretrieve.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

whash.obj : whash.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wtravers.obj : wtravers.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

whashin.obj : whashin.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wtools.obj : wtools.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

winterna.obj : winterna.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wplug.obj : wplug.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wpath_name.obj : wpath_name.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wcopy.obj : wcopy.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wequal.obj : wequal.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wlmalloc.obj : wlmalloc.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wout.obj : wout.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wtimer.obj : wtimer.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wurgent.obj : wurgent.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wsig.obj : wsig.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

whector.obj : whector.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wcecil.obj : wcecil.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wbits.obj : wbits.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wfile.obj : wfile.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wdir.obj : wdir.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wstring.obj : wstring.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wmisc.obj : wmisc.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wpattern.obj : wpattern.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

werror.obj : werror.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wumain.obj : wumain.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wmemory.obj : wmemory.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wargv.obj : wargv.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wboolstr.obj : wboolstr.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wsearch.obj : wsearch.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wconsole.obj : wconsole.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wmain.obj : wmain.c eif_struct.h
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wobject_id.obj : wobject_id.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

debug.obj : debug.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

interp.obj : interp.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

update.obj : update.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wbench.obj : wbench.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

wdle.obj : wdle.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

woption.obj : woption.c
	$(CC)  $(JCFLAGS) -DWORKBENCH $*.c

final: finalized.lib
work: wkbench.lib

bmain.c : main.c
	$(RM) bmain.c
	$(LN) main.c bmain.c

bmain.obj : bmain.c
	$(CC)  $(JCFLAGS) -DWORKBENCH -DNOHOOK $*.c

bexcept.c : except.c
	$(RM) bexcept.c
	$(LN) except.c bexcept.c

bexcept.obj : bexcept.c
	$(CC)  $(JCFLAGS) -DWORKBENCH -DNOHOOK $*.c

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

math.obj : eif_config.h
math.obj : math.c
math.obj : eif_portable.h
malloc.obj : eif_cecil.h
malloc.obj : eif_config.h
malloc.obj : eif_copy.h
malloc.obj : eif_dir.h
malloc.obj : eif_eiffel.h
malloc.obj : eif_except.h
malloc.obj : eif_file.h
malloc.obj : eif_garcol.h
malloc.obj : eif_hector.h
malloc.obj : eif_local.h
malloc.obj : eif_macros.h
malloc.obj : malloc.c
malloc.obj : eif_malloc.h
malloc.obj : eif_out.h
malloc.obj : eif_plug.h
malloc.obj : eif_portable.h
malloc.obj : eif_sig.h
malloc.obj : eif_size.h
malloc.obj : eif_struct.h
garcol.obj : eif_cecil.h
garcol.obj : eif_config.h
garcol.obj : eif_copy.h
garcol.obj : eif_dir.h
garcol.obj : eif_eiffel.h
garcol.obj : eif_except.h
garcol.obj : eif_file.h
garcol.obj : garcol.c
garcol.obj : eif_garcol.h
garcol.obj : eif_hector.h
garcol.obj : eif_local.h
garcol.obj : eif_macros.h
garcol.obj : eif_malloc.h
garcol.obj : eif_out.h
garcol.obj : eif_plug.h
garcol.obj : eif_portable.h
garcol.obj : eif_search.h
garcol.obj : eif_sig.h
garcol.obj : eif_size.h
garcol.obj : eif_struct.h
garcol.obj : eif_timer.h
garcol.obj : eif_urgent.h
local.obj : eif_cecil.h
local.obj : eif_config.h
local.obj : eif_except.h
local.obj : eif_garcol.h
local.obj : eif_hector.h
local.obj : local.c
local.obj : eif_local.h
local.obj : eif_malloc.h
local.obj : eif_plug.h
local.obj : eif_portable.h
local.obj : eif_sig.h
local.obj : eif_struct.h
local.obj : eif_urgent.h
except.obj : eif_cecil.h
except.obj : eif_config.h
except.obj : eif_copy.h
except.obj : eif_debug.h
except.obj : except.c
except.obj : eif_except.h
except.obj : eif_garcol.h
except.obj : eif_hector.h
except.obj : eif_local.h
except.obj : eif_macros.h
except.obj : eif_malloc.h
except.obj : eif_plug.h
except.obj : eif_portable.h
except.obj : eif_sig.h
except.obj : eif_size.h
except.obj : eif_struct.h
except.obj : eif_urgent.h
store.obj : eif_cecil.h
store.obj : eif_config.h
store.obj : eif_copy.h
store.obj : eif_except.h
store.obj : eif_garcol.h
store.obj : eif_hector.h
store.obj : eif_local.h
store.obj : eif_macros.h
store.obj : eif_malloc.h
store.obj : eif_plug.h
store.obj : eif_portable.h
store.obj : eif_size.h
store.obj : store.c
store.obj : eif_store.h
store.obj : eif_struct.h
store.obj : eif_traverse.h
retrieve.obj : eif_cecil.h
retrieve.obj : eif_config.h
retrieve.obj : eif_copy.h
retrieve.obj : eif_except.h
retrieve.obj : eif_garcol.h
retrieve.obj : eif_hashin.h
retrieve.obj : eif_hector.h
retrieve.obj : eif_local.h
retrieve.obj : eif_macros.h
retrieve.obj : eif_malloc.h
retrieve.obj : eif_plug.h
retrieve.obj : eif_portable.h
retrieve.obj : retrieve.c
whash.obj : whash.c
retrieve.obj : eif_retrieve.h
retrieve.obj : eif_size.h
retrieve.obj : eif_struct.h
hash.obj : eif_config.h
hash.obj : hash.c
hash.obj : eif_hash.h
hash.obj : eif_portable.h
hash.obj : eif_tools.h
traverse.obj : eif_cecil.h
traverse.obj : eif_config.h
traverse.obj : eif_copy.h
traverse.obj : eif_except.h
traverse.obj : eif_garcol.h
traverse.obj : eif_hashin.h
traverse.obj : eif_hector.h
traverse.obj : eif_local.h
traverse.obj : eif_macros.h
traverse.obj : eif_malloc.h
traverse.obj : eif_plug.h
traverse.obj : eif_portable.h
traverse.obj : eif_size.h
traverse.obj : eif_store.h
traverse.obj : eif_struct.h
traverse.obj : traverse.c
traverse.obj : eif_traverse.h
hashin.obj : eif_config.h
hashin.obj : hashin.c
hashin.obj : eif_hashin.h
hashin.obj : eif_malloc.h
hashin.obj : eif_portable.h
hashin.obj : eif_tools.h
tools.obj : eif_config.h
tools.obj : eif_portable.h
tools.obj : tools.c
tools.obj : eif_tools.h
internal.obj : eif_cecil.h
internal.obj : eif_config.h
internal.obj : eif_copy.h
internal.obj : eif_dir.h
internal.obj : eif_eiffel.h
internal.obj : eif_except.h
internal.obj : eif_file.h
internal.obj : eif_garcol.h
internal.obj : eif_hector.h
internal.obj : internal.c
internal.obj : eif_local.h
internal.obj : eif_macros.h
internal.obj : eif_malloc.h
internal.obj : eif_out.h
internal.obj : eif_plug.h
internal.obj : eif_portable.h
internal.obj : eif_size.h
internal.obj : eif_struct.h
plug.obj : eif_bits.h
plug.obj : eif_cecil.h
plug.obj : eif_config.h
plug.obj : eif_copy.h
plug.obj : eif_dir.h
plug.obj : eif_eiffel.h
plug.obj : eif_except.h
plug.obj : eif_file.h
plug.obj : eif_garcol.h
plug.obj : eif_hashin.h
plug.obj : eif_hector.h
plug.obj : eif_interp.h
plug.obj : eif_local.h
plug.obj : eif_macros.h
plug.obj : eif_malloc.h
plug.obj : eif_option.h
plug.obj : eif_out.h
plug.obj : plug.c
plug.obj : eif_plug.h
plug.obj : eif_portable.h
plug.obj : eif_size.h
plug.obj : eif_struct.h
copy.obj : eif_cecil.h
copy.obj : eif_config.h
copy.obj : copy.c
copy.obj : eif_copy.h
copy.obj : eif_dir.h
copy.obj : eif_eiffel.h
copy.obj : eif_except.h
copy.obj : eif_file.h
copy.obj : eif_garcol.h
copy.obj : eif_hash.h
copy.obj : eif_hector.h
copy.obj : eif_local.h
copy.obj : eif_macros.h
copy.obj : eif_malloc.h
copy.obj : eif_out.h
copy.obj : eif_plug.h
copy.obj : eif_portable.h
copy.obj : eif_size.h
copy.obj : eif_struct.h
copy.obj : eif_traverse.h
equal.obj : eif_cecil.h
equal.obj : eif_config.h
equal.obj : eif_copy.h
equal.obj : eif_dir.h
equal.obj : eif_eiffel.h
equal.obj : equal.c
equal.obj : eif_equal.h
equal.obj : eif_except.h
equal.obj : eif_file.h
equal.obj : eif_garcol.h
equal.obj : eif_hector.h
equal.obj : eif_local.h
equal.obj : eif_macros.h
equal.obj : eif_malloc.h
equal.obj : eif_out.h
equal.obj : eif_plug.h
equal.obj : eif_portable.h
equal.obj : eif_search.h
equal.obj : eif_size.h
equal.obj : eif_struct.h
equal.obj : eif_tools.h
equal.obj : eif_traverse.h
lmalloc.obj : eif_config.h
lmalloc.obj : eif_garcol.h
lmalloc.obj : lmalloc.c
lmalloc.obj : eif_malloc.h
lmalloc.obj : eif_plug.h
lmalloc.obj : eif_portable.h
lmalloc.obj : eif_struct.h
out.obj : eif_bits.h
out.obj : eif_cecil.h
out.obj : eif_config.h
out.obj : eif_copy.h
out.obj : eif_dir.h
out.obj : eif_eiffel.h
out.obj : eif_except.h
out.obj : eif_file.h
out.obj : eif_garcol.h
out.obj : eif_hashin.h
out.obj : eif_hector.h
out.obj : eif_local.h
out.obj : eif_macros.h
out.obj : eif_malloc.h
out.obj : out.c
out.obj : eif_out.h
out.obj : eif_plug.h
out.obj : eif_portable.h
out.obj : eif_sig.h
out.obj : eif_size.h
out.obj : eif_struct.h
timer.obj : eif_config.h
timer.obj : eif_portable.h
timer.obj : timer.c
timer.obj : eif_timer.h
urgent.obj : eif_config.h
urgent.obj : eif_portable.h
urgent.obj : urgent.c
urgent.obj : eif_urgent.h
sig.obj : eif_config.h
sig.obj : eif_except.h
sig.obj : eif_garcol.h
sig.obj : eif_malloc.h
sig.obj : eif_plug.h
sig.obj : eif_portable.h
sig.obj : sig.c
sig.obj : eif_sig.h
sig.obj : eif_struct.h
hector.obj : eif_cecil.h
hector.obj : eif_config.h
hector.obj : eif_except.h
hector.obj : eif_garcol.h
hector.obj : hector.c
hector.obj : eif_hector.h
hector.obj : eif_malloc.h
hector.obj : eif_plug.h
hector.obj : eif_portable.h
hector.obj : eif_struct.h
cecil.obj : cecil.c
cecil.obj : eif_cecil.h
cecil.obj : eif_config.h
cecil.obj : eif_copy.h
cecil.obj : eif_dir.h
cecil.obj : eif_eiffel.h
cecil.obj : eif_except.h
cecil.obj : eif_file.h
cecil.obj : eif_garcol.h
cecil.obj : eif_hector.h
cecil.obj : eif_local.h
cecil.obj : eif_macros.h
cecil.obj : eif_malloc.h
cecil.obj : eif_out.h
cecil.obj : eif_plug.h
cecil.obj : eif_portable.h
cecil.obj : eif_size.h
cecil.obj : eif_struct.h
cecil.obj : eif_tools.h
bits.obj : bits.c
bits.obj : eif_bits.h
bits.obj : eif_cecil.h
bits.obj : eif_config.h
bits.obj : eif_except.h
bits.obj : eif_garcol.h
bits.obj : eif_local.h
bits.obj : eif_malloc.h
bits.obj : eif_plug.h
bits.obj : eif_portable.h
bits.obj : eif_struct.h
file.obj : eif_cecil.h
file.obj : eif_config.h
file.obj : eif_copy.h
file.obj : eif_except.h
file.obj : file.c
file.obj : eif_file.h
file.obj : eif_garcol.h
file.obj : eif_hector.h
file.obj : eif_local.h
file.obj : eif_macros.h
file.obj : eif_malloc.h
file.obj : eif_plug.h
file.obj : eif_portable.h
file.obj : eif_size.h
file.obj : eif_struct.h
dir.obj : eif_cecil.h
dir.obj : eif_config.h
dir.obj : eif_copy.h
dir.obj : dir.c
dir.obj : eif_dir.h
dir.obj : eif_except.h
dir.obj : eif_garcol.h
dir.obj : eif_hector.h
dir.obj : eif_local.h
dir.obj : eif_macros.h
dir.obj : eif_malloc.h
dir.obj : eif_plug.h
dir.obj : eif_portable.h
dir.obj : eif_size.h
dir.obj : eif_struct.h
string.obj : eif_config.h
string.obj : eif_portable.h
string.obj : string.c
misc.obj : eif_cecil.h
misc.obj : eif_config.h
misc.obj : eif_copy.h
misc.obj : eif_except.h
misc.obj : eif_garcol.h
misc.obj : eif_hector.h
misc.obj : eif_local.h
misc.obj : eif_macros.h
misc.obj : eif_malloc.h
misc.obj : misc.c
misc.obj : eif_misc.h
misc.obj : eif_plug.h
misc.obj : eif_portable.h
misc.obj : eif_size.h
misc.obj : eif_struct.h
pattern.obj : eif_cecil.h
pattern.obj : eif_config.h
pattern.obj : eif_except.h
pattern.obj : eif_garcol.h
pattern.obj : eif_hector.h
pattern.obj : eif_malloc.h
pattern.obj : pattern.c
pattern.obj : eif_plug.h
pattern.obj : eif_portable.h
pattern.obj : eif_struct.h
error.obj : eif_config.h
error.obj : error.c
error.obj : eif_except.h
error.obj : eif_garcol.h
error.obj : eif_malloc.h
error.obj : eif_plug.h
error.obj : eif_portable.h
error.obj : eif_struct.h
umain.obj : umain.c
memory.obj : eif_cecil.h
memory.obj : eif_config.h
memory.obj : eif_copy.h
memory.obj : eif_except.h
memory.obj : eif_garcol.h
memory.obj : eif_hector.h
memory.obj : eif_local.h
memory.obj : eif_macros.h
memory.obj : eif_malloc.h
memory.obj : memory.c
memory.obj : eif_plug.h
memory.obj : eif_portable.h
memory.obj : eif_size.h
memory.obj : eif_struct.h
argv.obj : argv.c
argv.obj : eif_config.h
argv.obj : eif_malloc.h
argv.obj : eif_plug.h
argv.obj : eif_portable.h
boolstr.obj : boolstr.c
boolstr.obj : eif_config.h
boolstr.obj : eif_portable.h
search.obj : eif_config.h
search.obj : eif_portable.h
search.obj : search.c
search.obj : eif_search.h
search.obj : eif_tools.h
x2c.obj : eif_config.h
x2c.obj : eif_size.h
x2c.obj : x2c.c
debug.obj : eif_cecil.h
debug.obj : eif_config.h
debug.obj : eif_copy.h
debug.obj : debug.c
debug.obj : eif_debug.h
debug.obj : eif_except.h
debug.obj : eif_garcol.h
debug.obj : eif_hashin.h
debug.obj : eif_hector.h
debug.obj : eif_local.h
debug.obj : eif_macros.h
debug.obj : eif_malloc.h
debug.obj : eif_out.h
debug.obj : eif_plug.h
debug.obj : eif_portable.h
debug.obj : eif_sig.h
debug.obj : eif_size.h
debug.obj : eif_struct.h
interp.obj : eif_bits.h
interp.obj : eif_cecil.h
interp.obj : eif_config.h
interp.obj : eif_copy.h
interp.obj : eif_debug.h
interp.obj : eif_dir.h
interp.obj : eif_eiffel.h
interp.obj : eif_except.h
interp.obj : eif_file.h
interp.obj : eif_garcol.h
interp.obj : eif_hashin.h
interp.obj : eif_hector.h
interp.obj : interp.c
interp.obj : eif_interp.h
interp.obj : eif_local.h
interp.obj : eif_macros.h
interp.obj : eif_malloc.h
interp.obj : eif_out.h
interp.obj : eif_plug.h
interp.obj : eif_portable.h
interp.obj : eif_sig.h
interp.obj : eif_size.h
interp.obj : eif_struct.h
option.obj : eif_config.h
option.obj : option.c
option.obj : eif_option.h
option.obj : eif_portable.h
option.obj : eif_struct.h
update.obj : eif_cecil.h
update.obj : eif_config.h
update.obj : eif_copy.h
update.obj : eif_except.h
update.obj : eif_garcol.h
update.obj : eif_hashin.h
update.obj : eif_hector.h
update.obj : eif_local.h
update.obj : eif_macros.h
update.obj : eif_malloc.h
update.obj : eif_plug.h
update.obj : eif_portable.h
update.obj : eif_size.h
update.obj : eif_struct.h
update.obj : update.c
update.obj : eif_update.h
wbench.obj : eif_cecil.h
wbench.obj : eif_config.h
wbench.obj : eif_copy.h
wbench.obj : eif_except.h
wbench.obj : eif_garcol.h
wbench.obj : eif_hashin.h
wbench.obj : eif_hector.h
wbench.obj : eif_interp.h
wbench.obj : eif_local.h
wbench.obj : eif_macros.h
wbench.obj : eif_malloc.h
wbench.obj : eif_plug.h
wbench.obj : eif_portable.h
wbench.obj : eif_size.h
wbench.obj : eif_struct.h
wbench.obj : wbench.c
wbench.obj : eif_wbench.h
main.obj : eif_config.h
main.obj : eif_except.h
main.obj : eif_garcol.h
main.obj : main.c
main.obj : eif_malloc.h
main.obj : eif_plug.h
main.obj : eif_portable.h
main.obj : eif_sig.h
main.obj : eif_struct.h
main.obj : eif_urgent.h
wmain.obj : eif_config.h
wmain.obj : eif_except.h
wmain.obj : eif_garcol.h
wmain.obj : main.c
wmain.obj : eif_malloc.h
wmain.obj : eif_plug.h
wmain.obj : eif_portable.h
wmain.obj : eif_sig.h
wmain.obj : eif_struct.h
wmain.obj : eif_urgent.h
object_id.obj : eif_portable.h
object_id.obj : eif_garcol.h
object_id.obj : eif_except.h
object_id.obj : eif_hector.h
eif_threads.obj : eif_threads.h
eif_cond_var.obj : eif_cond_var.h
weif_threads.obj : eif_threads.h
weif_cond_var.obj : eif_cond_var.h
