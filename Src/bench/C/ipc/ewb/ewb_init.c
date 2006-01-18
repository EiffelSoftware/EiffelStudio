/*
	description: "[
			Connection initialization.
			For Windows:
				Once connection is established call tpipe to set stream that will
				be used elsewhere.
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
#include <sys/types.h>
#include "eif_logfile.h"
#include "stream.h"
#include "ewbio.h"
#include "proto.h"
#include "transfer.h"
#include <string.h>

extern int identify(void);		/* Make sure we are started via the wrapper */

#ifdef EIF_WINDOWS
extern HANDLE global_ewbin, global_ewbout, global_event_r, global_event_w;
#endif

rt_public void init_connect(void)
{
	STREAM *sp;		/* Stream used for communications with ised */

#ifdef USE_ADD_LOG
	progname = egc_system_name;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */
	(void) open_log("\\tmp\\ewb.log");
	set_loglvl(20);			/* Set debug level */
#endif

	if (-1 == identify())				/* Make sure ised started us */
		dexit(1);

	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 */

#ifdef EIF_WINDOWS
	sp = new_stream(global_ewbin, global_ewbout, global_event_r, global_event_w);
#else
	sp = new_stream(EWBIN, EWBOUT);
#endif

	if (sp == (STREAM *) 0)
		dexit(1);

	prt_init();				/* Initialize IDR filters */
	tpipe(sp);				/* Initialize transfers with application */

#ifdef USE_ADD_LOG
	progpid = getpid();					/* Program's PID */
	progname = egc_system_name;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */
	(void) open_log("/tmp/ised.log");
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#endif
}

#ifdef EIF_WINDOWS
/* C routines for the communications of debugged application and debugger. */

extern STREAM *sp;

typedef void (* EVENT_CALLBACK)(EIF_REFERENCE);
EVENT_CALLBACK event_callback;
EIF_OBJECT event_object;
EIF_INTEGER delay;
UINT_PTR event_id;

void CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime);

void win_ioh_make_client(EIF_POINTER a, EIF_OBJECT o, EIF_INTEGER a_delay)
{
	event_callback = (EVENT_CALLBACK) a;
	event_object = eif_adopt (o);
	delay = a_delay; 
}

void CALLBACK ioh_timer(HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime)
{
	/* KillTimer */
	if (WaitForSingleObject (readev(sp), 0) == WAIT_OBJECT_0)
		(event_callback)(eif_access(event_object));
}

void start_timer (void)
{
	/* Start the timer event to check for communications 
	   between bench and the application */
	event_id = SetTimer (NULL, 0, delay, (TIMERPROC) ioh_timer);
}

void stop_timer (void)
{
	/* Kill the timer event */
	KillTimer (NULL, event_id);
}

#endif
