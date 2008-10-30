#include "eif_eiffel.h"

#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <fcntl.h>

typedef union {
    struct sockaddr	him;
    struct sockaddr_in	him4;
    struct sockaddr_in6 him6;
} SOCKETADDRESS;


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

static int en_ipv6_supported() {
    static int res = -1;
    if (res == -1) {
        res = ipv6_supported_();
    }
    return res;
}

int ipv6_supported_()
{
    int fd;
    SOCKETADDRESS sa;
    int sa_len = sizeof(sa);

    fd = socket(AF_INET6, SOCK_STREAM, 0) ;
    if (fd < 0) {
	return 0;
    } 
    close(fd);

    /*
     * If fd 0 is a socket it means we've been launched from inetd or
     * xinetd. If it's a socket then check the family - if it's an
     * IPv4 socket then we need to disable IPv6.
     */
    if (getsockname(0, (struct sockaddr *)&sa, &sa_len) == 0) {
	struct sockaddr *saP = (struct sockaddr *)&sa;
	if (saP->sa_family != AF_INET6) {
	    return 0;
	}
    }

    /**
     * Linux - check if any interface has an IPv6 address.
     * Don't need to parse the line - we just need an indication.
     */
    {
        FILE *fP = fopen("/proc/net/if_inet6", "r");
        char buf[255];
        char *bufP;

        if (fP == NULL) {
            return 0;
        }
        bufP = fgets(buf, sizeof(buf), fP);
        fclose(fP);
        if (bufP == NULL) {
            return 0;
        }
    }

    return 1; 
}

static EIF_BOOLEAN prefer_ipv4 = 0;

void en_set_prefer_ipv4(EIF_BOOLEAN prefer) {
    prefer_ipv4 = prefer;
}

EIF_BOOLEAN en_get_prefer_ipv4() {
    return prefer_ipv4;
}

int en_ipv6_available() {
    int res = !en_get_prefer_ipv4() && en_ipv6_supported();
    printf ("en_ipv6_available = %d\n", res);
    return res;
}

int en_socket_address_len() {
    return sizeof(SOCKETADDRESS);
}



int NET_SocketClose(int fd) {
    int ret = close(fd);
    return ret;
}

int NET_Timeout(int fd, long timeout) {
    int ret;
    fd_set tbl;
    struct timeval t;
    t.tv_sec = timeout / 1000;
    t.tv_usec = (timeout % 1000) * 1000;
    FD_ZERO(&tbl);
    FD_SET(fd, &tbl);
    ret = select (fd + 1, &tbl, 0, 0, &t);
    return ret;
}

int en_addrinfo_ai_flags(struct addrinfo *s) {
    return s->ai_flags;
}

int en_addrinfo_ai_family(struct addrinfo *s) {
    return s->ai_family;
}

int en_addrinfo_ai_socktype(struct addrinfo *s) {
    return s->ai_socktype;
}

int en_addrinfo_ai_protocol(struct addrinfo *s) {
    return s->ai_protocol;
}

int en_addrinfo_ai_addrlen(struct addrinfo *s) {
    return s->ai_addrlen;
}

char* en_addrinfo_ai_canonname(struct addrinfo *s) {
    return s->ai_canonname;
}

void* en_addrinfo_ai_addr(struct addrinfo *s) {
    return s->ai_addr;
}

void* en_addrinfo_ai_next(struct addrinfo *s) {
    return s->ai_next;
}

void en_free_addrinfo(struct addrinfo *s) {
    freeaddrinfo(s);
}

int en_addrinfo_get_ipv4_address (struct sockaddr *s) {
    if (s->sa_family == AF_INET) {
    	struct sockaddr_in *him4 = (struct sockaddr_in *)s;
	printf("addr=%d, %d \n", him4->sin_addr.s_addr, ntohl(him4->sin_addr.s_addr));
    	return ntohl(him4->sin_addr.s_addr);
    }
    return 0;
}

void* en_addrinfo_get_ipv6_address (struct sockaddr *s) {
    if (s->sa_family == AF_INET6) {
	struct sockaddr_in6 *him6 = (struct sockaddr_in6*) s;
	return &(him6->sin6_addr);
    }
    return 0;
}

int en_addrinfo_get_port (SOCKETADDRESS *s) {
    return GET_PORT(s);
}

unsigned long en_addrinfo_get_ipv6_address_scope (struct addrinfo *s) {
    if (s->ai_family == AF_INET6) {
	struct sockaddr_in6 *him6 = (struct sockaddr_in6*) s->ai_addr;
	return him6->sin6_scope_id;
    }
    return 0;
}

void* en_addrinfo_get_address_pointer(struct addrinfo *s) {
    if (s->ai_family == AF_INET) {
    	struct sockaddr_in *him4 = (struct sockaddr_in *) s->ai_addr;
    	return &(him4->sin_addr.s_addr);
    } else if (s->ai_family == AF_INET6) {
	struct sockaddr_in6 *him6 = (struct sockaddr_in6*) s->ai_addr;
	return &(him6->sin6_addr);
    }
    return 0;
}

