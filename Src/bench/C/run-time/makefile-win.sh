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

OBJECTS = math.obj malloc.obj garcol.obj local.obj except.obj store.obj \
	retrieve.obj hash.obj traverse.obj hashin.obj tools.obj internal.obj \
	plug.obj copy.obj equal.obj out.obj timer.obj urgent.obj \
	sig.obj hector.obj cecil.obj bits.obj file.obj dir.obj string.obj \
	misc.obj pattern.obj error.obj umain.obj memory.obj argv.obj \
	boolstr.obj search.obj main.obj dle.obj option.obj \
	console.obj run_idr.obj  $(TOP)\ipc\shared\networku.obj \
	path_name.obj object_id.obj $(TOP)\console\econsole.lib \
	compress.obj eif_threads.obj $extra_object_files

WOBJECTS = $(NETWORK) wmath.obj wmalloc.obj wgarcol.obj wlocal.obj wexcept.obj \
	wstore.obj wretrieve.obj whash.obj wtravers.obj whashin.obj wtools.obj \
	winterna.obj wplug.obj wcopy.obj wequal.obj wout.obj \
	wtimer.obj wurgent.obj wsig.obj whector.obj wcecil.obj wbits.obj \
	wfile.obj wdir.obj wstring.obj wmisc.obj wpattern.obj werror.obj \
	wumain.obj wmemory.obj wargv.obj wboolstr.obj wsearch.obj wmain.obj \
	debug.obj interp.obj woption.obj update.obj wbench.obj  \
	wconsole.obj wrun_idr.obj wdle.obj $(TOP)\idrs\idr.lib wpath_name.obj \
	wobject_id.obj $(TOP)\console\econsole.lib \
	compress.obj weif_threads.obj $extra_object_files

EOBJ = wmath.obj wmalloc.obj wgarcol.obj wlocal.obj bexcept.obj wstore.obj \
	wretrieve.obj whash.obj wtravers.obj whashin.obj wtools.obj winterna.obj \
	wplug.obj wcopy.obj wequal.obj wout.obj wtimer.obj \
	wurgent.obj wsig.obj whector.obj wcecil.obj wbits.obj wfile.obj wdir.obj \
	wstring.obj wmisc.obj wpattern.obj werror.obj wumain.obj wmemory.obj \
	wargv.obj wboolstr.obj wsearch.obj bmain.obj debug.obj interp.obj \
	woption.obj update.obj wbench.obj wconsole.obj wrun_idr.obj \
	$(TOP)\ipc\shared\networku.obj wdle.obj \
	wpath_name.obj wobject_id.obj $(TOP)\console\econsole.lib \
	compress.obj weif_threads.obj

all:: size.h

all:: runtime.lib

runtime.lib: $(OBJECTS)
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

#all:: ebench.lib

..\ipc\app\network.lib: ..\ipc\app\proto.c
	cd ..\ipc\app
	$(MAKE)
	cd ..\..\run-time

ebench.lib: $(EOBJ)
	$(RM) $@
	$(LIB_EXE)$@ $(EOBJ)

all:: x2c.exe

x2c.exe: x2c.c
	$(RM) $@
	$(CC) x2c.c

all:: config.h portable.h

config.h : $(TOP)\config.h
	$(RM) $@
	$(LN) $(TOP)\config.h .

portable.h : $(TOP)\portable.h
	$(RM) $@
	$(LN) $(TOP)\portable.h .

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

wmain.obj : wmain.c struct.h
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

final: runtime.lib
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

