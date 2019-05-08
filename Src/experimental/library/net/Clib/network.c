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
	Eiffel Net C interfacing
	.../library/net/Clib/network.c
*/

#ifdef __VMS 		/* n.b. EIF_VMS is not defined yet */
#pragma module NET_NETWORK 	/* resolves module name clash with .../C/ipc/shared/network.c */
#endif /* __VMS */


#include "eif_config.h"

/* Selector for sendfile or equivalent.
 * Currently it is supported on Windows/Unix but no macOS.
 */
#if (EIF_OS != EIF_OS_DARWIN) && (EIF_OS != EIF_OS_OPENBSD) && (EIF_OS != EIF_OS_FREEBSD)
#define EIF_HAS_SENDFILE
#endif

#ifdef EIF_WINDOWS
#define FD_SETSIZE 256
#include <winsock2.h>
#include <ws2tcpip.h>
#include <MSWSock.h>
#include <io.h>
#endif

#include "eif_portable.h" 	/* required for VMS, recommended for others */
#include "eif_except.h"  
#include "eif_size.h"     	/* for LNGSIZ */
#include "eif_error.h"    	/* for eio() */

#include <stdio.h>

#ifdef I_SYS_TIME
#include <sys/time.h>
#endif

#ifdef EIF_VMS
#include "netvmsdef.h"
#else
#include <sys/types.h>
#endif

#ifndef EIF_WINDOWS
#include <unistd.h>
#endif

#include <errno.h>

#ifndef BSD
#define BSD_COMP
#endif

#include "eif_cecil.h"

#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
#endif

#ifndef EIF_WINDOWS
#include <sys/ioctl.h>
#endif

#ifdef EIF_HAS_SENDFILE
#ifndef EIF_WINDOWS
#include <sys/sendfile.h>
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

#if defined EIF_WINDOWS || defined EIF_VMS || defined VXWORKS
#else
#include <arpa/inet.h>
#include <fcntl.h>
#endif

#ifdef VXWORKS
#include <ioLib.h>
#include <inetLib.h>
#include <sockLib.h>
#endif

#include <string.h>

#ifdef EIF_WINDOWS
#define EIF_NET_INITIALIZE	do_init()
#define EIF_SOCKET_TYPE	SOCKET
#define EIFNET_ERROR_HAPPENED SOCKET_ERROR
	/* Clean up function */
typedef void (* EIF_CLEANUP)(EIF_BOOLEAN);

	/* Register `f' as a clean up function */
extern void eif_register_cleanup(EIF_CLEANUP f);
#else
#define EIF_NET_INITIALIZE
#define EIF_SOCKET_TYPE	int
#define EIFNET_ERROR_HAPPENED -1
#endif


typedef union {
    struct sockaddr	him;
    struct sockaddr_in	him4;
    struct sockaddr_in6 him6;
} SOCKETADDRESS;

#ifdef EIF_WINDOWS
/* To create portable code we override the definition of some errno constants to
 * map what winsock returns to us for error codes. */
#ifdef EWOULDBLOCK
	#undef EWOULDBLOCK
#endif
#define EWOULDBLOCK WSAEWOULDBLOCK

#ifdef EINPROGRESS
	#undef EINPROGRESS
#endif
#define EINPROGRESS WSAEINPROGRESS
#endif

	/* Raise an Eiffel exception in case an error occurred */
void eif_net_check (int retcode) {
	/* Check the return code of connect(), recv(), send(), ... */

#ifdef EIF_WINDOWS
	char buf[80]="Net error #";
	int errcode;
	if ((retcode == SOCKET_ERROR) || (retcode == INVALID_SOCKET)) {
		errcode = WSAGetLastError();
		errno = errcode;
		switch (errcode) {
			case WSANOTINITIALISED:
				eraise("WSANOTINITIALISED: A successful WSAStartup must occur before using this function.", EN_PROG);
				break;
			case WSAENETDOWN:
				eraise("WSAENETDOWN: The network subsystem has failed.", EN_PROG);
				break;
			case WSAEADDRINUSE:
				eraise("WSAEADDRINUSE: The specified address is already in use. (See the SO_REUSEADDR socket option under setsockopt).", EN_PROG);
				break;
			case WSAEFAULT:
				eraise("WSAEFAULT: The name or the namelen parameter is not a valid part of the user address space, the namelen parameter is too small, the name parameter contains incorrect address format for the associated address family, or the first two bytes of the memory block specified by name does not match the address family associated with the socket descriptor s.", EN_PROG);
				break;
			case WSAEINPROGRESS:
				eraise("WSAEINPROGRESS: A blocking Windows Sockets 1.1 call is in progress, or the service provider is still processing a callback function.", EN_PROG);
				break;
			case WSAEINVAL:
				eraise("WSAEINVAL: The socket is already bound to an address.", EN_PROG);
				break;
			case WSAENOBUFS:
				eraise("WSAENOBUFS: Not enough buffers available, too many connections.", EN_PROG);
				break;
			case WSAENOTSOCK:
				eraise("WSAENOTSOCK: The descriptor is not a socket.", EN_PROG);
				break;
			case WSAEAFNOSUPPORT:
				eraise ("WSAEAFNOSUPPORT: The specified address family is not supported.", EN_PROG);
				break;
			case WSAEMFILE:
				eraise ("WSAEMFILE: No more socket descriptors are available.", EN_PROG);
				break;
			case WSAEPROTONOSUPPORT:
				eraise ("WSAEPROTONOSUPPORT: The specified protocol is not supported.", EN_PROG);
				break;
			case WSAEPROTOTYPE:
				eraise ("WSAEPROTOTYPE: The specified protocol is the wrong type for this socket.", EN_PROG);
				break;
			case WSAESOCKTNOSUPPORT:
				eraise ("WSAESOCKTNOSUPPORT: The specified socket type is not supported in this address family.", EN_PROG);
				break;
			case WSAECONNRESET:
				eraise ("WSAECONNRESET: Connection reset by peer.", EN_PROG);
				break;
			case WSAECONNREFUSED:
				eraise ("WSAECONNREFUSED: Connection refused.", EN_PROG);
				break;
			case WSAENOTCONN:
				eraise ("WSAENOTCONN: Socket is not connected.", EN_PROG);
				break;
			default:
				if ((errcode != EWOULDBLOCK) && (errcode != EINPROGRESS)) {
#if (_MSC_VER >= 1400)
					_itoa_s(errcode,&buf[11], 50, 10);
#else
					itoa(errcode,&buf[11],10);
#endif
					eraise(buf, EN_ISE_IO);
				} else {
					errno = 0;
				}
		}
	} else {
		errno = 0;
	}
#else
		/* Get the last error here, and signal it like above...*/
	if (retcode < 0) {
		if ((errno != EWOULDBLOCK) && (errno != EINPROGRESS)) {
			eraise(NULL, EN_IO);
		} else {
			errno = 0;
		}
	} else {
		errno = 0;
	}
#endif
}

