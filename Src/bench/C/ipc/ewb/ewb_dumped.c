/*
    #####   #    #   #    #   #####    ######   #####           ####
    #    #  #    #   ##  ##   #    #   #        #    #         #    #
    #    #  #    #   # ## #   #    #   #####    #    #         #
    #    #  #    #   #    #   #####    #        #    #   ###   #
    #    #  #    #   #    #   #        #        #    #   ###   #    #
    #####    ####    #    #   #        ######   #####    ###    ####


	Eiffle/C interface routines for dump (debugger)
 	The dual Eiffel class is RECV_VALUE (cluster ipc)
	and CALL_INFO (cluster debug)

	For Windows:
		Simplified version from Unix using STREAM *sp from transfer.c:tpipe().
*/

#include "rt_macros.h"
#include "eif_interp.h"
#include "request.h"
#include "stack.h"
#include "eif_io.h"
#include "eif_in.h"
#include <string.h>

EIF_PROC set_rout;
EIF_PROC set_integer_8;
EIF_PROC set_integer_16;
EIF_PROC set_integer_32;
EIF_PROC set_integer_64;
EIF_PROC set_bool;
EIF_PROC set_char;
EIF_PROC set_wchar;
EIF_PROC set_real;
EIF_PROC set_double;
EIF_PROC set_ref;
EIF_PROC set_pointer;
EIF_PROC set_bits;
EIF_PROC set_error;
EIF_PROC set_void;

#ifdef EIF_WIN32
extern STREAM *sp;
#endif

rt_public void c_recv_rout_info (EIF_OBJ target)

/*
 * 	Wait for a request. If the request is of type DUMPED, DMP_VECT or DMP_MELTED
 *	ie. the trace of a routine call, fill the CALL_INFO instance (target)
 *	accordingly. If an aknowledge is recieved, signal the CALL_INFO that
 *	the call stack is exhausted. If something else comes, signal an error
 *  if the request is nether a DUMPED nor an AKNOLEDGE, signal an error and
 *	treat the incoming request as a normal asynchonous request.
 */

{
	EIF_GET_CONTEXT
	Request pack;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd [EWBOUT];
#endif
	Dump dump;
	char *c_rout_name;
	char string [128], *ptr = string;
	EIF_REFERENCE eif_rout_name, obj_addr;
	uint32 hack;		/* Temporary solution: 2 integers sent in one */
	uint32 orig, dtype;
	int line_number;	/* line number (i.e. break index) where application is stopped within feature */

	Request_Clean (pack);
#ifdef EIF_WIN32
	if (-1 != recv_packet (sp, &pack, TRUE)){ /* else send error */
#else
	if (-1 != recv_packet (readfd (sp), &pack)){ /* else send error */
#endif
		switch (pack.rq_type) {
			case DUMPED:
				dump = pack.rq_dump;
				switch (dump.dmp_type) {

					case DMP_VECT:
					case DMP_MELTED:
						c_rout_name = dump.dmp_vect->ex_rout;
						eif_rout_name = RTMS (c_rout_name);
							/* Protect just created object */
						RT_GC_PROTECT(eif_rout_name);

						sprintf (ptr, "%lX\0", (unsigned long) dump.dmp_vect -> ex_id);
						obj_addr = RTMS (ptr);

							/* Protect just created object */
						RT_GC_PROTECT(obj_addr);

						line_number = dump.dmp_vect->dex_linenum;

						hack = (uint32) dump.dmp_vect -> ex_orig;
						orig = hack >> 16;
						dtype = hack << 16;
						dtype >>= 16;

						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_BOOLEAN, EIF_BOOLEAN, EIF_REFERENCE,
											EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER)) set_rout)
							(eif_access (target),
							(EIF_BOOLEAN) (dump.dmp_type == DMP_MELTED),
							(EIF_BOOLEAN) 0,
							obj_addr,
							orig, dtype,
							eif_rout_name,
							line_number);

							/* Remove 2 protections */
						RT_GC_WEAN_N(2);
						return;
					default:
						break; /* send error */
				}
			case ACKNLGE:	/* send exhausted */
				(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_BOOLEAN, EIF_BOOLEAN, EIF_REFERENCE,
											EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER)) set_rout)
					(eif_access (target),
					(EIF_BOOLEAN) 0,
					(EIF_BOOLEAN) 1, /* exhausted is true */
					(EIF_REFERENCE) 0, 0L, 0L, (EIF_REFERENCE) 0, 0L);
				return;
			default:
				request_dispatch (pack); /* treat asynchronous request */
				break;	/* send error */
		}
	}
	else
		(FUNCTION_CAST(void, (EIF_REFERENCE)) set_error) (eif_access (target));
	return;
}


