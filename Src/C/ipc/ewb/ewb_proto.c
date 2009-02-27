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
#include "ewb_proto.h"
#include "eif_network.h"
#include "eif_logfile.h"

#include "stream.h"
#ifdef EIF_WINDOWS
#include "eif_argcargv.h"
#endif
#ifdef DEBUG
#include "com.h"
#endif

rt_public int ewb_rqstcnt = 0;		/* Request count, must match with daemon's one */

rt_private IDRF ewb_idrf;					/* IDR filter for serializations */
rt_private char ewb_idrf_initialized = (char) 0;	/* IDR filter already initialized ? */

/*
 * IDR protocol initialization.
 */

#ifdef EIF_WINDOWS
rt_public void ewb_prt_destroy(EIF_BOOLEAN t)
{
	idrf_destroy (&ewb_idrf);
}
#endif

rt_public void ewb_prt_init(void)
{
	if (!ewb_idrf_initialized) {
		if (-1 == idrf_create(&ewb_idrf, IDRF_SIZE))
			fatal_error("cannot initialize streams");		/* Run-time routine */
#ifdef EIF_WINDOWS
		eif_register_cleanup (ewb_prt_destroy);
#endif
		ewb_idrf_initialized = (char) 1;
	}
}

/*
 * Sending requests - Receiving answers
 */

rt_public void ewb_send_packet(EIF_PSTREAM sp, Request *rqst)
      				/* The connected socket */
              		/* The request to be sent */
{
	/* Sends an answer to the client */

	ewb_rqstcnt++;			/* One more request sent to daemon */
	idrf_reset_pos(&ewb_idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&ewb_idrf.i_encode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unable to serialize request %d", rqst->rq_type);
#endif
		dexit(1);
	}

	/* Send the answer and propagate error report */
	if (-1 == net_send(sp, idrs_buf(&ewb_idrf.i_encode), IDRF_SIZE)) {
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
rt_public int ewb_recv_packet(EIF_PSTREAM sp, Request *dans , BOOL reset)
#else
rt_public int ewb_recv_packet(EIF_PSTREAM sp, Request *dans)
#endif
      				/* The connected socket */
              		/* The daemon's answer */
{
	/* Wait for an answer and fill in the Request structure, then de-serialize
	 * it. If an error occurs, return -1. Otherwise return 0;
	 */

	ewb_rqstcnt++;			/* One more request received */
	idrf_reset_pos(&ewb_idrf);	/* Reposition IDR streams */

	/* Wait for request */
#ifdef EIF_WINDOWS
	if (-1 == net_recv(sp, idrs_buf(&ewb_idrf.i_decode), IDRF_SIZE, reset)) {
#else
	if (-1 == net_recv(sp, idrs_buf(&ewb_idrf.i_decode), IDRF_SIZE)) {
#endif

#ifdef USE_ADD_LOG
		add_log(2, "SYSERR recv: %m (%e)");
#endif
		return -1;		/* Connection lost, probably */
	}

	/* Deserialize request */
	if (!idr_Request(&ewb_idrf.i_decode, dans)) {
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