#ifdef EIF_WINDOWS

void eif_winsock_cleanup(EIF_BOOLEAN f)
{
	eif_net_check(WSACleanup());
}

rt_shared void do_init(void)
{
	WORD wVersionRequested;
	WSADATA wsaData;
	int err;
	static BOOL done = FALSE;

	if (!done) {
		wVersionRequested = MAKEWORD(2, 0);
		err = WSAStartup(wVersionRequested, &wsaData);
		if (err != 0) {
			fprintf (stderr, "Communications error %d", err);
			eraise ("Unable to start WINSOCK", EN_PROG);
		}
#ifndef EIF_IL_DLL
		eif_register_cleanup(eif_winsock_cleanup);
#endif
		done = TRUE;
	}
}
#endif

/* The following macros and functions are there to process REAL/DOUBLE
 * between different platforms. We change all formats into network format.
 */

#define ise_ntohf(x)		change_float_order(x)
#define ise_htonf(x)		change_float_order(x)
#define ise_ntohd(x)		change_double_order(x)
#define ise_htond(x)		change_double_order(x)

rt_private float change_float_order(float f) 
{
#if BYTEORDER == 0x4321
	return f;
#else
	float x, y;
	unsigned char *px=(unsigned char *)(&x);
	unsigned char *py=(unsigned char *)(&y);
	int i;

	x = f; /* It's necessary in Windows */
	for (i=0; i<sizeof(float); i++) 
		py[i] = px[sizeof(float)-1-i];
	return y;
#endif
}

rt_private double change_double_order(double d) 
{
#if BYTEORDER == 0x4321
	return d;
#else
	double x, y;
	unsigned char *px=(unsigned char *)(&x);
	unsigned char *py=(unsigned char *)(&y);
	int i;

	x = d; /* It's necessary in Windows. */
	for (i=0; i<sizeof(double); i++) 
		py[i] = px[sizeof(double)-i-1];
	return y;
#endif	
}



/*** select facilities ***/

EIF_INTEGER mask_size()
	/*x size of mask fd_set */
{
	return (EIF_INTEGER) (sizeof(fd_set));
}


void c_mask_clear(EIF_POINTER mask, EIF_INTEGER pos)
	/*x turn the bit for pos off in mask */
{
#ifdef EIF_WINDOWS
		/* The cast to SOCKET is required because it assumes
		 * we pass a SOCKET which is a UINT_PTR. */
	FD_CLR((SOCKET) pos, (fd_set *) mask);
#else
	FD_CLR((int) pos, (fd_set *) mask);
#endif
}


void c_set_bit(EIF_POINTER mask, EIF_INTEGER pos)
	/*x turn the bit for pos on in mask */
{
#ifdef EIF_WINDOWS
		/* The cast to SOCKET is required because it assumes
		 * we pass a SOCKET which is a UINT_PTR. */
	FD_SET((SOCKET) pos, (fd_set *) mask);
#else
	FD_SET((int) pos, (fd_set *) mask);
#endif
}

EIF_BOOLEAN c_is_bit_set(EIF_POINTER mask, EIF_INTEGER pos)
	/*x test the bit for pos in mask */
{
	return (EIF_BOOLEAN) ((FD_ISSET((int) pos, (fd_set *) mask)) != 0);
}

void c_zero_mask(EIF_POINTER mask)
	/*x clear all bits in mask */
{
	FD_ZERO((fd_set *) mask);
}


/*x** address facilities ***/

EIF_INTEGER address_size()
	/*x return the size of the struct sockaddr */
{

	return (EIF_INTEGER) sizeof(struct sockaddr);
}


EIF_INTEGER inet_address_size()
	/*x return the size of struct sockaddr_in */
{

	return (EIF_INTEGER) sizeof(SOCKETADDRESS);
}

EIF_INTEGER in_addr_size()
	/*return the size of struct in_addr */
{

	return (EIF_INTEGER) sizeof(struct in_addr);
}

EIF_INTEGER inet_inaddr_any()
	/*x value of constant INADDR_ANY */
{

	return (EIF_INTEGER) INADDR_ANY;
}

void set_sin_addr(EIF_POINTER add, EIF_INTEGER val)
{
	/*x set the 32-bit netid/hostid address on add structure */

	((struct in_addr *) add)->s_addr = (u_long) val;
}

EIF_INTEGER get_sin_addr(EIF_POINTER add)
{
	/*x 32-bit netid/hostid from internet address structure */

	return (EIF_INTEGER) ((struct in_addr *) add)->s_addr;
}

EIF_INTEGER net_host_addr(EIF_POINTER host_addr)
	/*x convert dotted string internet address in long integer format */
{
	return (EIF_INTEGER) inet_addr((char *) host_addr);
}

EIF_POINTER net_host(EIF_POINTER addr)
	/*x internet address string in dotted notation from address struct */
{
	char *res;

	res =  (char *) inet_ntoa(*((struct in_addr *) addr));
	return (EIF_POINTER) res;
}

