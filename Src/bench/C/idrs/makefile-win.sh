TOP = ..
CC = $cc
JCFLAGS = $ccflags $optimize -I$(TOP)
MV = copy
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

OBJECTS = \
	idr_double.obj \
	idr_float.obj \
	idr_array.obj \
	idr_char.obj \
	idr_getpos.obj \
	idr_int.obj \
	idr_long.obj \
	idr_opaque.obj \
	idr_poly.obj \
	idr_read.obj \
	idr_setpos.obj \
	idr_short.obj \
	idr_size.obj \
	idr_stack.obj \
	idr_string.obj \
	idr_uchar.obj \
	idr_uint.obj \
	idr_ulong.obj \
	idr_union.obj \
	idr_ushort.obj \
	idr_vector.obj \
	idr_void.obj \
	idr_write.obj \
	idrf_creat.obj \
	idrf_dstry.obj \
	idrf_pos.obj \
	idrm_creat.obj \
	idrm_dstry.obj 

all:: idr.lib

idr.lib: $(OBJECTS)
	$(RM) $@
	$link_line
