/*x
	Synchronous polling facilities
*/

#include "config.h"
#include "size.h" /* for LNGSIZ */
#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <winsock.h>
#define EWOULDBLOCK WSAEWOULDBLOCK
#define EINPROGRESS WSAEINPROGRESS
#include <stdio.h>
#include "except.h"
#endif

#ifdef EIF_OS2
#include <stdlib.h>
#include <types.h>
#include <sys/socket.h>
#include <io.h>
#endif

#include <sys/types.h>
#ifndef EIF_WINDOWS
#include <sys/time.h>
#endif
#include <errno.h>
#ifndef BSD
#define BSD_COMP
#endif
#if defined EIF_WINDOWS
#else
#include <sys/ioctl.h>
#endif

#include <fcntl.h> /*x added for fcntl */
#ifndef FNDELAY
#define FNDELAY O_NDELAY
#endif

#include "cecil.h"
#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
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
#if defined EIF_WINDOWS || defined EIF_OS2
#else
#include <sys/un.h>
#endif

#include "bitmask.h"


EIF_INTEGER c_syncpoll(fd)
EIF_INTEGER fd;
	/*x Synchronously poll a socket without modifying buffer
	    expecting 1 for something, 0 for eof, -1 for error */
{
	char single_char_buf;
	int result;

	result = recv((int) fd, (char *) &single_char_buf, (int) 1, (int) MSG_PEEK);
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_select_poll(fd)
EIF_INTEGER fd;
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

EIF_INTEGER c_is_blocking(fd)
EIF_INTEGER fd;
	/*x attempt to get blocking status of socket */
	/*x BIG BUG UNDER HP-UX !!! => couldn't get actual blocking status */
{
#if defined EIF_WIN32 || EIF_OS2
	return 0;
#else
	return (EIF_INTEGER) fcntl((int) fd, (int) F_GETFL, (int) FNDELAY);
#endif
}
