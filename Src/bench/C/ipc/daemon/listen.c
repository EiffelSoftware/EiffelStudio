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
#include "timehdr.h"
#include "stream.h"

#define ACTIVE_TM	10		/* Active checks performed every 10 seconds */

#ifndef EOFPIPE
rt_private int active_check(STREAM *sp, int pid);	/* Monitor connection to detect child death */
#endif

rt_public void dwide_listen(void)
{
	/* Listen on all the file descriptors opened for reading until the
	 * connected socket is broken. If the socket is in fact a pipe, then there
	 * is a chance select() will not wake up on the EOF condition... Therefore,
	 * in that case, we use some other tricks to make sure our children are
	 * still playing quietly in the garden.
	 */

#ifndef EOFPIPE
	struct timeval tm;		/* Selection time out */
	struct timeval tmu;		/* Timeout structure used (may be modified) */
	int nfd;				/* Number of file descriptors processed */
#endif

	/* Make sure we listen on the connected socket and call the handling
	 * routine whenever data is available there.
	 */
	if (-1 == add_input(readfd(d_data.d_cs), drqsthandle)) {
#ifdef USE_ADD_LOG
		add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
		dexit(1);
	}

#ifndef EOFPIPE
	/* Okay, select will not detect and EOF condition on a pipe. But that's not
	 * a problem. We simply set up a timeout on the selection, and we will run
	 * some checks if nothing has happened during that period.
	 */

	tm.tv_sec = ACTIVE_TM;
	tm.tv_usec = 0;
#endif

	/* After having selected, we scan all our files to make sure none of them
	 * has been removed from the selection process. If at least one is missing,
	 * we are exiting immediately.
	 */

#ifdef EOFPIPE
	while (0 < do_select((struct timeval *) 0))
#else
	for (
		bcopy(&tm, &tmu, sizeof(struct timeval));
		0 <= (nfd = do_select(&tmu));
		bcopy(&tm, &tmu, sizeof(struct timeval))
	)
#endif
	{
		/* The body of this loop is executed each time an input was detected
		 * from select, or each time it timed out. We perform some sanity
		 * checks on the file descriptors, to make sure no I/O error was
		 * detected (in which case the input is removed).
		 */

		if (!has_input(readfd(d_data.d_cs)))	/* Stream connection broken */
			return;								/* Abort processing */

		if (d_data.d_app > 0 && !has_input(readfd(d_data.d_as))) {
			d_data.d_app = 0;
			close_stream(d_data.d_as);
			dead_app();				/* Send a DEAD notification to ewb */
		}

/* Begin code for not EOFPIPE */
#ifndef EOFPIPE
		/* Perform active checks only when the select timed out. Otherwise, we
		 * know the other end is alive (it is talking to us).
		 */

		if (nfd == 0) {				/* Select timed out */
			if (0 != active_check(d_data.d_cs, d_data.d_ewb)) {
				d_data.d_ewb = 0;
#ifdef USE_ADD_LOG
				add_log(12, "ewb is dead");
#endif
				return;				/* This ends the listening */
			}
			if (0 != active_check(d_data.d_as, d_data.d_app)) {
				d_data.d_app = 0;
				close_stream(d_data.d_as);
				dead_app();			/* Send a DEAD notification to ewb */
			}
		}
#endif
/* End code for not EOFPIPE */
	}

#ifdef USE_ADD_LOG
	add_log(12, "do_select: %s (%s)", s_strerror(), s_strname());
#endif
}

/* Begin code for not EOFPIPE */
#ifndef EOFPIPE

/* The select system call is unable to detect the EOF on a pipe. The following
 * function provides a means for the daemon to check whether its child is
 * alive (there is no SO_KEEPALIVE option on a pipe unfortunately :-).
 */

#ifndef PIDCHECK
#include "request.h"
#endif

rt_private int active_check(STREAM *sp, int pid)
	/* Communication channel */
	/* Child's pid */
{
	/* Make sure 'pid' is still alive. If the pid checking facility is enabled
	 * in the kernel, we use that. Otherwise, we send a KPALIVE request,
	 * which will be discarded by the child. The idea being that if the child
	 * is dead, then we'll get a SIGPIPE signal (which is trapped by the
	 * sending routine).
	 */

#ifndef PIDCHECK
	Request rqst;
#endif

	if (pid == 0)				/* No application recorded */
		return 0;				/* Nothing to check */

#ifdef PIDCHECK
	if (-1 == kill(pid, 0)) {			/* If kill fails, the pid is gone */
		(void) rem_input(readfd(sp));	/* Remove its input */
		return 1;
	}
#else
	rqst.rq_type = KPALIVE;
	send_packet(writefd(sp), &rqst);	/* Send dummy request */
	if (!has_input(readfd(sp)))			/* Failure, could not send request */
		return 1;						/* Child is dead */
	}
#endif

	return 0;		/* Ok, child still alive */
}

#endif
/* End code for not EOFPIPE */

