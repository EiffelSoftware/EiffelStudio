#include "config.h"
#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <winsock.h>
#define EWOULDBLOCK WSAEWOULDBLOCK
#define EINPROGRESS WSAEINPROGRESS
#include <stdio.h>
#include "except.h"
#endif

#include <sys/types.h>
#ifndef EIF_WIN32
#include <sys/time.h>
#endif
#include <errno.h>
#ifndef BSD
#define BSD_COMP
#endif
#ifndef EIF_WIN32
#include <sys/ioctl.h>
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
#ifndef EIF_WIN32
#include <sys/un.h>
#endif

#include "bitmask.h"

#ifdef EIF_WIN32
extern void eio(void);
void do_init(void);
EIF_INTEGER int_size(void);

eif_winsock_cleanup()
{
	int err;
	err = WSACleanup ();
	/* bad luck if this is an error ! */
}

void do_init()
{
	WORD wVersionRequested;
	WSADATA wsaData;
	int err;
	static BOOL done = FALSE;

	if (!done)
		{
		wVersionRequested = MAKEWORD (1, 1);
		err = WSAStartup(wVersionRequested, &wsaData);
		if (err != 0)
			{
			fprintf (stderr, "Communications error %d", err);
			eraise ("Unable to start WINSOCK", EN_PROG);
			}
		eif_register_cleanup (eif_winsock_cleanup);
		}
}
#endif



/* get size of mask from the 
 * struct fd_mask size 
 */
EIF_INTEGER mask_size ()
{
	return (EIF_INTEGER) (sizeof (fd_set));
}


void c_mask_clear (mask, pos)
EIF_OBJ mask;
EIF_INTEGER pos;
{
	FD_CLR((int) pos, (fd_set *) mask);
}


void c_set_bit (mask, pos)
EIF_OBJ mask;
EIF_INTEGER pos;
{
	FD_SET((int) pos, (fd_set *) mask);
}

EIF_BOOLEAN c_is_bit_set (mask, pos)
EIF_OBJ mask;
EIF_INTEGER pos;
{
	return (EIF_BOOLEAN) ((FD_ISSET((int) pos, (fd_set *) mask)) != 0);
}

void c_zero_mask (mask)
EIF_OBJ mask;
{
	FD_ZERO ((fd_set *) mask);
}

EIF_INTEGER address_size ()
{
	/* return the size of the struct sockaddr */

	return (EIF_INTEGER) sizeof (struct sockaddr);
}


EIF_INTEGER inet_address_size ()
{
	/* return the size of struct sockaddr_in */

	return (EIF_INTEGER) sizeof (struct sockaddr_in);
}

EIF_INTEGER in_addr_size ()
{
	/*return the size of struct in_addr */

	return (EIF_INTEGER) sizeof (struct in_addr);
}

EIF_INTEGER inet_inaddr_any ()
{
	/* return the value of constant INADDR_ANY */

	return (EIF_INTEGER) INADDR_ANY;
}

void set_sin_addr (add, val)
EIF_POINTER add;
EIF_INTEGER val;
{
	/* set the struct item s_addr to val */

	((struct in_addr *) add)->s_addr = (u_long) val;
}

EIF_INTEGER get_sin_addr (add)
EIF_POINTER add;
{
	/* return the value of the struct item s_addr */

	return (EIF_INTEGER) ((struct in_addr *) add)->s_addr;
}

EIF_INTEGER net_host_addr (host_addr)
EIF_POINTER host_addr;
{
	/* return the inet address */

	return (EIF_INTEGER) inet_addr ((char *) host_addr);
}

EIF_POINTER net_host (addr)
EIF_POINTER addr;
{
	char *res;
	EIF_POINTER address;

	res =  (char *) inet_ntoa (*((struct in_addr *) addr));
	address = makestr(res, strlen(res));
	free (res);
	return address;
}

void host_address_from_name (addr, name)
EIF_POINTER addr;
EIF_POINTER name;
{
	struct hostent *hp;

#ifdef EIF_WIN32
	do_init();
#endif
	hp = gethostbyname ((char *) name);

	if (hp == (struct hostent *) 0)
		eio();

	((struct in_addr *) addr)->s_addr = ((struct in_addr *)(hp->h_addr))->s_addr;
}

EIF_INTEGER get_servent_port (name, proto)
EIF_POINTER name;
EIF_POINTER proto;
{
	struct servent *sp;

#ifdef EIF_WIN32
	do_init();
#endif
	sp = getservbyname ((char *) name, (char *) proto);
	if (sp == (struct servent *) 0)
		eio();
	else
		return (EIF_INTEGER) sp->s_port;
}


