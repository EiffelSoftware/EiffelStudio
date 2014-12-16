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
          CONSTANTS AND OTHER ERROR NUMBERS
*/


#include "eif_config.h"

#ifdef EIF_WINDOWS
#include <winsock2.h>
#include <ws2tcpip.h>
#endif

#include "eif_portable.h"	/* required for VMS, recommended for all */

#ifdef EIF_VMS
#include "netvmsdef.h"
#else
#include <sys/types.h>
#endif

#ifdef VXWORKS
#include <types/vxTypesOld.h>
#endif

#ifndef EIF_WINDOWS
 
#ifdef I_SYS_TIME
#include <sys/time.h>
#endif
#endif
#include <errno.h>
#include <fcntl.h>
#include "eif_cecil.h"

#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
#endif

#ifdef I_NETINET_IN
#include <netinet/in.h>
#endif
#ifdef I_SYS_IN
#include <sys/in.h>
#endif
#if defined EIF_WINDOWS || defined EIF_VMS
#else
#include <netinet/tcp.h>
#endif
#ifdef SOC_XNS
#include <netns/ns.h>
#endif

#ifndef FNDELAY
#define FNDELAY O_NDELAY
#endif

#ifndef FASYNC
#define FASYNC O_SYNC
#endif

#ifdef EIF_WINDOWS
/* To create portable code we override the definition of some errno constants to
 * map what winsock returns to us for error codes. */
#ifdef EWOULDBLOCK
	#undef EWOULDBLOCK
#endif
#define EWOULDBLOCK             WSAEWOULDBLOCK
#ifdef EINPROGRESS
	#undef EINPROGRESS
#endif
#define EINPROGRESS             WSAEINPROGRESS
#ifdef EALREADY
	#undef EALREADY
#endif
#define EALREADY                WSAEALREADY
#ifdef ENOTSOCK
	#undef ENOTSOCK
#endif
#define ENOTSOCK                WSAENOTSOCK
#ifdef EDESTADDRREQ
	#undef EDESTADDRREQ
#endif
#define EDESTADDRREQ            WSAEDESTADDRREQ
#ifdef EMSGSIZE
	#undef EMSGSIZE
#endif
#define EMSGSIZE                WSAEMSGSIZE
#ifdef EPROTOTYPE
	#undef EPROTOTYPE
#endif
#define EPROTOTYPE              WSAEPROTOTYPE
#ifdef ENOPROTOOPT
	#undef ENOPROTOOPT
#endif
#define ENOPROTOOPT             WSAENOPROTOOPT
#ifdef EPROTONOSUPPORT
	#undef EPROTONOSUPPORT
#endif
#define EPROTONOSUPPORT         WSAEPROTONOSUPPORT
#ifdef ESOCKTNOSUPPORT
	#undef ESOCKTNOSUPPORT
#endif
#define ESOCKTNOSUPPORT         WSAESOCKTNOSUPPORT
#ifdef EOPNOTSUPP
	#undef EOPNOTSUPP
#endif
#define EOPNOTSUPP              WSAEOPNOTSUPP
#ifdef EPFNOSUPPORT
	#undef EPFNOSUPPORT
#endif
#define EPFNOSUPPORT            WSAEPFNOSUPPORT
#ifdef EAFNOSUPPORT
	#undef EAFNOSUPPORT
#endif
#define EAFNOSUPPORT            WSAEAFNOSUPPORT
#ifdef EADDRINUSE
	#undef EADDRINUSE
#endif
#define EADDRINUSE              WSAEADDRINUSE
#ifdef EADDRNOTAVAIL
	#undef EADDRNOTAVAIL
#endif
#define EADDRNOTAVAIL           WSAEADDRNOTAVAIL
#ifdef ENETDOWN
	#undef ENETDOWN
#endif
#define ENETDOWN                WSAENETDOWN
#ifdef ENETUNREACH
	#undef ENETUNREACH
#endif
#define ENETUNREACH             WSAENETUNREACH
#ifdef ENETRESET
	#undef ENETRESET
#endif
#define ENETRESET               WSAENETRESET
#ifdef ECONNABORTED
	#undef ECONNABORTED
#endif
#define ECONNABORTED            WSAECONNABORTED
#ifdef ECONNRESET
	#undef ECONNRESET
#endif
#define ECONNRESET              WSAECONNRESET
#ifdef ENOBUFS
	#undef ENOBUFS
#endif
#define ENOBUFS                 WSAENOBUFS
#ifdef EISCONN
	#undef EISCONN
#endif
#define EISCONN                 WSAEISCONN
#ifdef ENOTCONN
	#undef ENOTCONN
#endif
#define ENOTCONN                WSAENOTCONN
#ifdef ESHUTDOWN
	#undef ESHUTDOWN
