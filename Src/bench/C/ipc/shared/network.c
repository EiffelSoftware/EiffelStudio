/*

 #    #  ######   #####  #    #   ####   #####   #    #           ####
 ##   #  #          #    #    #  #    #  #    #  #   #           #    #
 # #  #  #####      #    #    #  #    #  #    #  ####            #
 #  # #  #          #    # ## #  #    #  #####   #  #     ###    #
 #   ##  #          #    ##  ##  #    #  #   #   #   #    ###    #    #
 #    #  ######     #    #    #   ####   #    #  #    #   ###     ####

	Contains all socket/pipes messages routines.

	$Id$

	As signal may arrive, we must check when an error occurs, that
	it is not the signal's fault.
*/

#ifdef __VMS	/* module name clash with .../library/clib/network.c */
#pragma module IPC_NETWORK
#endif /* __VMS */

#include "eif_portable.h"
#include "eif_network.h"
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <setjmp.h>
#include <sys/types.h>
#include "eif_globals.h"
#include "rt_assert.h"

#ifdef EIF_WIN32
#include <windows.h>
#include "stream.h"
#else
#include <unistd.h>
#endif

#ifdef EIF_VMS
#include "ipcvms.h"
#endif  /* EIF_VMS */

extern unsigned TIMEOUT;		/* Time out on reads */

#ifndef EIF_WIN32

#ifdef ETIMEDOUT
#define NET_TIMEOUT ETIMEDOUT	/* Try to return a meaningful error code */
#else
#define NET_TIMEOUT EPIPE		/* That will do if ETIMEDOUT does not exist */
#endif

#ifdef ECONNRESET
#define NET_BROKEN ECONNRESET	/* Connection reset by peer */
#else
#define NET_BROKEN EPIPE		/* Default error if no ECONNRESET */
#endif

#endif

rt_private jmp_buf env;		/* Environment saving for longjmp() */

#ifdef EIF_WIN32
rt_private void CALLBACK timeout(HWND, UINT, UINT, DWORD);	/* Signal handler for read timeouts */
#else
rt_private Signal_t broken(void);	/* Signal handler for SIGPIPE */
rt_private Signal_t timeout(void);	/* Signal handler for read timeouts */
#ifndef EIF_VMS
extern int errno;	/* shouldn't this be #include <errno.h> for all platforms??? */
#endif
#endif

#ifdef EIF_WIN32
rt_public int net_recv(STREAM *cs, char *buf, size_t size, BOOL reset)
			/* The connected socket descriptor */
			/* Where data are to be stored */
			/* Amount of data to be read */
			/* Reset event associated with cs reader? */
#else
rt_public int net_recv(int cs, char *buf, size_t size)
       				/* The connected socket descriptor */
          			/* Where data are to be stored */
         			/* Amount of data to be read */
#endif
{
	/* Read from network */

	volatile size_t len = 0;		/* Total amount of bytes read */

#ifdef EIF_WIN32
	DWORD length;			/* Amount read by last system call */
	UINT_PTR timer = 0;
	BOOL fSuccess;
#ifdef USE_ADD_LOG
		add_log(2, "in net_recv");
#endif
#else
	Signal_t (*oldalrm)();
	int length;
#endif

	REQUIRE("Valid size", size <= INT32_MAX);

#ifdef EIF_WIN32
	if (0 != setjmp(env)) {
		KillTimer (NULL, timer);        /* Stop alarm clock */
		errno = EPIPE;                          /* Signal timeout on read */
		return -1;
	}

	while (len < size) {
		timer = SetTimer(NULL, timer, TIMEOUT*1000, (TIMERPROC) timeout);   /* Give read only TIMEOUT seconds to succeed */
		fSuccess = ReadFile(readfd(cs), buf + len, (DWORD) (size - len), &length, NULL);
		KillTimer (NULL, timer);

		if (fSuccess)
			if (length == 0)        /* connection closed */
				goto closed;
			else
				;
		else
				return -1;              /* failed */

		len += length;
	}

	if (reset)
		/* There is a problem when there are 0 bytes t send
		 * Literally 0 bytes are sent and the Semaphore is set
		 * We need to release the semaphore in this case
		 */
		if (size == 0) {
				/* Wait to get back in sync. */
			if (WaitForSingleObject (readev(cs), INFINITE) != WAIT_OBJECT_0)
#ifdef USE_ADD_LOG
				add_log (8, "network:97 Bad wait");
#else
				;
#endif
		} else
			if (WaitForSingleObject (readev(cs), 0) != WAIT_OBJECT_0)
#ifdef USE_ADD_LOG
				add_log (8, "network:101 Wait on %d failed", size);
#else
				;
#endif

	return 0;

closed:

	/* Unlike recv(), we return an error condition with a suitable errno code
	 * if possible when and end of file is detected... because we never expect
	 * one. Before closing the connection, the remote application should be
	 * polite enough to send a 'bye' request and wait for us to receive it.
	 */

	errno = EPIPE;				/* conntection is broken */
	KillTimer (NULL, timer);	/* stop alarm clock */

  	return -1;

#else
	oldalrm = signal(SIGALRM, (void (*)(int)) timeout);	/* Trap SIGALRM within this function */

	if (0 != setjmp(env)) {
		alarm(0);					/* Stop alarm clock */
		signal(SIGPIPE, oldalrm);
		errno = NET_TIMEOUT;		/* Signal timeout on read */
		return -1;
	}


	while (len < size) {

		alarm(TIMEOUT);			/* Give read only TIMEOUT seconds to succeed */
		length = read(cs, buf + len, size - len);
		alarm(0);

		if (length == 0)	/* connection closed */
			goto closed;

		if (length == -1) {
			if (errno != EINTR) {
				return -1;		/* failed */
			} else {
				length = 0;
			}
		}

		len += length;
	}

	signal(SIGALRM, oldalrm);	/* restore default handler */

	return 0;

closed:

	/* Unlike recv(), we return an error condition with a suitable errno code
	 * if possible when and end of file is detected... because we never expect
	 * one. Before closing the connection, the remote application should be
	 * polite enough to send a 'bye' request and wait for us to receive it.
	 */

	errno = NET_BROKEN;			/* conntection is broken */
	alarm(0);					/* stop alarm clock */
	signal(SIGALRM, oldalrm);	/* restore default handler */

	return -1;
#endif
}