void host_address_from_name (EIF_POINTER addr, EIF_POINTER name)
	/*x 32-bits netid/hostid set in addr from hostname name */
{
	struct hostent *hp;
#ifdef VXWORKS
	int h_errno = 0;
#endif

	EIF_NET_INITIALIZE;

#ifdef VXWORKS
	hp = NULL;
#else
	hp = gethostbyname((char *) name);
#endif

	if (hp == (struct hostent *) 0) {
#ifdef EIF_WINDOWS
		eif_net_check(EIFNET_ERROR_HAPPENED);
#else
			/* On Unix, `gethostbyname' does not set errno, but h_errno. This is why
			 * we cannot use `eif_net_check'. */
		errno = h_errno;
		if (h_errno == HOST_NOT_FOUND) {
			eraise ("The specified host is unknown.", EN_ISE_IO);
		} else if (h_errno == NO_ADDRESS || h_errno == NO_DATA) {
			eraise ("The requested name is valid but does not have an IP address.", EN_ISE_IO);
		} else if (h_errno == NO_RECOVERY) {
			eraise ("A non-recoverable name server error occurred.", EN_ISE_IO);
		} else if (h_errno == TRY_AGAIN) {
			eraise ("A temporary error occurred on an authoritative name server. Try again later.", EN_ISE_IO);
		} else {
			eio();
		}
#endif
	}

	((struct in_addr *) addr)->s_addr = ((struct in_addr *) (hp->h_addr))->s_addr;
}

EIF_INTEGER get_servent_port(EIF_POINTER name, EIF_POINTER proto)
	/*x get port number of a service by its name */
{
	struct servent *sp;

	EIF_NET_INITIALIZE;
#ifdef VXWORKS
	sp = NULL;
#else
	sp = getservbyname((char *) name, (char *) proto);
#endif
	if (sp == (struct servent *) 0) {
		eif_net_check(EIFNET_ERROR_HAPPENED);
			/* Not Reached */
		return -1;
	} else
		return (EIF_INTEGER) ntohs(sp->s_port);
}


void set_from_c(EIF_POINTER addr, EIF_POINTER c_part)
	/*x copy internet address from addr into c_part */
{
	((struct in_addr *) addr)->s_addr = ((struct in_addr *) c_part)->s_addr;
}


void set_sock_family(EIF_POINTER add, EIF_INTEGER family)
	/*x set socket family in socket address structure add */
{
	((struct sockaddr *) add)->sa_family = (u_short) family;
}

EIF_INTEGER get_sock_family(EIF_POINTER add)
	/*x get socket family in socket address structure add */
{
	return (EIF_INTEGER) ((struct sockaddr *) add)->sa_family;
}

void set_inet_sock_family(EIF_POINTER add, EIF_INTEGER family)
	/*x set socket family in internet socket address structure (!) */
{
	((struct sockaddr_in *) add)->sin_family = (u_short) family;
}

EIF_INTEGER get_inet_sock_family(EIF_POINTER add)
	/*x get socket family in internet socket address structure (!) */
{
	return (EIF_INTEGER) ((struct sockaddr_in *) add)->sin_family;
}

void set_sock_port(EIF_POINTER add, EIF_INTEGER port)
	/*x set socket port in internet socket address structure add */
{
	((struct sockaddr_in *) add)->sin_port = htons((u_short) port);
}

EIF_INTEGER get_sock_port(EIF_POINTER add)
	/*x get socket port in internet socket address structure add */
{
	return (EIF_INTEGER) ntohs(((struct sockaddr_in *) add)->sin_port);
}


void set_sock_addr_in(EIF_POINTER add, EIF_POINTER addr_in)
	/*x set 32-bit netid/hostid internet address from internet address
	    structure addr_in (in_addr) into internet socket address stucture
	    add (sockaddr_in) */
{
	memcpy(&(((struct sockaddr_in *) add)->sin_addr), (struct in_addr *) addr_in, sizeof(struct in_addr));
}


EIF_POINTER get_sock_addr_in(EIF_POINTER add)
	/*x get 32-bits netid/hostid internet address into internet address
	    structure in_addr from internet socket address structure add
	    (sockaddr_in) */
{
	return (EIF_POINTER) &(((struct sockaddr_in *) add)->sin_addr);
}

void set_sock_data(EIF_POINTER add, EIF_POINTER dat)
	/*x copy 14-bytes protocol-specific address data into socket address
	    structure add from dat */
{
	memcpy(((struct sockaddr *) add)->sa_data, dat, 14);
}

EIF_POINTER get_sock_data(EIF_POINTER add)
	/*x get 14-bytes protocol-specific address data from socket address
	    structure add */
{
	return (EIF_POINTER) ((struct sockaddr *)add)->sa_data;
}

void set_sock_zero(EIF_POINTER add, EIF_POINTER zero)
	/*x set the internet socket address sin_zero zone to 8 characters
	    similar to the one pointed by zero, or 0 if zero is null
	    unused (!) */
{
	if (zero == (EIF_POINTER) 0) {
		int i;
		for (i = 0; i < 8; i++)
			((struct sockaddr_in *) add)->sin_zero[i] = '\0';
	} else
		memcpy(((struct sockaddr_in *) add)->sin_zero, (char *) zero, 8);
}

EIF_POINTER get_sock_zero(EIF_POINTER add)
	/*x get the sin_zero zone value in internet socket address struct add
	    unused (!) */
{
	return (EIF_POINTER) ((struct sockaddr_in *) add)->sin_zero;
}

void c_unlink(EIF_POINTER name)
	/*x erase unix domain socket filename name */
{
#if defined EIF_WINDOWS && (_MSC_VER >= 1400)
	_unlink((char *) name);
#else
	unlink((char *) name);
#endif
}

