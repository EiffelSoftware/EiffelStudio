/*
	description: "[
			Eiffel/C interface routines for dump (debugger)
			The dual Eiffel class is RECV_VALUE (cluster ipc)
			and CALL_INFO (cluster debug)

			For Windows:
				Simplified version from Unix using STREAM *ewb_sp from transfer.c:tpipe().
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "rt_macros.h"
#include "eif_interp.h"
#include "request.h"
#include "stack.h"
#include "eif_io.h"
#include "eif_in.h"
#include <string.h>
#include "rt_garcol.h"
#include "stream.h"

extern STREAM *ewb_sp;

EIF_PROC set_rout;
EIF_PROC set_natural_8;
EIF_PROC set_natural_16;
EIF_PROC set_natural_32;
EIF_PROC set_natural_64;
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
EIF_PROC set_exception_trace;
EIF_PROC set_void;


rt_public void c_recv_rout_info (EIF_OBJ target)

/*
 * 	Wait for a request. If the request is of type DUMPED, DMP_VECT or DMP_MELTED
 *	ie. the trace of a routine call, fill the CALL_INFO instance (target)
 *	accordingly. If an aknowledge is recieved, signal the CALL_INFO that
 *	the call stack is exhausted. If something else comes, signal an error
 *  if the request is nether a DUMPED nor an ACKNOWLEDGE, signal an error and
 *	treat the incoming request as a normal asynchonous request.
 */

{
	EIF_GET_CONTEXT
	Request pack;

	Dump dump;
	char *c_rout_name;
	char string [128], *ptr = string;
	EIF_REFERENCE eif_rout_name, obj_addr;
	uint32 orig, dtype;
	int line_number;	/* line number (i.e. break index) where application is stopped within feature */

	Request_Clean (pack);
#ifdef EIF_WINDOWS
	if (-1 != recv_packet (ewb_sp, &pack, TRUE)){ /* else send error */
#else
	if (-1 != recv_packet (ewb_sp, &pack)){ /* else send error */
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

						sprintf (ptr, "%" EIF_POINTER_DISPLAY, (rt_uint_ptr) dump.dmp_vect -> ex_id);
						obj_addr = RTMS (ptr);

							/* Protect just created object */
						RT_GC_PROTECT(obj_addr);

						line_number = dump.dmp_vect->ex_linenum;

						orig = dump.dmp_vect->ex_orig;
						dtype = dump.dmp_vect->ex_dtype;

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
	EIF_TYPED_VALUE item;
	uint32 type_flag;

	Request_Clean (pack);
#ifdef EIF_WINDOWS
	if (-1 != recv_packet (ewb_sp, &pack, TRUE)) {
#else
	if (-1 != recv_packet (ewb_sp, &pack)) {
#endif
		if (pack.rq_type == DUMPED) {
			switch (pack.rq_dump.dmp_type) {
				case DMP_EXCEPTION_TRACE:
					item = *pack.rq_dump.dmp_item;
					(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_32)) set_exception_trace) (eif_access (target), item.it_int32);
					return;
				case DMP_ITEM:
					item = *pack.rq_dump.dmp_item;
					type_flag = item.type;
					switch (type_flag & SK_HEAD) {
						case SK_BOOL: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_BOOLEAN)) set_bool) (eif_access (target), item.it_char); return;
						case SK_CHAR: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_CHARACTER)) set_char) (eif_access (target), item.it_char); return;
						case SK_WCHAR: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_WIDE_CHAR)) set_wchar) (eif_access (target), item.it_wchar); return;
						case SK_UINT8: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_NATURAL_8)) set_natural_8) (eif_access (target), item.it_uint8); return;
						case SK_UINT16: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_NATURAL_16)) set_natural_16) (eif_access (target), item.it_uint16); return;
						case SK_UINT32: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_NATURAL_32)) set_natural_32) (eif_access (target), item.it_uint32); return;
						case SK_UINT64: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_NATURAL_64)) set_natural_64) (eif_access (target), item.it_uint64); return;
						case SK_INT8: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_8)) set_integer_8) (eif_access (target), item.it_int8); return;
						case SK_INT16: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_16)) set_integer_16) (eif_access (target), item.it_int16); return;
						case SK_INT32: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_32)) set_integer_32) (eif_access (target), item.it_int32); return;
						case SK_INT64: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_64)) set_integer_64) (eif_access (target), item.it_int64); return;
						case SK_REAL32: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REAL_32)) set_real) (eif_access (target), item.it_real32); return;
						case SK_REAL64: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REAL_64)) set_double) (eif_access (target), item.it_real64); return;
						case SK_POINTER: (FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER)) set_pointer) (eif_access (target), item.it_ptr); return;
						case SK_REF:
						case SK_EXP:
							(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER)) set_ref)
									(eif_access (target), item.it_ref, type_flag & SK_DTYPE);
								/* reference and dynamic type */
							return;
						case SK_BIT:
							(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER)) set_bits) (eif_access (target),
								item.it_ref, type_flag & SK_BMASK);
								/* reference and number of bits */
							return;
						default:
							break;
					}
					break;
				case DMP_VOID:
					/* No more values to be received */
					(FUNCTION_CAST(void, (EIF_REFERENCE)) set_void) (eif_access (target));
					return;
				default:
					break;
			}
		} else {
			request_dispatch (pack);
		}
	}
	(FUNCTION_CAST(void, (EIF_REFERENCE)) set_error) (eif_access (target));
}


rt_public void c_pass_recv_routines (
	EIF_PROC d_nat_8,
	EIF_PROC d_nat_16,
	EIF_PROC d_nat_32,
	EIF_PROC d_nat_64,
	EIF_PROC d_int_8,
	EIF_PROC d_int_16,
	EIF_PROC d_int_32,
	EIF_PROC d_int_64,
	EIF_PROC d_bool,
	EIF_PROC d_char,
	EIF_PROC d_wchar,
	EIF_PROC d_real,
	EIF_PROC d_double,
	EIF_PROC d_ref,
	EIF_PROC d_point,
	EIF_PROC d_bits,
	EIF_PROC d_error,
	EIF_PROC d_exception_trace,
	EIF_PROC d_void)
/*
 *	Register the routines to communicate with a RECV_VALUE
 */
{
	set_natural_8 = d_nat_8;
	set_natural_16 = d_nat_16;
	set_natural_32 = d_nat_32;
	set_natural_64 = d_nat_64;
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
	set_exception_trace = d_exception_trace;
	set_void = d_void;
}

rt_public void c_pass_set_rout (EIF_PROC d_rout)
/*
 *	Register the routine to communicate with a CALL_INFO
 */
{
	set_rout = d_rout;
}