#ifdef EIF_WIN32
rt_public int net_send(STREAM *cs, char *buffer, size_t size)
#else
rt_public int net_send(int cs, char *buffer, size_t size)
#endif
       				/* The connected socket descriptor */
          			/* Where data are stored */
         			/* Amount of data to be sent */
{
	/* Write to network */

	size_t amount;
	char * volatile buf = buffer;

#ifdef EIF_WIN32
	DWORD error;
	size_t length;
	BOOL fSuccess;
#else
	size_t length;
	int error;
	Signal_t (*oldpipe)();
#endif

#ifdef USE_ADD_LOG
		add_log(2, "in net_send %d bytes on fd %d", size, writefd(cs));
#endif

	REQUIRE("Valid size", size <= INT32_MAX);

#ifdef EIF_WIN32
	if (0 != setjmp(env)) {
		errno = EPIPE;
		fprintf (stderr, "net_send: setjmp /= 0\n");
		return -1;
	}

	ReleaseSemaphore (writeev(cs),1,NULL);
	for (length = 0; length < size; buf += error, length += error) {
		amount = size - length;
		if (amount > BUFSIZ)    /* do not write more than BUFSIZ */
			amount = BUFSIZ;
		fSuccess = WriteFile(writefd(cs), buf, (DWORD) amount, &error, NULL);
		if (!fSuccess){
			fprintf (stderr, "net_send: write failed. fdesc = %p, errno = %i\n", writefd(cs),  GetLastError());
			return -1;
		}
	}

#else  /* (not) EIF_WIN32 */

	oldpipe = signal(SIGPIPE, (void (*)(int)) broken);	/* Trap SIGPIPE within this function */
	if (0 != setjmp(env)) {
		signal(SIGPIPE, oldpipe);
		errno = EPIPE;
		printf ("net_send: setjmp /= 0\n");
		return -1;
	}

	for (length = 0; length < size; buf += error, length += error) {
		amount = size - length;
		if (amount > BUFSIZ)	/* do not write more than BUFSIZ */
			amount = BUFSIZ;
		error = write(cs, buf, amount);
		if (error == -1){
			if (errno != EINTR){
#ifdef EIF_VMS
				printf ("%s: net_send: write failed. fdesc = %i, errno = %i (VMS %i)\n", 
					eifrt_vms_get_progname (NULL,0), cs, errno, vaxc$errno);
				perror (" ");
#else
				printf ("net_send: write failed. fdesc = %i, errno = %i\n", cs,  errno);
#endif
				return -1;
			}
			else
				error = 0;		/* number of bytes send */
		}
	}

	signal(SIGPIPE, oldpipe);	/* restore default handler */

#endif /* EIF_WIN32 */
	return 0;
}

#ifndef EIF_WIN32
rt_private Signal_t broken(void)
{
#ifdef USE_ADD_LOG
	add_log(20, "SIGPIPE signal handler broken() called in network.c");
#endif
	longjmp(env, 1);			/* SIGPIPE was received */
	/* NOTREACHED */
}
#endif

#ifdef EIF_WIN32
rt_private void CALLBACK timeout(HWND hwnd, UINT msg, UINT id, DWORD time)
#else
rt_private Signal_t timeout(void)
#endif
{
	longjmp(env, 1);			/* Alarm signal received */
	/* NOTREACHED */
}
