
#define EIF_NET_INITIALIZE do_init()

#include <Winsock2.h>
#include <ws2tcpip.h>

#include "eif_eiffel.h"



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

extern void do_init ();

typedef union {
    struct sockaddr	him;
    struct sockaddr_in	him4;
    struct sockaddr_in6 him6;
} SOCKETADDRESS;

struct ipv6bind {
    SOCKETADDRESS	*addr;
    SOCKET	 	 ipv4_fd;
    SOCKET 	 	 ipv6_fd;
};

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

#ifndef IN6_IS_ADDR_ANY
#define IN6_IS_ADDR_ANY(a)	\
    (((a)->s6_words[0] == 0) && ((a)->s6_words[1] == 0) &&	\
    ((a)->s6_words[2] == 0) && ((a)->s6_words[3] == 0) &&	\
    ((a)->s6_words[4] == 0) && ((a)->s6_words[5] == 0))
#endif


static int en_ipv6_supported() {
    static int res = -1;
    if (res == -1) {
        HMODULE lib;
        int fd = socket(AF_INET6, SOCK_STREAM, 0);
        if (fd < 0) {
            printf ("en_ipv6_supported fd < 0\n");
    	    return (res = 0);
        } 
        closesocket (fd);
        if ((lib = LoadLibrary ("ws2_32.dll")) == 0) {
            printf ("en_ipv6_supported loadLibrary = 0\n");
    	    return (res = 0);
        }
        if (GetProcAddress (lib, "getaddrinfo") == 0) {
            printf ("en_ipv6_supported getaddrinfo = 0\n");
    	    FreeLibrary (lib);
    	    return (res = 0);
        }
        if (GetProcAddress (lib, "freeaddrinfo") == 0) {
    	    FreeLibrary (lib);
    	    return (res = 0);
        }
        if (GetProcAddress (lib, "getnameinfo") == 0) {
    	    FreeLibrary (lib);
    	    return (res = 0);
        }
        FreeLibrary(lib);        
        return (res = 1);
    }
    return res;
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

int NET_Bind(int s, struct sockaddr *him, int len)
{
    int rv = bind(s, him, len);

    if (rv == SOCKET_ERROR) {
	/*
	 * If bind fails with WSAEACCES it means that a privileged
	 * process has done an exclusive bind (NT SP4/2000/XP only).
	 */
	if (WSAGetLastError() == WSAEACCES) {
	    WSASetLastError(WSAEADDRINUSE);
	}
    }

    return rv;
}

int NET_BindV6(struct ipv6bind* b) {
    int fd=-1, ofd=-1, rv, len;
    /* need to defer close until new sockets created */
    int close_fd=-1, close_ofd=-1; 
    SOCKETADDRESS oaddr; /* other address to bind */
    int family = b->addr->him.sa_family;
    int ofamily;
    u_short port; /* requested port parameter */
    u_short bound_port;

    if (family == AF_INET && (b->addr->him4.sin_addr.s_addr != INADDR_ANY)) {
	/* bind to v4 only */
	int ret;
	ret = NET_Bind (b->ipv4_fd, (struct sockaddr *)b->addr, 
				sizeof (struct sockaddr_in));
        if (ret == SOCKET_ERROR) {
	    CLOSE_SOCKETS_AND_RETURN;
        }
	closesocket (b->ipv6_fd);
	b->ipv6_fd = -1;
	return 0;
    }
    if (family == AF_INET6 && (!IN6_IS_ADDR_ANY(&b->addr->him6.sin6_addr))) {
	/* bind to v6 only */
	int ret;
	ret = NET_Bind (b->ipv6_fd, (struct sockaddr *)b->addr, 
				sizeof (struct sockaddr_in6));
        if (ret == SOCKET_ERROR) {
	    CLOSE_SOCKETS_AND_RETURN;
        }
	closesocket (b->ipv4_fd);
	b->ipv4_fd = -1;
	return 0;
    }

    /* We need to bind on both stacks, with the same port number */

    memset (&oaddr, 0, sizeof(oaddr));
    if (family == AF_INET) {
	ofamily = AF_INET6;
	fd = b->ipv4_fd;
	ofd = b->ipv6_fd;
	port = (u_short)GET_PORT (b->addr);
	IN6ADDR_SETANY (&oaddr.him6);
	oaddr.him6.sin6_port = port;
    } else {
	ofamily = AF_INET;
	ofd = b->ipv4_fd;
	fd = b->ipv6_fd;
	port = (u_short)GET_PORT (b->addr);
	oaddr.him4.sin_family = AF_INET;
	oaddr.him4.sin_port = port;
	oaddr.him4.sin_addr.s_addr = INADDR_ANY;
    }

    rv = NET_Bind (fd, (struct sockaddr *)b->addr, SOCKETADDRESS_LEN(b->addr));
    if (rv == SOCKET_ERROR) {
    	CLOSE_SOCKETS_AND_RETURN;
    }

    /* get the port and set it in the other address */
    len = SOCKETADDRESS_LEN(b->addr);
    if (getsockname(fd, (struct sockaddr *)b->addr, &len) == -1) {
    	CLOSE_SOCKETS_AND_RETURN;
    }
    bound_port = GET_PORT (b->addr);
    SET_PORT (&oaddr, bound_port);
    if ((rv=NET_Bind (ofd, (struct sockaddr *) &oaddr, 
				SOCKETADDRESS_LEN (&oaddr))) == SOCKET_ERROR) {
	int retries;
	int sotype, arglen=sizeof(sotype);

 	/* no retries unless, the request was for any free port */

        if (port != 0) {
    	    CLOSE_SOCKETS_AND_RETURN;
        }

	getsockopt(fd, SOL_SOCKET, SO_TYPE, (void *)&sotype, &arglen);

#define SOCK_RETRIES 50
	/* 50 is an arbitrary limit, just to ensure that this
	 * cannot be an endless loop. Would expect socket creation to 
	 * succeed sooner.
	 */
    	for (retries = 0; retries < SOCK_RETRIES; retries ++) {
	    int len;
	    close_fd = fd; fd = -1;
	    close_ofd = ofd; ofd = -1;
	    b->ipv4_fd = SOCKET_ERROR;
	    b->ipv6_fd = SOCKET_ERROR;

	    /* create two new sockets */
	    fd = socket (family, sotype, 0);
	    if (fd == SOCKET_ERROR) {
    	        CLOSE_SOCKETS_AND_RETURN;
	    }
	    ofd = socket (ofamily, sotype, 0);
	    if (ofd == SOCKET_ERROR) {
    	        CLOSE_SOCKETS_AND_RETURN;
	    }

	    /* bind random port on first socket */
	    SET_PORT (&oaddr, 0);
    	    rv = NET_Bind (ofd, (struct sockaddr *)&oaddr, SOCKETADDRESS_LEN(&oaddr));
    	    if (rv == SOCKET_ERROR) {
    	        CLOSE_SOCKETS_AND_RETURN;
	    }
	    /* close the original pair of sockets before continuing */
	    closesocket (close_fd); 
	    closesocket (close_ofd); 
	    close_fd = close_ofd = -1;

	    /* bind new port on second socket */
	    len = SOCKETADDRESS_LEN(&oaddr);
            if (getsockname(ofd, (struct sockaddr *)&oaddr, &len) == -1) {
    	        CLOSE_SOCKETS_AND_RETURN;
            }
    	    bound_port = GET_PORT (&oaddr);
	    SET_PORT (b->addr, bound_port);
    	    rv = NET_Bind (fd, (struct sockaddr *)b->addr, SOCKETADDRESS_LEN(b->addr));

    	    if (rv != SOCKET_ERROR) {
		if (family == AF_INET) {
	    	    b->ipv4_fd = fd;
	    	    b->ipv6_fd = ofd;
		} else {
	    	    b->ipv4_fd = ofd;
	    	    b->ipv6_fd = fd;
		}
		return 0;
	    }
	}
	CLOSE_SOCKETS_AND_RETURN;
    }
    return 0;
}


/*
 * Return the default TOS value
 */
int NET_GetDefaultTOS() {
    static int default_tos = -1;
    OSVERSIONINFO ver;
    HKEY hKey;
    LONG ret;

    /*
     * If default ToS already determined then return it
     */
    if (default_tos >= 0) {
	return default_tos;
    }

    /*
     * Assume default is "normal service"
     */	
    default_tos = 0;

    /* 
     * Which OS is this?
     */
    ver.dwOSVersionInfoSize = sizeof(ver);
    GetVersionEx(&ver);

    /*
     * If 2000 or greater then no default ToS in registry
     */
    if (ver.dwPlatformId == VER_PLATFORM_WIN32_NT) {
	if (ver.dwMajorVersion >= 5) {
	    return default_tos;
	}
    }

    /*
     * Query the registry to see if a Default ToS has been set.
     * Different registry entry for NT vs 95/98/ME.
     */
    if (ver.dwPlatformId == VER_PLATFORM_WIN32_NT) {
	ret = RegOpenKeyEx(HKEY_LOCAL_MACHINE, 
		           "SYSTEM\\CurrentControlSet\\Services\\Tcp\\Parameters",
		           0, KEY_READ, (PHKEY)&hKey);
    } else {
	ret = RegOpenKeyEx(HKEY_LOCAL_MACHINE, 
		           "SYSTEM\\CurrentControlSet\\Services\\VxD\\MSTCP\\Parameters", 
		           0, KEY_READ, (PHKEY)&hKey);
    }
    if (ret == ERROR_SUCCESS) {	
	DWORD dwLen;
	DWORD dwDefaultTOS;
	ULONG ulType;
	dwLen = sizeof(dwDefaultTOS);

	ret = RegQueryValueEx(hKey, "DefaultTOS",  NULL, &ulType,
			     (LPBYTE)&dwDefaultTOS, &dwLen);
	RegCloseKey(hKey);
	if (ret == ERROR_SUCCESS) {
	    default_tos = (int)dwDefaultTOS;
        }
    }
    return default_tos;
}

int NET_GetSockOpt(int s, int level, int optname, void *optval,
	       int *optlen)
{
    int rv;

    rv = getsockopt(s, level, optname, optval, optlen);

    /*
     * IPPROTO_IP/IP_TOS is not supported on some Windows
     * editions so return the default type-of-service
     * value.
     */
    if (rv == SOCKET_ERROR) {

	if (WSAGetLastError() == WSAENOPROTOOPT &&
	    level == IPPROTO_IP && optname == IP_TOS) {

	    int *tos;
	    tos = (int *)optval;
	    *tos = NET_GetDefaultTOS();

	    rv = 0;
	}
    }

    return rv;
}

int NET_SetSockOpt(int s, int level, int optname, const void *optval, int optlen)
{   
    int rv;

    if (level == IPPROTO_IP && optname == IP_TOS) {
	int *tos = (int *)optval;
	*tos &= (IPTOS_TOS_MASK | IPTOS_PREC_MASK);
    }

    rv = setsockopt(s, level, optname, optval, optlen);

    if (rv == SOCKET_ERROR) {
	/*
	 * IP_TOS & IP_MULTICAST_LOOP can't be set on some versions
	 * of Windows.
	 */
	if ((WSAGetLastError() == WSAENOPROTOOPT) &&
	    (level == IPPROTO_IP) &&
	    (optname == IP_TOS || optname == IP_MULTICAST_LOOP)) {
	    rv = 0;
	}

	/*
	 * IP_TOS can't be set on unbound UDP sockets.
	 */
	if ((WSAGetLastError() == WSAEINVAL) && 
	    (level == IPPROTO_IP) &&
	    (optname == IP_TOS)) {
	    rv = 0;
	}
    }

    return rv;
}

int NET_SocketClose(int fd) {
    struct linger l;
    int ret;
    int len = sizeof (l);
    if (getsockopt(fd, SOL_SOCKET, SO_LINGER, (char *)&l, &len) == 0) {
	if (l.l_onoff == 0) {
	    WSASendDisconnect(fd, NULL);
	}
    }
    ret = closesocket (fd);
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

    EIF_NET_INITIALIZE;

    error = getaddrinfo(hostname, 0, 0, & res);
    if (error != 0) {
        // TODO Handle Error
	res = 0;
    } 
    return res;
}

void en_socket_stream_create (EIF_OBJECT current) {

    int fd;

    EIF_NET_INITIALIZE;

    fd = socket(AF_INET, SOCK_STREAM, 0);

    if (fd == -1) {
        printf("create error\n");
        // TODO Handle Error
	return;
    } else {
        printf("create fd = %d\n", fd);
	/* Set socket attribute so it is not passed to any child process */
	SetHandleInformation((HANDLE)(UINT_PTR)fd, HANDLE_FLAG_INHERIT, FALSE);
        eif_field (eif_access(current), "fd", EIF_INTEGER) = fd;
    }
    if (en_ipv6_available()) {
        fd = socket(AF_INET6, SOCK_STREAM, 0);
        if (fd == -1) {
            // TODO Handle Error
            eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
	    NET_SocketClose(fd);
	    return;
        } else {
            eif_field (eif_access(current), "fd1", EIF_INTEGER) = fd;
        }
    } else {
        eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
    }
}

void en_socket_datagram_create (EIF_OBJECT current) {

    int fd, fd1;
    int t = TRUE;
    DWORD x1, x2; /* ignored result codes */

    EIF_NET_INITIALIZE;
    fd =  (int) socket (AF_INET, SOCK_DGRAM, 0);

    if (fd == -1) {
        printf("create error\n");
        // TODO Handle Error
	return;
    } else {
        printf("create fd = %d\n", fd);
        SetHandleInformation((HANDLE)(UINT_PTR)fd, HANDLE_FLAG_INHERIT, FALSE);
        eif_field (eif_access(current), "fd", EIF_INTEGER) = fd;
        NET_SetSockOpt(fd, SOL_SOCKET, SO_BROADCAST, (char*)&t, sizeof(BOOL));
    }

    if (en_ipv6_available()) {
	/* SIO_UDP_CONNRESET fixes a bug introduced in Windows 2000, which
	 * returns connection reset errors un connected UDP sockets (as well
  	 * as connected sockets. The solution is to only enable this feature
	 * when the socket is connected
	 */
	t = FALSE; 
	WSAIoctl(fd,SIO_UDP_CONNRESET,&t,sizeof(t),&x1,sizeof(x1),&x2,0,0);
    	t = TRUE;
	fd1 = socket (AF_INET6, SOCK_DGRAM, 0);
        if (fd1 == -1) {
            // TODO Handle Error
	    return;
        }
        NET_SetSockOpt(fd1, SOL_SOCKET, SO_BROADCAST, (char*)&t, sizeof(BOOL));
	t = FALSE;
	WSAIoctl(fd1,SIO_UDP_CONNRESET,&t,sizeof(t),&x1,sizeof(x1),&x2,0,0);
        eif_field (eif_access(current), "fd1", EIF_INTEGER) = fd;
    	SetHandleInformation((HANDLE)(UINT_PTR)fd1, HANDLE_FLAG_INHERIT, FALSE);
    } else {
    	eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
    }
}

void en_socket_stream_connect (EIF_OBJECT current, EIF_POINTER sockaddr, EIF_INTEGER timeout) {

    EIF_INTEGER localport;
    SOCKETADDRESS* him;
    int family;
    EIF_INTEGER fd, fd1=-1;
    int ipv6_supported;
    int connect_res;

    EIF_NET_INITIALIZE;

    ipv6_supported = en_ipv6_available();
    localport = eif_field (eif_access(current), "the_local_port", EIF_INTEGER);

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);
    if (ipv6_supported) {
	fd1 = eif_field (eif_access(current), "fd1", EIF_INTEGER);
    }

    him = (SOCKETADDRESS*) sockaddr;

    family = him->him.sa_family; 
    if (family == AF_INET6) {
        printf("connect family == AF_INET6\n");
	if (!ipv6_supported) {
	    // TODO Handle Error 
	    return;
	} else {
	    if (fd1 == -1) {
                printf("connect fd1 == -1\n");
	    	// TODO Handle Error 
	    	return;
	    }
	    /* close the v4 socket, and set fd to be the v6 socket */
            eif_field (eif_access(current), "fd", EIF_INTEGER) = fd1;
            eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
	    NET_SocketClose(fd); 
	    fd = fd1;
	}
    } else {
        printf("connect family = AF_INET4\n");
	if (fd1 != -1) {
            eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
	    NET_SocketClose(fd1); 
	}
	if (fd == -1) {
            // TODO Handle Error 
	    return;
	} 
    }

    if (timeout <= 0) {
        connect_res = connect(fd, (struct sockaddr *) him, SOCKETADDRESS_LEN(him));
	if (connect_res == SOCKET_ERROR) {
	    connect_res = WSAGetLastError();
	}
    } else {
	int optval;
        int optlen = sizeof(optval);

        /* make socket non-blocking */
        optval = 1;
        ioctlsocket( fd, FIONBIO, &optval );

        /* initiate the connect */
        connect_res = connect(fd, (struct sockaddr *) him, SOCKETADDRESS_LEN(him));
        if (connect_res == SOCKET_ERROR) {
            if (WSAGetLastError() != WSAEWOULDBLOCK) {
                connect_res = WSAGetLastError();
            } else {
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
		    shutdown( fd, SD_BOTH );
		     /* make socket blocking again - just in case */
		    optval = 0;
		    ioctlsocket( fd, FIONBIO, &optval );
		    return;
		}

		/*
		 * We must now determine if the connection has been established
		 * or if it has failed. The logic here is designed to work around
		 * bug on Windows NT whereby using getsockopt to obtain the 
		 * last error (SO_ERROR) indicates there is no error. The workaround
		 * on NT is to allow winsock to be scheduled and this is done by
		 * yielding and retrying. As yielding is problematic in heavy
		 * load conditions we attempt up to 3 times to get the error reason.
		 */
		if (!FD_ISSET(fd, &ex)) {
		    connect_res = 0;
		} else {
		    int retry;
		    for (retry=0; retry<3; retry++) {
			NET_GetSockOpt(fd, SOL_SOCKET, SO_ERROR, 
				       (char*)&connect_res, &optlen);
			if (connect_res) {
			    break;
			}
			Sleep(0);
		    }

		    if (connect_res == 0) {
                        // TODO Handle Error 
			return;
		    }
		}
	    }
	}

	/* make socket blocking again */
	optval = 0;
	ioctlsocket(fd, FIONBIO, &optval);
    }

    printf("connect_res= %d\n", connect_res);
    if (connect_res) {
	if (connect_res == WSAEADDRNOTAVAIL) {
            // TODO Handle Error 
	} else {
            // TODO Handle Error 
	}
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

	    if (WSAGetLastError() == WSAENOTSOCK) {
                // TODO Handle Error 
	    } else {
	        // TODO Handle Error 
	    }
	    return;
	}
	port = ntohs ((u_short)GET_PORT(him));
        eif_field (eif_access(current), "the_local_port", EIF_INTEGER) = port;
    }

}

