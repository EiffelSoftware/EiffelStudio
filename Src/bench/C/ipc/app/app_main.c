/*

 #    #    ##       #    #    #           ####
 ##  ##   #  #      #    ##   #          #    #
 # ## #  #    #     #    # #  #          #
 #    #  ######     #    #  # #   ###    #
 #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #     #    #    #   ###     ####

	The main entry point.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include <sys/types.h>
#include <stdio.h>
#include "eif_logfile.h"
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif
#include "stream.h"
#include "ewbio.h"
#include "transfer.h"

extern char *rindex(const char *s, int c);
extern unsigned TIMEOUT;

rt_public void main(int argc, char **argv)
{
	/* This is the main entry point for the application */

	/* Compute program name, removing any leading path to keep only the name
	 * of the executable file.
	 */
	progname = rindex(argv[0], '/');		/* Only last name if '/' found */
	if (progname++ == (char *) 0)			/* There were no '/' */
		progname = argv[0];					/* This must be the filename then */
	progpid = getpid();						/* Program's PID */

	/* Open a logfile in /tmp -- FIXME */
	if (0 != open_log("/tmp/ised.log"))
		perror("open_log: cannot open /tmp/ised.log");
	set_loglvl(20);							/* Highest debug level */

	add_log(12, "starting application process");

	if (-1 == identify())				/* Make sure ised started us */
		dexit(1);

	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 * (A pipe is only a one-way communication channel, but a pair of pipes is
	 * a two-way stream, unlike a socket which is already a two-way stream).
	 */

	(void) new_stream(EWBIN, EWBOUT);
	alarm(TIMEOUT);			/* Ensure we'll die in TIMEOUT seconds */
	wide_listen();

	end_debug(); /* Free communication buffer if necessary */
	exit(0);
}


