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
	$(CC) -c $(JCFLAGS) $<

CFLAGS = -I. -I$(TOP) -I$(TOP)/idrs -I$(TOP)/console -I$(TOP)/ipc/app

NETWORK = $(TOP)\ipc\app\network.lib

OBJECTS = lmalloc.obj math.obj malloc.obj garcol.obj local.obj except.obj store.obj \
	retrieve.obj hash.obj traverse.obj hashin.obj tools.obj internal.obj \
	plug.obj copy.obj equal.obj out.obj timer.obj urgent.obj \
	sig.obj hector.obj cecil.obj bits.obj file.obj dir.obj string.obj \
	misc.obj pattern.obj error.obj umain.obj memory.obj argv.obj \
	boolstr.obj search.obj main.obj dle.obj option.obj \
	console.obj run_idr.obj  $(TOP)\ipc\shared\networku.obj $(TOP)\ipc\shared\shword.obj \
	path_name.obj object_id.obj $(TOP)\console\econsole.lib \
	compress.obj eif_threads.obj eif_cond_var.obj eif_once.obj $extra_object_files

WOBJECTS = $(NETWORK) wlmalloc.obj wmath.obj wmalloc.obj wgarcol.obj wlocal.obj wexcept.obj \
	wstore.obj wretrieve.obj whash.obj wtravers.obj whashin.obj wtools.obj \
	winterna.obj wplug.obj wcopy.obj wequal.obj wout.obj \
	wtimer.obj wurgent.obj wsig.obj whector.obj wcecil.obj wbits.obj \
	wfile.obj wdir.obj wstring.obj wmisc.obj wpattern.obj werror.obj \
	wumain.obj wmemory.obj wargv.obj wboolstr.obj wsearch.obj wmain.obj \
	debug.obj interp.obj woption.obj update.obj wbench.obj  \
	wconsole.obj wrun_idr.obj wdle.obj $(TOP)\idrs\idr.lib wpath_name.obj \
	wobject_id.obj $(TOP)\console\econsole.lib \
	compress.obj weif_threads.obj weif_cond_var.obj weif_once.obj $extra_object_files

EOBJECTS = wlmalloc.obj wmath.obj wmalloc.obj wgarcol.obj \
	wlocal.obj bexcept.obj wstore.obj wretrieve.obj whash.obj wtravers.obj whashin.obj \
	wtools.obj winterna.obj wplug.obj wcopy.obj wequal.obj wout.obj wtimer.obj \
	wurgent.obj wsig.obj whector.obj wcecil.obj wbits.obj wfile.obj wdir.obj \
	wstring.obj wmisc.obj wpattern.obj werror.obj wumain.obj wmemory.obj \
	wargv.obj wboolstr.obj wsearch.obj bmain.obj debug.obj interp.obj \
	woption.obj update.obj wbench.obj wconsole.obj wrun_idr.obj \
	$(TOP)\ipc\shared\networku.obj wdle.obj \
	wpath_name.obj wobject_id.obj $(TOP)\console\econsole.lib \
	compress.obj weif_threads.obj weif_cond_var.obj weif_once.obj

all:: eif_size.h

all:: finalized.lib

finalized.lib: $(OBJECTS)
	$link_line

all:: wkbench.lib

wkbench.lib: $(WOBJECTS)
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
	$link_eline

all:: x2c.exe

x2c.exe: x2c.c
	$(CC) x2c.c

all:: eif_config.h eif_portable.h

eif_config.h : $(TOP)\eif_config.h
	$(LN) $(TOP)\eif_config.h .

eif_portable.h : $(TOP)\eif_portable.h
	$(LN) $(TOP)\eif_portable.h .

*.obj: eif_config.h eif_portable.h eif_globals.h eif_eiffel.h eif_macros.h

wmath.c : math.c
	$(LN) math.c wmath.c

wmalloc.c : malloc.c
	$(LN) malloc.c wmalloc.c

wgarcol.c : garcol.c
	$(LN) garcol.c wgarcol.c

weif_threads.c : eif_threads.c
	$(LN) eif_threads.c weif_threads.c

weif_cond_var.c : eif_cond_var.c
	$(LN) eif_cond_var.c weif_cond_var.c

weif_once.c : eif_once.c
	$(LN) eif_once.c weif_once.c

wlocal.c : local.c
	$(LN) local.c wlocal.c

wexcept.c : except.c
	$(LN) except.c wexcept.c

wstore.c : store.c
	$(LN) store.c wstore.c

wrun_idr.c : run_idr.c
	$(LN) run_idr.c wrun_idr.c

wretrieve.c : retrieve.c
	$(LN) retrieve.c wretrieve.c

whash.c : hash.c
	$(LN) hash.c whash.c

wtravers.c : traverse.c
	$(LN) traverse.c wtravers.c

whashin.c : hashin.c
	$(LN) hashin.c whashin.c

wtools.c : tools.c
	$(LN) tools.c wtools.c

winterna.c : internal.c
	$(LN) internal.c winterna.c

wpath_name.c : path_name.c
	$(LN) path_name.c wpath_name.c

wplug.c : plug.c
	$(LN) plug.c wplug.c

wcopy.c : copy.c
	$(LN) copy.c wcopy.c

wequal.c : equal.c
	$(LN) equal.c wequal.c

wlmalloc.c : lmalloc.c
	$(LN) lmalloc.c wlmalloc.c

wout.c : out.c
	$(LN) out.c wout.c

wtimer.c : timer.c
	$(LN) timer.c wtimer.c

wurgent.c : urgent.c
	$(LN) urgent.c wurgent.c

