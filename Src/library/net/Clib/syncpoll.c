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
#define WIN32_LEAN_AND_MEAN
#include <winsock.h>
#define EWOULDBLOCK WSAEWOULDBLOCK
#define EINPROGRESS WSAEINPROGRESS
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

#include <fcntl.h> /*x added for fcntl */
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

EIF_INTEGER c_syncpoll(EIF_INTEGER fd)
	/*x Synchronously poll a socket without modifying buffer
	    expecting 1 for something, 0 for eof, -1 for error */
{
	char single_char_buf;
	int result;

	result = recv((int) fd, (char *) &single_char_buf, (int) 1, (int) MSG_PEEK);
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_select_poll(EIF_INTEGER fd)
	/*x Get read status for socket fd */
{
	fd_set fdmask;
	struct timeval timeout;

	timeout.tv_sec = (unsigned long) 0;
	timeout.tv_usec = (long) 0;

	FD_ZERO(&fdmask);
	FD_SET(fd, &fdmask);

	if (select(fd + 1, &fdmask, (fd_set *) 0, (fd_set *) 0, &timeout) < 0)
		eio();
	return (FD_ISSET(fd, &fdmask));
}

EIF_INTEGER c_select_poll_with_timeout(EIF_INTEGER fd, 
		                               EIF_BOOLEAN read_mode,
									   EIF_INTEGER timeout)
	/*x Get read/write status for socket fd within `timeout' seconds */
{
	fd_set fdmask;
	struct timeval tmout;
	int res;

	tmout.tv_sec = (unsigned long) timeout;
	tmout.tv_usec = (long) 0;

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
									       EIF_INTEGER timeout)
	/*x Get exception status for socket fd within `timeout' seconds */
{
	fd_set fdmask;
	struct timeval tmout;
	int res;

	tmout.tv_sec = (unsigned long) timeout;
	tmout.tv_usec = (long) 0;

	FD_ZERO(&fdmask);
	FD_SET(fd, &fdmask);

	res = select(fd + 1, (fd_set *) 0, (fd_set *) 0, &fdmask, &tmout);

	if (res < 0)
		eio();
	return (FD_ISSET(fd, &fdmask));
}

EIF_INTEGER c_is_blocking(EIF_INTEGER fd)
	/*x attempt to get blocking status of socket */
	/*x BIG BUG UNDER HP-UX !!! => couldn't get actual blocking status */
{
#if defined EIF_WINDOWS || defined EIF_OS2 || defined EIF_VMS || defined VXWORKS
	return 0;
#else
	return (EIF_INTEGER) fcntl((int) fd, (int) F_GETFL, (int) FNDELAY);
#endif
}