#ifdef EIF_WINDOWS
int c_windows_socket (SOCKET l_socket) {
#ifdef EIF_64_BITS
		/* On 64-bit system `SOCKET' is actually a pointer. For the moment, we check that
		 * it is not coded on the whole 64-bit. */
	if (l_socket != INVALID_SOCKET) {
		if ((l_socket & RTU64C(0x00000000FFFFFFFF)) != l_socket) {
				/* We are in trouble. Raise an exception for the moment. */
			eraise ("Descriptor too big to be represented as INTEGER_32", EN_PROG);
		}
	}
	return (int) l_socket;
#else
	return (int) l_socket;
#endif
}
#endif

EIF_INTEGER c_socket(EIF_INTEGER add_f, EIF_INTEGER typ, EIF_INTEGER prot)
	/*x get a socket descriptor from a scoket family, type and protocol */
{
	EIF_SOCKET_TYPE l_socket;
	int result;
	EIF_NET_INITIALIZE;
	l_socket = socket ((int) add_f, (int) typ, (int) prot);
#ifdef EIF_WINDOWS
	result = c_windows_socket (l_socket);
#else
	result = (int) l_socket;
#endif
	eif_net_check (result);
	return (EIF_INTEGER) result;
}

void c_close_socket(EIF_INTEGER s)
	/*x close socket descriptor s */
{
#ifdef EIF_WINDOWS
	closesocket((EIF_SOCKET_TYPE)s);
#else
	close((EIF_SOCKET_TYPE) s);
#endif
}

void c_bind(EIF_INTEGER s, EIF_POINTER add, EIF_INTEGER length)
	/*x bind socket descriptor s to socket address address (of length
	    length */
{
	EIF_NET_INITIALIZE;
	eif_net_check (bind((EIF_SOCKET_TYPE) s, (struct sockaddr *) add, (int) length));
}

EIF_INTEGER c_accept(EIF_INTEGER s, EIF_POINTER add, EIF_INTEGER length)
	/*x accept connections on socket descriptor s, set peer address
	    into socket address structure add (of length *length) */
{
#ifdef EIF_VMS
	size_t a_length = (size_t) length;
#else
	socklen_t a_length = (socklen_t) length;
#endif
	EIF_SOCKET_TYPE l_socket;
	int result;

	EIF_NET_INITIALIZE;
	l_socket = accept ((EIF_SOCKET_TYPE) s, (struct sockaddr *) add, &a_length);
#ifdef EIF_WINDOWS
	result = c_windows_socket (l_socket);
#else
	result = (int) l_socket;
#endif
	eif_net_check (result);
	return (EIF_INTEGER) result;

}

void c_listen(EIF_INTEGER s, EIF_INTEGER backlog)
	/*x listen up to backlog connexions on socket descriptor s */
{
	EIF_NET_INITIALIZE;
	eif_net_check (listen((EIF_SOCKET_TYPE) s, (int) backlog));
}

void c_connect(EIF_INTEGER s, EIF_POINTER add, EIF_INTEGER length)
	/*x connect socket s to socket address add of length length */
{
	EIF_NET_INITIALIZE;
	eif_net_check (connect((EIF_SOCKET_TYPE) s, (struct sockaddr *) add, (int) length));
}

EIF_INTEGER c_select(EIF_INTEGER nfds, EIF_POINTER rmask, EIF_POINTER wmask, EIF_POINTER emask, EIF_INTEGER timeout, EIF_INTEGER timeoutm)
	/* Read The Fine Manual */
{
	struct timeval t;
	int result;

	EIF_NET_INITIALIZE;
#ifdef EIF_WINDOWS
	if (!rmask && !wmask && !emask) {
		if (timeout != -1) 
			Sleep(timeout*1000 + timeoutm);
		return 0;
	}
#endif
	if (timeout == -1) {
		result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL);
		eif_net_check (result);
		return (EIF_INTEGER) result;
	}

	t.tv_sec = timeout;
	t.tv_usec = (timeoutm * 1000);

	result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t);
	eif_net_check (result);
	return (EIF_INTEGER) result;
}

void c_sock_name(EIF_INTEGER s, EIF_POINTER addr, EIF_INTEGER length)
	/*x socket s address structure into addr
	    of length length (to be provided a priori) */
{
#ifdef EIF_VMS
	size_t a_length = (size_t) length;
#else
	socklen_t a_length = (socklen_t) length;
#endif
	int result;

	EIF_NET_INITIALIZE;
	result = getsockname((EIF_SOCKET_TYPE) s, (struct sockaddr *) addr, &a_length);
	eif_net_check (result);
}

EIF_INTEGER c_peer_name(EIF_INTEGER s, EIF_POINTER addr, EIF_INTEGER length)
	/*x get peer address of socket s in socket address structure addr
	    of length length (to be provided a priori) */
{
#ifdef EIF_VMS
	size_t a_length = (size_t) length;
#else
	socklen_t a_length = (socklen_t) length;
#endif
	int result;

	EIF_NET_INITIALIZE;
	result = getpeername((EIF_SOCKET_TYPE) s, (struct sockaddr *) addr, &a_length);
	eif_net_check (result);
	return (EIF_INTEGER) a_length;
}

/*x basic types receiving (macro) */
#define CREADX(bytes_read, descriptor, element_pointer, sizeofelement, flags) \
	bytes_read = recv((EIF_SOCKET_TYPE) descriptor, (char *) element_pointer, (int) sizeofelement, (int) flags)

/*x basic types sending (macro) */
#define CSENDX(bytes_sent, descriptor, element_pointer, sizeofelement, flags) \
	bytes_sent = send((EIF_SOCKET_TYPE) descriptor, (char *) element_pointer, (int) sizeofelement, (int) flags)

/*x basic types sending TO (macro) */
#define CSENDXTO(bytes_sent, descriptor,element_pointer,sizeofelement, flags, addr_pointer, sizeofaddr) \
	bytes_sent = sendto((EIF_SOCKET_TYPE) descriptor, (char *) element_pointer, (int) sizeofelement, (int) flags, \
			(struct sockaddr *) addr_pointer, (int) sizeofaddr)


/******************************************************/
/* send to operations                                 */
/******************************************************/

