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

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

extern int identify();			/* Make sure we are started via the wrapper */

public void dexit(status)
int status;
{
    exit(status);
}

public void welcome()
{
	/* Print a welcome message */

	printf("Welcome to the Eiffel workbench!\n");
}

public void init_connect()
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
}
