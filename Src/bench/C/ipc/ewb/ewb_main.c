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
#include "eif_logfile.h"
#include "stream.h"
#include "ewbio.h"
#include <string.h>

extern void welcome(void);			/* Print a welcome message */
rt_public void dexit(int status);	/* Final exiting with logging message */
extern int identify(void);			/* Make sure we are started via the wrapper */

rt_public void main(int argc, char **argv)
{
	int s;			/* The connected socket descriptor */
	STREAM *sp;		/* Stream used for communications with ised */

	/* Compute program name, removing any leading path to keep only the name
	 * of the executable file.
	 */
	progname = rindex(argv[0], '/');	/* Only last name if '/' found */
	if (progname++ == (char *) 0)		/* There were no '/' */
		progname = argv[0];				/* This must be the filename then */
	progpid = getpid();					/* Program's PID */

	/* Open a logfile in /tmp -- FIXME */
	if (0 != open_log("/tmp/ised.log"))
		perror("open_log: cannot open /tmp/ised.log");
	set_loglvl(20);						/* Highest debug level */


	if (-1 == identify())				/* Make sure ised started us */
		dexit(1);

#ifdef NEVER
	welcome();	/* Hello there! */
	yylex();	/* Interactive mode */
	exit(0);
#endif

	/* Create a stream, which associates the two ends of the pair of pipes
	 * opened with the parent. The STREAM provides a bidrectional abstraction.
	 */
	sp = new_stream(EWBIN, EWBOUT);
	if (sp == (STREAM *) 0)
		dexit(1);

	create_listening_window(argc, argv, EWBIN);	/* Plug in listening window */

	dexit(0);
}

rt_public void dexit(int status)
{
#ifdef USE_ADD_LOG
	add_log(12, "exiting with status %d", status);
#endif
	exit(status);
}
