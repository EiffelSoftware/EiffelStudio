TOP=..\..
OUTDIR= .
INDIR= .
CC=$cc
RM=del
OUTPUT_CMD= $output_cmd
LIBRUN = $(TOP)\run-time
LIBIDR = $(TOP)\idrs
DPFLAGS = -I$(TOP) -I$(LIBRUN) -I$(LIBIDR) -I.
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

all:: ipc.$lib mtipc.$lib

ipc.$lib: $(OBJECTS)
	$link_line

mtipc.$lib: $(MT_OBJECTS)
	$link_mtline

MTcom.$obj: com.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTidentify.$obj: identify.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTlock.$obj: lock.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTlogfile.$obj: logfile.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTnetwork.$obj: network.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTnetworku.$obj: networku.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTselect.$obj: select.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTshword.$obj: shword.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTstack.$obj: stack.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTstream.$obj: stream.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTsystem.$obj: system.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTtransfer.$obj: transfer.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTrqst_idrs.$obj: rqst_idrs.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

MTuu.$obj: uu.c
	$(CC) -c $(JMTCFLAGS) $? $(OUTPUT_CMD)$@