void set_from_c (addr, c_part)
EIF_POINTER addr;
EIF_POINTER c_part;
{
#ifdef USE_STRUCT_COPY
	((struct in_addr *) addr)->s_addr = ((struct in_addr *) c_part)->s_addr;
#else
	bcopy(((struct in_addr *) addr)->s_addr, (((struct sockaddr_in *) c_part)->s_addr), sizeof (struct in_addr));
#endif
}


void set_sock_family (add, family)
EIF_POINTER add;
EIF_INTEGER family;
{
	((struct sockaddr *) add)->sa_family = (u_short) family;
}

EIF_INTEGER get_sock_family (add)
EIF_POINTER add;
{
	return (EIF_INTEGER) ((struct sockaddr *) add)->sa_family;
}

void set_inet_sock_family (add, family)
EIF_POINTER add;
EIF_INTEGER family;
{
	((struct sockaddr_in *) add)->sin_family = (u_short) family;
}

EIF_INTEGER get_inet_sock_family (add)
EIF_POINTER add;
{
	return (EIF_INTEGER) ((struct sockaddr_in *) add)->sin_family;
}

void set_sock_port (add, port)
EIF_POINTER add;
EIF_INTEGER port;
{
	((struct sockaddr_in *) add)->sin_port = htons((u_short) port);
}

EIF_INTEGER get_sock_port (add)
EIF_POINTER add;
{
	return (EIF_INTEGER) ntohs(((struct sockaddr_in *) add)->sin_port);
}


void set_sock_addr_in (add, addr_in)
EIF_POINTER add;
EIF_POINTER addr_in;
{
#ifdef USE_STRUCT_COPY
	((struct sockaddr_in *) add)->sin_addr = *((struct in_addr *) addr_in);
#else
	bcopy((struct in_addr *) addr_in, &(((struct sockaddr_in *) add)->sin_addr), sizeof (struct in_addr));
#endif
}


EIF_POINTER get_sock_addr_in (add)
EIF_POINTER add;
{
	return (EIF_POINTER) &(((struct sockaddr_in *) add)->sin_addr);
}

void set_sock_data (add, dat)
EIF_POINTER add;
EIF_POINTER dat;
{
	strncpy(((struct sockaddr *) add)->sa_data, dat, 14);
}

EIF_POINTER get_sock_data (add)
EIF_POINTER add;
{
	return (EIF_POINTER) ((struct sockaddr *)add)->sa_data;
}

void set_sock_zero (add, zero)
EIF_POINTER add;
EIF_POINTER zero;
{
	if (zero == (EIF_POINTER) 0) {
		int i;
		for (i = 0; i < 8; i++)
			((struct sockaddr_in *) add)->sin_zero[i] = '\0';
	} else
		strncpy(((struct sockaddr_in *) add)->sin_zero, (char *) zero, 8);
}

EIF_POINTER get_sock_zero (add)
EIF_POINTER add;
{
	return (EIF_POINTER) ((struct sockaddr_in *) add)->sin_zero;
}

void c_unlink (name)
EIF_POINTER name;
{
	unlink ((char *) name);
}

EIF_INTEGER c_socket (add_f, typ, prot)
EIF_INTEGER add_f, typ, prot;
{
	int result;

#ifdef EIF_WIN32
	do_init();
#endif
	result = socket ((int) add_f, (int) typ, (int) prot);
#ifndef EIF_WIN32
	if (result < 0)
		eio();
#else
	if (result == INVALID_SOCKET)
		eio();
#endif
	return (EIF_INTEGER) result;
}

void c_close_socket (s)
EIF_INTEGER s;
{
#ifndef EIF_WIN32
	close ((int) s);
#else
	closesocket (s);
#endif
}

void c_bind (s, add, length)
EIF_INTEGER s;
EIF_POINTER add;
EIF_INTEGER length;
{
#ifndef EIF_WIN32
	if (bind ((int) s, (struct sockaddr *) add, (int) length) < 0)
		eio();
#else
	do_init();
	if (bind ((int) s, (struct sockaddr *) add, (int) length) == SOCKET_ERROR)
		eio();
#endif
}

