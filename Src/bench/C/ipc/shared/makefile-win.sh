TOP=..\..
OUTDIR= .
INDIR= .
CC=$cc
RM=del
OUTPUT_CMD= $output_cmd
LIBRUN = $(TOP)\run-time
LIBIDR = $(TOP)\idrs
DPFLAGS = -I$(TOP) -I$(LIBRUN) -I$(LIBIDR) -I$(LIBRUN)\include -I.
CFLAGS = $(DPFLAGS) -DWORKBENCH
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize

OBJECTS = \
	com.$obj \
	identify.$obj \
	lock.$obj \
	logfile.$obj \
	network.$obj \
	networku.$obj \
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
	MTlock.$obj \
	MTlogfile.$obj \
	MTnetwork.$obj \
	MTnetworku.$obj \
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
	$link_mtline

MTcom.$obj: com.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTidentify.$obj: identify.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTlock.$obj: lock.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTlogfile.$obj: logfile.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTnetwork.$obj: network.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTnetworku.$obj: networku.c
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

