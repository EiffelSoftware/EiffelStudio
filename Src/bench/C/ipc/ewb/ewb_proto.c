/*
	description: "Protocol handling. Send requests and wait for answers."
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

#include "eif_config.h"
#include "eif_portable.h"
#include <stdio.h>		/* For error reports -- FIXME */
#include <sys/types.h>
#include "request.h"
#include "rqst_idrs.h"
#include "proto.h"
#include "eif_network.h"
#include "eif_logfile.h"

#ifdef EIF_WINDOWS
#include "eif_argcargv.h"
#include "stream.h"
#endif

rt_public int rqstcnt = 0;		/* Request count, must match with daemon's one */

rt_private IDRF idrf;			/* IDR filter for serializations */

/*
 * IDR protocol initialization.
 */

#ifdef EIF_WINDOWS
rt_public void prt_destroy(EIF_BOOLEAN t)
{
	idrf_destroy (&idrf);
}
#endif

rt_public void prt_init(void)
{
	if (-1 == idrf_create(&idrf, IDRF_SIZE))
		fatal_error("cannot initialize streams");		/* Run-time routine */
#ifdef EIF_WINDOWS
	eif_register_cleanup (prt_destroy);
#endif
}

/*
 * Sending requests - Receiving answers
 */

#ifdef EIF_WINDOWS
rt_public void send_packet(STREAM *s, Request *rqst)
#else
rt_public void send_packet(int s, Request *rqst)
#endif
      				/* The connected socket */
              		/* The request to be sent */
{
	/* Sends an answer to the client */

	rqstcnt++;			/* One more request sent to daemon */
	idrf_reset_pos(&idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&idrf.i_encode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unable to serialize request %d", rqst->rq_type);
#endif
		dexit(1);
	}

	/* Send the answer and propagate error report */
	if (-1 == net_send(s, idrs_buf(&idrf.i_encode), IDRF_SIZE)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR send: %m (%e)");
#endif
		dexit(1);
	}

#ifdef DEBUG
	trace_request("sent", rqst);
#endif
}

#ifdef EIF_WINDOWS
rt_public int recv_packet(STREAM *s, Request *dans, BOOL reset)
#else
rt_public int recv_packet(int s, Request *dans)
#endif
      				/* The connected socket */
              		/* The daemon's answer */
{
	/* Wait for an answer and fill in the Request structure, then de-serialize
	 * it. If an error occurs, return -1. Otherwise return 0;
	 */

	rqstcnt++;			/* One more request received */
	idrf_reset_pos(&idrf);	/* Reposition IDR streams */

	/* Wait for request */
#ifdef EIF_WINDOWS
	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE, reset)) {
#else
	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE)) {
#endif

#ifdef USE_ADD_LOG
		add_log(2, "SYSERR recv: %m (%e)");
#endif
		return -1;		/* Connection lost, probably */
	}

	/* Deserialize request */
	if (!idr_Request(&idrf.i_decode, dans)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot deserialize request");
#endif
		return -1;
	}

#ifdef DEBUG
	trace_request("got", dans);
#endif

	return 0;		/* All is ok */
}