EIF_INTEGER c_send_stream_to_noexception(EIF_INTEGER fd, EIF_POINTER stream_pointer, EIF_INTEGER length, EIF_INTEGER flags, EIF_POINTER addr_pointer, EIF_INTEGER sizeofaddr)
	/*  Transmission of string s of size size through socket fd
	 *  NO exception is raised, and eventual error is return as result!
	 */
{
	int res;
	CSENDXTO(res, fd, (char *)stream_pointer,length,flags,(struct sockaddr *) addr_pointer,sizeofaddr);
	return (EIF_INTEGER) res;
}

void c_send_stream_to(EIF_INTEGER fd, EIF_POINTER stream_pointer, EIF_INTEGER length, EIF_INTEGER flags, EIF_POINTER addr_pointer, EIF_INTEGER sizeofaddr)
	/*x transmission of string s of size size through socket fd */
{
	int res;
	res = c_send_stream_to_noexception(fd, (char *)stream_pointer,length,flags,(struct sockaddr *) addr_pointer, sizeofaddr);
	eif_net_check(res);
}

/******************************************************/
/* put operations                                 */
/******************************************************/

EIF_INTEGER c_put_stream_noexception(EIF_INTEGER fd, EIF_POINTER stream_pointer, EIF_INTEGER length)
	/* transmission of string s of size length through socket fd.
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
	int res;
	CSENDX(res, fd, stream_pointer, length, 0);
	return (EIF_INTEGER) res;
}

void c_put_stream(EIF_INTEGER fd, EIF_POINTER stream_pointer, EIF_INTEGER length)
	/*x transmission of string s of size length through socket fd */
{
	eif_net_check(c_put_stream_noexception(fd, stream_pointer, length));
}

EIF_INTEGER c_sendfile_fallback(EIF_INTEGER out_fd, FILE* f, EIF_INTEGER offset, EIF_INTEGER length, EIF_INTEGER a_timeout_ms)
	/* transmission of file content from file `f` of size length through socket out_fd.
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
#define EIFNET_BUFFSIZE 4096
	int fd;
	int retval_read, retval_write;
	int bytes_sent, bytes_to_read;
	int n, bytes_to_send;
	char buf[EIFNET_BUFFSIZE];

#ifdef EIF_WINDOWS
	fd = _fileno(f);
#else
	fd = fileno(f);
#endif
	bytes_sent = 0;
	bytes_to_read = length;
	if (offset > 0) {
		fseek(f, offset, SEEK_SET);
	}
	do {
			/* Read chunk of bytes */
		if (bytes_to_read < EIFNET_BUFFSIZE) {
			n = bytes_to_read;
		} else {
			n = EIFNET_BUFFSIZE;
		}
#ifdef EIF_WINDOWS		
		retval_read = (int)_read(fd, buf, n);
#else
		retval_read = (int) read(fd, buf, n);
#endif
		if (retval_read < 0) {
				/* error while reading file */
			return (EIF_INTEGER) retval_read;
		} else {
			bytes_to_read = bytes_to_read - retval_read;
		}
			/* Send read bytes */
		bytes_to_send = retval_read;
		do {
			retval_write = (int) c_put_stream_noexception(out_fd, buf, bytes_to_send);
			if (retval_write < 0) {
					/* error while writing into socket */
				return (EIF_INTEGER) retval_write;
			} else {
				bytes_to_send = bytes_to_send - retval_write;
				bytes_sent = bytes_sent + retval_write;
			}
		} while (bytes_to_send > 0);

	} while (retval_read || retval_write);

		/* If this code is reached, no file or network error occurred
		 * thus return the number of bytes read and sent.
		 */
	return (EIF_INTEGER) bytes_sent;
#undef EIFNET_BUFFSIZE
}

EIF_INTEGER c_sendfile(EIF_INTEGER out_fd, FILE* f, EIF_INTEGER offset, EIF_INTEGER length, EIF_INTEGER a_timeout_ms)
	/* transmission of file content from file `f` of size length through socket out_fd.
	 * On Windows, due to asynchronous potential behavior, wait for completion using `a_timeout_ms` value.
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
#ifndef EIF_HAS_SENDFILE
	return c_sendfile_fallback (out_fd, f, offset, length, a_timeout_ms);
#elif defined(EIF_WINDOWS)
	BOOL retval;
	HANDLE hFile;
	OVERLAPPED ovlp;
	DWORD bytes_to_send, bytes_sent;
	DWORD curoff;
	DWORD dwFlags;

	/*	Initialize locals */
	hFile = (HANDLE)_get_osfhandle(fileno(f));
	curoff=(DWORD) offset;
	dwFlags = 0;
	memset(&ovlp, 0, sizeof(OVERLAPPED));
	ovlp.hEvent = CreateEvent(NULL, FALSE, FALSE, NULL);
	bytes_sent = 0;
	bytes_to_send = (DWORD) length;
	retval = 0;

	/*	Send file content */
	while (bytes_to_send) {
		DWORD xmitbytes;
		/*
		 * If we want to force our own chunk size ...
		 *  
		 * if (bytes_to_send > 65536) {
		 * 		xmitbytes = 65536;
		 * } else {
		 * 		// Last call to TransmitFile()
		 * 		xmitbytes = bytes_to_send;
		 * 		//dwFlags |= TF_REUSE_SOCKET;
		 * 		//dwFlags |= TF_WRITE_BEHIND;
		 * }
		*/
		xmitbytes = bytes_to_send;
		ovlp.Offset = (DWORD)curoff;
		/* FIXME: see large file support: ovlp.OffsetHigh = (DWORD)(curoff >> 32); */
		retval = TransmitFile((EIF_SOCKET_TYPE) out_fd, (HANDLE) hFile, xmitbytes, 
				(DWORD) 0 /* Use default Windows block size */, 
				(LPOVERLAPPED) &ovlp, 
				(LPTRANSMIT_FILE_BUFFERS) NULL,
				(DWORD) dwFlags
			);
		if (!retval) {
			int errcode;
			errcode = WSAGetLastError();
			if ((errcode == ERROR_IO_PENDING) | (errcode == WSA_IO_PENDING)) {
				int rv;
				rv = WaitForSingleObject(ovlp.hEvent, (DWORD) (a_timeout_ms >= 0 ? a_timeout_ms : INFINITE));
				if (rv == WAIT_OBJECT_0) {
					if (!WSAGetOverlappedResult((EIF_SOCKET_TYPE)out_fd, (LPOVERLAPPED) &ovlp, &xmitbytes, FALSE, &dwFlags)) {
						return -1;
					}
					retval = 0; /* for code after the `while` loop. */
				} else if (rv == WAIT_TIMEOUT) {
					return (EIF_INTEGER) -1;
				} else {
						/* either WAIT_FAILED or WAIT_ABANDONED or ... */
					return (EIF_INTEGER) -1;
				}
			}
		}
		bytes_to_send -= xmitbytes;
		curoff += xmitbytes;
		bytes_sent += xmitbytes;
	}
	if (retval) {
		return (EIF_INTEGER) bytes_sent;
	} else {
			/* Error occurred */
		return (EIF_INTEGER) -1;
	}
