/*
	Eiffel Net C interfacing
	.../library/net/Clib/network.c
*/

#ifdef __VMS	/* module name clash with .../C/ipc/shared/network.c */
#pragma module NET_NETWORK
#endif /* __VMS */

#ifdef EIF_WIN32
#define FD_SETSIZE 256
#endif

#include "eif_config.h"
#include "eif_portable.h" 	/* required for VMS, recommended for others */
#include "eif_except.h"  
#include "eif_size.h"     	/* for LNGSIZ */
#include "eif_error.h"    	/* for eio() */

#ifdef EIF_WIN32
#define WIN32_LEAN_AND_MEAN
#include <winsock.h>
#define EWOULDBLOCK WSAEWOULDBLOCK
#define EINPROGRESS WSAEINPROGRESS
#include <stdio.h>
#endif

#ifdef EIF_OS2
#include <stdlib.h>
#include <types.h>
#include <sys/socket.h>
#include <io.h>
#endif

#ifndef EIF_WIN32
#include <sys/time.h>
#endif

#ifdef EIF_VMS
#include "netvmsdef.h"
#else
#include <sys/types.h>
#endif

#ifndef EIF_WIN32
#include <unistd.h>
#endif

#include <errno.h>

#ifndef BSD
#define BSD_COMP
#endif

#ifndef EIF_WIN32
#include <sys/ioctl.h>
#endif

#include "eif_cecil.h"

#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
#endif

#ifdef I_FD_SET_SYS_SELECT
#include <sys/select.h>
#endif

#ifdef I_NETINET_I
#include <netinet/in.h>
#endif

#ifdef I_SYS_IN
#include <sys/in.h>
#endif

#if defined EIF_WIN32 || defined EIF_OS2 || defined EIF_VMS
#else
#include <sys/un.h>
#include <arpa/inet.h>
#include <fcntl.h>
#endif

#include <string.h>

#include "bitmask.h"



#ifdef EIF_WIN32
#define EIFNET_ERROR_HAPPENED SOCKET_ERROR
	/* Clean up function */
typedef void (* EIF_CLEANUP)(EIF_BOOLEAN);

	/* Register `f' as a clean up function */
extern void eif_register_cleanup(EIF_CLEANUP f);
#else
#define EIFNET_ERROR_HAPPENED -1
#endif

	/* Raise an Eiffel exception in case an error occured */

void eif_net_check (int retcode) {
	/* Check the return code of connect(), recv(), send(), ... */

#ifdef EIF_WIN32
	char buf[80]="Net error #";
	int errcode;
	if (retcode == SOCKET_ERROR) {
		errcode = WSAGetLastError();
		if (errcode==WSANOTINITIALISED)
			eraise("WSANOTINITIALISED A successful WSAStartup must occur before using this function.",EN_PROG);
		if (errcode==WSAENETDOWN)
			eraise("WSAENETDOWN The network subsystem has failed.",EN_PROG);
		if (errcode==WSAEADDRINUSE)
			eraise("WSAEADDRINUSE The specified address is already in use. (See the SO_REUSEADDR socket option under setsockopt).",EN_PROG);
		if (errcode==WSAEFAULT)
			eraise("WSAEFAULT The name or the namelen parameter is not a valid part of the user address space, the namelen parameter is too small, the name parameter contains incorrect address format for the associated address family, or the first two bytes of the memory block specified by name does not match the address family associated with the socket descriptor s.",EN_PROG);
		if (errcode==WSAEINPROGRESS)
			eraise("WSAEINPROGRESS A blocking Windows Sockets 1.1 call is in progress, or the service provider is still processing a callback function.",EN_PROG);
		if (errcode==WSAEINVAL)
			eraise("WSAEINVAL The socket is already bound to an address.",EN_PROG);
		if (errcode==WSAENOBUFS)
			eraise("WSAENOBUFS Not enough buffers available, too many connections.",EN_PROG);
		if (errcode==WSAENOTSOCK)
			eraise("WSAENOTSOCK The descriptor is not a socket.",EN_PROG);
		if ((errcode != EWOULDBLOCK) && (errcode != EINPROGRESS)) {
			itoa(errcode,&buf[11],10);
			eraise(buf,EN_IO);
		}
	}
#else
		/* FIXME */
		/* Get the last error here, and signal it like above...*/
	if (retcode < 0) {
		eraise("Error happened when accessing net",EN_IO);
	}
#endif

}