void en_socket_stream_bind (EIF_OBJECT current, EIF_POINTER sockaddr) {

    SOCKETADDRESS* him;
    int family;
    int fd, fd1;
    int ipv6_supported;
    int localport;
    int rv;

    EIF_NET_INITIALIZE;

    ipv6_supported = en_ipv6_available();


    him = (SOCKETADDRESS*) sockaddr;
    family = him->him.sa_family; 
    localport = ntohs ((u_short) GET_PORT (him));

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);
    if (ipv6_supported) {
        fd1 = eif_field (eif_access(current), "fd1", EIF_INTEGER);
    }


    if (ipv6_supported) {
    	struct ipv6bind v6bind;
	v6bind.addr = him;
	v6bind.ipv4_fd = fd;
	v6bind.ipv6_fd = fd1;
	rv = NET_BindV6(&v6bind);
        printf("bindv6 res= %d\n", rv);
	if (rv != -1) {
	    /* check if the fds have changed */
	    if (v6bind.ipv4_fd != fd) {
                printf("v6bind.ipv4_fd != fd\n");
		fd = v6bind.ipv4_fd;
		if (fd == -1) {
		    /* socket is closed. */
                    eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
		} else {
		    /* socket was re-created */
                    eif_field (eif_access(current), "fd", EIF_INTEGER) = fd;
		}
	    }
	    if (v6bind.ipv6_fd != fd1) {
                printf("v6bind.ipv6_fd != fd1\n");
		fd1 = v6bind.ipv6_fd;
		if (fd1 == -1) {
		    /* socket is closed. */
                    eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
		} else {
		    /* socket was re-created */
                    eif_field (eif_access(current), "fd1", EIF_INTEGER) = fd1;
		}
	    }
	}
    } else {
    	rv = NET_Bind(fd, (struct sockaddr *)him, SOCKETADDRESS_LEN(him));
    }

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
    	fd = him->him.sa_family == AF_INET? fd: fd1;

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
    int fd, fd1;
    SOCKETADDRESS *addr;
    int ipv6_supported;

    EIF_NET_INITIALIZE;


    addr = (SOCKETADDRESS*) sockaddr;
    ipv6_supported = en_ipv6_available();

    printf("listen start\n");

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);

    if (addr->him.sa_family == AF_INET || IN6ADDR_ISANY(&addr->him6)) {
	/* listen on v4 */
    	if (listen(fd, count) == -1) {
	    // TODO Handle Error
        }
    } else {
	NET_SocketClose (fd);
	eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
    }

    if (ipv6_supported) {
        fd1 = eif_field (eif_access(current), "fd1", EIF_INTEGER);
        if (addr->him.sa_family == AF_INET6 || addr->him4.sin_addr.s_addr == INADDR_ANY) {
	    /* listen on v6 */
    	    if (listen(fd1, count) == -1) {
	        //TODO Handle Error
            }
        } else {
	    NET_SocketClose (fd1);
	    eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
        }
    }
    printf("listen end\n");
}



