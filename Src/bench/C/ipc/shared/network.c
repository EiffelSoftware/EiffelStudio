/*

 #    #  ######   #####  #    #   ####   #####   #    #           ####
 ##   #  #          #    #    #  #    #  #    #  #   #           #    #
 # #  #  #####      #    #    #  #    #  #    #  ####            #
 #  # #  #          #    # ## #  #    #  #####   #  #     ###    #
 #   ##  #          #    ##  ##  #    #  #   #   #   #    ###    #    #
 #    #  ######     #    #    #   ####   #    #  #    #   ###     ####

	Contains all socket/pipes messages routines.
	
	As signal may arrive, we must check when an error occurs, that
	it is not the signal's fault.
*/

#include "config.h"
#include "portable.h"
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <setjmp.h>
#include <sys/types.h>

extern unsigned TIMEOUT;		/* Time out on reads */

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

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_private jmp_buf env;		/* Environment saving for longjmp() */
rt_private Signal_t broken();	/* Signal handler for SIGPIPE */
rt_private Signal_t timeout();	/* Signal handler for read timeouts */

extern int errno;

rt_public int net_recv(cs, buf, size)
int cs;				/* The connected socket descriptor */
char *buf;			/* Where data are to be stored */
int size;			/* Amount of data to be read */
{
	/* Read from network */

	int len = 0;		/* Total amount of bytes read */
	int length;			/* Amount read by last system call */
	Signal_t (*oldalrm)();

	oldalrm = signal(SIGALRM, timeout);	/* Trap SIGALRM within this function */

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

		if (length == -1)
			if (errno != EINTR)
				return -1;		/* failed */
			else
				length = 0;

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
}


rt_public int net_send(cs, buf, size)
int cs;				/* The connected socket descriptor */
char *buf;			/* Where data are stored */
int size;			/* Amount of data to be sent */
{
	/* Write to network */

	int error;
	int length;
	int amount;
	Signal_t (*oldpipe)();

	oldpipe = signal(SIGPIPE, broken);	/* Trap SIGPIPE within this function */

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
				printf ("net_send: write failed. fdesc = %i, errno = %i\n", cs,  errno);
				return -1;
			}
			else
				error = 0;		/* number of bytes send */
		}
	}

	signal(SIGPIPE, oldpipe);	/* restore default handler */

	return 0;
}

rt_private Signal_t broken()
{
	longjmp(env, 1);			/* SIGPIPE was received */
	/* NOTREACHED */
}

rt_private Signal_t timeout()
{
	longjmp(env, 1);			/* Alarm signal received */
	/* NOTREACHED */
}

