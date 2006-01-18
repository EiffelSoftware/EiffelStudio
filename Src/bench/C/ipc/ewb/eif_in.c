/*
	description: "EiffelStudio debugger interface to communicate with daemon."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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

#include "eif_macros.h"
#include "eif_io.h"
#include "eif_in.h"
#include "ewb.h"
#include <string.h>

#ifdef EIF_WINDOWS
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
#ifndef EIF_WINDOWS
	STREAM *sp = stream_by_fd[EWBOUT];
#endif
	Request_Clean (rqst);
		/* ensure Request is all 0 (recognized as non initialized) -- Didier */
#ifdef EIF_WINDOWS
	recv_packet (sp, &rqst, FALSE);
#else
	recv_packet (readfd(sp), &rqst);
#endif
	return request_dispatch (rqst);
}


EIF_REFERENCE request_dispatch (Request rqst)
{
	EIF_REFERENCE eif_string;

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
				sprintf (ptr, "0x%" EIF_POINTER_DISPLAY, (rt_uint_ptr) stop_info.st_where.wh_obj);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_where.wh_origin);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_where.wh_type);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_where.wh_offset);
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

rt_public void send_byte_code (EIF_INTEGER real_body_index, BODY_INDEX real_body_id, char *byte_array, EIF_INTEGER size)
{
/*
	STREAM *sp;
	Request rqst;

	sp = stream_by_fd [EWBOUT];

	Request_Clean (rqst);
	rqst.rq_type = BCODE;
	rqst.rq_opaque.op_first = (int) real_body_index;
	rqst.rq_opaque.op_second = (int) real_body_id;

#ifdef EIF_WINDOWS
	if (-1 == send_packet (sp, &rqst))
#else
	if (-1 == send_packet (writefd(sp), &rqst))
#endif
			printf ("error\n");

	if (-1 == twrite (byte_array, size))
			printf ("error\n");

#ifdef EIF_WINDOWS
	if (-1 == recv_packet (sp, &rqst))
#else
	if (-1 == recv_packet (readfd(sp), &rqst))
#endif
			printf ("error\n");

	if (rqst.rq_type != ACK || rqst.rq_ack.ak_type != AK_OK)
			printf ("error\n");
*/
}

rt_public void send_breakpoint (BODY_INDEX real_body_id, long int offset, EIF_BOOLEAN opcode)
{
/*
	STREAM *sp;
	Request rqst;

	sp = stream_by_fd [EWBOUT];

	Request_Clean (rqst);
	rqst.rq_type = BREAK_ON;
	rqst.rq_opaque.op_first = (int) real_body_index;
	rqst.rq_opaque.op_second = (int) real_body_id;
	rqst.rq_opaque.op_third = offset;

#ifdef EIF_WINDOWS
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

#ifdef EIF_WINDOWS
	send_ack (sp, AK_OK);
#else
	send_ack (writefd(sp), AK_OK);
#endif
*/
}
