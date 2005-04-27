/*

    #    #    #     #     #####           ####
    #    ##   #     #       #            #    #
    #    # #  #     #       #            #
    #    #  # #     #       #     ###    #
    #    #   ##     #       #     ###    #    #
    #    #    #     #       #     ###     ####

	Connection initialization.

	For Windows:
		Once connection is established call tpipe to set stream that will
		be used elsewhere.
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