void* en_getaddrinfo(char *hostname) {
    struct addrinfo *res = 0;
    int error;

    error = getaddrinfo(hostname, 0, 0, & res);
    if (error != 0) {
        // TODO Handle Error
	res = 0;
    } 
    return res;
}


void en_socket_stream_create (EIF_OBJECT current) {
    int fd;
    
    if (en_ipv6_available()) {
        fd = socket(AF_INET6, SOCK_STREAM, 0);
    } else {
        fd = socket(AF_INET, SOCK_STREAM, 0);
    }

    if (fd == -1) {
        printf("create error\n");
        // TODO Handle Error
	return;
    } else {
        printf("create fd = %d\n", fd);
    }
    eif_field (eif_access(current), "fd", EIF_INTEGER) = fd;
    /* fd1 not used in solaris/linux */
    eif_field (eif_access(current), "fd1", EIF_INTEGER) = 0;
}

void en_socket_datagram_create (EIF_OBJECT current) {
    int fd;
    int t = 1;

    if (en_ipv6_available()) {
        fd = socket(AF_INET6, SOCK_DGRAM, 0);
    } else {
        fd = socket(AF_INET, SOCK_DGRAM, 0);
    }

    if (fd == -1) {
        printf("create error\n");
        // TODO Handle Error
	return;
    } else {
        printf("create fd = %d\n", fd);
    }
    eif_field (eif_access(current), "fd", EIF_INTEGER) = fd;

    setsockopt(fd, SOL_SOCKET, SO_BROADCAST, (char*) &t, sizeof(int));

    /*
     * On Linux for IPv6 sockets we must set the hop limit
     * to 1 to be compatible with default ttl of 1 for IPv4 sockets.
     */
    if (en_ipv6_available()) {
        int ttl = 1;
	setsockopt(fd, IPPROTO_IPV6, IPV6_MULTICAST_HOPS, (char *)&ttl, sizeof(ttl));
    }

    /* fd1 not used in solaris/linux */
    eif_field (eif_access(current), "fd1", EIF_INTEGER) = 0;
}

void en_socket_stream_connect (EIF_OBJECT current, EIF_POINTER sockaddr, EIF_INTEGER timeout) {

    EIF_INTEGER localport;
    SOCKETADDRESS* him;
    int family;
    EIF_INTEGER fd;
    int ipv6_supported;
    int connect_res;

    ipv6_supported = en_ipv6_available();
    localport = eif_field (eif_access(current), "the_local_port", EIF_INTEGER);

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);

    him = (SOCKETADDRESS*) sockaddr;

    family = him->him.sa_family; 
    if (family == AF_INET6) {
        printf("connect family == AF_INET6\n");
	if (!ipv6_supported) {
	    // TODO Handle Error 
	    return;
	}
    } else {
        printf("connect family = AF_INET4\n");
    }

    if (timeout <= 0) {
        connect_res = connect(fd, (struct sockaddr *) him, SOCKETADDRESS_LEN(him));
    } else {
        /* 
         * A timeout was specified. We put the socket into non-blocking
         * mode, connect, and then wait for the connection to be 
         * established, fail, or timeout.
         */
	SET_NONBLOCKING(fd);

	connect_res = connect(fd, (struct sockaddr *)him, SOCKETADDRESS_LEN(him));

	/* connection not established immediately */
	if (connect_res != 0) {
	    if (errno != EINPROGRESS) {
	        //TODO Handle Error 
		SET_BLOCKING(fd);
	        return;
	    }
            fd_set wr, ex;
            struct timeval t;

            FD_ZERO(&wr);
            FD_ZERO(&ex);
            FD_SET(fd, &wr);
            FD_SET(fd, &ex);
            t.tv_sec = timeout / 1000;
            t.tv_usec = (timeout % 1000) * 1000;

            /* 
             * Wait for timout, connection established or
             * connection failed.
             */
            connect_res = select(fd+1, 0, &wr, &ex, &t);

    	    /* 
    	     * Timeout before connection is established/failed so
    	     * we throw exception and shutdown input/output to prevent
    	     * socket from being used.
    	     * The socket should be closed immediately by the caller.
    	     */
    	     if (connect_res == 0) {
                // TODO Handle Error 
    	        shutdown( fd, SHUT_RDWR);
    	        return;
            }
    	    if (!FD_ISSET(fd, &ex)) {
    	        connect_res = 0;
    	    } else {
                // TODO Handle Error 
    		return;
    	    }
    	}
        SET_BLOCKING(fd);
    }

    printf("connect_res= %d\n", connect_res);
    if (connect_res) {
        // TODO Handle Error 
	return;
    }

    eif_field (eif_access(current), "fd", EIF_INTEGER) = fd;

    /*
     * we need to initialize the local port field if bind was called
     * previously to the connect (by the client) then localport field
     * will already be initialized
     */
    if (localport == 0) {
	/* Now that we're a connected socket, let's extract the port number
	 * that the system chose for us and store it in the Socket object.
  	 */
	u_short port;
	int len = SOCKETADDRESS_LEN(him);
	if (getsockname(fd, (struct sockaddr *)him, &len) == -1) {
	    // TODO Handle Error 
	    return;
	}
	port = ntohs ((u_short)GET_PORT(him));
        eif_field (eif_access(current), "the_local_port", EIF_INTEGER) = port;
    }

}