#else /* not EIF_WINDOWS */
	ssize_t retval;
	if (length > 0) {
		size_t bytes_to_send;
		ssize_t bytes_sent;
		off_t curoff = offset;
		int fd;

		fd = fileno(f);
		bytes_to_send = (size_t) length;
		while ((retval = sendfile((EIF_SOCKET_TYPE) out_fd, (int) fd, (off_t *) &curoff, bytes_to_send) > 0) && (bytes_to_send > 0)) {
			if (retval > 0) {
				bytes_to_send = bytes_to_send - retval;
				bytes_sent = bytes_sent + retval;
			}
		} 
		if (retval) {
			return (EIF_INTEGER) bytes_sent;
		} else {
				/* Error occurred */
			return (EIF_INTEGER) retval;
		}
	} else {
		return (EIF_INTEGER) 0;
	}
#endif
}

/******************************************************/
/* read operations                                    */
/******************************************************/

EIF_INTEGER c_read_stream_noexception(EIF_INTEGER fd, EIF_INTEGER len, EIF_POINTER buf)
	/* Read a stream of character from socket fd into buffer buf of length len.
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
	int res;
	CREADX(res,fd,buf,len, 0);
	return (EIF_INTEGER) res;
}

EIF_INTEGER c_read_stream(EIF_INTEGER fd, EIF_INTEGER len, EIF_POINTER buf)
	/* Read a stream of character from socket fd into buffer buf
	    of length len */
{
	EIF_INTEGER res;
	res = c_read_stream_noexception(fd, len, buf);
	eif_net_check(res);
	return res;
}

EIF_INTEGER c_recv_noexception(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags)
	/* Receive at most len bytes from socket fd into buffer buf
	 *   flags can be or'ed from 0, MSG_OOB, MSG_PEEK or MSG_DONTROUTE 
	 * NO exception is raised, and eventual error is return as result!
	 */
{
	int res;
	CREADX(res, fd, buf, len, flags);
	return (EIF_INTEGER) res;
}

EIF_INTEGER c_receive(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags)
	/* Receive at most len bytes from socket fd into buffer buf
	    flags can be or'ed from 0, MSG_OOB, MSG_PEEK or MSG_DONTROUTE */
{
	EIF_INTEGER res;
	res = c_recv_noexception(fd, buf, len, flags);
	eif_net_check(res);
	return res;
}

EIF_INTEGER c_recvfrom_noexception(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags, EIF_POINTER addr, EIF_POINTER addr_len)
	/* Like c_receive and sender address is stored into socket address
	 *   structure addr and address length into *addr_len .
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
	int res;
#ifdef EIF_VMS
	size_t l_addr_len = (size_t) (*(EIF_INTEGER *) addr_len);
#else
	socklen_t l_addr_len = (socklen_t) (*(EIF_INTEGER *) addr_len);
#endif
	res = recvfrom((EIF_SOCKET_TYPE) fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) addr, &l_addr_len);
	*(EIF_INTEGER *) addr_len = (EIF_INTEGER) l_addr_len;
	return (EIF_INTEGER) res;
}

EIF_INTEGER c_rcv_from(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags, EIF_POINTER addr, EIF_POINTER addr_len)
	/* Like c_receive and sender address is stored into socket address
	    structure addr and address length into *addr_len */
{
	EIF_INTEGER res;
	res = c_recvfrom_noexception(fd, buf, len, flags, addr, addr_len);
	eif_net_check(res);
	return res;
}


/********************************************************/
/* write operations                                     */
/********************************************************/

EIF_INTEGER c_write_noexception(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len)
	/* Write at most len bytes from buffer buf into socket fd
	 *   return number of actually sent bytes.
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
	int result;
	CSENDX(result, fd, buf, len, 0);
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_write(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len)
	/* Write at most len bytes from buffer buf into socket fd
	    return number of actually sent bytes */
{
	EIF_INTEGER res;
	res = c_write_noexception(fd, buf, len);
	eif_net_check (res);
	return res;
}

EIF_INTEGER c_send_noexception(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags)
	/* Send at most len bytes from buffer buf into socket fd
	 *   to connected peer address
	 *   flags can be or'ed from 0 with MSG_OOB, MSG_PEEK, MSG_DONTROUTE
	 *   return actual number of bytes sent .
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
	int result;
	CSENDX(result, fd, buf, len, flags);
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_send(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags)
	/* Send at most len bytes from buffer buf into socket fd
	    to connected peer address
	    flags can be or'ed from 0 with MSG_OOB, MSG_PEEK, MSG_DONTROUTE
	    return actual number of bytes sent */
{
	EIF_INTEGER res;
	res = c_send_noexception(fd, buf, len, flags);
	eif_net_check (res);
	return res;
}

