/*

  ####   ######  #####   #    #  ######  #####            ####
 #       #       #    #  #    #  #       #    #          #    #
  ####   #####   #    #  #    #  #####   #    #          #
      #  #       #####   #    #  #       #####    ###    #
 #    #  #       #   #    #  #   #       #   #    ###    #    #
  ####   ######  #    #    ##    ######  #    #   ###     ####

	Network handling of debugging requests, when application is stopped.
*/

#include "config.h"
#include "portable.h"
#include "proto.h"
#include "ewbio.h"
#include "stream.h"
#include "transfer.h"
#include "logfile.h"

/* This variable records whether the workbench application was launched via
 * the ised wrapper (i.e. in debug mode) or not.
 */
private int debug_mode = 0;	/* Assume not in debug mode */

extern char *ename;			/* Eiffel executable base name (run-time var) */

shared void dserver()
{
	/* This routine is called by the debugger once the program context has
	 * been saved. The application enters in a server mode, after having
	 * sent a stop notification to the remote workbench.
	 */

	if (!debug_mode)		/* If not in debugging mode */
		return;				/* Resume execution immediately */

#ifdef USE_ADD_LOG
	add_log(9, "STOPPED");
#endif

#ifdef NEVER
	stop_rqst(EWBOUT);		/* Notify workbench we stopped */
#endif
	wide_listen();			/* Listen on the socket, waiting for requests */

	/* Exiting from this routine resumes control to the debugger */
}

shared void winit()
{
	/* Initialize the workbench process, by checking whether it has been
	 * started under debugger control or not. This routine is called early
	 * in the process execution by main().
	 */

	STREAM *sp;					/* Stream used to talk to ised */

#ifdef USE_ADD_LOG
	progpid = getpid();					/* Program's PID */
	progname = ename;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */
	(void) open_log("/tmp/ised.log");
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
	add_log(7, "identifying...");
#endif

	if (-1 == identify())		/* Did ised start us? */
		return;					/* No, then debugging is not allowed */

	debug_mode = 1;				/* Debugging is allowed */

	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 * (A pipe is only a one-way communication channel, but a pair of pipes is
	 * a two-way stream, unlike a socket which is already a two-way stream).
	 */

	sp = new_stream(EWBIN, EWBOUT);
	if (sp == (STREAM *) 0)
		enomem();				/* A run-time critical exception */

	tpipe(sp);					/* Initialize tread/twrite transfer pipe */
	prt_init();					/* Initialize IDR filters */

#ifdef USE_ADD_LOG
	add_log(7, "application started in debug mode");
#endif

	wide_listen();				/* Listen to incoming request from ewb */
}

