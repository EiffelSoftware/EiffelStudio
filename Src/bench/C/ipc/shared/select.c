/*

  ####   ######  #       ######   ####    #####           ####
 #       #       #       #       #    #     #            #    #
  ####   #####   #       #####   #          #            #
      #  #       #       #       #          #     ###    #
 #    #  #       #       #       #    #     #     ###    #    #
  ####   ######  ######  ######   ####      #     ###     ####

	Runs select on an arbitrary set of file descriptor. This is
	suitable only for input file descriptors. Usually, output
	file descriptors are set with non-blocking I/Os.
*/

#include "config.h"
#include "portable.h"
#include "timehdr.h" 	/* %%ss moved */
#include "select.h"
#include <errno.h>
/* #include "timehdr.h" */
#include "bitmask.h"

#define TMP_TIMEOUT	200000	/* Number of micro-seconds for temporary select */

/* Array of call-backs set for ready on input conditions. Those call backs
 * are added into the array via add_input(). Call backs are invoked as soon
 * as something is ready on the file descriptor. The file descriptor is given
 * as argument to the call back.
 * Call backs should not return any status, because how can we imagine which is
 * the best in case of failure?
 */
rt_private void (*callback[NOFILE])();		/* Call backs on a per-fd basis */

/* The select mask is updated every time a file descriptor is added or removed,
 * as well as the maximum file descriptor number to be used for the select call.
 */
rt_private fd_set rd_mask;			/* Read mask */
rt_private fd_set rd_tmask;		/* Temporary mask */
rt_private fd_set read_mask;		/* Mask used for select (altered) */
rt_private int nfds = 0;					/* Number of fd to be selected */

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

extern int errno;						/* System call error status */

/*
 * Setting the parameters.
 */

rt_public int add_input(int fd, void (*call) (/* ??? */))
       					/* File descriptor on which select must be done */
               			/* Function to be called when input is available */
{
	/* Add an input condition on file descriptor 'fd', with associated call
	 * back procedure and update internal informations.
	 * The function returns 0 if ok, -1 otherwise (call back pointer void or
	 * file descriptor invalid) and sets 's_errno'
	 */

	if (fd < 0 || fd >= NOFILE) {			/* File descriptor out of range */
		s_errno = S_FDESC;					/* Invalid file descriptor */
		return -1;
	}
	if (call == (void (*)()) 0) {			/* Null pointer for callback */
		s_errno = S_CALBAK;					/* Invalid callback pointer */
		return -1;
	}
	if (callback[fd] != (void (*)()) 0) {	/* Callback already set */
		s_errno = S_CALSET;					/* Cannot override old callback */
		return -1;
	}

	if ((fd + 1) > nfds)				/* Keep number of fd up-to-date */
		nfds = fd + 1;					/* Fd start at 0 */
	callback[fd] = call;				/* Record callback */
	FD_SET(fd, &rd_mask);				/* Select will monitor this fd */
	FD_SET(fd, &rd_tmask);				/* Also set temporary mask */

	return 0;			/* Ok status */
}

rt_public int tmp_input(int fd)
{
	/* Temporarily reset the selection for 'fd' in the temporary read mask. In
	 * effect, we won't select for this file in the next TMP_TIMEOUT seconds.
	 * This is to prevent remotely unavailable strems with high rate local
	 * input to eat all our CPU resources.
	 */

	if (fd < 0 || fd >= NOFILE) {			/* File descriptor out of range */
		s_errno = S_FDESC;					/* Invalid file descriptor */
		return -1;
	}
	if (callback[fd] == (void (*)()) 0) {	/* No current selection */
		s_errno = S_NOCALBAK;				/* No callback was set */
		return -1;
	}

	FD_CLR(fd, &rd_tmask);					/* Clear only temporary mask */

	return 0;
}

rt_public void (*new_callback(int fd, void (*call) (/* ??? */)))(void)
       					/* File descriptor on which select must be done */
               			/* New function to be called when input is available */
{
	/* Change the call back associated with the file descriptor and return the
	 * old call back. If no input was associated with that file descriptor,
	 * it is an error and a null pointer is returned.
	 */

	void (*old_call)();					/* The old call back set for that fd */

	if (fd < 0 || fd >= NOFILE) {		/* File descriptor out of range */
		s_errno = S_FDESC;				/* Invalid file descriptor */
		return (void (*)()) 0;
	}
	if (call == (void (*)()) 0) {		/* Null pointer for callback */
		s_errno = S_CALBAK;				/* Invalid callback pointer */
		return (void (*)()) 0;
	}
	old_call = callback[fd];			/* Previously stored callback address */
	callback[fd] = (void (*)()) 0;		/* Otherwise add_input() will fail */
	if (-1 == add_input(fd, call)) {	/* Failed, restore old status */
		callback[fd] = old_call;		/* Reset old callback value */
		return (void (*)()) 0;			/* No change occurred */
	}

	return old_call;	/* Success: return old value (cannot be null) */
}