math.obj : config.h
math.obj : math.c
math.obj : portable.h
malloc.obj : cecil.h
malloc.obj : config.h
malloc.obj : copy.h
malloc.obj : dir.h
malloc.obj : eiffel.h
malloc.obj : except.h
malloc.obj : file.h
malloc.obj : garcol.h
malloc.obj : hector.h
malloc.obj : local.h
malloc.obj : macros.h
malloc.obj : malloc.c
malloc.obj : malloc.h
malloc.obj : out.h
malloc.obj : plug.h
malloc.obj : portable.h
malloc.obj : sig.h
malloc.obj : size.h
malloc.obj : struct.h
garcol.obj : cecil.h
garcol.obj : config.h
garcol.obj : copy.h
garcol.obj : dir.h
garcol.obj : eiffel.h
garcol.obj : except.h
garcol.obj : file.h
garcol.obj : garcol.c
garcol.obj : garcol.h
garcol.obj : hector.h
garcol.obj : local.h
garcol.obj : macros.h
garcol.obj : malloc.h
garcol.obj : out.h
garcol.obj : plug.h
garcol.obj : portable.h
garcol.obj : search.h
garcol.obj : sig.h
garcol.obj : size.h
garcol.obj : struct.h
garcol.obj : timer.h
garcol.obj : urgent.h
local.obj : cecil.h
local.obj : config.h
local.obj : except.h
local.obj : garcol.h
local.obj : hector.h
local.obj : local.c
local.obj : local.h
local.obj : malloc.h
local.obj : plug.h
local.obj : portable.h
local.obj : sig.h
local.obj : struct.h
local.obj : urgent.h
except.obj : cecil.h
except.obj : config.h
except.obj : copy.h
except.obj : debug.h
except.obj : except.c
except.obj : except.h
except.obj : garcol.h
except.obj : hector.h
except.obj : local.h
except.obj : macros.h
except.obj : malloc.h
except.obj : plug.h
except.obj : portable.h
except.obj : sig.h
except.obj : size.h
except.obj : struct.h
except.obj : urgent.h
store.obj : cecil.h
store.obj : config.h
store.obj : copy.h
store.obj : except.h
store.obj : garcol.h
store.obj : hector.h
store.obj : local.h
store.obj : macros.h
store.obj : malloc.h
store.obj : plug.h
store.obj : portable.h
store.obj : size.h
store.obj : store.c
store.obj : store.h
store.obj : struct.h
store.obj : traverse.h
retrieve.obj : cecil.h
retrieve.obj : config.h
retrieve.obj : copy.h
retrieve.obj : except.h
retrieve.obj : garcol.h
retrieve.obj : hashin.h
retrieve.obj : hector.h
retrieve.obj : local.h
retrieve.obj : macros.h
retrieve.obj : malloc.h
retrieve.obj : plug.h
retrieve.obj : portable.h
retrieve.obj : retrieve.c
whash.obj : whash.c
retrieve.obj : retrieve.h
retrieve.obj : size.h
retrieve.obj : struct.h
hash.obj : config.h
hash.obj : hash.c
hash.obj : hash.h
hash.obj : portable.h
hash.obj : tools.h
traverse.obj : cecil.h
traverse.obj : config.h
traverse.obj : copy.h
traverse.obj : except.h
traverse.obj : garcol.h
traverse.obj : hashin.h
traverse.obj : hector.h
traverse.obj : local.h
traverse.obj : macros.h
traverse.obj : malloc.h
traverse.obj : plug.h
traverse.obj : portable.h
traverse.obj : size.h
traverse.obj : store.h
traverse.obj : struct.h
traverse.obj : traverse.c
traverse.obj : traverse.h
hashin.obj : config.h
hashin.obj : hashin.c
hashin.obj : hashin.h
hashin.obj : malloc.h
hashin.obj : portable.h
hashin.obj : tools.h
tools.obj : config.h
tools.obj : portable.h
tools.obj : tools.c
tools.obj : tools.h
internal.obj : cecil.h
internal.obj : config.h
internal.obj : copy.h
internal.obj : dir.h
internal.obj : eiffel.h
internal.obj : except.h
internal.obj : file.h
internal.obj : garcol.h
internal.obj : hector.h
internal.obj : internal.c
internal.obj : local.h
internal.obj : macros.h
internal.obj : malloc.h
internal.obj : out.h
internal.obj : plug.h
internal.obj : portable.h
internal.obj : size.h
internal.obj : struct.h
plug.obj : bits.h
plug.obj : cecil.h
plug.obj : config.h
plug.obj : copy.h
plug.obj : dir.h
plug.obj : eiffel.h
plug.obj : except.h
plug.obj : file.h
plug.obj : garcol.h
plug.obj : hashin.h
plug.obj : hector.h
plug.obj : interp.h
plug.obj : local.h
plug.obj : macros.h
plug.obj : malloc.h
plug.obj : option.h
plug.obj : out.h
plug.obj : plug.c
plug.obj : plug.h
plug.obj : portable.h
plug.obj : size.h
plug.obj : struct.h
copy.obj : cecil.h
copy.obj : config.h
copy.obj : copy.c
copy.obj : copy.h
copy.obj : dir.h
copy.obj : eiffel.h
copy.obj : except.h
copy.obj : file.h
copy.obj : garcol.h
copy.obj : hash.h
copy.obj : hector.h
copy.obj : local.h
copy.obj : macros.h
copy.obj : malloc.h
copy.obj : out.h
copy.obj : plug.h
copy.obj : portable.h
copy.obj : size.h
copy.obj : struct.h
copy.obj : traverse.h
equal.obj : cecil.h
equal.obj : config.h
equal.obj : copy.h
equal.obj : dir.h
equal.obj : eiffel.h
equal.obj : equal.c
equal.obj : equal.h
equal.obj : except.h
equal.obj : file.h
equal.obj : garcol.h
equal.obj : hector.h
equal.obj : local.h
equal.obj : macros.h
equal.obj : malloc.h
equal.obj : out.h
equal.obj : plug.h
equal.obj : portable.h
equal.obj : search.h
equal.obj : size.h
equal.obj : struct.h
equal.obj : tools.h
equal.obj : traverse.h
lmalloc.obj : config.h
lmalloc.obj : garcol.h
lmalloc.obj : lmalloc.c
lmalloc.obj : malloc.h
lmalloc.obj : plug.h
lmalloc.obj : portable.h
lmalloc.obj : struct.h
out.obj : bits.h
out.obj : cecil.h
out.obj : config.h
out.obj : copy.h
out.obj : dir.h
out.obj : eiffel.h
out.obj : except.h
out.obj : file.h
out.obj : garcol.h
out.obj : hashin.h
out.obj : hector.h
out.obj : local.h
out.obj : macros.h
out.obj : malloc.h
out.obj : out.c
out.obj : out.h
out.obj : plug.h
out.obj : portable.h
out.obj : sig.h
out.obj : size.h
out.obj : struct.h
timer.obj : config.h
timer.obj : portable.h
timer.obj : timer.c
timer.obj : timer.h
urgent.obj : config.h
urgent.obj : portable.h
urgent.obj : urgent.c
urgent.obj : urgent.h
sig.obj : config.h
sig.obj : except.h
sig.obj : garcol.h
sig.obj : malloc.h
sig.obj : plug.h
sig.obj : portable.h
sig.obj : sig.c
sig.obj : sig.h
sig.obj : struct.h
hector.obj : cecil.h
hector.obj : config.h
hector.obj : except.h
hector.obj : garcol.h
hector.obj : hector.c
hector.obj : hector.h
hector.obj : malloc.h
hector.obj : plug.h
hector.obj : portable.h
hector.obj : struct.h
cecil.obj : cecil.c
cecil.obj : cecil.h
cecil.obj : config.h
cecil.obj : copy.h
cecil.obj : dir.h
cecil.obj : eiffel.h
cecil.obj : except.h
cecil.obj : file.h
cecil.obj : garcol.h
cecil.obj : hector.h
cecil.obj : local.h
cecil.obj : macros.h
cecil.obj : malloc.h
cecil.obj : out.h
cecil.obj : plug.h
cecil.obj : portable.h
cecil.obj : size.h
cecil.obj : struct.h
cecil.obj : tools.h
bits.obj : bits.c
bits.obj : bits.h
bits.obj : cecil.h
bits.obj : config.h
bits.obj : except.h
bits.obj : garcol.h
bits.obj : local.h
bits.obj : malloc.h
bits.obj : plug.h
bits.obj : portable.h
bits.obj : struct.h
file.obj : cecil.h
file.obj : config.h
file.obj : copy.h
file.obj : except.h
file.obj : file.c
file.obj : file.h
file.obj : garcol.h
file.obj : hector.h
file.obj : local.h
file.obj : macros.h
file.obj : malloc.h
file.obj : plug.h
file.obj : portable.h
file.obj : size.h
file.obj : struct.h
dir.obj : cecil.h
dir.obj : config.h
dir.obj : copy.h
dir.obj : dir.c
dir.obj : dir.h
dir.obj : except.h
dir.obj : garcol.h
dir.obj : hector.h
dir.obj : local.h
dir.obj : macros.h
dir.obj : malloc.h
dir.obj : plug.h
dir.obj : portable.h
dir.obj : size.h
dir.obj : struct.h
string.obj : config.h
string.obj : portable.h
string.obj : string.c
misc.obj : cecil.h
misc.obj : config.h
misc.obj : copy.h
misc.obj : except.h
misc.obj : garcol.h
misc.obj : hector.h
misc.obj : local.h
misc.obj : macros.h
misc.obj : malloc.h
misc.obj : misc.c
misc.obj : misc.h
misc.obj : plug.h
misc.obj : portable.h
misc.obj : size.h
misc.obj : struct.h
pattern.obj : cecil.h
pattern.obj : config.h
pattern.obj : except.h
pattern.obj : garcol.h
pattern.obj : hector.h
pattern.obj : malloc.h
pattern.obj : pattern.c
pattern.obj : plug.h
pattern.obj : portable.h
pattern.obj : struct.h
error.obj : config.h
error.obj : error.c
error.obj : except.h
error.obj : garcol.h
error.obj : malloc.h
error.obj : plug.h
error.obj : portable.h
error.obj : struct.h
umain.obj : umain.c
memory.obj : cecil.h
memory.obj : config.h
memory.obj : copy.h
memory.obj : except.h
memory.obj : garcol.h
memory.obj : hector.h
memory.obj : local.h
memory.obj : macros.h
memory.obj : malloc.h
memory.obj : memory.c
memory.obj : plug.h
memory.obj : portable.h
memory.obj : size.h
memory.obj : struct.h
argv.obj : argv.c
argv.obj : config.h
argv.obj : malloc.h
argv.obj : plug.h
argv.obj : portable.h
boolstr.obj : boolstr.c
boolstr.obj : config.h
boolstr.obj : portable.h
search.obj : config.h
search.obj : portable.h
search.obj : search.c
search.obj : search.h
search.obj : tools.h
x2c.obj : config.h
x2c.obj : size.h
x2c.obj : x2c.c
debug.obj : cecil.h
debug.obj : config.h
debug.obj : copy.h
debug.obj : debug.c
debug.obj : debug.h
debug.obj : except.h
debug.obj : garcol.h
debug.obj : hashin.h
debug.obj : hector.h
debug.obj : local.h
debug.obj : macros.h
debug.obj : malloc.h
debug.obj : out.h
debug.obj : plug.h
debug.obj : portable.h
debug.obj : sig.h
debug.obj : size.h
debug.obj : struct.h
interp.obj : bits.h
interp.obj : cecil.h
interp.obj : config.h
interp.obj : copy.h
interp.obj : debug.h
interp.obj : dir.h
interp.obj : eiffel.h
interp.obj : except.h
interp.obj : file.h
interp.obj : garcol.h
interp.obj : hashin.h
interp.obj : hector.h
interp.obj : interp.c
interp.obj : interp.h
interp.obj : local.h
interp.obj : macros.h
interp.obj : malloc.h
interp.obj : out.h
interp.obj : plug.h
interp.obj : portable.h
interp.obj : sig.h
interp.obj : size.h
interp.obj : struct.h
option.obj : config.h
option.obj : option.c
option.obj : option.h
option.obj : portable.h
option.obj : struct.h
update.obj : cecil.h
update.obj : config.h
update.obj : copy.h
update.obj : except.h
update.obj : garcol.h
update.obj : hashin.h
update.obj : hector.h
update.obj : local.h
update.obj : macros.h
update.obj : malloc.h
update.obj : plug.h
update.obj : portable.h
update.obj : size.h
update.obj : struct.h
update.obj : update.c
update.obj : update.h
wbench.obj : cecil.h
wbench.obj : config.h
wbench.obj : copy.h
wbench.obj : except.h
wbench.obj : garcol.h
wbench.obj : hashin.h
wbench.obj : hector.h
wbench.obj : interp.h
wbench.obj : local.h
wbench.obj : macros.h
wbench.obj : malloc.h
wbench.obj : plug.h
wbench.obj : portable.h
wbench.obj : size.h
wbench.obj : struct.h
wbench.obj : wbench.c
wbench.obj : wbench.h
main.obj : config.h
main.obj : except.h
main.obj : garcol.h
main.obj : main.c
main.obj : malloc.h
main.obj : plug.h
main.obj : portable.h
main.obj : sig.h
main.obj : struct.h
main.obj : urgent.h
wmain.obj : config.h
wmain.obj : except.h
wmain.obj : garcol.h
wmain.obj : main.c
wmain.obj : malloc.h
wmain.obj : plug.h
wmain.obj : portable.h
wmain.obj : sig.h
wmain.obj : struct.h
wmain.obj : urgent.h
object_id.obj : portable.h
object_id.obj : garcol.h
object_id.obj : except.h
object_id.obj : hector.h
eif_threads.obj : eif_threads.h
weif_threads.obj : eif_threads.h
