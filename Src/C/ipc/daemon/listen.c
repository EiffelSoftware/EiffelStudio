/*
	description: "Wide listening on all opened file descriptors (read)."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_config.h"
#include "eif_portable.h"
#include <sys/types.h>
#include "dbg_proto.h"
#include "select.h"
#include "timehdr.h"
#include "stream.h"
#include "listen.h"
#include "ecdbgd.h"
#include "eif_logfile.h"
#include <string.h>
#include <signal.h>

#ifdef EIF_WINDOWS
#define ACTIVE_TM	1		/* Active checks performed every 1 seconds */
#elif defined EIF_VMS
#define ACTIVE_TM	5		/* Active checks performed every 5 seconds */
#include <lib$routines.h>
#include <jpidef.h>
#include <ssdef.h>
#else
#define ACTIVE_TM	10		/* Active checks performed every 10 seconds */
#endif

#ifndef EOFPIPE
#ifdef EIF_WINDOWS
rt_private int active_check(STREAM *sp, HANDLE pid);	/* Monitor connection to detect child death */
#else
rt_private int active_check(STREAM *sp, int pid);	/* Monitor connection to detect child death */
#endif
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
#ifndef EIF_WINDOWS
	struct timeval tm;		/* Selection time out */
	struct timeval tmu;		/* Timeout structure used (may be modified) */
#endif
	int nfd;				/* Number of file descriptors processed */
#endif

	/* Make sure we listen on the connected socket and call the handling
	 * routine whenever data is available there.
	 */