EIF_INTEGER c_accept (s, add, length)
EIF_INTEGER s;
EIF_POINTER add;
EIF_INTEGER length;
{
	int a_length, result;

	a_length = (int) length;

#ifdef EIF_WIN32
	do_init();
#endif

	result = accept ((int) s, (struct sockaddr *) add, &a_length);

#ifndef EIF_WIN32
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (result == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif

	return (EIF_INTEGER) result;
}

void c_listen (s, backlog)
EIF_INTEGER s, backlog;
{
#ifndef EIF_WIN32
	if ((listen ((int) s, (int) backlog)) < 0)
		eio();
#else
	do_init();
	if ((listen ((int) s, (int) backlog)) == SOCKET_ERROR)
		eio();
#endif
}

void c_connect (s, add, length)
EIF_INTEGER s;
EIF_POINTER add;
EIF_INTEGER length;
{
#ifndef EIF_WIN32
	if ((connect ((int) s, (struct sockaddr *) add, (int) length)) < 0)
		if (errno != EINPROGRESS)
			eio();
#else
	do_init();
	if ((connect ((int) s, (struct sockaddr *) add, (int) length)) == SOCKET_ERROR)
		if (WSAGetLastError() != EINPROGRESS)
			eio();
#endif
}

EIF_INTEGER c_select (nfds, rmask, wmask, emask, timeout, timeoutm)
EIF_INTEGER nfds;
EIF_OBJ rmask, wmask, emask;
EIF_INTEGER timeout, timeoutm;
{
	struct timeval t;
	int result;

#ifdef EIF_WIN32
	do_init();
#endif
	if (timeout == -1) {
#ifndef EIF_WIN32
		if ((result = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL)) < 0)
			eio();
#else
		if ((result = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL)) == SOCKET_ERROR)
			eio();
#endif
		return (EIF_INTEGER) result;
	}

	t.tv_sec = timeout;
	t.tv_usec = timeoutm;

#ifndef EIF_WIN32
	if ((result = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t)) < 0)
		eio();
#else
	if ((result = select ((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t)) == SOCKET_ERROR)
		eio();
#endif
	return (EIF_INTEGER) result;
}

void c_sock_name (s, addr, length)
EIF_INTEGER s;
EIF_POINTER addr;
EIF_INTEGER length;
{
	int a_length, result;

#ifdef EIF_WIN32
	do_init();
#endif
	a_length = (int) length;

	result = getsockname((int) s, (struct sockaddr *) addr, &a_length);

#ifndef EIF_WIN32
	if (result < 0)
#else
	if (result == SOCKET_ERROR)
#endif
		eio();
}

EIF_INTEGER c_peer_name (s, addr, length)
EIF_INTEGER s;
EIF_POINTER addr;
EIF_INTEGER length;
{
	int a_length, result;

#ifdef EIF_WIN32
	do_init();
#endif
	a_length = (int) length;

	result = getpeername((int) s, (struct sockaddr *) addr, &a_length);

#ifndef EIF_WIN32
	if (result < 0)
#else
	if (result == SOCKET_ERROR)
#endif
		eio();
	return (EIF_INTEGER) a_length;
}


void c_put_bool (fd, b)
EIF_INTEGER fd;
EIF_BOOLEAN b;
{
#ifndef EIF_WIN32
	if (b) 
		if (write ((int)fd, "True", 4) < 0)
			if (errno != EWOULDBLOCK)
				eio();
	else
		if (write ((int)fd, "False", 5) < 0)
			if (errno != EWOULDBLOCK)
				eio();
#else
	int err;

	if (b)
		err = send (fd, "True", 4, 0);
	else 
		err = send (fd, "False", 5, 0);

	if ((err == SOCKET_ERROR) && (WSAGetLastError() != EWOULDBLOCK))
		eio();
#endif
}