EIF_INTEGER en_socket_stream_accept (EIF_OBJECT current, SOCKETADDRESS *him, EIF_INTEGER timeout) {

    int fd=-1, fd1=-1;
    int len;

    EIF_NET_INITIALIZE;

    fd = eif_field (eif_access(current), "fd", EIF_INTEGER);
    fd1 = eif_field (eif_access(current), "fd1", EIF_INTEGER);

    printf("accept_start fd = %d, fd1 = %d\n", fd, fd1);

    if (fd != -1 && fd1 != -1) {
	fd_set rfds;
	struct timeval t, *tP=&t;
	int lastfd, res, fd2;
	FD_ZERO(&rfds);
	FD_SET(fd,&rfds);
	FD_SET(fd1,&rfds);
	if (timeout) {
	    t.tv_sec = timeout/1000;
	    t.tv_usec = (timeout%1000)*1000;
	} else {
	    tP = NULL;
	}
	res = select (fd, &rfds, NULL, NULL, tP);
	if (res == 0) {
	    // TODO Handle error
	    return -1;
	} else if (res == 1) {
	    fd2 = FD_ISSET(fd, &rfds)? fd: fd1;
	} else if (res == 2) {
	    /* avoid starvation */
	    lastfd = eif_field (eif_access(current), "lastfd", EIF_INTEGER);
	    if (lastfd != -1) {
		fd2 = lastfd==fd? fd1: fd;
	    } else {
		fd2 = fd;
	    }
            eif_field (eif_access(current), "lastfd", EIF_INTEGER) = fd2;
	} else {
	    // TODO Handle error
	    return -1;
	}
	if (fd2 == fd) { /* v4 */
	    len = sizeof (struct sockaddr_in);
	} else {
	    len = sizeof (struct sockaddr_in6);
	}
	fd = fd2;
    } else {
	int ret;
	if (fd1 != -1) {
	    fd = fd1;
	    len = sizeof (struct sockaddr_in6);
	} else {
	    len = sizeof (struct sockaddr_in);
	}
	if (timeout) {
            ret = NET_Timeout(fd, timeout);
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
    }
    fd = accept(fd, (struct sockaddr *)him, &len);
    printf("accept fd = %d\n", fd);
    if (fd < 0) {
	/* REMIND: SOCKET CLOSED PROBLEM */
        if (fd == -2) {
	    // TODO Handle error
        } else {
	    // TODO Handle error
        }
    }
    return fd;
}

void en_socket_close(int fd, int fd1) {

    if (fd != -1) {
	NET_SocketClose(fd);
    }

    if (fd1 != -1) {
	NET_SocketClose(fd1);
    }
}

void en_socket_address_fill_ipv4(EIF_POINTER sockaddr, EIF_INTEGER address, EIF_INTEGER port) {
    	struct sockaddr_in *him4 = (struct sockaddr_in*)sockaddr;
    	memset((char *) him4, 0, sizeof(struct sockaddr_in));
    	him4->sin_port = htons((short) port);
    	him4->sin_addr.s_addr = (u_long) htonl(address);
    	him4->sin_family = AF_INET;
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