void eif_net_check_recv (int r) {
	/* Check the value returned returned by recv() */

#ifdef EIF_WIN32
	if (r == SOCKET_ERROR) {
		eif_net_check(r);
	} else if (r == 0) {
		eraise ("Connection closed", EN_PROG);
	}
#else
		/* FIXME */
	if (r < 0)
		eif_net_check(r);
#endif

}


#ifdef EIF_OS2
void do_init(void)
{
	static int done = FALSE;

	if (! done)
		eif_net_check (sock_init());
}
#endif


#ifdef EIF_WIN32

void eif_winsock_cleanup(EIF_BOOLEAN f)
{
	eif_net_check(WSACleanup());
}

void do_init(void)
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
		eif_register_cleanup(eif_winsock_cleanup);
		done = TRUE;
	}
}
#endif

/* The following macros and functions are added by Yuanchang(Terry) Tang to
 * process REAL/DOUBLE between different platforms. We change all formats
 * into UNIX format. Because Eiffel run-time does not distinguish Linux
 * from Unix, we have to use "ntohl" to distinguish them in the
 * functions instead of defining different macros.
 */

#define ise_ntohf(x)		change_float_order(x)
#define ise_htonf(x)		change_float_order(x)
#define ise_ntohd(x)		change_double_order(x)
#define ise_htond(x)		change_double_order(x)

static char ise_order_flag=0; /* value 1: No order reversing is necessary;
							   *       2: Order reversing is necessary;
							   *       0: Test if order reversing is necessary
							   */

float change_float_order(float f) 
{
	float x, y;
	unsigned char *px=(unsigned char *)(&x);
	unsigned char *py=(unsigned char *)(&y);
	int i;

	if (ise_order_flag==0) {
		if (0x1122 == ntohl(0x1122)) 
			ise_order_flag = 1;
		else
			ise_order_flag = 2;
	}
	if (ise_order_flag == 1)
		return f;
	else {
		x = f; /* It's necessary in Windows */
		for (i=0; i<sizeof(float); i++) 
			py[i] = px[sizeof(float)-1-i];
		return y;
	}
}

double change_double_order(double d) 
{
	double x, y;
	unsigned char *px=(unsigned char *)(&x);
	unsigned char *py=(unsigned char *)(&y);
	int i;

	if (ise_order_flag==0) {
		if (0x1122 == ntohl(0x1122)) 
			ise_order_flag = 1;
		else
			ise_order_flag = 2;
	}
	if (ise_order_flag == 1)
		return d;
	else {
		x = d; /* It's necessary in Windows. */
		for (i=0; i<sizeof(double); i++) 
			py[i] = px[sizeof(double)-i-1];
		return y;
	}
}



/*** select facilities ***/

EIF_INTEGER mask_size()
	/*x size of mask fd_set */
{
	return (EIF_INTEGER) (sizeof(fd_set));
}


void c_mask_clear(EIF_OBJ mask, EIF_INTEGER pos)
	/*x turn the bit for pos off in mask */
{
	FD_CLR((int) pos, (fd_set *) mask);
}


void c_set_bit(EIF_OBJ mask, EIF_INTEGER pos)
	/*x turn the bit for pos on in mask */
{
	FD_SET((int) pos, (fd_set *) mask);
}

EIF_BOOLEAN c_is_bit_set(EIF_OBJ mask, EIF_INTEGER pos)
	/*x test the bit for pos in mask */
{
	return (EIF_BOOLEAN) ((FD_ISSET((int) pos, (fd_set *) mask)) != 0);
}

void c_zero_mask(EIF_OBJ mask)
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

	return (EIF_INTEGER) sizeof(struct sockaddr_in);
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
	EIF_POINTER address;

	res =  (char *) inet_ntoa(*((struct in_addr *) addr));
	address = makestr(res, strlen(res));
	return address;
}

