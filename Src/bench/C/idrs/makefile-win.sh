TOP = ..
OUTDIR= .
INDIR= .
OUTPUT_CMD= $output_cmd
CC = $cc
JCFLAGS = $ccflags -I$(TOP)\run-time -I$(TOP)\ipc\shared $optimize -I$(TOP)
JMTCFLAGS = $mtccflags -I$(TOP)\run-time -I$(TOP)\ipc\shared $optimize -I$(TOP)
MV = copy
RM = del

OBJECTS = \
	idr_double.$obj \
	idr_float.$obj \
	idr_array.$obj \
	idr_char.$obj \
	idr_getpos.$obj \
	idr_int.$obj \
	idr_long.$obj \
	idr_opaque.$obj \
	idr_poly.$obj \
	idr_read.$obj \
	idr_setpos.$obj \
	idr_short.$obj \
	idr_size.$obj \
	idr_stack.$obj \
	idr_string.$obj \
	idr_uchar.$obj \
	idr_uint.$obj \
	idr_ulong.$obj \
	idr_union.$obj \
	idr_ushort.$obj \
	idr_vector.$obj \
	idr_void.$obj \
	idr_write.$obj \
	idrf_creat.$obj \
	idrf_dstry.$obj \
	idrf_pos.$obj \
	idrm_creat.$obj \
	idrm_dstry.$obj

MT_OBJECTS = \
	MTidr_double.$obj \
	MTidr_float.$obj \
	MTidr_array.$obj \
	MTidr_char.$obj \
	MTidr_getpos.$obj \
	MTidr_int.$obj \
	MTidr_long.$obj \
	MTidr_opaque.$obj \
	MTidr_poly.$obj \
	MTidr_read.$obj \
	MTidr_setpos.$obj \
	MTidr_short.$obj \
	MTidr_size.$obj \
	MTidr_stack.$obj \
	MTidr_string.$obj \
	MTidr_uchar.$obj \
	MTidr_uint.$obj \
	MTidr_ulong.$obj \
	MTidr_union.$obj \
	MTidr_ushort.$obj \
	MTidr_vector.$obj \
	MTidr_void.$obj \
	MTidr_write.$obj \
	MTidrf_creat.$obj \
	MTidrf_dstry.$obj \
	MTidrf_pos.$obj \
	MTidrm_creat.$obj \
	MTidrm_dstry.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: idr.$lib mtidr.$lib

idr.$lib: $(OBJECTS)
	$link_line

mtidr.$lib: $(MT_OBJECTS)
	$link_mtline

MTidr_double.$obj: idr_double.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_float.$obj: idr_float.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_array.$obj: idr_array.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_char.$obj: idr_char.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_getpos.$obj: idr_getpos.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_int.$obj: idr_int.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidrm_dstry.$obj: idrm_dstry.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidrm_creat.$obj: idrm_creat.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidrf_pos.$obj: idrf_pos.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidrf_dstry.$obj: idrf_dstry.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidrf_creat.$obj: idrf_creat.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_write.$obj: idr_write.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_void.$obj: idr_void.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_vector.$obj: idr_vector.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_ushort.$obj: idr_ushort.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_union.$obj: idr_union.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_ulong.$obj: idr_ulong.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_uint.$obj: idr_uint.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_uchar.$obj: idr_uchar.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_string.$obj: idr_string.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_stack.$obj: idr_stack.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_size.$obj: idr_size.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_short.$obj: idr_short.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_setpos.$obj: idr_setpos.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_read.$obj: idr_read.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_poly.$obj: idr_poly.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_opaque.$obj: idr_opaque.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTidr_long.$obj: idr_long.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

