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

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

extern int identify(void);		/* Make sure we are started via the wrapper */

#ifdef EIF_WIN32
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

#ifdef EIF_WIN32
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

