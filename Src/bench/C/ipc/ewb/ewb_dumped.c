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
 */

#include "macros.h"
#include "interp.h"
#include "request.h"
#include "stack.h"
#include "eif_io.h"

EIF_PROC set_rout;
EIF_PROC set_integer;
EIF_PROC set_bool;
EIF_PROC set_char;
EIF_PROC set_real;
EIF_PROC set_double;
EIF_PROC set_ref;
EIF_PROC set_pointer;
EIF_PROC set_bits;
EIF_PROC set_error;
EIF_PROC set_void;


rt_public c_recv_rout_info (EIF_OBJ target)
	       	       
/*
 * 	Wait for a request. If the request is of type DUMPED, DMP_VECT or DMP_MELTED
 *	ie. the trace of a routine call, fill the CALL_INFO instance (target)
 *	accordingly. If an aknowledge is recieved, signal the CALL_INFO that
 *	the call stack is exhausted. If something else comes, signal an error
 *  if the request is nether a DUMPED nor an AKNOLEDGE, signal an error and
 *	treat the incoming request as a normal asynchonous request. 
 */

{
	static int sleep_delay = 30;
	Request pack;
	STREAM *sp = stream_by_fd [EWBOUT];
	Dump dump;
	char *c_rout_name, *eif_rout_name, *obj_addr;
	char string [128], *ptr = string;
	uint32 hack;		/* Temporary solution: 2 integers sent in one */
	uint32 orig, dtype;

	Request_Clean (pack);
	if (-1 != recv_packet (readfd (sp), &pack)){ /* else send error */
		switch (pack.rq_type) {
			case DUMPED:
				dump = pack.rq_dump;
				switch (dump.dmp_type) {

					case DMP_VECT:
					case DMP_MELTED:
						c_rout_name = dump.dmp_vect -> ex_rout;
						eif_rout_name = RTMS (c_rout_name);
						sprintf (ptr, "%lX\0", dump.dmp_vect -> ex_id);
						obj_addr = RTMS (ptr);

						hack = (uint32) dump.dmp_vect -> ex_orig;
						orig = hack >> 16;
						dtype = hack << 16;
						dtype >>= 16;

						(set_rout) (eif_access (target), 
							(EIF_BOOLEAN) dump.dmp_type == DMP_MELTED,
							(EIF_BOOLEAN) 0,
							obj_addr,
							orig, dtype,
							eif_rout_name);
						return;	
					default:
						break; /* send error */
				}			
			case ACKNLGE:	/* send exhausted */
				(set_rout) (eif_access (target),
					(EIF_BOOLEAN) 0,
					(EIF_BOOLEAN) 1, /* exhausted is true */
					(char *) 0, 0L, (char *) 0);
				return;
			default:
				request_dispatch (pack); /* treat asynchronous request */
				break;	/* send error */	
		}
	}
	else
	(set_error) (eif_access (target));
	return;
}


rt_public c_recv_value (EIF_OBJ target)
	       	       
/*
 *	wait for a request. If it is a dumped item, send it to the RECV_VALUE 
 *	instance target. Else, report an error to target. If the request is not a 
 *	DUMPED, treat it as a normal asynchronous request (and report the error too)
 */
{
	Request pack;
	STREAM *sp = stream_by_fd [EWBOUT];
	Dump dump;
	struct item item;
	uint32 type_flag;

	Request_Clean (pack);
	if (-1 != recv_packet (readfd (sp), &pack)){
		if (pack.rq_type == DUMPED){
			if (pack.rq_dump.dmp_type == DMP_ITEM){
				item = *pack.rq_dump.dmp_item;
				type_flag = item.type;
				switch (type_flag & SK_HEAD) {
					case SK_BOOL:
						set_bool (eif_access (target), item.it_char);
						return;
					case SK_CHAR:
						set_char (eif_access (target), item.it_char);
						return;
					case SK_INT:
						set_integer (eif_access (target), item.it_long);
						return;
					case SK_FLOAT:
						set_real (eif_access (target), item.it_float);
						return;
					case SK_DOUBLE:
						set_double (eif_access (target), item.it_double);
						return;
					case SK_POINTER:
						set_pointer (eif_access (target), item.it_ptr);
						return;
					case SK_REF:
					case SK_EXP:
						set_ref (eif_access (target),
								item.it_ref, 
								type_flag & SK_DTYPE);
							/* reference and dynamic type */
						return;
					case SK_BIT:
						set_bits (eif_access (target),
							item.it_ref, 
							type_flag & SK_BMASK);
							/* reference and number of bits */
						return;
					default:	
						break;
				}
			} else if (pack.rq_dump.dmp_type == DMP_VOID){
				/* No more values to be received */
				(set_void) (eif_access (target));
				return;
			}
		} else{
			request_dispatch (pack);
		}
	}
	(set_error) (eif_access (target)); 
}


rt_public c_pass_recv_routines (EIF_PROC d_int, EIF_PROC d_bool, EIF_PROC d_char, EIF_PROC d_real, EIF_PROC d_double, EIF_PROC d_ref, EIF_PROC d_point, EIF_PROC d_bits, EIF_PROC d_error, EIF_PROC d_void)
                                                        
                                          
/*
 *	Register the routines to communicate with a RECV_VALUE
 */
{
	set_integer = d_int;
	set_bool = d_bool;
	set_char = d_char;
	set_real = d_real;
	set_double = d_double;
	set_ref = d_ref;
	set_pointer = d_point;
	set_bits = d_bits;
	set_error = d_error;
	set_void = d_void;
}
		
rt_public c_pass_set_rout (EIF_PROC d_rout)
                
/*
 *	Register the routine to communicate with a CALL_INFO
 */
{
	set_rout = d_rout;
}