void host_address_from_name (EIF_POINTER addr, EIF_POINTER name)
	/*x 32-bits netid/hostid set in addr from hostname name */
{
	struct hostent *hp;

#if defined EIF_WIN32 || defined EIF_OS2
	do_init();
#endif

	hp = gethostbyname((char *) name);

	if (hp == (struct hostent *) 0)
		eif_net_check(EIFNET_ERROR_HAPPENED);

	((struct in_addr *) addr)->s_addr = ((struct in_addr *) (hp->h_addr))->s_addr;
}

EIF_INTEGER get_servent_port(EIF_POINTER name, EIF_POINTER proto)
	/*x get port number of a service by its name */
{
	struct servent *sp;

#if defined EIF_WIN32 || defined EIF_OS2
	do_init();
#endif

	sp = getservbyname((char *) name, (char *) proto);
	if (sp == (struct servent *) 0) {
		eio();
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
	strncpy(((struct sockaddr *) add)->sa_data, dat, 14);
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
		strncpy(((struct sockaddr_in *) add)->sin_zero, (char *) zero, 8);
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
	unlink((char *) name);
}

EIF_INTEGER c_socket(EIF_INTEGER add_f, EIF_INTEGER typ, EIF_INTEGER prot)
	/*x get a socket descriptor from a scoket family, type and protocol */
{
	int result;

#if defined EIF_WIN32 || defined EIF_OS2
	do_init();
#endif

	result = socket((int) add_f, (int) typ, (int) prot);
#if defined EIF_WIN32 || defined EIF_OS2
	if (result == INVALID_SOCKET)
		eio();
#else
	if (result < 0)
		eio();
#endif
	return (EIF_INTEGER) result;
}

void c_close_socket(EIF_INTEGER s)
	/*x close socket descriptor s */
{
#ifdef EIF_WIN32
	closesocket((SOCKET)s);
#elif defined EIF_OS2
	soclose((int) s);
#else
	close((int) s);
#endif
}

void c_bind(EIF_INTEGER s, EIF_POINTER add, EIF_INTEGER length)
	/*x bind socket descriptor s to socket address address (of length
	    length */
{
#ifdef EIF_WIN32
	do_init();
	eif_net_check (bind((SOCKET) s, (struct sockaddr *) add, (int) length));
#elif defined EIF_OS2
	do_init();
	eif_net_check (bind((int) s, (struct sockaddr *) add, (int) length));
#else
	eif_net_check (bind((int) s, (struct sockaddr *) add, (int) length));
#endif
}

EIF_INTEGER c_accept(EIF_INTEGER s, EIF_POINTER add, EIF_INTEGER length)
	/*x accept connections on socket descriptor s, set peer address
	    into socket address structure add (of length *length) */
{
#ifdef EIF_VMS
	size_t a_length = length;
#else
	int a_length = length;
#endif

#if defined EIF_WIN32

	SOCKET result;

	do_init();
	result = accept((SOCKET) s, (struct sockaddr *) add, &a_length);
	eif_net_check ((result==INVALID_SOCKET) ? EIFNET_ERROR_HAPPENED : 0);

#elif defined EIF_OS2

	int result;

	do_init();
	result = accept((int) s, (struct sockaddr *) add, &a_length);
	eif_net_check ((result==-1) ? EIFNET_ERROR_HAPPENED : 0);
#else

	int result;

	result = accept((int) s, (struct sockaddr *) add, &a_length);
	eif_net_check ((result<0) ? ((errno!=EWOULDBLOCK) ? EIFNET_ERROR_HAPPENED : 0) : 0);

#endif

	return (EIF_INTEGER) result;

}

void c_listen(EIF_INTEGER s, EIF_INTEGER backlog)
	/*x listen up to backlog connexions on socket descriptor s */
{
#ifdef EIF_WIN32
	do_init();
	eif_net_check (listen((SOCKET) s, (int) backlog));
#elif defined EIF_OS2
	do_init();
	eif_net_check (listen((int) s, (int) backlog));
#else
	eif_net_check (listen((int) s, (int) backlog));
#endif
}

void c_connect(EIF_INTEGER s, EIF_POINTER add, EIF_INTEGER length)
	/*x connect socket s to socket address add of length length */
{
#ifdef EIF_WIN32
	do_init();
	eif_net_check (connect((SOCKET) s, (struct sockaddr *) add, (int) length));
#elif defined EIF_OS2
	do_init();
	eif_net_check ((connect((int) s, (struct sockaddr *) add, (int) length)==EIFNET_ERROR_HAPPENED) ? ((sock_errno()!=SOCEINPROGRESS) ? EIFNET_ERROR_HAPPENED : 0) : 0);
#else
	eif_net_check ((connect((int) s, (struct sockaddr *) add, (int) length)==EIFNET_ERROR_HAPPENED) ? ((errno!=EINPROGRESS) ? EIFNET_ERROR_HAPPENED : 0) : 0);
#endif
}

EIF_INTEGER c_select(EIF_INTEGER nfds, EIF_OBJ rmask, EIF_OBJ wmask, EIF_OBJ emask, EIF_INTEGER timeout, EIF_INTEGER timeoutm)
	/* Read The Fine Manual */
{
	struct timeval t;
	int result;

#if defined EIF_WIN32 || defined EIF_OS2
	do_init();
	if (!rmask && !wmask && !emask) {
		if (timeout != -1) 
			Sleep(timeout*1000 + timeoutm);
		return 0;
	}
#endif
	if (timeout == -1) {
#ifdef EIF_WIN32
		eif_net_check (result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL));
#elif defined EIF_OS2
		eif_net_check (result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL));
#else
		eif_net_check (result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, (struct timeval *) NULL));