EIF_INTEGER c_sendto_noexception(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags, EIF_POINTER addr, EIF_INTEGER addr_len)
	/* Like c_send and peer address can be set through socket address
	 *   structure addr of length addr_len .
	 *	NO exception is raised, and eventual error is return as result!
	 */
{
	int result;
	result = sendto((EIF_SOCKET_TYPE) fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) addr, (int) addr_len);
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_send_to (EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags, EIF_POINTER addr, EIF_INTEGER addr_len)
	/* Like c_send and peer address can be set through socket address
	    structure addr of length addr_len */
{
	EIF_INTEGER res;
	res = c_sendto_noexception(fd, buf, len, flags, addr, addr_len);
	eif_net_check (res);
	return res;
}

/********************************************************/
/* Socket options management                            */
/********************************************************/

void c_set_sock_opt_int(EIF_INTEGER fd, EIF_INTEGER level, EIF_INTEGER opt, EIF_INTEGER val)
	/* Set socket fd options */
{
	int arg = (int) val;
	eif_net_check (setsockopt((EIF_SOCKET_TYPE) fd, (int) level, (int) opt, (char *) &arg, sizeof(arg)));
}

EIF_INTEGER c_get_sock_opt_int(EIF_INTEGER fd, EIF_INTEGER level, EIF_INTEGER opt)
	/* Get socket fd options */
{
	int arg;
#ifdef EIF_VMS
	size_t asize;
#else
	socklen_t asize;
#endif
	asize = sizeof(arg);
	eif_net_check(getsockopt((EIF_SOCKET_TYPE) fd, (int) level, (int) opt, (char *) &arg, &asize));
	return (EIF_INTEGER) arg;
}

EIF_BOOLEAN c_is_linger_on(EIF_INTEGER fd)
	/* Does socket discard data on close ? (default linger off -> no) */
{
	struct linger arg;
#ifdef EIF_VMS
	size_t asize;
#else
	socklen_t asize;
#endif
	asize = sizeof(arg);
	eif_net_check (getsockopt((EIF_SOCKET_TYPE) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize));
	return (EIF_BOOLEAN) (! (arg.l_onoff == 0));
}

EIF_INTEGER c_linger_time(EIF_INTEGER fd)
	/* Non null values are equivalent (despite original specification) */
{
	struct linger arg;
#ifdef EIF_VMS
	size_t asize;
#else
	socklen_t asize;
#endif
	asize = sizeof(arg);
	eif_net_check (getsockopt((EIF_SOCKET_TYPE) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize));
	return (EIF_INTEGER) arg.l_linger;
}

EIF_INTEGER c_set_sock_opt_linger(EIF_INTEGER fd, EIF_BOOLEAN flag, EIF_INTEGER time)
	/* Set linger options (on/off and timeout), does not work */
{
	struct linger arg;
	int result;

#ifdef EIF_WINDOWS
		/* On Windows the struct expects `u_short' not `int'. */
	arg.l_onoff = (u_short) flag;
	arg.l_linger = (u_short) time;
#else
	arg.l_onoff = (int) flag;
	arg.l_linger = (int) time;
#endif
	result = setsockopt((EIF_SOCKET_TYPE) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, sizeof(arg));
	eif_net_check (result);
	return (EIF_INTEGER) result;
}

/********************************************************/
/* timeout   											*/
/********************************************************/

#define nanoseconds_in_second 		RTU64C(1000000000)
#define nanoseconds_in_millisecond 	RTU64C(1000000)
#define nanoseconds_in_microsecond 	RTU64C(1000)

EIF_NATURAL_64 c_get_sock_opt_timeout(EIF_INTEGER fd, EIF_INTEGER level, int optname)
	/* Get socket fd timeval `optname` option in nanoseconds */
{
#ifdef EIF_VMS
	size_t asize;
#else
	socklen_t asize;
#endif

#ifdef EIF_WINDOWS
	int arg;
	asize = sizeof(arg);
	eif_net_check(getsockopt((EIF_SOCKET_TYPE) fd, (int) level, optname, (char *) &arg, &asize));
	return nanoseconds_in_millisecond * arg; 
#else
	struct timeval tv;
	asize = sizeof(struct timeval);
	eif_net_check(getsockopt((EIF_SOCKET_TYPE) fd, (int) level, optname, &tv, &asize));
	return (EIF_NATURAL_64) (nanoseconds_in_second * tv.tv_sec + nanoseconds_in_microsecond * tv.tv_usec);
#endif
}

void c_set_sock_opt_timeout(EIF_INTEGER fd, EIF_INTEGER level, int optname, EIF_NATURAL_64 timeout_ns)
	/* Set socket `optname` option to timeout_ns */
{
#ifdef EIF_WINDOWS
	EIF_NATURAL_64 ms;
	int arg;
	ms = timeout_ns / nanoseconds_in_millisecond; 
	if (ms > INT_MAX) {
		arg = INT_MAX;
	} else {
		arg = (int) ms;
	}
	if (arg == 0 && timeout_ns != 0) {
			/* timeout values are above zero, but less than 1 millisecond
			 * then set to 1 millisecond as a timeout of 0 may indicate an infinite time-out period).
			 */
		arg = 1;
	}
	eif_net_check (setsockopt((EIF_SOCKET_TYPE) fd, (int) level, optname, (char *) &arg, sizeof(arg)));
#else
	struct timeval tv;
	tv.tv_sec = (long) (timeout_ns / nanoseconds_in_second); 
	tv.tv_usec = (long) ((timeout_ns % nanoseconds_in_second) / nanoseconds_in_microsecond);
	if (tv.tv_sec == 0 && tv.tv_usec == 0 && timeout_ns != 0) {
			/* timeout values are above zero, but less than 1 microsecond
			 * then set to 1 microsecond as a timeout of 0 may indicate an infinite time-out period).
			 */
		tv.tv_usec = 1;
	}
	eif_net_check (setsockopt((EIF_SOCKET_TYPE) fd, (int) level, optname, &tv, sizeof(struct timeval)));
#endif
}

/********************************************************/
/* Misc													*/
/********************************************************/

