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

/* .../library/net/Clib/netvmsdef.h 
	VMS-specific definitions for network.c 
	$Id$
*/

#ifndef _netvmsdef_h_
#define _netvmsdef_h_

#ifdef EIF_VMS	    /* controls the rest of this file... */

/* #define _SOCKADDR_LEN   /* if defined, forces BSD4.4 enhanced socket functionality */

/* #define VMS_MULTINET 1	/* if set, force use of Multinet */
/* #define _DECC_V4_SOURCE    /* if set, forces old definitions */

#include <unistd.h>
#include <fcntl.h>
#include <tcp.h>	/* TCP_NODELAY, et. al. */

#ifndef O_NONBLOCK	/* omission in fcntl.h for DECC V5.2 (__DECC_VER == 50290003) on VMS < 70000000 */
#define O_NONBLOCK  0100000
#endif /* O_NONBLOCK */

#if __VMS_VER < 70000000
    /* ditto for unistd.h when __VMS_VER < 70000000 */
    int unlink(const char *__path);
#endif /* __VMS_VER < 7.0 */

#if defined(VMS_MULTINET)
# define NET_RETLEN_TYPE size_t
# include <multinet_root:[multinet.include.sys]types.h>
# include <multinet_root:[multinet.include.sys]socket.h>
# include <multinet_root:[multinet.include]netdb.h>
# include <multinet_root:[multinet.include.netinet]in.h>
# include <multinet_root:[multinet.include.sys]ioctl.h>
# define ioctl socket_ioctl
# ifdef MULTINET_OLD /* and hence need prototypes for these functions: */
    /* Multinet V3.4 socket.h et.al. dont define prototypes for these. */
    typedef unsigned long __in_addr_t;
    typedef unsigned short __in_port_t;
    int ioctl(int __sd, int __r, void * __argp);
    int select(int __nfds, fd_set *__readfds, fd_set *__writefds, 
		    fd_set *__exceptfds, struct timeval *__timeout);
    int listen(int __sd, int __backlog);
    int socket(int __af, int __mess_type, int __prot_type);
    int accept(int __sd, struct sockaddr *__S_addr, size_t *__len);
    int bind(int __sd, const struct sockaddr *__s_name, size_t __len);    
    int connect(int __sd, const struct sockaddr *__name, size_t __len);
    int getpeername(int __sd, struct sockaddr *__name, size_t *__len);
    int getsockname(int __sd, struct sockaddr *__name, size_t *__len);
    __ssize_t recvfrom(int __sd, void *__buf, size_t __buflen, int __flags, 
	    struct sockaddr *__from, size_t *__fromlen);
    __ssize_t sendto(int __sd, const void *__msg, size_t __msglen, int __flags, 
	    const struct sockaddr *__to, size_t __tolen);
    int getsockopt(int __sd, int __level, int __optname, void *__optval, size_t *__optlen);
    int setsockopt(int __sd, int __level, int __optname, const void *__optval, size_t __optlen);
    __ssize_t recv(int __sd, void *__buf, size_t __length, int __flags);
    __ssize_t send(int __sd, const void *__msg, size_t __length, int __flags);
    __in_addr_t htonl(__in_addr_t __hostlong);
    __in_port_t htons(__in_port_t __hostshort);
    __in_addr_t ntohl(__in_addr_t __netlong);
    __in_port_t ntohs(__in_port_t __netshort);
    __in_addr_t inet_network(const char *__cp);
    __in_addr_t inet_lnaof(struct in_addr __in);
    __in_addr_t inet_netof(struct in_addr __in);

# else	/* (not MULTINET_OLD) */
	/* Most multinet socket functions are now prototyped. These are	*/
	/* still unprototyped/undefined as of Multinet V4.0A		*/
	int inet_addr(const char *__cp);
	char *inet_ntoa(struct in_addr __in); 
# endif /* multinet_old (no prototypes) */
#elif defined(__DECC_VER)  /* (not VMS_MULTINET) and hence >= v5.0 */
# define NET_RETLEN_TYPE size_t
# include <types.h>
/* #include <time.h> */
# include <socket.h>
# include <netdb.h>
# include <in.h>
# include <ioctl.h>
# include <inet.h>
/* # include <netinet.h> */
#  if !defined __VMS_VER || __VMS_VER < 70000000 /* and no ioctl is available... */
#  define ioctl my_ioctl
    int ioctl(int __sd, int __r, void * __argp);
#  endif
#else
	/* neither VMS_MULTINET nor __DECC_VER defined. What to do? */
	Configuration error in __FILE__ - not MULTINET, old DECC
# define NET_RETLEN_TYPE size_t
#endif /* VMS_MULTINET || __DECC_VER( > 5.x) */
typedef NET_RETLEN_TYPE net_retlen_t;


#endif  /* EIF_VMS */
#endif  /* _netvmsdef_h_ */
