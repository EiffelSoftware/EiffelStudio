TOP=..$(DIR)..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC=$cc
OUTPUT_CMD= $output_cmd
LIBRUN = $(TOP)$(DIR)run-time
LIBIDR = $(TOP)$(DIR)idrs
DPFLAGS = -I$(TOP) -I$(LIBRUN) -I$(LIBIDR) -I$(LIBRUN)$(DIR)include -I.
CFLAGS = $(DPFLAGS) -DWORKBENCH -DEIF_IPC
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize

OBJECTS = \
	com.$obj \
	identify.$obj \
	logfile.$obj \
	network.$obj \
	select.$obj \
	shword.$obj \
	stack.$obj \
	stream.$obj \
	system.$obj \
	transfer.$obj \
	rqst_idrs.$obj \
	uu.$obj

MT_OBJECTS = \
	MTcom.$obj \
	MTidentify.$obj \
	MTlogfile.$obj \
	MTnetwork.$obj \
	MTselect.$obj \
	MTshword.$obj \
	MTstack.$obj \
	MTstream.$obj \
	MTsystem.$obj \
	MTtransfer.$obj \
	MTrqst_idrs.$obj \
	MTuu.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard:: ipc.$lib
mtstandard:: mtipc.$lib

ipc.$lib: $(OBJECTS)
	$link_line

mtipc.$lib: $(MT_OBJECTS)
	$link_line

MTcom.$obj: com.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTidentify.$obj: identify.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTlogfile.$obj: logfile.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTnetwork.$obj: network.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTselect.$obj: select.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTshword.$obj: shword.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTstack.$obj: stack.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTstream.$obj: stream.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTsystem.$obj: system.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTtransfer.$obj: transfer.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTrqst_idrs.$obj: rqst_idrs.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTuu.$obj: uu.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