#endif
#define ESHUTDOWN               WSAESHUTDOWN
#ifdef ETOOMANYREFS
	#undef ETOOMANYREFS
#endif
#define ETOOMANYREFS            WSAETOOMANYREFS
#ifdef ETIMEDOUT
	#undef ETIMEDOUT
#endif
#define ETIMEDOUT               WSAETIMEDOUT
#ifdef ECONNREFUSED
	#undef ECONNREFUSED
#endif
#define ECONNREFUSED            WSAECONNREFUSED
#ifdef ELOOP
	#undef ELOOP
#endif
#define ELOOP                   WSAELOOP
#ifdef EHOSTDOWN
	#undef EHOSTDOWN
#endif
#define EHOSTDOWN               WSAEHOSTDOWN
#ifdef EHOSTUNREACH
	#undef EHOSTUNREACH
#endif
#define EHOSTUNREACH            WSAEHOSTUNREACH
#ifdef EPROCLIM
	#undef EPROCLIM
#endif
#define EPROCLIM                WSAEPROCLIM
#ifdef EUSERS
	#undef EUSERS
#endif
#define EUSERS                  WSAEUSERS
#ifdef EDQUOT
	#undef EDQUOT
#endif
#define EDQUOT                  WSAEDQUOT
#ifdef ESTALE
	#undef ESTALE
#endif
#define ESTALE                  WSAESTALE
#ifdef EREMOTE
	#undef EREMOTE
#endif
#define EREMOTE                 WSAEREMOTE
#endif



/*x** Error numbers ***/

EIF_INTEGER c_errorno()
	/*x The global last error number variable */
{
	return (EIF_INTEGER) errno;
}

void c_reset_error()
	/*x Reset the global last error number variable */
{
	errno = 0;
}

EIF_INTEGER family_no_support()
	/*x Address family not supported by protocol family */
{
	return (EIF_INTEGER) EAFNOSUPPORT;
}

EIF_INTEGER proto_no_support()
	/*x Protocol not supported */
{
	return (EIF_INTEGER) EPROTONOSUPPORT;
}

EIF_INTEGER table_full()
	/*x Too many open files */
{
	return (EIF_INTEGER) EMFILE;
}

EIF_INTEGER no_buffs()
	/*x No buffer space available */
{
	return (EIF_INTEGER) ENOBUFS;
}

EIF_INTEGER c_permission()
	/*x Not owner */
{
	return (EIF_INTEGER) EPERM;
}

EIF_INTEGER bad_socket()
	/*x Bad file number */
{
	return (EIF_INTEGER) EBADF;
}

EIF_INTEGER no_socket()
	/*x Socket operation on non-socket */
{
	return (EIF_INTEGER) ENOTSOCK;
}

EIF_INTEGER error_address()
	/*x Cannot assign requested address */
{
	return (EIF_INTEGER) EADDRNOTAVAIL;
}

EIF_INTEGER busy_address()
	/*x Address already in use */
{
	return (EIF_INTEGER) EADDRINUSE;
}

EIF_INTEGER bound_address()
	/*x Invalid argument */
{
	return (EIF_INTEGER) EINVAL;
}

EIF_INTEGER no_access()
	/*x Permission denied */
{
	return (EIF_INTEGER) EACCES;
}

EIF_INTEGER unreadable()
	/*x Bad address */
{
	return (EIF_INTEGER) EFAULT;
}

EIF_INTEGER no_connect()
	/*x Operation invalid or not supported */
{
	return (EIF_INTEGER) EOPNOTSUPP;
}

EIF_INTEGER would_block()
	/*x Operation would (have) block in blocking mode */
{
	return (EIF_INTEGER) EWOULDBLOCK;
}

EIF_INTEGER in_use()
	/*x Socket is already connected */
{
	return (EIF_INTEGER) EISCONN;
}

EIF_INTEGER socket_expire()
	/*x Connection (connect()) timed out */
{
	return (EIF_INTEGER) ETIMEDOUT;
}

EIF_INTEGER connect_refused()
	/*x Connection actively refused by target machine */
{
	return (EIF_INTEGER) ECONNREFUSED;
}

EIF_INTEGER no_network()
	/*x Network is unreachable */
{
	return (EIF_INTEGER) ENETUNREACH;
}


EIF_INTEGER no_option()
	/*x Protocol not available */
{
	return (EIF_INTEGER) ENOPROTOOPT;
}


/*x** Socket families ***/

EIF_INTEGER af_unix()
	/*x Unix internal protocols family */
{
	return (EIF_INTEGER) AF_UNIX;
}

EIF_INTEGER af_inet()
	/*x Internet protocols family */
{
	return (EIF_INTEGER) AF_INET;
}

