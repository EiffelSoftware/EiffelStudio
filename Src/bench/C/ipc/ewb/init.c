/*

    #    #    #     #     #####           ####
    #    ##   #     #       #            #    #
    #    # #  #     #       #            #
    #    #  # #     #       #     ###    #
    #    #   ##     #       #     ###    #    #
    #    #    #     #       #     ###     ####

	Connection initialization.
*/

#include "config.h"
#include "portable.h"
#include <sys/types.h>
#include "logfile.h"
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
extern char *ename;				/* Eiffel program name */

rt_public void init_connect(void)
{
	int s;			/* The connected socket descriptor */
	STREAM *sp;		/* Stream used for communications with ised */

	if (-1 == identify())				/* Make sure ised started us */
		dexit(1);

	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 */
	sp = new_stream(EWBIN, EWBOUT);
	if (sp == (STREAM *) 0)
		dexit(1);

	prt_init();				/* Initialize IDR filters */
	tpipe(sp);				/* Initialize transfers with application */

#ifdef USE_ADD_LOG
	progpid = getpid();					/* Program's PID */
	progname = ename;					/* Computed by Eiffel run-time */

	/* Open a logfile in /tmp */
	(void) open_log("/tmp/ised.log");
	set_loglvl(LOGGING_LEVEL);			/* Set debug level */
#endif
}