#endif
		return (EIF_INTEGER) result;
	}

	t.tv_sec = timeout;
	t.tv_usec = timeoutm;

#ifdef EIF_WIN32
	eif_net_check (result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t));
#elif defined EIF_OS2
	eif_net_check (result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t));
#else
	eif_net_check (result = select((int) nfds, (fd_set *) rmask, (fd_set *) wmask, (fd_set *) emask, &t));
#endif
	return (EIF_INTEGER) result;
}

void c_sock_name(EIF_INTEGER s, EIF_POINTER addr, EIF_INTEGER length)
	/*x socket s address structure into addr
	    of length length (to be provided a priori) */
{
#ifdef EIF_VMS
	size_t a_length; int result;
#else
	int a_length, result;
#endif

#if defined EIF_WIN32 || defined EIF_OS2
	do_init();
#endif

	a_length = (int) length;

	result = getsockname((int) s, (struct sockaddr *) addr, &a_length);

	eif_net_check (result);
}

EIF_INTEGER c_peer_name(EIF_INTEGER s, EIF_POINTER addr, EIF_INTEGER length)
	/*x get peer address of socket s in socket address structure addr
	    of length length (to be provided a priori) */
{
#ifdef EIF_VMS
	size_t a_length; int result;
#else
	int a_length, result;
#endif

#if defined EIF_WIN32 || defined EIF_OS2
	do_init();
#endif

	a_length = (int) length;

	result = getpeername((int) s, (struct sockaddr *) addr, &a_length);

	eif_net_check (result);

	return (EIF_INTEGER) a_length;
}


/*x basic types sending TO (macro) */

#ifdef EIF_WIN32
#define CSENDXTO(descriptor,element_pointer,sizeofelement, flags, addr_pointer, sizeofaddr) \
	eif_net_check (sendto (descriptor, element_pointer, sizeofelement, flags, addr_pointer, sizeofaddr));
#elif defined EIF_OS2
#define CSENDXTO(descriptor,element_pointer,sizeofelement, flags, addr_pointer, sizeofaddr) \
	eif_net_check ((sendto (descriptor, element_pointer, sizeofelement, flags, addr_pointer, sizeofaddr)==EIFNET_ERROR_HAPPENED) ? ((sock_errno()!=SOCEWOULDBLOCK) ? EIFNET_ERROR_HAPPENED : 0) : 0);
