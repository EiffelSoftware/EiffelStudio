TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I.
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MKDIR = $mkdir
MAKE = $make
OBJECTS = network.$obj network_r.$obj hostname.$obj syncpoll.$obj storable.$obj
MT_OBJECTS = MTnetwork.$obj MTnetwork_r.$obj MThostname.$obj MTsyncpoll.$obj MTstorable.$obj
IL_OBJECTS = ILnetwork.$obj ILnetwork_r.$obj ILhostname.$obj ILsyncpoll.$obj ILstorable.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries
	$(MAKE) clean

standard:: net.lib ilnet.lib
mtstandard:: mtnet.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

net.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtnet.lib: $(MT_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ilnet.lib: $(IL_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@


MTnetwork.$obj: network.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTnetwork_r.$obj: network_r.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MThostname.$obj: hostname.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTsyncpoll.$obj: syncpoll.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTstorable.$obj: storable.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILnetwork.$obj: network.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILnetwork_r.$obj: network_r.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILhostname.$obj: hostname.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILsyncpoll.$obj: syncpoll.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILstorable.$obj: storable.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