EIF_INTEGER c_fcntl(EIF_INTEGER fd, EIF_INTEGER cmd, EIF_INTEGER arg)
	/* Set possibly open fd socket options */
{
#if defined EIF_WINDOWS || defined VXWORKS
	return 0;
#elif defined EIF_VMS
#  ifdef DEBUG
	printf("c_fcntl(%d, %d, %d) called\n", fd, cmd, arg);
#  endif /* DEBUG */
	return 0;
#else
	return (EIF_INTEGER) fcntl((int) fd, (int) cmd, (int) arg);
#endif
}

void c_set_blocking(EIF_INTEGER fd)
	/* Set socket fd blocking */
{
#ifdef EIF_WINDOWS
	u_long arg = 0;
	eif_net_check(ioctlsocket((SOCKET) fd, FIONBIO, &arg));
#elif defined VXWORKS
	int arg = 0;
	eif_net_check(ioctl((int) fd, FIONBIO, (int) &arg)); 
#elif defined EIF_VMS
	int arg = 0;
	eif_net_check(ioctl((int) fd, FIONBIO, &arg)); 
#else
	int arg = 0;
	eif_net_check(ioctl((int) fd, FIONBIO, (char *) &arg));
#endif
}

void c_set_non_blocking(EIF_INTEGER fd)
	/* Set socket fd non-blocking */
{

#ifdef EIF_WINDOWS
	u_long arg = 1;
	eif_net_check(ioctlsocket((SOCKET) fd, FIONBIO, &arg));
#elif defined VXWORKS
	int arg = 1;
	eif_net_check(ioctl((int) fd, FIONBIO, (int) &arg)); 
#elif defined EIF_VMS
	int arg = 1;
	eif_net_check(ioctl((int) fd, FIONBIO, &arg)); 
#else
	int arg = 1;
	eif_net_check(ioctl ((int) fd, FIONBIO, (char *) &arg));
#endif
}

EIF_INTEGER c_get_number(EIF_POINTER data_obj)
	/* Packet number out of packet structure */
{
	/* Note: it is assumed here the size of a long integer (EIF_INTEGER)
	 * is either 4 or 8.
	 */

#if LNGSIZ == 4
	return (EIF_INTEGER) ntohl(* ((EIF_INTEGER *) data_obj));
#else
	uint32 upper, lower, value;
	unsigned long tmp;
	EIF_INTEGER result;

	memcpy(&value, ((char *) data_obj), sizeof(uint32));
	lower = (uint32) ntohl(value);
	upper = 0x00000000;
	if (lower & 0x80000000) {
		lower &= 0x7fffffff;
		upper = 0x80000000;
	}
	result = (EIF_INTEGER) ((lower & 0x00000000ffffffff) | (upper << 32));

	return result;
#endif
}

void c_set_number(EIF_POINTER data_obj, EIF_INTEGER num)
	/* Set packet number in packet structure */
{
	/* Note: it is assumed here the size of a long integer (EIF_INTEGER)
	 * is either 4 or 8.
	 */

#if LNGSIZ == 4
	(*(EIF_INTEGER *) data_obj) = htonl(num);
#else
	uint32 upper, lower, value;
	unsigned long tmp;

	lower = (uint32) (num & 0x000000007fffffff);
	if (num & 0x8000000000000000)
		lower |= 0x80000000;
	value = htonl((uint32)(lower));
	memcpy(((char *) data_obj), &value, sizeof(uint32));
#endif
}


void c_shutdown(EIF_INTEGER sock, EIF_INTEGER how)
	/* Shut down a socket with `how' modality */
{
		/* Note that even if the call to `shutdown' fails we don't throw an
		 * exception. The reason is that sometime the socket is already closed
		 * from the other side and we don't want an exception in that case.
		 */
	shutdown((int) sock,(int) how);
}



#ifdef EIF_VMS
# ifdef VMS_MULTINET
    int     decc$get_sdc(int __descrip_no);
# else
    int     decc$get_sdc(int __descrip_no);
# endif

# if !defined VMS_MULTINET && defined EIF_VMS_VER && EIF_VMS_VER < 70000000 
/* and no ioctl is available... */
/*  actually, ioctl may be available. We don't know what version the object
    will run on, so must call lib$find_image_symbol...
*/

static int my_ioctl (int sd, int r, void * argp) {
    static int first_time;
    /* typedef int (*ioctl_fptr) (int __sd, int __r, void * __argp) ;
    static ioctl_fptr ioctl_p;						*/
    static int (*ioctl_p) (int __sd, int __r, void * __argp) ;
    printf("my_ioctl(%d, %d, %d) called\n", sd, r, *(int*)argp);
    return -1;
}
# endif /* VMS_MULTINET || __DECC_VER ( > 5.x) */
#endif /* EIF_VMS */

#ifdef DEBUG
int debug_sockopt(s)
int s;
{
    unsigned int err, errn, val;
#ifndef VMS_MULTINET
    unsigned
#endif
    int siz;

#ifdef EIF_VMS
    unsigned int sdc = decc$get_sdc(s);
#endif
    siz = sizeof(val);
    err = getsockopt(s, SOL_SOCKET, SO_KEEPALIVE, &val, &siz);
    siz = sizeof(val);
    err = getsockopt(s, SOL_SOCKET, O_NONBLOCK, &val, &siz);
    errn = errno;
    return 0;
}
#endif

#define DEBUG
#if defined(EIF_VMS) && defined(DEBUG)
static int print_errno()
{
    int err = (errno == EVMSERR ? vaxc$errno : errno);
#ifdef VMS_MULTINET
#include "multinet_root:[multinet.include]netdb.h"
    int err1 = h_errno;
    printf("\nnetwork_debug: errno = %d (%s), h_errno = %d\n", 
	errno, strerror(errno, vaxc$errno), h_errno);
#else
    printf("\nnetwork_debug: errno = %d (%s), h_errno = (not avail)\n", 
	errno, strerror(errno, vaxc$errno));
#endif
    return errno;
}
#endif /* VMS && DEBUG */
