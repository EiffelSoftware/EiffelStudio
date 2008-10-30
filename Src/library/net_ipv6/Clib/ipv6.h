#ifndef IPV6_H
#define IPV6_H

#include "eif_config.h"

#ifdef EIF_WINDOWS

#include <Winsock2.h>
#include <ws2tcpip.h>
#include "eif_eiffel.h"

#define EIF_NET_INITIALIZE do_init()

#ifndef IPTOS_TOS_MASK
#define IPTOS_TOS_MASK 0x1e
#endif

#ifndef IPTOS_PREC_MASK
#define IPTOS_PREC_MASK 0xe0
#endif 

/* used to disable connection reset messages on Windows XP */
#ifndef SIO_UDP_CONNRESET
#define SIO_UDP_CONNRESET _WSAIOW(IOC_VENDOR,12)
#endif

/* Macro, which cleans-up the iv6bind structure,
 * closes the two sockets (if open),
 * and returns SOCKET_ERROR. Used in NET_BindV6 only.
 */

#define CLOSE_SOCKETS_AND_RETURN {	\
    if (fd != -1) {			\
	closesocket (fd); 		\
	fd = -1;			\
    }					\
    if (ofd != -1) {			\
	closesocket (ofd); 		\
	ofd = -1;			\
    }					\
    if (close_fd != -1) {		\
	closesocket (close_fd);		\
	close_fd = -1;			\
    }					\
    if (close_ofd != -1) {		\
	closesocket (close_ofd);	\
	close_ofd = -1;			\
    }					\
    b->ipv4_fd = b->ipv6_fd = -1;	\
    return SOCKET_ERROR;		\
}

void do_init ();

void eif_net_check (int retcode);

#else // Not EIF_WINDOWS

#include "eif_eiffel.h"

#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <fcntl.h>

#define EIF_NET_INITIALIZE

#define SET_NONBLOCKING(fd) {		\
        int flags = fcntl(fd, F_GETFL);	\
        flags |= O_NONBLOCK; 		\
        fcntl(fd, F_SETFL, flags);	\
}

#define SET_BLOCKING(fd) {		\
        int flags = fcntl(fd, F_GETFL); \
	flags &= ~O_NONBLOCK;		\
        fcntl(fd, F_SETFL, flags);      \
}

#endif // EIF_WINDOWS

typedef union {
    struct sockaddr	him;
    struct sockaddr_in	him4;
    struct sockaddr_in6 him6;
} SOCKETADDRESS;

#ifdef EIF_WINDOWS
struct ipv6bind {
    SOCKETADDRESS	*addr;
    SOCKET	 	 ipv4_fd;
    SOCKET 	 	 ipv6_fd;
};
#endif // EIF_WINDOWS


#define SOCKETADDRESS_LEN(X)	\
	(((X)->him.sa_family==AF_INET6)? sizeof(struct sockaddr_in6) : \
			 sizeof(struct sockaddr_in))


#define SET_PORT(X,Y) {				\
    if ((X)->him.sa_family == AF_INET) {	\
    	(X)->him4.sin_port = (Y);		\
    } else {					\
    	(X)->him6.sin6_port = (Y);		\
    }						\
}

#define GET_PORT(X) ((X)->him.sa_family==AF_INET ?(X)->him4.sin_port: (X)->him6.sin6_port)

#ifndef IN6_IS_ADDR_ANY
#define IN6_IS_ADDR_ANY(a)	\
    (((a)->s6_words[0] == 0) && ((a)->s6_words[1] == 0) &&	\
    ((a)->s6_words[2] == 0) && ((a)->s6_words[3] == 0) &&	\
    ((a)->s6_words[4] == 0) && ((a)->s6_words[5] == 0))
#endif

void en_set_prefer_ipv4(EIF_BOOLEAN prefer);

EIF_BOOLEAN en_get_prefer_ipv4();

EIF_BOOLEAN en_ipv6_available();
EIF_BOOLEAN en_ipv6_supported();


#endif //IPV6_H