#ifdef EIF_WINDOWS
 	if (-1 == add_input(daemon_data.d_cs, (STREAM_FN) drqsthandle)) {
#else
	if (-1 == add_input(daemon_data.d_cs, drqsthandle)) {
#endif

#ifdef USE_ADD_LOG
		add_log(4, "add_input: %s (%s)", s_strerror(), s_strname());
#endif
		daemon_exit(1);
	}

#ifndef EOFPIPE
	/* Okay, select will not detect and EOF condition on a pipe. But that's not
	 * a problem. We simply set up a timeout on the selection, and we will run
	 * some checks if nothing has happened during that period.
	 */
#ifndef EIF_WINDOWS
	tm.tv_sec = ACTIVE_TM;
	tm.tv_usec = 0;
#endif
#endif

	/* After having selected, we scan all our files to make sure none of them
	 * has been removed from the selection process. If at least one is missing,
	 * we are exiting immediately.
	 */
#ifdef EIF_WINDOWS
#ifdef USE_ADD_LOG
		add_log(12, "In dwide_listen");
		close_log();
		reopen_log();
#endif
#endif

#ifdef EOFPIPE
#ifdef EIF_WINDOWS
	while (0 < do_select((char *) 0))
#else
	while (0 < do_select((struct timeval *) 0))
#endif

#else
#ifdef EIF_WINDOWS
	for (;0 <= (nfd = do_select(ACTIVE_TM));)
#else
	for (
		memcpy (&tmu, &tm, sizeof(struct timeval));
		0 <= (nfd = do_select(&tmu));
		memcpy (&tmu, &tm, sizeof(struct timeval))
	)
#endif
#endif
	{
		/* The body of this loop is executed each time an input was detected
		 * from select, or each time it timed out. We perform some sanity
		 * checks on the file descriptors, to make sure no I/O error was
		 * detected (in which case the input is removed).
		 */
#ifdef EIF_WINDOWS
#ifdef USE_ADD_LOG
		add_log(12, "selected");
#endif
		if (!has_input(daemon_data.d_cs))		/* Stream connection broken */
		{
			return;				/* Abort processing */
		}

		if (daemon_data.d_app > 0 && !has_input(daemon_data.d_as)) {
			CloseHandle (daemon_data.d_app);
			daemon_data.d_app = NULL;
#else
		if (!has_input(daemon_data.d_cs))	/* Stream connection broken */
		{
			return;								/* Abort processing */
		}

		if (daemon_data.d_app > 0 && !has_input(daemon_data.d_as)) {
			daemon_data.d_app = 0;
#endif
			close_stream(daemon_data.d_as);
			free(daemon_data.d_as);
			daemon_data.d_as = NULL;
			dead_app();				/* Send a DEAD notification to ewb */
		}

/* Begin code for not EOFPIPE */
#ifndef EOFPIPE
		/* Perform active checks only when the select timed out. Otherwise, we
		 * know the other end is alive (it is talking to us).
		 */

		if (nfd == 0) {				/* Select timed out */
			if (0 != active_check(daemon_data.d_cs, daemon_data.d_ewb)) {
				/* FIXME jfiat: maybe we should kill the d_app process too ?  */
				/* The 'cleaning' will be done during the 'daemon_exit(..)' call 
				 * daemon_data.d_ewb = 0;
				 */
#ifdef USE_ADD_LOG
				add_log(12, "ewb is dead");
#endif
				return;				/* This ends the listening */
			}
			if (0 != active_check(daemon_data.d_as, daemon_data.d_app)) {
#ifdef EIF_WINDOWS
				CloseHandle (daemon_data.d_app);
				daemon_data.d_app = NULL;
				(void) rem_input(daemon_data.d_as);
#else
				daemon_data.d_app = 0;
#endif
				close_stream(daemon_data.d_as);
				free(daemon_data.d_as);
				daemon_data.d_as = NULL;
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

#ifdef EIF_WINDOWS
rt_private int active_check(STREAM *sp, HANDLE pid)
#else
rt_private int active_check(STREAM *sp, int pid)
#endif
	/* Communication channel */
	/* Child's pid */
{
	/* Make sure 'pid' is still alive. If the pid checking facility is enabled
	 * in the kernel, we use that. Otherwise, we send a KPALIVE request,
	 * which will be discarded by the child. The idea being that if the child
	 * is dead, then we'll get a SIGPIPE signal (which is trapped by the
	 * sending routine).
	 */
#ifndef EIF_WINDOWS
#ifndef PIDCHECK
	Request rqst;
#endif
#endif

	if (pid == 0) {				/* No application recorded */
		return 0;				/* Nothing to check */
	}

#ifdef EIF_WINDOWS
	if (WaitForSingleObject (pid, 0) == WAIT_OBJECT_0) {
  		return 1;
	}
#elif defined EIF_VMS
	/* VMS does has PIDCHECK, but only on V7.0 or later, and	*/
	/* only when the _POSIX_EXIT feature test macro is set.		*/
	{
	    VMS_STS st; int schstate;
	    /* just check to see if process is still alive. Use a datum kept in PCB */
	    /* (in nonpaged pool) for minimum overhead */
	    st = lib$getjpi(&JPI$_STATE, &pid, 0, &schstate, 0,0);
	    if (st == SS$_SUSPENDED) { st = 1; }
	    if (!VMS_SUCCESS (st)) {
#ifdef USE_ADD_LOG
		if (st != SS$_NONEXPR) {
		    vaxc$errno = st;
		    add_log(2,"Trouble getting info for process (%d): %d (%s)",
			pid, st, strerror(EVMSERR, st));
		}
#endif /* USE_ADD_LOG */
		    (void) rem_input(sp);	/* Remove its input */
		    return 1;
	    }
	}

#else /* not EIF_VMS */
#ifdef PIDCHECK
	if (-1 == kill(pid, 0)) {			/* If kill fails, the pid is gone */
		(void) rem_input(sp);	/* Remove its input */
		return 1;
	}
#else
	rqst.rq_type = KPALIVE;
	dbg_send_packet(sp, &rqst);	/* Send dummy request */
	if (!has_input(sp)) {		/* Failure, could not send request */
		return 1;				/* Child is dead */
	}
	} /*extra right curly brace? */
#endif /* PIDCHECK */
#endif /* (platform) */
	return 0;		/* Ok, child still alive */
}

#endif
/* End code for not EOFPIPE */
