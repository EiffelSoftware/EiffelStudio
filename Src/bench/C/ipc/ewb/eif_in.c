#include "eif_macros.h"
#include "eif_io.h"
#include "eif_in.h"
#include "ewb.h"
#include <string.h>

#ifdef EIF_WIN32
extern STREAM *sp;
#endif

/*
	Eiffel/C interface routines
*/

EIF_OBJ failure_handler;
EIF_OBJ dead_handler;
EIF_OBJ stopped_handler;

EIF_PROC failure_hdlr_set;
EIF_PROC dead_hdlr_set;
EIF_PROC stopped_hdlr_set;

void rqst_handler_to_c(EIF_OBJ eif_rqst_hdlr, EIF_INTEGER rqst_type, EIF_PROC eif_set)
{
	/* Keep a reference in C to the Eiffel objects
	 * handling the requests from ised.
	 */

	switch (rqst_type) {
		case REP_FAILURE:
			failure_handler = eif_adopt (eif_rqst_hdlr);
			failure_hdlr_set = eif_set;
			break;
		case REP_DEAD:
			dead_handler = eif_adopt (eif_rqst_hdlr);
			dead_hdlr_set = eif_set;
			break;
		case REP_STOPPED:
			stopped_handler = eif_adopt (eif_rqst_hdlr);
			stopped_hdlr_set = eif_set;
			break;
	}
}


EIF_REFERENCE request_handler (void)
{
	/* Dispatch request from ised to
	 * proper RQST_HANDLER Eiffel object
	 */

	Request rqst;
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif
	Request_Clean (rqst);
		/* ensure Request is all 0 (recognized as non initialized) -- Didier */
#ifdef EIF_WIN32
	recv_packet (sp, &rqst, FALSE);
#else
	recv_packet (readfd(sp), &rqst);
#endif
	return request_dispatch (rqst);
}


EIF_REFERENCE request_dispatch (Request rqst)
{
	char *eif_string;

	switch (rqst.rq_type) {
		case ASYNACK:
			return (char *) 0;
		case ACKNLGE:
			return (char *) 0;
		case DEAD:
			eif_string = makestr ("Nothing", 7);
			(dead_hdlr_set) (eif_access (dead_handler), eif_string);
			return eif_access (dead_handler);
		case STOPPED:
			{
				Stop stop_info;
				char string [1024], *ptr = string;

				stop_info = rqst.rqu.rqu_stop;
				strcpy (ptr, stop_info.st_where.wh_name);
				ptr += strlen (ptr) + 1; /* one char farther than terminating NULL */
				sprintf (ptr, "0x%lX", stop_info.st_where.wh_obj);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_where.wh_origin);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_where.wh_type);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%ld", stop_info.st_where.wh_offset);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_why);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_code);
				ptr += strlen (ptr) + 1;
				strcpy (ptr, stop_info.st_tag);
				ptr += strlen (ptr); /* terminating null so that (ptr - string) is the length */
				eif_string = makestr (string, ptr - string);
				(stopped_hdlr_set) (eif_access (stopped_handler), eif_string);
				return eif_access (stopped_handler);
			}
		default:
			eif_string = makestr ("Nothing", 7);
			(failure_hdlr_set) (eif_access (failure_handler), eif_string);
			return eif_access (failure_handler);
		}
}

/*
	External C routines for the various Eiffel
	request handlers (RQST_HANDLER classes).
*/

rt_public void send_byte_code (EIF_INTEGER real_body_index, EIF_INTEGER real_body_id, char *byte_array, EIF_INTEGER size)
{
/*
	STREAM *sp;
	Request rqst;

	sp = stream_by_fd [EWBOUT];

	Request_Clean (rqst);
	rqst.rq_type = BCODE;
	rqst.rq_opaque.op_first = (int) real_body_index;
	rqst.rq_opaque.op_second = (int) real_body_id;

#ifdef EIF_WIN32
	if (-1 == send_packet (sp, &rqst))
#else
	if (-1 == send_packet (writefd(sp), &rqst))
#endif
			printf ("error\n");

	if (-1 == twrite (byte_array, size))
			printf ("error\n");

#ifdef EIF_WIN32
	if (-1 == recv_packet (sp, &rqst))
#else
	if (-1 == recv_packet (readfd(sp), &rqst))
#endif
			printf ("error\n");

	if (rqst.rq_type != ACK || rqst.rq_ack.ak_type != AK_OK)
			printf ("error\n");
*/
}

rt_public void send_breakpoint (long int real_body_id, long int offset, EIF_BOOLEAN opcode)
{
/*
	STREAM *sp;
	Request rqst;

	sp = stream_by_fd [EWBOUT];

	Request_Clean (rqst);
	rqst.rq_type = BREAK_ON;
	rqst.rq_opaque.op_first = (int) real_body_index;
	rqst.rq_opaque.op_second = (int) real_body_id;
	rqst.rq_opaque.op_third = (long) offset;

#ifdef EIF_WIN32
	if (-1 == send_packet (sp, &rqst))
#else
	if (-1 == send_packet (writefd(sp), &rqst))
#endif
		error

	if (rqst.rq_type != ACK || rqst.rq_ack.ak_type != AK_OK)
			printf ("error\n");
*/
}

rt_public void send_ack_end (void)
{
/*
	STREAM *sp = stream_by_fd [EWBOUT];

#ifdef EIF_WIN32
	send_ack (sp, AK_OK);
#else
	send_ack (writefd(sp), AK_OK);
#endif
*/
}