EIF_INTEGER af_inet6()
	/*x Internet protocols family */
{
	return (EIF_INTEGER) AF_INET6;
}

EIF_INTEGER af_ns()
	/*x Xerox NS protocols family */
{
#ifdef AF_NS
	return (EIF_INTEGER) AF_NS;
#else
	return (EIF_INTEGER) 0;
#endif
}

/*x
EIF_INTEGER af_implink()
	IMP link layer
{
	return (EIF_INTEGER) AF_IMPLINK;
}
*/


/*x** Socket types ***/

EIF_INTEGER sock_stream()
	/*x Stream socket */
{
	return (EIF_INTEGER) SOCK_STREAM;
}

EIF_INTEGER sock_dgrm()
	/*x Datagram socket */
{
	return (EIF_INTEGER) SOCK_DGRAM;
}

EIF_INTEGER sock_raw()
	/*x Raw socket */
{
	return (EIF_INTEGER) SOCK_RAW;
}

EIF_INTEGER level_sol_socket()
	/*x ??? */
{
	return (EIF_INTEGER) SOL_SOCKET;
}

/*
EIF_INTEGER sock_seqpacket()
	Sequenced packet socket
{
	return (EIF_INTEGER) SOCK_SEQPACKET;
}

EIF_INTEGER sock_rdm()
	Reliably delivered message socket
{
	return (EIF_INTEGER) SOCK_RDM;
}
*/


#ifdef SOC_XNS

EIF_INTEGER level_nsproto_raw()
	/*x (raw) */
{
	return (EIF_INTEGER) NSPROTO_RAW;
}

EIF_INTEGER level_nsproto_pe()
	/*x generate unique PEX ID level */
{
	return (EIF_INTEGER) NSPROTO_PE;
}

EIF_INTEGER level_nsproto_spp()
	/*x SPP */
{
	return (EIF_INTEGER) NSPROTO_SPP;
}

EIF_INTEGER so_headerson_input()
	/*x pass IDP header on input */
{
	return (EIF_INTEGER) SO_HEADERS_ON_INPUT;
}

EIF_INTEGER so_headerson_output()
	/*x pass IDP eader on output */
{
	return (EIF_INTEGER) SO_HEADERS_ON_OUTPUT;
}

EIF_INTEGER so_defaultheaders()
	/*x set default SPP header for output */
{
	return (EIF_INTEGER) SO_DEFAULT_HEADERS;
}

EIF_INTEGER so_lastheader()
	/*x fetch last SPP header */
{
	return (EIF_INTEGER) SO_LAST_HEADER;
}

EIF_INTEGER somtu()
	/*x SPP MTU value */
{
	return (EIF_INTEGER) SO_MTU;
}

EIF_INTEGER soseqno()
	/*x generate unique PEX ID optname */
{
	return (EIF_INTEGER) SO_SEQNO;
}

EIF_INTEGER so_allpackets()
	/*x pass all IDP packets to user */
{
	return (EIF_INTEGER) SO_ALL_PACKETS;
}

EIF_INTEGER so_nsiproute()
	/*x specify IP route for XNS */
{
	return (EIF_INTEGER) SO_NSIP_ROUTE;
}



#else



EIF_INTEGER level_nsproto_raw()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER level_nsproto_pe()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER level_nsproto_spp()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_headerson_input()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_headerson_output()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_defaultheaders()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_lastheader()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER somtu()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER soseqno()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_allpackets()
	/*x only meaningful for Xerox NS sockets */
{
	return (EIF_INTEGER) 0;
}

EIF_INTEGER so_nsiproute()
{
	return (EIF_INTEGER) 0;
}



#endif


/*x** Socket protocols ***/

EIF_INTEGER level_iproto_tcp()
	/*x TCP */
{
	return (EIF_INTEGER) IPPROTO_TCP;
}

EIF_INTEGER level_iproto_ip()
	/*x options in IP header level */
{
	return (EIF_INTEGER) IPPROTO_IP;
}


/*x** Socket options through setsockopt() call ***/