void en_socket_stream_bind (EIF_OBJECT current, EIF_POINTER sockaddr) {

    SOCKETADDRESS* him;
    int fd;
    int localport;
    int rv;

    him = (SOCKETADDRESS*) sockaddr;
    localport = ntohs ((u_short) GET_PORT (him));

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);
    rv = bind(fd, (struct sockaddr *)him, SOCKETADDRESS_LEN(him));

    printf("bind_res= %d\n", rv);

    if (rv == -1) {	
	// TODO Handle Error
	return;
    }

    /* intialize the local port */
    if (localport == 0) {
	/* Now that we're a bound socket, let's extract the port number
	 * that the system chose for us and store it in the Socket object.
  	 */
	int len = SOCKETADDRESS_LEN(him);
	u_short port;

	if (getsockname(fd, (struct sockaddr *)him, &len) == -1) {
	    // TODO Handle Error
	    return;
	}
	port = ntohs ((u_short) GET_PORT (him));
        eif_field (eif_access(current), "the_local_port", EIF_INTEGER) = port;
    } else {
        eif_field (eif_access(current), "the_local_port", EIF_INTEGER) = localport;
    }
    printf("bind_end\n");
}

void en_socket_stream_listen (EIF_OBJECT current, EIF_POINTER sockaddr, EIF_INTEGER count) {
    int fd;
    SOCKETADDRESS *addr;

    addr = (SOCKETADDRESS*) sockaddr;

    printf("listen start\n");

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);

    if (listen(fd, count) == -1) {
        // TODO Handle Error
    }
    printf("listen end\n");
}



EIF_INTEGER en_socket_stream_accept (EIF_OBJECT current, SOCKETADDRESS *him, EIF_INTEGER timeout) {

    int fd=-1;
    int len;

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);

    printf("accept_start fd = %d\n", fd);

    if (timeout) {
        int ret = NET_Timeout(fd, timeout);
        if (ret == 0) {
            // TODO Handle error
            return -1;
        } else if (ret == -1) {
          // TODO Handle error
            return -1;
        } else if (ret == -2) {
          // TODO Handle error
            return -1;
        }
    }

    len = SOCKETADDRESS_LEN(him);

    fd = accept(fd, (struct sockaddr *)him, &len);
    printf("accept fd = %d\n", fd);
    if (fd < 0) {
        // TODO Handle error
    }
    return fd;
}

void en_socket_close(int fd, int fd1) {

    if (fd != -1) {
	NET_SocketClose(fd);
    }

}

void en_socket_address_fill_ipv4(EIF_POINTER sockaddr, EIF_INTEGER address, EIF_INTEGER port) {
    if (en_ipv6_available()) {
	unsigned char caddr[16];    
	struct sockaddr_in6 *him6 = (struct sockaddr_in6*)sockaddr;
	memset((char *)him6, 0, sizeof(struct sockaddr_in6));
	him6->sin6_port = (u_short) htons((u_short)port);
	
        memset((char *) caddr, 0, 16);
	if (address == INADDR_ANY) {
            /* we would always prefer IPv6 wildcard address 
            caddr[10] = 0xff;
            caddr[11] = 0xff; */
	} else {
            caddr[10] = 0xff;
            caddr[11] = 0xff;
            caddr[12] = ((address >> 24) & 0xff);
            caddr[13] = ((address >> 16) & 0xff);
            caddr[14] = ((address >> 8) & 0xff);
            caddr[15] = (address & 0xff); 
        }	
	memcpy((void *)&(him6->sin6_addr), caddr, sizeof(struct in6_addr) );
	him6->sin6_family = AF_INET6; 
    } else {
    	struct sockaddr_in *him4 = (struct sockaddr_in*)sockaddr;
    	memset((char *) him4, 0, sizeof(struct sockaddr_in));
    	him4->sin_port = htons((short) port);
    	him4->sin_addr.s_addr = (u_long) htonl(address);
    	him4->sin_family = AF_INET;
   }
}

void en_socket_address_fill_ipv6(EIF_POINTER sockaddr, EIF_POINTER caddr, EIF_INTEGER port, EIF_INTEGER scopeid) {
	struct sockaddr_in6 *him6 = (struct sockaddr_in6*)sockaddr;
	memset((char *)him6, 0, sizeof(struct sockaddr_in6));
	him6->sin6_port = (u_short) htons((u_short)port);
	memcpy((void *)&(him6->sin6_addr), caddr, sizeof(struct in6_addr) );
	him6->sin6_family = AF_INET6; 
	him6->sin6_scope_id = scopeid;
}

void en_local_host_name (EIF_POINTER data) {
    if (gethostname(data, 256) == -1) {
	strcpy(data, "localhost");
    }
}