rt_public void c_recv_value (EIF_OBJ target)

/*
 *	wait for a request. If it is a dumped item, send it to the RECV_VALUE
 *	instance target. Else, report an error to target. If the request is not a
 *	DUMPED, treat it as a normal asynchronous request (and report the error too)
 */
{
	Request pack;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd [EWBOUT];
#endif
	struct  item item;
	uint32  type_flag;

	Request_Clean (pack);
#ifdef EIF_WIN32
	if (-1 != recv_packet (sp, &pack, TRUE)) {
#else
	if (-1 != recv_packet (readfd (sp), &pack)) {
#endif
		if (pack.rq_type == DUMPED) {
			if (pack.rq_dump.dmp_type == DMP_ITEM) {
				item = *pack.rq_dump.dmp_item;
				type_flag = item.type;
				switch (type_flag & SK_HEAD) {
					case SK_BOOL:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_BOOLEAN)) set_bool) (eif_access (target), item.it_char);
						return;
					case SK_CHAR:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_CHARACTER)) set_char) (eif_access (target), item.it_char);
						return;
					case SK_WCHAR:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_WIDE_CHAR)) set_wchar) (eif_access (target), item.it_wchar);
						return;
					case SK_INT8:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_8)) set_integer_8) (eif_access (target), item.it_int8);
						return;
					case SK_INT16:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_16)) set_integer_16) (eif_access (target), item.it_int16);
						return;
					case SK_INT32:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_32)) set_integer_32) (eif_access (target), item.it_int32);
						return;
					case SK_INT64:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_64)) set_integer_64) (eif_access (target), item.it_int64);
						return;
					case SK_FLOAT:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REAL)) set_real) (eif_access (target), item.it_float);
						return;
					case SK_DOUBLE:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_DOUBLE)) set_double) (eif_access (target), item.it_double);
						return;
					case SK_POINTER:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER)) set_pointer) (eif_access (target), item.it_ptr);
						return;
					case SK_REF:
					case SK_EXP:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER)) set_ref)
								(eif_access (target),
								item.it_ref,
								type_flag & SK_DTYPE);
							/* reference and dynamic type */
						return;
					case SK_BIT:
						(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER)) set_bits) (eif_access (target),
							item.it_ref,
							type_flag & SK_BMASK);
							/* reference and number of bits */
						return;
					default:
						break;
				}
			} else if (pack.rq_dump.dmp_type == DMP_VOID) {
				/* No more values to be received */
				(FUNCTION_CAST(void, (EIF_REFERENCE)) set_void) (eif_access (target));
				return;
			}
		} else {
			request_dispatch (pack);
		}
	}
	(FUNCTION_CAST(void, (EIF_REFERENCE)) set_error) (eif_access (target));
}


rt_public void c_pass_recv_routines (EIF_PROC d_int_8, EIF_PROC d_int_16, EIF_PROC d_int_32, EIF_PROC d_int_64, EIF_PROC d_bool, EIF_PROC d_char, EIF_PROC d_wchar, EIF_PROC d_real, EIF_PROC d_double, EIF_PROC d_ref, EIF_PROC d_point, EIF_PROC d_bits, EIF_PROC d_error, EIF_PROC d_void)
/*
 *	Register the routines to communicate with a RECV_VALUE
 */
{
	set_integer_8 = d_int_8;
	set_integer_16 = d_int_16;
	set_integer_32 = d_int_32;
	set_integer_64 = d_int_64;
	set_bool = d_bool;
	set_char = d_char;
	set_wchar = d_wchar;
	set_real = d_real;
	set_double = d_double;
	set_ref = d_ref;
	set_pointer = d_point;
	set_bits = d_bits;
	set_error = d_error;
	set_void = d_void;
}

rt_public void c_pass_set_rout (EIF_PROC d_rout)
/*
 *	Register the routine to communicate with a CALL_INFO
 */
{
	set_rout = d_rout;
}
