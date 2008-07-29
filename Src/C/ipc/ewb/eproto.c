/*
	description: "[
			Eiffel workbench protocol-specific routines.

			Those must be in a file different from proto.c, since ewb is itself
			written in Eiffel and the run-time already has its own communication
			routines.
			]"
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
#include "eproto.h"
#include "ewb_proto.h"
#include "com.h"
#include "stream.h"
#include "ewbio.h"
#include "ewb_transfer.h"
#include <string.h>

/*
 * Protocol specific routines
 */

rt_public int shell(char *cmd)
{
	/* Run specified shell command synchronously and return its execution
	 * status (0 for ok, 1 for failure).
	 */

	Request rqst;

	Request_Clean (rqst);	/* Recognized as non initialized -- Didier */

	rqst.rq_type = CMD;					/* Command will be run in foreground */

	ewb_send_packet(ewb_sp, &rqst);	/* Processing done by ised */

	if (-1 == send_str(ewb_sp, cmd)) {		/* Send command string */
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return 1;
	}

#ifdef EIF_WINDOWS
	ewb_recv_packet(ewb_sp, &rqst, TRUE);
#else
	ewb_recv_packet(ewb_sp, &rqst);
#endif

	return AK_OK == rqst.rq_ack.ak_type ? 0 : 1;
}

rt_public int background(char *cmd)
{
	/* Run specified shell command asynchronously, and return the job number
	 * attached to it. The application will be notified with an ASYNACK when
	 * the status of this job is known. The notification will include the
	 * job number, of course, so that we know which job has completed.
	 * A -1 is returned if the command cannot be launched at all.
	 */

	Request rqst;

	Request_Clean (rqst);
	rqst.rq_type = ASYNCMD;				/* Daemon will run it in background */
	rqst.rq_opaque.op_1 = ewb_rqstcnt;	/* Use request count as job number */

	ewb_send_packet(ewb_sp, &rqst);	/* Processing done by ised */

	if (-1 == send_str(ewb_sp, cmd)) {		/* Send command string */
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return -1;			/* Cannot launch command */
	}

	return rqst.rq_opaque.op_1;		/* The command's job number */
}

rt_public int app_start(char *cmd)
          			/* The command string (without i/o redirection) */
{
	/* Start application under ised control and establish communication link
	 * with ewb for debugging purpose. Return 0 if ok, -1 for failure.
	 */

	Request rqst;

	Request_Clean (rqst);
	rqst.rq_type = APPLICATION;			/* Request application start-up */

	ewb_send_packet(ewb_sp, &rqst);	/* Send request for ised processing */

	if (-1 == send_str(ewb_sp, cmd)) {		/* Send command string */
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return -1;
	}

#ifdef EIF_WINDOWS
	ewb_recv_packet(ewb_sp, &rqst, TRUE);		/* Acknowledgment */
#else
	ewb_recv_packet(ewb_sp, &rqst);		/* Acknowledgment */
#endif
	return AK_OK == rqst.rq_ack.ak_type ? 0 : -1;
}