#else
#define CSENDXTO(descriptor,element_pointer,sizeofelement, flags, addr_pointer, sizeofaddr) \
	eif_net_check ((sendto ((int) descriptor, (char *) element_pointer, (int) sizeofelement, (int) flags, \
		(struct sockaddr *) addr_pointer, (int) sizeofaddr)<0) ? ((errno!=EWOULDBLOCK) ? EIFNET_ERROR_HAPPENED : 0) : 0);
#endif

void c_send_char_to(EIF_INTEGER fd, EIF_CHARACTER c, EIF_INTEGER flags, EIF_OBJ addr_pointer, EIF_INTEGER sizeofaddr)
	/*x transmission of character c through socket fd */
{
	CSENDXTO(fd,&c,sizeof(char),flags,(struct sockaddr *) addr_pointer,sizeofaddr)
}

void c_send_int_to(EIF_INTEGER fd, EIF_INTEGER i, EIF_INTEGER flags, EIF_OBJ addr_pointer, EIF_INTEGER sizeofaddr)
	/* transmission of Eiffel integer i through socket fd */
{
	unsigned long ti;
	ti = htonl((unsigned long) i);
	CSENDXTO(fd,(char *) &ti,sizeof(ti),flags,(struct sockaddr *) addr_pointer,sizeofaddr)
}

void c_send_float_to(EIF_INTEGER fd, EIF_REAL f, EIF_INTEGER flags, EIF_OBJ addr_pointer, EIF_INTEGER sizeofaddr)
	/*x transmission of real f through socket fd */
{
	/* If no prototype is used for the declaration of c_send_float_to() in
	   the caller,an automatic conversion from float to double will occur.
	   We need to explicitly convert the argument to a float before safely
	   sending it on the socket. Xavier */

	float tf;
	tf = f;
	CSENDXTO(fd,(char *)&tf,sizeof(tf),flags,(struct sockaddr *) addr_pointer,sizeofaddr)
}

void c_send_double_to(EIF_INTEGER fd, EIF_DOUBLE d, EIF_INTEGER flags, EIF_OBJ addr_pointer, EIF_INTEGER sizeofaddr)
	/*x transmission of double d through socket fd */
{
	double dbl;
	dbl = d;
	CSENDXTO(fd,(char *) &dbl,sizeof(dbl),flags,(struct sockaddr *) addr_pointer,sizeofaddr)
}

void c_send_stream_to(EIF_INTEGER fd, EIF_OBJ stream_pointer, EIF_INTEGER length, EIF_INTEGER flags, EIF_OBJ addr_pointer, EIF_INTEGER sizeofaddr)
	/*x transmission of string s of size size trought socket fd */
{
	CSENDXTO(fd,stream_pointer,length,flags,(struct sockaddr *) addr_pointer,sizeofaddr)
}



/*x basic types sending (macro) */

#ifdef EIF_WIN32
#define CPUTX(descriptor,element_pointer,sizeofelement) \
	eif_net_check (send (descriptor, element_pointer, sizeofelement, 0));
#elif defined EIF_OS2
#define CPUTX(descriptor,element_pointer,sizeofelement) \
	eif_net_check ((send (descriptor, element_pointer, sizeofelement, 0)==-1) ? ((sock_errno()!=SOCEWOULDBLOCK) ? -1 : 0) : 0);
#else
#define CPUTX(descriptor,element_pointer,sizeofelement) \
	eif_net_check ((write((int) descriptor, (char *) element_pointer, (int) sizeofelement) < 0) ? ((errno!=EWOULDBLOCK) ? EIFNET_ERROR_HAPPENED : 0) : 0);
#endif


void c_put_char(EIF_INTEGER fd, EIF_CHARACTER c)
	/*x transmission of character c through socket fd */
{
	CPUTX(fd,&c,sizeof(char))
}

void c_put_int(EIF_INTEGER fd, EIF_INTEGER i)
	/* transmission of Eiffel integer i through socket fd */
{
	unsigned long ti;
	ti = htonl ((unsigned long) i);
	CPUTX(fd,(char *) &ti,sizeof(ti))
}

