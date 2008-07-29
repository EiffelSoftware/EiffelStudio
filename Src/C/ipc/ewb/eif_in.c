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
#include "stream.h"
#include "rt_assert.h"

/*
	Eiffel/C interface routines
*/

rt_private EIF_OBJ failure_handler;
rt_private EIF_OBJ dead_handler;
rt_private EIF_OBJ notify_handler;
rt_private EIF_OBJ stopped_handler;

rt_private EIF_PROC failure_hdlr_set;
rt_private EIF_PROC dead_hdlr_set;
rt_private EIF_PROC notify_hdlr_set;
rt_private EIF_PROC stopped_hdlr_set;

rt_public void rqst_handler_to_c(EIF_OBJ eif_rqst_hdlr, EIF_INTEGER rqst_type, EIF_PROC eif_set)
{
	/* Keep a reference in C to the Eiffel objects
	 * handling the requests from ised.
	 */

	REQUIRE("handler_not_null", eif_rqst_hdlr);

	switch (rqst_type) {
		case REP_FAILURE:
			if (eif_access(eif_rqst_hdlr) == NULL && eif_set == NULL) {
				if (failure_handler != NULL) {
					eif_wean(failure_handler);
					failure_handler = NULL;
				}
				failure_hdlr_set = NULL;
			} else {
				failure_handler = eif_adopt (eif_rqst_hdlr);
				failure_hdlr_set = eif_set;
			}
			break;
		case REP_DEAD:
			if (eif_access(eif_rqst_hdlr) == NULL && eif_set == NULL) {
				if (dead_handler != NULL) {
					eif_wean(dead_handler);
					dead_handler = NULL;
				}
				dead_hdlr_set = NULL;
			} else {
				dead_handler = eif_adopt (eif_rqst_hdlr);
				dead_hdlr_set = eif_set;
			}
			break;
		case REP_NOTIFIED:
			if (eif_access(eif_rqst_hdlr) == NULL && eif_set == NULL) {
				if (notify_handler != NULL) {
					eif_wean(notify_handler);
					notify_handler = NULL;
				}
				notify_hdlr_set = NULL;
			} else {
				notify_handler = eif_adopt (eif_rqst_hdlr);
				notify_hdlr_set = eif_set;
			}
			break;
		case REP_STOPPED:
			if (eif_access(eif_rqst_hdlr) == NULL && eif_set == NULL) {
				if (stopped_handler != NULL) {
					eif_wean(stopped_handler);
					stopped_handler = NULL;
				}
				stopped_hdlr_set = NULL;
			} else {
				stopped_handler = eif_adopt (eif_rqst_hdlr);
				stopped_hdlr_set = eif_set;
			}
			break;
	}
}

rt_public EIF_REFERENCE request_handler (void)
{
	/* Dispatch request from ised to
	 * proper RQST_HANDLER Eiffel object
	 */

	Request rqst;
	Request_Clean (rqst);

		/* ensure Request is all 0 (recognized as non initialized) -- Didier */
#ifdef EIF_WINDOWS
	ewb_recv_packet (ewb_sp, &rqst, FALSE);
#else
	ewb_recv_packet (ewb_sp, &rqst);
#endif
	return request_dispatch (rqst);
}


rt_public EIF_REFERENCE request_dispatch (Request rqst)
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
		case NOTIFIED:
			{
				Notif notif_info;
				char string [1024], *ptr = string;

				notif_info = rqst.rqu.rqu_event;
				sprintf (ptr, "%i", notif_info.st_type);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", notif_info.st_data);
				ptr += strlen (ptr) + 1;
				eif_string = makestr (string, ptr - string);
				(notify_hdlr_set) (eif_access (notify_handler), eif_string);
				return eif_access (notify_handler);
			}
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
				sprintf (ptr, "%" EIF_POINTER_DISPLAY, (rt_uint_ptr) stop_info.st_where.wh_thread_id);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_why);
				ptr += strlen (ptr) + 1;
				sprintf (ptr, "%i", stop_info.st_exception);
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
	Request rqst;
	STREAM *sp = ewb_sp;


	Request_Clean (rqst);
	rqst.rq_type = BCODE;
	rqst.rq_opaque.op_1 = (int) real_body_index;
	rqst.rq_opaque.op_2 = (int) real_body_id;

#ifdef EIF_WINDOWS
	if (-1 == ewb_send_packet (sp, &rqst))
#else
	if (-1 == ewb_send_packet (sp, &rqst))
#endif
			printf ("error\n");

	if (-1 == ewb_twrite (byte_array, size))
			printf ("error\n");

	if (-1 == ewb_recv_packet (sp, &rqst))
			printf ("error\n");

	if (rqst.rq_type != ACK || rqst.rq_ack.ak_type != AK_OK)
			printf ("error\n");
*/
}

rt_public void send_breakpoint (BODY_INDEX real_body_id, long int offset, EIF_BOOLEAN opcode)
{
/*
	Request rqst;
	STREAM *sp = ewb_sp;

	Request_Clean (rqst);
	rqst.rq_type = BREAK_ON;
	rqst.rq_opaque.op_1 = (int) real_body_index;
	rqst.rq_opaque.op_2 = (int) real_body_id;
	rqst.rq_opaque.op_3 = offset;

	if (-1 == ewb_send_packet (sp, &rqst))
		error

	if (rqst.rq_type != ACK || rqst.rq_ack.ak_type != AK_OK)
			printf ("error\n");
*/
}

rt_public void send_ack_end (void)
{
/*
	STREAM *sp = ewb_sp;

	send_ack (sp, AK_OK);
*/
}
