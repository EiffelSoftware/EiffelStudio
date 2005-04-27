/*

 #          #     ####    #####  ######  #    #           ####
 #          #    #          #    #       ##   #          #    #
 #          #     ####      #    #####   # #  #          #
 #          #         #     #    #       #  # #   ###    #
 #          #    #    #     #    #       #   ##   ###    #    #
 ######     #     ####      #    ######  #    #   ###     ####

	Wide listening on all opened file descriptors (read).

	For Windows:
		A #ifdef removed as the nature of the select statement is predetermined.
 */

#include "eif_config.h"
#include "eif_portable.h"
#include <sys/types.h>
#include "proto.h"
#include "select.h"
#include "ewbio.h"
#include "stream.h"
#include "listen.h"
#include "eif_logfile.h"

#ifdef EIF_WINDOWS
extern STREAM *sp;
extern HANDLE global_ewbin, global_ewbout, global_event_r, global_event_w;
#else
extern int ised;		/* Socket used to chat with the daemon */
#endif

rt_public void wide_listen(void)
{
	/* Listen on all the file descriptors opened for reading until the
	 * connected socket is broken.
	 */

	/* Make sure we listen on the connected socket and call the handling
	 * routine whenever data is available there.
	 */

#ifdef EIF_WINDOWS
	if (-1 == add_input(sp, (HANDLE_FN) arqsthandle)) {
#else
	if (-1 == add_input(EWBIN, arqsthandle)) {
#endif

#ifdef USE_ADD_LOG
		add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
		dexit(1);
	}

#ifdef USE_ADD_LOG
	add_log(12, "in listen");
#endif

	/* After having selected, we scan all our files to make sure none of them
	 * has been removed from the selection process. If at least one is missing,
	 * we are exiting immediately.
	 */

#ifdef EIF_WINDOWS

	while (0 <= do_select(0)) {
#ifdef USE_ADD_LOG
	add_log(12, "in while do_select");
#endif
		if (!has_input(sp)) {			/* Socket connection broken? */
#ifdef USE_ADD_LOG
	add_log(12, "in !has_input which is what we want");
#endif
			return;						/* Anyway, abort processing */
		}
	}
#ifdef USE_ADD_LOG
	add_log(12, "out of listen");
#endif

#else

	while (0 < do_select((struct timeval *) 0)) {
		if (!has_input(EWBIN))			/* Socket connection broken? */
			return;						/* Anyway, abort processing */
	}
#endif

#ifdef USE_ADD_LOG
	add_log(12, "do_select: %s (%s)", s_strerror(), s_strname());
#endif
}