void c_put_float(EIF_INTEGER fd, EIF_REAL f)
	/*x transmission of real f through socket fd */
{
	/* If no prototype is used for the declaration of c_put_float() in the
	   caller,an automatic conversion from float to double will occur.
	   We need to explicitly convert the argument to a float before safely
	   sending it on the socket. Xavier */

	float tf;
	tf = f;
	tf = ise_htonf(tf);
	CPUTX(fd, (char *) &tf,sizeof(tf))
}

void c_put_double(EIF_INTEGER fd, EIF_DOUBLE d)
	/*x transmission of double d through socket fd */
{
	double dbl;
	dbl = ise_htond(d);
	CPUTX(fd,(char *) &dbl,sizeof(dbl))
}

void c_put_stream(EIF_INTEGER fd, EIF_OBJ stream_pointer, EIF_INTEGER length)
	/*x transmission of string s of size size trought socket fd */
{
	CPUTX(fd,stream_pointer,length)
}


	/*x basic types receiving (macro) */

#ifdef EIF_WIN32
#define CREADX(descriptor, element_pointer, sizeofelement) \
	eif_net_check_recv (recv((int) descriptor, (char *) element_pointer, sizeofelement, 0));
#elif defined EIF_OS2
#define CREADX(descriptor, element_pointer, sizeofelement) \
	if (recv((int) descriptor, (char *) element_pointer, sizeofelement, 0) == SOCEWOULDBLOCK) \
		if (sock_errno() != SOCEWOULDBLOCK) \
			eio();
#else
#define CREADX(descriptor, element_pointer, sizeofelement) \
	if (read((int) descriptor, (char *) element_pointer, (int) sizeofelement) < 0) \
		if (errno != EWOULDBLOCK) \
			eio();
#endif

EIF_REAL c_read_float (EIF_INTEGER fd)
	/*x read a real from socket fd */
{
	float f=0.0;
	CREADX(fd,&f,sizeof(float))
	return (EIF_REAL) ise_ntohf(f);
}

EIF_DOUBLE c_read_double(EIF_INTEGER fd)
	/*x read a double from socket fd */
{
	double d=0.0;
	CREADX(fd,&d,sizeof(double))
	return (EIF_DOUBLE) ise_ntohd(d);
}

EIF_CHARACTER c_read_char(EIF_INTEGER fd)
	/*x read a character from socket fd */
{
	char c=0;
	CREADX(fd,&c,sizeof(char))
	return (EIF_CHARACTER) c;
}

EIF_INTEGER c_read_int(EIF_INTEGER fd)
	/*x read an integer from socket fd */
{
	EIF_INTEGER i=0L;
	CREADX(fd,&i,sizeof(EIF_INTEGER))
	return (EIF_INTEGER) ntohl((unsigned long) i);
}