wsig.c : sig.c
	$(LN) sig.c wsig.c

whector.c : hector.c
	$(LN) hector.c whector.c

wcecil.c : cecil.c
	$(LN) cecil.c wcecil.c

wbits.c : bits.c
	$(LN) bits.c wbits.c

wconsole.c : console.c
	$(LN) console.c wconsole.c

wfile.c : file.c
	$(LN) file.c wfile.c

wdir.c : dir.c
	$(LN) dir.c wdir.c

wstring.c : string.c
	$(LN) string.c wstring.c

wmisc.c : misc.c
	$(LN) misc.c wmisc.c

wpattern.c : pattern.c
	$(LN) pattern.c wpattern.c

werror.c : error.c
	$(LN) error.c werror.c

wumain.c : umain.c
	$(LN) umain.c wumain.c

wmemory.c : memory.c
	$(LN) memory.c wmemory.c

woption.c : option.c
	$(LN) option.c woption.c

wargv.c : argv.c
	$(LN) argv.c wargv.c

wboolstr.c : boolstr.c
	$(LN) boolstr.c wboolstr.c

wsearch.c : search.c
	$(LN) search.c wsearch.c

wmain.c : main.c
	$(LN) main.c wmain.c

wobject_id.c : object_id.c
	$(LN) object_id.c wobject_id.c

wdle.c : dle.c
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

weif_once.obj : weif_once.c
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
	$(LN) main.c bmain.c

bmain.obj : bmain.c
	$(CC)  $(JCFLAGS) -DWORKBENCH -DNOHOOK $*.c

bexcept.c : except.c
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

malloc.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

garcol.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_search.h eif_sig.h \
			eif_size.h eif_struct.h eif_timer.h eif_urgent.h

local.obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_local.h eif_malloc.h \
			eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

except.obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_sig.h eif_size.h eif_struct.h eif_urgent.h

store.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h eif_traverse.h

retrieve.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_retrieve.h eif_size.h eif_struct.h

hash.obj : eif_hash.h eif_tools.h

traverse.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_store.h eif_struct.h \
			eif_traverse.h

hashin.obj : eif_hashin.h eif_malloc.h eif_tools.h

tools.obj : eif_tools.h

internal.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h

plug.obj : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h eif_option.h \
			eif_out.h eif_plug.h eif_size.h eif_struct.h

copy.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hash.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h \
			eif_struct.h eif_traverse.h

equal.obj : eif_cecil.h eif_copy.h eif_dir.h eif_equal.h eif_except.h eif_file.h \
			eif_garcol.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_search.h eif_size.h eif_struct.h eif_tools.h eif_traverse.h

lmalloc.obj : eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

out.obj : eif_bits.h eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hashin.h eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h \
			eif_sig.h eif_size.h eif_struct.h

timer.obj : eif_timer.h

urgent.obj : eif_urgent.h

sig.obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h

hector.obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

cecil.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_file.h eif_garcol.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_size.h eif_struct.h \
			eif_tools.h

bits.obj : eif_bits.h eif_cecil.h eif_except.h eif_garcol.h eif_local.h eif_malloc.h \
			eif_plug.h eif_struct.h

file.obj : eif_cecil.h eif_copy.h eif_except.h eif_file.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

dir.obj : eif_cecil.h eif_copy.h eif_dir.h eif_except.h eif_garcol.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h

misc.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_misc.h eif_plug.h eif_size.h eif_struct.h

pattern.obj : eif_cecil.h eif_except.h eif_garcol.h eif_hector.h eif_malloc.h \
			eif_plug.h eif_struct.h

error.obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_struct.h

memory.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hector.h eif_local.h \
			eif_malloc.h eif_plug.h eif_size.h eif_struct.h

argv.obj : eif_malloc.h eif_plug.h

search.obj : eif_search.h eif_tools.h

x2c.obj : eif_size.h

debug.obj : eif_cecil.h eif_copy.h eif_debug.h eif_except.h eif_garcol.h eif_hashin.h \
			eif_hector.h eif_local.h eif_malloc.h eif_out.h eif_plug.h eif_sig.h \
			eif_size.h eif_struct.h

interp.obj : eif_bits.h eif_cecil.h eif_copy.h eif_debug.h eif_dir.h eif_except.h eif_file.h \
			eif_garcol.h eif_hashin.h eif_hector.h eif_interp.h eif_local.h eif_malloc.h \
			eif_out.h eif_plug.h eif_sig.h eif_size.h eif_struct.h

option.obj : eif_option.h eif_struct.h

update.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_update.h

wbench.obj : eif_cecil.h eif_copy.h eif_except.h eif_garcol.h eif_hashin.h eif_hector.h \
			eif_interp.h eif_local.h eif_malloc.h eif_plug.h eif_size.h eif_struct.h eif_wbench.h

main.obj : eif_except.h eif_garcol.h eif_malloc.h eif_plug.h eif_sig.h eif_struct.h eif_urgent.h

wmain.obj : eif_except.h eif_garcol.h main.c eif_malloc.h eif_plug.h eif_sig.h eif_struct.h \
			eif_urgent.h

object_id.obj : eif_garcol.h eif_except.h eif_hector.h

eif_threads.obj : eif_threads.h eif_cond_var.h
eif_cond_var.obj : eif_cond_var.h
eif_once.obj: eif_once.h eif_threads.h

weif_threads.obj : eif_threads.h eif_cond_var.h
weif_cond_var.obj : eif_cond_var.h
weif_once.obj: eif_once.h eif_threads.h
