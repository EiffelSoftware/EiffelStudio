/*
	description: "[
			Runs select on an arbitrary set of file descriptor. This is
			suitable only for input file descriptors. Usually, output
			file descriptors are set with non-blocking I/Os.

			For Windows:
				Our STREAMs are abstract enough to allow the same interface.
				We maintain a list of the pipes with a callback set.
				We inspect each STREAM by using WaitOnMultipleObject on the associated read event.
				Only one event will be triggered at a time so we call the callback on that one.
			]"
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

#include "eif_config.h"	    /* must always be first include files */
#include "eif_portable.h"

#ifdef I_SYS_TIMES
#include <sys/times.h>
#elif defined(I_SYS_TIME)
#include <sys/times.h>
#endif
#include <sys/types.h> /* for Cray */
#include <errno.h>
#include "timehdr.h" 	/* %%ss moved */
#include "select.h"
#include "stream.h"
#include "string.h"

#ifdef EIF_WINDOWS
#include "eif_logfile.h"
#ifndef NOFILE
#define NOFILE VAL_NOFILE	/* File descriptor limit */
#endif
#include <windows.h>

#else
#include "bitmask.h"
#endif /* (not) EIF_WINDOWS */

#ifdef EIF_VMS
#include "ipcvms.h"	/* VMS: force use of select jacket */
#endif /* EIF_VMS */

#define TMP_TIMEOUT	200000	/* Number of micro-seconds for temporary select */

/* Array of call-backs set for ready on input conditions. Those call backs
 * are added into the array via add_input(). Call backs are invoked as soon
 * as something is ready on the file descriptor. The file descriptor is given
 * as argument to the call back.
 * Call backs should not return any status, because how can we imagine which is
 * the best in case of failure?
 */
#ifdef EIF_WINDOWS
rt_private STREAM *callback_handles [NOFILE];		/* Call backs on a per-fd basis */
rt_private STREAM_FN callback_array[NOFILE];		/* Call backs on a per-fd basis */

rt_public STREAM_FN callback (EIF_LPSTREAM);
rt_private void set_callback (EIF_LPSTREAM, STREAM_FN);
void set_multiple_mask (EIF_LPSTREAM, HANDLE mask[NOFILE]);
void unset_multiple_mask (EIF_LPSTREAM, HANDLE mask[NOFILE]);
#else
rt_private STREAM_FN callback[NOFILE];		/* Call backs on a per-fd basis */
#endif

/* The select mask is updated every time a file descriptor is added or removed,
 * as well as the maximum file descriptor number to be used for the select call.
 */

rt_private int nfds = 0;					/* Number of fd to be selected */

#ifdef EIF_WINDOWS
rt_private HANDLE rd_mask [NOFILE] = {0};		/* Read mask */
rt_private HANDLE rd_tmask [NOFILE] = {0};		/* Temporary mask */
#else
rt_private fd_set rd_mask;			/* Read mask */
rt_private fd_set rd_tmask;		/* Temporary mask */
rt_private fd_set read_mask;		/* Mask used for select (altered) */
#endif

/* The global variable s_errno is used to record error conditions from this
 * set of routines. The s_errlist[] array contains a description of each
 * error while s_nerr is the size of that array. Similarily, s_nerrlist[] and
 * s_nerr contain the symbolic names and the size of the array.
 */
rt_public int s_errno = 0;					/* Error number */
rt_private char *s_errlist[] = {			/* List of error messages */
	"OK",								/* No error */
	"Invalid file descriptor",			/* S_FDESC */
	"Invalid callback address",			/* S_CALBAK */
	"A callback is already set",		/* S_CALSET */
	"No callback was set",				/* S_NOCALBAK */
	"Select system call failed",		/* S_SELECT */
	"No input file to select",			/* S_NOFILE */
};
rt_private char *s_nerrlist[] = {			/* Symbolic codes for errors */
	"OK",								/* No error */
	"S_FDESC",							/* Invalid file descriptor */
	"S_CALBAK",							/* Invalid call back address */
	"S_CALSET",							/* Callback is already set */
	"S_NOCALBAK",						/* No callback was set */
	"S_SELECT",							/* Select system call failed */
	"S_NOFILE",							/* No input file to select */
};
rt_private int s_nerr = sizeof(s_errlist);	/* Number of error messages */