EIF_INTEGER c_read_stream(EIF_INTEGER fd, EIF_INTEGER len, EIF_OBJ buf)
	/*x read a stream of character from socket fd into buffer buf
	    of length len */
{
        int nr;

#ifdef EIF_WIN32
	eif_net_check (nr = recv(fd, (char *) buf, (int) len, 0));
#elif defined EIF_OS2
	if ((nr = recv(fd, (char *) buf, (int) len, 0)) == -1)
		if (sock_errno() != SOCEWOULDBLOCK)
			eio();
#else
	if ((nr = read ((int) fd, (char *) buf, (int) len)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) nr;
}


EIF_INTEGER c_receive(EIF_INTEGER fd, EIF_OBJ buf, EIF_INTEGER len, EIF_INTEGER flags)
	/*x receive at most len bytes from socket fd into buffer buf
	    flags can be or'ed from 0, MSG_OOB, MSG_PEEK or MSG_DONTROUTE */
{
	int result;

	result = recv((int) fd, (char *) buf, (int) len, (int) flags);
#ifdef EIF_WIN32
	eif_net_check (result);
#elif defined EIF_OS2
	if (result == -1)
		if (sock_errno() != SOCEWOULDBLOCK)
			eio();
#else
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_rcv_from(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags, EIF_POINTER addr, EIF_POINTER addr_len)
	/*x like c_receive and sender address is stored into socket address
	    structure addr and address length into *addr_len */
{
	int result;

#ifdef EIF_VMS /* requires size_t cast */
	result = recvfrom ((int) fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) addr, (size_t*) addr_len);
#else
	result = recvfrom ((int) fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) addr, (int *) addr_len);
#endif

#ifdef EIF_WIN32
	eif_net_check (result);
#elif defined EIF_OS2
	if (result == -1)
		if (sock_errno() != SOCEWOULDBLOCK)
			eio();
#else
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_write(EIF_INTEGER fd, EIF_POINTER buf, EIF_INTEGER l)
	/*x write at most l bytes from buffer buf into socket fd
	    return number of actually sent bytes */
{
	int result;
#ifdef EIF_WIN32
	result = send(fd, (char *) buf, (int) l, 0);
	eif_net_check (result);
#elif defined EIF_OS2
	result = send(fd, (char *) buf, (int) l, 0);
	if (result == -1)
		if (sock_errno() != SOCEWOULDBLOCK)
			eio();
#else
	result = write((int) fd, (char *) buf, (int) l);
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_send(EIF_INTEGER fd, EIF_OBJ buf, EIF_INTEGER len, EIF_INTEGER flags)
	/*x send at most len bytes from buffer buf into socket fd
	    to connected peer address
	    flags can be or'ed from 0 with MSG_OOB, MSG_PEEK, MSG_DONTROUTE
	    return actual number of bytes sent */
{
	int result;

	result = send((int) fd, (char *) buf, (int) len, (int) flags);
	if (result < 0)
		if (errno != EWOULDBLOCK)
			eio();
	return (EIF_INTEGER) result;
}

EIF_INTEGER c_send_to (EIF_INTEGER fd, EIF_OBJ buf, EIF_INTEGER len, EIF_INTEGER flags, EIF_OBJ addr, EIF_INTEGER addr_len)
	/*x like c_send and peer address can be set through socket address
	    structure addr of length addr_len */
{
	int result;

#ifdef EIF_WIN32
	eif_net_check (result = sendto((int) fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) addr, (int) addr_len));
#elif defined EIF_OS2
	if ((result = sendto((int) fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) addr, (int) addr_len)) < 0)
		if (sock_errno() != SOCEWOULDBLOCK)
			eio();
#else
	if ((result = sendto((int) fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) addr, (int) addr_len)) < 0)
		if (errno != EWOULDBLOCK)
			eio();
#endif
	return (EIF_INTEGER) result;
}

void c_set_sock_opt_int(EIF_INTEGER fd, EIF_INTEGER level, EIF_INTEGER opt, EIF_INTEGER val)
	/*x set socket fd options */
{
	int arg = (int) val;
	eif_net_check (setsockopt((int) fd, (int) level, (int) opt, (char *) &arg, sizeof(arg)));
}

EIF_INTEGER c_get_sock_opt_int(EIF_INTEGER fd, EIF_INTEGER level, EIF_INTEGER opt)
	/*x get socket fd options */
{
#ifdef EIF_VMS
	int arg; size_t asize;
#else
	int arg, asize;
#endif

	asize = sizeof(arg);
#ifdef EIF_WIN32
	if (getsockopt((int) fd, (int) level, (int) opt, (char *) &arg, &asize) == SOCKET_ERROR)
#elif defined EIF_OS2
	if (getsockopt((int) fd, (int) level, (int) opt, (char *) &arg, &asize) == -1)
#else
	if (getsockopt((int) fd, (int) level, (int) opt, (char *) &arg, &asize) < 0)
#endif
		return (EIF_INTEGER) 0;
	return (EIF_INTEGER) arg;
}

