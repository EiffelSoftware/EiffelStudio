/*

 #          #     ####    #####  ######  #    #           ####
 #          #    #          #    #       ##   #          #    #
 #          #     ####      #    #####   # #  #          #
 #          #         #     #    #       #  # #   ###    #
 #          #    #    #     #    #       #   ##   ###    #    #
 ######     #     ####      #    ######  #    #   ###     ####

	Wide listening on all opened file descriptors (read).
*/

#include "config.h"
#include "portable.h"
#include <sys/types.h>
#include "proto.h"
#include "select.h"
#include "ewbio.h"
#include "stream.h"

extern int ised;		/* Socket used to chat with the daemon */

rt_public void wide_listen(void)
{
	/* Listen on all the file descriptors opened for reading until the
	 * connected socket is broken.
	 */

	/* Make sure we listen on the connected socket and call the handling
	 * routine whenever data is available there.
	 */

	if (-1 == add_input(EWBIN, arqsthandle)) {
#ifdef USE_ADD_LOG
		add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
		dexit(1);
	}

	/* After having selected, we scan all our files to make sure none of them
	 * has been removed from the selection process. If at least one is missing,
	 * we are exiting immediately.
	 */

	while (0 < do_select((struct timeval *) 0)) {
		if (!has_input(EWBIN))			/* Socket connection broken? */
			return;						/* Anyway, abort processing */
	}

#ifdef USE_ADD_LOG
	add_log(12, "do_select: %s (%s)", s_strerror(), s_strname());
#endif
}