rt_public void (*rem_input(int fd))(void)
       					/* File descriptor on which no select is to be done */
{
	/* This function removes the input and associated callback for 'fd' and
	 * returns the old callback value.
	 */

	void (*old_call)();					/* The old call back set for that fd */
	int i;								/* To eventually update nfds */

	if (fd < 0 || fd >= NOFILE) {		/* File descriptor out of range */
		s_errno = S_FDESC;
		return (void (*)()) 0;
	}

	old_call = callback[fd];			/* Save previous callback value */
	callback[fd] = (void (*)()) 0;		/* And clear entry anyway */
	if (old_call == (void (*)()) 0) {	/* No callback was set */
		s_errno = S_NOCALBAK;			/* This error does not really matter */
		return (void (*)()) 0;			/* As we cleared the entry already */
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
			if (callback[i] != (void (*)()) 0) {
				nfds = i + 1;			/* Number of fd still monitored */
				break;					/* Found it, break loop */
			}
	}

	return old_call;	/* Success: return old value (cannot be null) */
}

rt_public int has_input(int fd)
{
	/* Returns 1 if the associated 'fd' has an input callback recorded, 0 if
	 * the file is not selected, and -1 in case of error.
	 */

	if (fd < 0 || fd >= NOFILE) {			/* File descriptor out of range */
		s_errno = S_FDESC;					/* Invalid file descriptor */
		return -1;
	}

	if (callback[fd] != (void (*)()) 0)
		return 1;
	
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
 * Altering the result from select
 */

rt_public void clear_fd(int f)
{
	/* It could happen that while processing one file descriptor, we have to
	 * read another one (e.g. in streams, when we select on both the socket
	 * carrier and the stream and we receive a stream I/O request while sending
	 * one). This function takes care of that. It simply clears the specified
	 * bit in the select mask.
	 */
	
#ifdef DEBUG
#ifdef USE_ADD_LOG
	if (FD_ISSET(f, &read_mask))
		add_log(20, "removing input on file descriptor #%d", f);
#endif
#endif

	FD_CLR(f, &read_mask);			/* Remove active input on the file */
}

/*
 * Perform select system call.
 */

rt_public int do_select(struct timeval *timeout)
{
	/* Finally, this runs the select call with the computed read mask, with the
	 * specified timeout. The return value is simply the propagated status we
	 * got from select() itself. If some input is available, we handle it by
	 * calling the specified callback routine. If more than one file descriptor
	 * was ready, we handle them all before returning.
	 * Note that when the select call is interrupted by a signal, it is
	 * restarted automatically.
	 */
	
	struct timeval first_timeout;	/* Timeout used for first select */
	int nfd;						/* Status reported by select */
	int fd;							/* To loop over file descriptors */
	int isfirst = 1;				/* Mark first select */

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

		/* The first select is done with TMP_TIMEOUT time unless a timeout is
		 * given. The temporary mask is used for this first selection. That
		 * way, we do not select for the temporary "out" files, which increases
		 * the chance of having the remote end of a stream clear to send the
		 * next time those files are selected.
		 */

		if (isfirst) {
			if (timeout == (struct timeval *) 0) {
				first_timeout.tv_sec = 0;
				first_timeout.tv_usec = TMP_TIMEOUT;
			} else
				bcopy(timeout, &first_timeout, sizeof(struct timeval));
			bcopy(&rd_tmask, &read_mask, sizeof(fd_set));
			nfd = select(nfds, &read_mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, &first_timeout);
		} else {
			bcopy(&rd_mask, &read_mask, sizeof(fd_set));
			nfd = select(nfds, &read_mask, (Select_fd_set_t) 0, (Select_fd_set_t) 0, timeout);
		}

		if (nfd == -1)
			if (errno != EINTR) {		/* Not interrupted by a signal */
				s_errno = S_SELECT;		/* Signals: select failed */
				return -1;				/* Propagate error status */
			} else
				continue;				/* Re-issue the system call */

		if (isfirst) {
			bcopy(&rd_tmask, &rd_tmask, sizeof(fd_set));
			isfirst = 0;
			if (nfd == 0 && timeout == (struct timeval *) 0)
				continue;				/* First select timed out */
		}
		break;							/* Exit from loop */
	}

	/* If we come here, then the select call must have succeded. If the timeout
	 * value was reached, nfd is set to 0. Otherwise, it is set to the number
	 * of ready file descriptors.
	 */
	
	if (nfd == 0)						/* Select timed out */
		return 0;						/* Propagate status */

#ifdef DEBUG
#ifdef USE_ADD_LOG
	for (fd = 0; fd < nfds; fd++)
		if (FD_ISSET(fd, &read_mask))	/* Something is present */
			add_log(20, "file descriptor #%d is ready", fd);
#endif
#endif

	/* Loop over the file descriptors and process any of them which is marked
	 * as ready for reading.
	 */
	
	for (fd = 0; fd < nfds; fd++)
		if (FD_ISSET(fd, &read_mask))	/* Something is present */
			(callback[fd])(fd);			/* Wake up associated callback */

#ifdef DEBUG
#ifdef USE_ADD_LOG
	add_log(20, "select call returning %d", nfd);
#endif
#endif

	return nfd;				/* Number of files processed */
}