EIF_BOOLEAN c_is_linger_on(EIF_INTEGER fd)
	/*x does socket discard data on close ? (default linger off -> no) */
{
	struct linger arg;
#ifdef EIF_VMS
	size_t asize;
#else
	int asize;
#endif
	asize = sizeof(arg);

#ifdef EIF_WIN32
	if (getsockopt((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) == SOCKET_ERROR)
#elif defined EIF_OS2
	if (getsockopt((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) == -1)
#else
	if (getsockopt((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) < 0)
#endif
		return (EIF_BOOLEAN) 0;
	return (EIF_BOOLEAN) (! (arg.l_onoff == 0));
}

EIF_INTEGER c_linger_time(EIF_INTEGER fd)
	/*x non null values are equivalent (despite original specification) */
{
	struct linger arg;
#ifdef EIF_VMS
	size_t asize;
#else
	int asize;
#endif

	asize = sizeof(arg);

#ifdef EIF_WIN32
	if (getsockopt((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) == SOCKET_ERROR)
#elif defined EIF_OS2
	if (getsockopt((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) == -1)
#else
	if (getsockopt((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, &asize) < 0)
#endif
		return (EIF_INTEGER) 0;
	return (EIF_INTEGER) arg.l_linger;
}

EIF_INTEGER c_set_sock_opt_linger(EIF_INTEGER fd, EIF_BOOLEAN flag, EIF_INTEGER time)
	/*x set linger options (on/off and timeout), does not work */
{
	struct linger arg;

	arg.l_onoff = (int) flag;
	arg.l_linger = (int) time;

	return (EIF_INTEGER) setsockopt((int) fd, SOL_SOCKET, SO_LINGER, (char *) &arg, sizeof(arg));
}

EIF_INTEGER c_fcntl(EIF_INTEGER fd, EIF_INTEGER cmd, EIF_INTEGER arg)
	/*x set possibly open fd socket options */
{
#if defined EIF_WIN32 || defined EIF_OS2
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
	/*x set socket fd blocking */
{
#ifdef EIF_OS2
	int arg = 0;
	ioctl((int) fd, FIONBIO, (char *) &arg, sizeof(arg));
#elif defined EIF_WIN32
	u_long arg = 0;
	ioctlsocket((int) fd, FIONBIO, &arg);
#else
	int arg = 0;
	ioctl((int) fd, FIONBIO, (char *) &arg);
#endif
}

void c_set_non_blocking(EIF_INTEGER fd)
	/*x set socket fd non-blocking */
{

#ifdef EIF_OS2
	int arg = 1;
	ioctl ((int) fd, FIONBIO, (char *) &arg, sizeof(arg));
#elif defined EIF_WIN32
	u_long arg = 1;
	ioctlsocket((int) fd, FIONBIO, &arg);
#else
	int arg = 1;
	ioctl ((int) fd, FIONBIO, (char *) &arg);
#endif
}

EIF_INTEGER c_packet_number_size(void)
	/*x size of packet number data structure in packet */
{
	return (EIF_INTEGER) (sizeof(uint32));
}

EIF_INTEGER c_get_number(EIF_OBJECT data_obj)
	/*x packet number out of packet structure */
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

void c_set_number(EIF_OBJ data_obj, EIF_INTEGER num)
	/*x set packet number in packet structure */
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

void c_set_data(EIF_OBJ pdata_obj, EIF_OBJ sdata_obj, EIF_INTEGER count)
	/*x copy count amout of bytes from pdata_obj into sdata_obj */
{
	memcpy(sdata_obj, (pdata_obj + c_packet_number_size()), count);
}

void c_get_data(EIF_OBJ rdata_obj, EIF_OBJ pdata_obj, EIF_INTEGER count)
	/*x copy count amount of bytes from rdata_obj into pdata_obj */
{
	memcpy((pdata_obj + c_packet_number_size()), rdata_obj, count);
}


void c_shutdown(EIF_INTEGER sock, EIF_INTEGER how)
	/*x shut down a socket with `how' modality */
{
	shutdown((int) sock,(int) how);
}



#ifdef EIF_VMS
# ifdef VMS_MULTINET
    int     decc$get_sdc(int __descrip_no);
# else
    int     decc$get_sdc(int __descrip_no);
# endif

#if !defined VMS_MULTINET && defined EIF_VMS_VER && EIF_VMS_VER < 70000000 
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
#   endif
# endif /* VMS_MULTINET || __DECC_VER ( > 5.x) */

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
