/*
indexing
	description: "EiffelNet: library of reusable components for networking."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
	Synchronous polling facilities
*/

#include "eif_config.h"
#include "eif_size.h" /* for LNGSIZ */

#ifdef EIF_WINDOWS
#include <winsock2.h>
#include <stdio.h>
#endif

#ifdef I_SYS_TIME
#include <sys/time.h>
#endif

#include <sys/types.h>

#ifndef EIF_WINDOWS
#include <unistd.h>
#endif

#include <errno.h>

#ifndef BSD
#define BSD_COMP
#endif

#ifndef EIF_WINDOWS
#include <sys/ioctl.h>
#endif

#include <fcntl.h> /* added for fcntl */
#ifndef FNDELAY
#define FNDELAY O_NDELAY
#endif

#include "eif_cecil.h"
#include "eif_except.h"
#include "eif_error.h"

#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
#ifdef VXWORKS
#include <sockLib.h>
#endif
#endif

#ifdef I_FD_SET_SYS_SELECT
#include <sys/select.h>
#endif

#ifdef I_NETINET_IN
#include <netinet/in.h>
#endif
#ifdef I_SYS_IN
#include <sys/in.h>
#endif
#ifdef I_SYS_UN
#include <sys/un.h>
#endif

#include <string.h>

#define nanoseconds_in_second RTU64C(1000000000)
#define nanoseconds_in_microsecond RTU64C(1000)

EIF_INTEGER c_syncpoll(EIF_INTEGER fd)
	/* Synchronously poll a socket without modifying buffer
	    expecting 1 for something, 0 for eof, -1 for error */
{
	char single_char_buf;
	int result;

	result = recv((int) fd, (char *) &single_char_buf, 1, (int) MSG_PEEK);
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_select_poll(EIF_INTEGER fd)
	/* Get read status for socket fd */
{
	fd_set fdmask;
	struct timeval timeout;

	timeout.tv_sec = 0;
	timeout.tv_usec = 0;

	FD_ZERO(&fdmask);
	FD_SET(fd, &fdmask);

	if (select(fd + 1, &fdmask, (fd_set *) 0, (fd_set *) 0, &timeout) < 0)
		eio();
	return (FD_ISSET(fd, &fdmask));
}

EIF_INTEGER c_select_poll_with_timeout(EIF_INTEGER fd, 
		                               EIF_BOOLEAN read_mode,
									   EIF_NATURAL_64 timeout_ns)
	/* Get read/write status for socket fd within `timeout_ns` nanoseconds*/
{
	fd_set fdmask;
	struct timeval tmout;
	int res;
	EIF_NATURAL_64 n64;
	n64 = timeout_ns / nanoseconds_in_second;
	if (n64 > LONG_MAX) {
		/* Overflown, use max value instead */
		tmout.tv_sec = LONG_MAX;
	} else {
		tmout.tv_sec = (long) n64;
	}
	tmout.tv_usec = (long) ((timeout_ns % nanoseconds_in_second) / nanoseconds_in_microsecond);
	if (tmout.tv_sec == 0 && tmout.tv_usec == 0 && timeout_ns != 0) {
			/* timeout values are above zero, but less than 1 microsecond
			 * then set to 1 microsecond to avoid eventual special behavior for 0 timeouts).
			 */
		tmout.tv_usec = 1;
	}

	FD_ZERO(&fdmask);
	FD_SET(fd, &fdmask);

	if (read_mode)
		res = select(fd + 1, &fdmask, (fd_set *) 0, (fd_set *) 0, &tmout);
	else
		res = select(fd + 1, (fd_set *) 0, &fdmask, (fd_set *) 0, &tmout);

	if (res < 0)
		eio();
	return (FD_ISSET(fd, &fdmask));
}

EIF_INTEGER c_check_exception_with_timeout(EIF_INTEGER fd, 
									       EIF_NATURAL_64 timeout_ns)
	/* Get exception status for socket fd within `timeout_ns` nanoseconds */
{
	fd_set fdmask;
	struct timeval tmout;
	int res;
	EIF_NATURAL_64 n64;
	n64 = timeout_ns / nanoseconds_in_second;
	if (n64 > LONG_MAX) {
		/* Overflown, use max value instead */
		tmout.tv_sec = LONG_MAX;
	} else {
		tmout.tv_sec = (long) n64;
	}
	tmout.tv_usec = (long) ((timeout_ns % nanoseconds_in_second) / nanoseconds_in_microsecond);
	if (tmout.tv_sec == 0 && tmout.tv_usec == 0 && timeout_ns != 0) {
			/* timeout values are above zero, but less than 1 microsecond
			 * then set to 1 microsecond to avoid eventual special behavior for 0 timeouts).
			 */
		tmout.tv_usec = 1;
	}

	FD_ZERO(&fdmask);
	FD_SET(fd, &fdmask);

	res = select(fd + 1, (fd_set *) 0, (fd_set *) 0, &fdmask, &tmout);

	if (res < 0)
		eio();
	return (FD_ISSET(fd, &fdmask));
}

EIF_INTEGER c_is_blocking(EIF_INTEGER fd)
	/* Attempt to get blocking status of socket */
	/* BIG BUG UNDER HP-UX !!! => couldn't get actual blocking status */
{
#if defined EIF_WINDOWS || defined EIF_VMS || defined VXWORKS
	return 0;
#else
	return (EIF_INTEGER) fcntl((int) fd, (int) F_GETFL, (int) FNDELAY);
#endif
}