void c_put_char (fd, c)
EIF_INTEGER fd;
EIF_CHARACTER c;
{
#ifndef EIF_WIN32
	if (write ((int)fd, &c, sizeof (char)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (send (fd, &c, sizeof(char), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
}

void c_put_int (fd, i)
EIF_INTEGER fd;
EIF_INTEGER i;
{
#ifndef EIF_WIN32
	if (write ((int)fd, (EIF_INTEGER *)&i, sizeof (EIF_INTEGER)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (send (fd, (char *) &i, sizeof (EIF_INTEGER), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
}

void c_put_float (fd, f)
EIF_INTEGER fd;
EIF_REAL f;
{
		/* If no prototype is used for the declaration of c_put_float() in the caller,
		 * an automatic conversion from float to double will occur. We need to explicitly
		 * convert the argument to a float before safely sending it on the socket. Xavier
		 */

	float tf;
	tf = f;
#ifndef EIF_WIN32
	if (write ((int)fd, &tf, sizeof (float)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (send (fd, (char *) &tf, sizeof(tf), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
}

void c_put_double (fd, d)
EIF_INTEGER fd;
EIF_DOUBLE d;
{
#ifndef EIF_WIN32
	if (write ((int)fd, (double *) &d, sizeof (double)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (send (fd, (char *) &d, sizeof(d), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
}

void c_put_string (fd, s)
EIF_INTEGER fd;
EIF_OBJ s;
{
#ifndef EIF_WIN32
	if (write ((int)fd, s, strlen (s)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (send (fd, s, strlen(s), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
}

void c_put_stream (fd, s, l)
EIF_INTEGER fd;
EIF_OBJ s;
EIF_INTEGER l;
{
#ifndef EIF_WIN32
	if (write ((int)fd, (char *)s, (int)l) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (send (fd, s, l, 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
}

EIF_REAL c_read_float (fd)
EIF_INTEGER fd;
{
	float f;
#ifndef EIF_WIN32
	if (read ((int) fd, &f, sizeof (float)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (recv ((int) fd, (char *) &f, sizeof (float), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();

#endif
	return (EIF_REAL) f;
}

EIF_DOUBLE c_read_double (fd)
EIF_INTEGER fd;
{
	double d;
#ifndef EIF_WIN32
	if (read ((int) fd, &d, sizeof (double)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (recv (fd, (char *) &d, sizeof (double), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_DOUBLE) d;
}

EIF_CHARACTER c_read_char (fd)
EIF_INTEGER fd;
{
	char c;
#ifndef EIF_WIN32
	if (read ((int) fd, &c, sizeof (char)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (recv (fd, &c, sizeof (char), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_CHARACTER) c;
}

EIF_INTEGER c_read_int (fd)
EIF_INTEGER fd;
{
	EIF_INTEGER i;

#ifndef EIF_WIN32
	if (read ((int)fd, (char *) &i, sizeof (EIF_INTEGER)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (recv (fd, (char *) &i, sizeof (EIF_INTEGER), 0) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) i;
}


EIF_INTEGER c_read_stream (fd, len, buf)
EIF_INTEGER fd;
EIF_INTEGER len;
EIF_OBJ buf;
{
	int nr;

#ifndef EIF_WIN32
	if ((nr = read ((int) fd, (char *) buf, (int) len)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if ((nr = recv (fd, (char *) buf, (int) len, 0)) == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) nr;
}

EIF_INTEGER c_read (fd, l, buf)
EIF_INTEGER fd;
EIF_INTEGER l;
EIF_OBJ buf;
{
	int result;

#ifndef EIF_WIN32
	result = read ((int) fd, buf, (int) l);
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	result = recv ((int) fd, buf, (int) l, 0);
	if (result == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_receive (fd, buf, len, flags)
EIF_INTEGER fd;
EIF_OBJ buf;
EIF_INTEGER len;
EIF_INTEGER flags;
{
	int result;

	result = recv ((int)fd, (char *)buf, (int)len, (int) flags);
#ifndef EIF_WIN32
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (result == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_rcv_from (fd, buf, len, flags, addr, addr_len)
EIF_INTEGER fd;
EIF_POINTER buf;
EIF_INTEGER len;
EIF_INTEGER flags;
EIF_POINTER addr;
EIF_POINTER addr_len;
{
	int result;

	result = recvfrom ((int)fd, (char *)buf, (int)len, (int)flags, (struct sockaddr *) addr, (int*)addr_len);

#ifndef EIF_WIN32
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
#else
	if (result == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_write (fd, l, buf)
EIF_INTEGER fd;
EIF_INTEGER l;
EIF_OBJ buf;
{
	int result;
#ifndef EIF_WIN32
	result = write ((int) fd, (char *) buf, (int) l);
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();

#else
	result = send (fd, (char *) buf, (int) l, 0);
	if (result == SOCKET_ERROR)
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();

#endif
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_send (fd, buf, len, flags)
EIF_INTEGER fd;
EIF_OBJ buf;
EIF_INTEGER len;
EIF_INTEGER flags;
{
	int result;

	result = send ((int)fd, (char *)buf, (int)len, (int)flags);
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_send_to (fd, buf, len, flags, addr, addr_len)
EIF_INTEGER fd;
EIF_OBJ buf;
EIF_INTEGER len;
EIF_INTEGER flags;
EIF_OBJ addr;
EIF_INTEGER addr_len;
{
	int result;

	if ((result = sendto ((int)fd, (char *)buf, (int)len, (int)flags, (struct sockaddr *) addr, (int)addr_len)) < 0)
#ifndef EIF_WIN32
		if (errno != EWOULDBLOCK)
			eio();
#else
		if (WSAGetLastError() != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

void c_set_sock_opt_int (fd, level, opt, val)
EIF_INTEGER fd;
EIF_INTEGER level;
EIF_INTEGER opt;
EIF_INTEGER val;
{
	int arg = (int) val;

	if ((setsockopt ((int)fd, (int) level, (int) opt, (char *) &arg, sizeof (arg))) < 0)
		eio();
}

EIF_INTEGER c_get_sock_opt_int (fd, level, opt)
EIF_INTEGER fd;
EIF_INTEGER level;
EIF_INTEGER opt;
{
	int arg, asize;

	asize = sizeof (arg);
#ifndef EIF_WIN32
	if (getsockopt ((int) fd, (int) level, (int) opt, (char *) &arg, &asize) < 0)
#else
	if (getsockopt ((int) fd, (int) level, (int) opt, (char *) &arg, &asize) == SOCKET_ERROR)
#endif
		return (EIF_INTEGER) 0;
	return (EIF_INTEGER) arg;
}

EIF_BOOLEAN c_is_linger_on (fd)
EIF_INTEGER fd;
{
	struct linger arg;
	int asize;

	asize = sizeof (arg);

#ifndef EIF_WIN32
	if (getsockopt ((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) < 0)
#else
	if (getsockopt ((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) == SOCKET_ERROR)
#endif
		return (EIF_BOOLEAN) 0;

	return (EIF_BOOLEAN) (!(arg.l_onoff == 0));
}

EIF_INTEGER c_linger_time (fd)
EIF_INTEGER fd;
{
	struct linger arg;
	int asize;

	asize = sizeof (arg);

#ifndef EIF_WIN32
	if (getsockopt ((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) < 0)
#else
	if (getsockopt ((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) == SOCKET_ERROR)
#endif
		return (EIF_INTEGER) 0;

	return (EIF_INTEGER) arg.l_linger;
}

EIF_INTEGER c_set_sock_opt_linger (fd, flag, time)
EIF_INTEGER fd;
EIF_BOOLEAN flag;
EIF_INTEGER time;
{
	struct linger arg;

	arg.l_onoff = (int) flag;
	arg.l_linger = (int) time;

	return (EIF_INTEGER) setsockopt ((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, sizeof (arg));
}

EIF_INTEGER c_fcntl (fd, cmd, arg)
EIF_INTEGER fd;
EIF_INTEGER cmd;
EIF_INTEGER arg;
{
#ifndef EIF_WIN32
	return (EIF_INTEGER) fcntl ((int)fd, (int)cmd, (int)arg);
#else
	return 0;
#endif
}

void c_set_blocking (fd)
EIF_INTEGER fd;
{
#ifndef EIF_WIN32
	int arg = 0;

	ioctl ((int)fd, FIONBIO, (char *) &arg);
#else
	u_long arg = 0;

	ioctlsocket ((int)fd, FIONBIO, &arg);
#endif
}

void c_set_non_blocking (fd)
EIF_INTEGER fd;
{

#ifndef EIF_WIN32
	int arg = 1;
	ioctl ((int)fd, FIONBIO, (char *) &arg);
#else
	u_long arg = 1;
	ioctlsocket ((int)fd, FIONBIO, &arg);
#endif
}

EIF_INTEGER int_size ()
{
	return sizeof (EIF_INTEGER);
}

EIF_INTEGER c_get_number (data_obj)
EIF_OBJ data_obj;
{
	return (EIF_INTEGER) ntohl (* ((EIF_INTEGER *) data_obj));
}

void c_set_number (data_obj, num)
EIF_OBJ data_obj;
EIF_INTEGER num;
{
	(*(EIF_INTEGER *) data_obj) = htonl (num);
}

void c_set_data (pdata_obj, sdata_obj, count)
EIF_OBJ pdata_obj;
EIF_OBJ sdata_obj;
EIF_INTEGER count;
{
	bcopy ((pdata_obj + int_size()), sdata_obj, count);
}

void c_get_data (rdata_obj, pdata_obj, count)
EIF_OBJ rdata_obj;
EIF_OBJ pdata_obj;
EIF_INTEGER count;
{
	bcopy (rdata_obj, (pdata_obj + int_size()), count);
}