/*
 * Setting the parameters.
 */

rt_public int add_input(EIF_PSTREAM sp, STREAM_FN call)
		/* `sp': Stream on which select must be done */
		/* `call': Function to be called when input is available */
{
	/* Add an input condition on file descriptor 'fd', with associated call
	 * back procedure and update internal informations.
	 * The function returns 0 if ok, -1 otherwise (call back pointer void or
	 * file descriptor invalid) and sets 's_errno'
	 */
#ifdef EIF_WINDOWS
	if (nfds >= NOFILE) {					/* File descriptor out of range */
#else
	int fd = readfd(sp);
	if (fd < 0 || fd >= NOFILE) {			/* File descriptor out of range */
#endif
		s_errno = S_FDESC;					/* Invalid file descriptor */
		return -1;
	}

	if (call == NULL) {						/* Null pointer for callback */
		s_errno = S_CALBAK;					/* Invalid callback pointer */
		return -1;
	}

#ifdef EIF_WINDOWS
	if (callback(sp) != NULL) {				/* Callback already set */
#else
	if (callback[fd] != NULL) {				/* Callback already set */
#endif
		s_errno = S_CALSET;					/* Cannot override old callback */
		return -1;
	}

#ifdef EIF_WINDOWS
	set_callback(sp, call);				/* Record callback */
	set_multiple_mask(sp, rd_mask);		/* Select will monitor this fd */
	set_multiple_mask(sp, rd_tmask);	/* Also set temporary mask */
#else
	if ((fd + 1) > nfds)				/* Keep number of fd up-to-date */
		nfds = fd + 1;					/* Fd start at 0 */
	callback[fd] = call;				/* Record callback */
	FD_SET(fd, &rd_mask);				/* Select will monitor this fd */
	FD_SET(fd, &rd_tmask);				/* Also set temporary mask */
#endif
	return 0;			/* Ok status */
}

rt_public STREAM_FN new_callback(EIF_PSTREAM sp, STREAM_FN call)
		/* `sp': STREAM on which select must be done */
		/* `call': New function to be called when input is available */
{
	/* Change the call back associated with the file descriptor and return the
	 * old call back. If no input was associated with that file descriptor,
	 * it is an error and a null pointer is returned.
	 */

	STREAM_FN old_call;					/* The old call back set for that fd */

#ifdef EIF_WINDOWS
	if (call == NULL) {					/* Null pointer for callback */
		s_errno = S_CALBAK;				/* Invalid callback pointer */
		return NULL;
	}

	old_call = callback(sp);			/* Previously stored callback address */
	set_callback(sp, NULL);				/* Otherwise add_input() will fail */

	if (-1 == add_input(sp, call)) {	/* Failed, restore old status */
		set_callback(sp,old_call);		/* Reset old callback value */
		return NULL;					/* No change occurred */
	}
#else
	int fd = readfd(sp);

	if (fd < 0 || fd >= NOFILE) {		/* File descriptor out of range */
		s_errno = S_FDESC;				/* Invalid file descriptor */
		return NULL;
	}
	if (call == NULL) {						/* Null pointer for callback */
		s_errno = S_CALBAK;				/* Invalid callback pointer */
		return NULL;
	}
	old_call = callback[fd];			/* Previously stored callback address */
	callback[fd] = NULL;				/* Otherwise add_input() will fail */

	if (-1 == add_input(sp, call)) {	/* Failed, restore old status */
		callback[fd] = old_call;		/* Reset old callback value */
		return NULL;					/* No change occurred */
	}
#endif

	return old_call;	/* Success: return old value (cannot be null) */
}

rt_public STREAM_FN rem_input(EIF_PSTREAM sp)
		/* `sp': Stream on which no select is to be done */
{
	/* This function removes the input and associated callback for 'sp' and
	 * returns the old callback value.
	 */

	STREAM_FN old_call;					/* The old call back set for that fd */

#ifdef EIF_WINDOWS
	old_call = callback(sp);		/* Save previous callback value */
	set_callback(sp, NULL);			/* And clear entry anyway */
	if (old_call == NULL) {			/* No callback was set */
		s_errno = S_NOCALBAK;		/* This error does not really matter */
		return NULL;			/* As we cleared the entry already */
	}

	/* Update the reading mask and the nfds value. This is important, because
	 * it is the only way do_select() can tell whether there is at least one
  	 * input file descriptor. Otherwise, with a null timout, we could block
  	 * forever.
  	 */

	unset_multiple_mask(sp, rd_mask);				/* We no longer need to monitor it */
	unset_multiple_mask(sp, rd_tmask);				/* Remove it also from temporary mask */

#else
	int i;								/* To eventually update nfds */
	int fd = readfd(sp);

	if (fd < 0 || fd >= NOFILE) {		/* File descriptor out of range */
		s_errno = S_FDESC;
		return NULL;
	}

	old_call = callback[fd];			/* Save previous callback value */
	callback[fd] = NULL;				/* And clear entry anyway */

	if (old_call == NULL) {				/* No callback was set */
		s_errno = S_NOCALBAK;			/* This error does not really matter */
		return NULL;					/* As we cleared the entry already */
	}

	/* Update the reading mask and the nfds value. This is important, because
	 * it is the only way do_select() can tell whether there is at least one
	 * input file descriptor. Otherwise, with a null timout, we could block
	 * forever.
	 */
	FD_CLR(fd, &rd_mask);				/* We no longer need to monitor it */
	FD_CLR(fd, &rd_tmask);				/* Remove it also from temporary mask */
	if (nfds == (fd + 1)) {				/* This file was the maximum fd */
		nfds = 0;						/* Assume no more file */
		for (i = fd - 1; i >= 0; i--)
			if (callback[i] != NULL) {
				nfds = i + 1;			/* Number of fd still monitored */
				break;					/* Found it, break loop */
			}
	}
#endif

	return old_call;	/* Success: return old value (cannot be null) */
}

rt_public int has_input(EIF_PSTREAM sp)
{
	/* Returns 1 if the associated 'fd' has an input callback recorded, 0 if
	 * the file is not selected, and -1 in case of error.
	 */

#ifdef EIF_WINDOWS
	if (callback(sp) != NULL)
		return 1;
#else
	int fd = readfd(sp);
	if (fd < 0 || fd >= NOFILE) {			/* File descriptor out of range */
		s_errno = S_FDESC;					/* Invalid file descriptor */
		return -1;
	}

	if (callback[fd] != NULL)
		return 1;
#endif

	return 0;			/* This file is not selected any more */
}

/*
 * Description of errors.
 */

rt_public char *s_strerror(void)
{
	/* Return a description of the last error, as described by 's_errno' */

	if (s_errno < 0 || s_errno >= s_nerr)	/* Value out of range */
		return "Unknown";					/* Unknown error */

	return s_errlist[s_errno];				/* English description */
}

rt_public char *s_strname(void)
{
	/* Return the symbolic name of the last error, as described by 's_errno' */

	if (s_errno < 0 || s_errno >= s_nerr)	/* Value out of range */
		return "UNKNOWN";					/* Unknow mnemonic */

	return s_nerrlist[s_errno];				/* Symbolic name of error */
}

/*
 * Perform select system call.
 */

#ifdef EIF_WINDOWS
rt_public int do_select(DWORD timeout)
#else
rt_public int do_select(struct timeval *timeout)
#endif
{
	/* Finally, this runs the select call with the computed read mask, with the
	 * specified timeout. The return value is simply the propagated status we
	 * got from select() itself. If some input is available, we handle it by
	 * calling the specified callback routine. If more than one file descriptor
	 * was ready, we handle them all before returning.
	 * Note that when the select call is interrupted by a signal, it is
	 * restarted automatically.
	 */

	STREAM* sp;						/* To loop over STREAM* */
#ifdef EIF_WINDOWS
	DWORD first_timeout;			/* Timeout used for first select */
	DWORD nfd;						/* Status reported by select */
	int isfirst = 1;				/* Mark first select */
#else
	struct timeval first_timeout;	/* Timeout used for first select */
	int nfd;						/* Status reported by select */
	int fd;							/* To loop over file descriptors */
	int isfirst = 1;				/* Mark first select */
#endif

	/* If no more file are to be selected, return immediately with a proper
	 * error status in 's_errno'. This should be a convenient way to detect
	 * that all the input sources have been removed, if this is only a
	 * meta-knowledge.
	 */

	if (nfds == 0) {
		s_errno = S_NOFILE;			/* No more input file */
		return -1;
	}

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "selecting with mask 0x%lx", rd_mask);
#endif
#endif

	/* Loop until select() succeeds or fails for any reason but a signal */
	for (;;) {

#ifdef USE_ADD_LOG
	add_log(20, "selecting");
#endif

		/* The first select is done with TMP_TIMEOUT time unless a timeout is
		 * given. The temporary mask is used for this first selection. That
		 * way, we do not select for the temporary "out" files, which increases
		 * the chance of having the remote end of a stream clear to send the
		 * next time those files are selected.
		 */
#ifdef EIF_WINDOWS
#ifdef USE_ADD_LOG
	add_log(20, "Selecting on count %d", nfds);
	{
	int i;
	for (i = 0; i < nfds; i++)
		add_log (20, "   semaphore %d", rd_tmask [i]);
	}
#endif
#endif

#ifdef EIF_WINDOWS
		if (isfirst) {
			if (timeout == 0) {
				first_timeout = TMP_TIMEOUT;
				nfd = WaitForMultipleObjects (nfds, rd_tmask, FALSE, first_timeout / 1000);
			} else {
				first_timeout = timeout;
				nfd = WaitForMultipleObjects (nfds, rd_tmask, FALSE, first_timeout * 1000);
			}
		} else {
			nfd = WaitForMultipleObjects (nfds, rd_mask, FALSE, timeout * 1000);
		}

		if (nfd == WAIT_FAILED) {
#ifdef USE_ADD_LOG
	add_log(20, "Select failure %d count %d", GetLastError(), nfds);
#endif
			s_errno = S_SELECT;		/* Signals: select failed */
			return -1;				/* Propagate error status */
			}

		if (isfirst) {
			isfirst = 0;
			if (nfd == WAIT_TIMEOUT && timeout == 0) {
				continue;				/* First select timed out */
			}
		}
		break;							/* Exit from loop */
#else
		if (isfirst) {
			if (timeout == (struct timeval *) 0) {
				first_timeout.tv_sec = 0;
				first_timeout.tv_usec = TMP_TIMEOUT;
			} else {
				memcpy (&first_timeout, timeout, sizeof(struct timeval));
			}
			memcpy (&read_mask, &rd_tmask, sizeof(fd_set));
			nfd = select(nfds, &read_mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &first_timeout);
		} else {
			memcpy (&read_mask, &rd_mask, sizeof(fd_set));
			nfd = select(nfds, &read_mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, timeout);
		}

		if (nfd == -1) {
			if (errno != EINTR) {		/* Not interrupted by a signal */
				s_errno = S_SELECT;		/* Signals: select failed */
				return -1;				/* Propagate error status */
			} else {
				continue;				/* Re-issue the system call */
			}
		}

		if (isfirst) {
			isfirst = 0;
			if (nfd == 0 && timeout == (struct timeval *) 0) {
				continue;				/* First select timed out */
			}
		}
		break;							/* Exit from loop */
#endif
	} /* end of for(;;) */

	/* If we come here, then the select call must have succeded. If the timeout
	 * value was reached, nfd is set to 0. Otherwise, it is set to the number
	 * of ready file descriptors.
	 */

#ifdef EIF_WINDOWS
	if (nfd == WAIT_TIMEOUT) {			/* Select timed out */
#else
	if (nfd == 0) {						/* Select timed out */
#endif
		return 0;						/* Propagate status */
	}

#ifdef EIF_WINDOWS
	sp = callback_handles [nfd - WAIT_OBJECT_0];
#endif

#ifdef DEBUG
#ifdef EIF_WINDOWS
#ifdef USE_ADD_LOG
			add_log(20, "file descriptor #%d is ready", sp->sr);
#endif
#else /* if not EIF_WINDOWS */
#ifdef USE_ADD_LOG
	for (fd = 0; fd < nfds; fd++)
		if (FD_ISSET(fd, &read_mask))	/* Something is present */
			add_log(20, "file descriptor #%d is ready", fd);
#endif
#endif
#endif

	/* Loop over the file descriptors and process any of them which is marked
	 * as ready for reading.
	 */

#ifdef EIF_WINDOWS
	callback_array [nfd - WAIT_OBJECT_0](sp);	/* Wake up associated callback */
#else
	for (fd = 0; fd < nfds; fd++) {
		if (FD_ISSET(fd, &read_mask)) {	/* Something is present */
			sp = stream_by_fd[fd];
			(callback[fd])(sp);			/* Wake up associated callback */
		};
	}
#endif

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "select call returning %d", nfd);
#endif
#endif


#ifdef EIF_WINDOWS
	return 1;				/* Number of files processed */
#else
	return nfd;				/* Number of files processed */
#endif
}

#ifdef EIF_WINDOWS
STREAM_FN callback(STREAM *h)
{
	int i;

	for (i = 0; i < nfds; i++)
		if (readfd(callback_handles[i]) == readfd(h))
			return callback_array [i];

	return NULL;
}

void set_callback (STREAM *h, STREAM_FN call)
{
	int i;

	for (i = 0; i < nfds; i++)
		if (readfd(callback_handles [i]) == readfd(h))
			{
			if (call == NULL)
				{
				if (nfds > 1)
					{
					callback_handles [i] = callback_handles [nfds-1];
					callback_array [i] = callback_array [nfds-1];
					}
				else
					{
					callback_handles [i] = NULL;
					callback_array [i] = NULL;
					}
				nfds --;
				}
			else
				callback_array [i] = call;

			return;
			}
	callback_array [nfds] = call;
	callback_handles [nfds] = h;
	nfds ++;
}

void set_multiple_mask (STREAM *h, HANDLE mask[NOFILE])
{
	int i;

	for (i = 0; mask[i] != 0 && i < nfds; i++) {
		if (mask[i] == readev(h)) {
			return ;
		}
	}

	for (i = 0; i < nfds; i++) {
		if (mask[i] == 0) {
			mask [i] = readev(h);
			break;
		}
	}
	if (i == nfds) {
		mask [i-1] = readev(h);
	}
}

void unset_multiple_mask (STREAM *h, HANDLE mask[NOFILE])
{
	int i, j;

	for (i = 0; mask[i] != 0 && i < nfds; i++)
		if (mask [i] == readev(h))
			{
			for (j = i+1; mask[j] != 0 && j < NOFILE-1; j++)
				mask [j-1] = mask[j];
			mask [j - 1] = 0;
			break;
			}
}
#endif