EIF_INTEGER ipoptions()
	/*x options in IP header optname */
{
#ifdef IP_OPTIONS
	return (EIF_INTEGER) IP_OPTIONS;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER tcpmax_seg()
	/*x get TCP maximum segement size */
{
#if defined EIF_WINDOWS || defined EIF_VMS
	return (EIF_INTEGER) 0;
#else
	return (EIF_INTEGER) TCP_MAXSEG;
#endif
}

EIF_INTEGER tcpno_delay()
	/*x don't delat send to coalesce packets */
{
#ifdef  TCP_NODELAY
	return (EIF_INTEGER) TCP_NODELAY;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER sobroadcast()
	/*x permit sending of broadcast messages */
{
	return (EIF_INTEGER) SO_BROADCAST;
}

EIF_INTEGER sodebug()
	/*x turn on debugging info recording */
{
	return (EIF_INTEGER) SO_DEBUG;
}

EIF_INTEGER so_dont_route()
	/*x just use interface addresses */
{
	return (EIF_INTEGER) SO_DONTROUTE;
}

EIF_INTEGER soerror()
	/*x get error status and clear */
{
	return (EIF_INTEGER) SO_ERROR;
}

EIF_INTEGER so_keep_alive()
	/*x keep connections alive */
{
	return (EIF_INTEGER) SO_KEEPALIVE;
}

EIF_INTEGER solinger()
	/*x linger on close if data present */
{
	return (EIF_INTEGER) SO_LINGER;
}

EIF_INTEGER so_oob_inline()
	/*x leave received OOB data in-line */
{
	return (EIF_INTEGER) SO_OOBINLINE;
}

EIF_INTEGER so_rcv_buf()
	/*x receive buffer size */
{
	return (EIF_INTEGER) SO_RCVBUF;
}

EIF_INTEGER so_snd_buf()
	/*x send buffer size */
{
	return (EIF_INTEGER) SO_SNDBUF;
}

EIF_INTEGER so_rcv_lowat()
	/*x receive low-water mark */
{
#ifdef SO_RCVLOWAT
	return (EIF_INTEGER) SO_RCVLOWAT;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_snd_lowat()
	/*x send low-water mark */
{
#ifdef SO_SNDLOWAT
	return (EIF_INTEGER) SO_SNDLOWAT;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_rcv_timeo()
	/*x receive timeout */
{
#ifdef SO_RCVTIMEO
	return (EIF_INTEGER) SO_RCVTIMEO;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_snd_timeo()
	/*x send timeout */
{
#ifdef SO_SNDTIMEO
	return (EIF_INTEGER) SO_SNDTIMEO;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER so_reuse_addr()
	/*x allow local address reuse */
{
	return (EIF_INTEGER) SO_REUSEADDR;
}

EIF_INTEGER sotype()
	/*x get socket type */
{
	return (EIF_INTEGER) SO_TYPE;
}

EIF_INTEGER so_use_loopback()
	/*x bypass hardware when possible */
{
#ifdef SO_USELOOPBACK
	return (EIF_INTEGER) SO_USELOOPBACK;
#else
	return (EIF_INTEGER) 0;
#endif
}


	/*x** Socket options constants used through fcntl() call ***/

EIF_INTEGER c_fgetown()
	/* get status of reception mode for SIGIO and SIGURG signals */
{
#ifdef F_GETOWN
	return (EIF_INTEGER) F_GETOWN;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER c_fsetown()
	/* set status of reception mode for SIGIO and SIGURG signals */
{
#ifdef F_SETOWN
	return (EIF_INTEGER) F_SETOWN;
#else
	return (EIF_INTEGER) 0;
#endif
}

EIF_INTEGER c_fgetfl()
	/*x command constant for examination of file flag bits */
{
#if defined EIF_WINDOWS || defined EIF_VMS
	return (EIF_INTEGER) 0;
#else
	return (EIF_INTEGER) F_GETFL;
#endif
}

EIF_INTEGER c_fsetfl()
	/*x command constant for setting file flag bits */
{
#if defined EIF_WINDOWS || defined EIF_VMS
	return (EIF_INTEGER) 0;
#else
	return (EIF_INTEGER) F_SETFL;
#endif
}

EIF_INTEGER c_fndelay()
	/*x constant to designate socket as "nonblocking" */
{
#ifdef EIF_WINDOWS
	return (EIF_INTEGER) 0;
#else
	return (EIF_INTEGER) FNDELAY;
#endif
}

EIF_INTEGER c_fasync()
	/*x constant to allow reception of asynchronous I/O signals */
{
#ifdef  EIF_WINDOWS
	return (EIF_INTEGER) 0;
#else
	return (EIF_INTEGER) FASYNC;
#endif
}

EIF_INTEGER c_einprogress()
	/*x connection in progress */
{
	return (EIF_INTEGER) EINPROGRESS;
}

EIF_INTEGER c_oobmsg()
	/*x send or receive out-of-band data */
{
	return (EIF_INTEGER) MSG_OOB;
}

EIF_INTEGER c_peekmsg()
	/*x peek an incoming message */
{
	return (EIF_INTEGER) MSG_PEEK;
}

EIF_INTEGER c_msgdontroute()
	/*x bypass routing */
{
#ifdef MSG_DONTROUTE
	return (EIF_INTEGER) MSG_DONTROUTE;
#else
	return (EIF_INTEGER) 0;
#endif
}
