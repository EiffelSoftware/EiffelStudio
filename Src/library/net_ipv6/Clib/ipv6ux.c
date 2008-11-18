#include "ipv6.h"

extern void eif_net_check (int retcode);

static int net_socket_close(int fd) {
	int ret = close(fd);
	return ret;
}

static int net_timeout(int fd, long timeout) {
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

static int convert_v4_to_v6_sockaddr (struct sockaddr* dst, struct sockaddr* src) {
	if (en_ipv6_available() && src->sa_family == AF_INET) {
		unsigned char caddr[16];	
		struct sockaddr_in *him4 = (struct sockaddr_in*)src;
		struct sockaddr_in6 *him6 = (struct sockaddr_in6*)dst;

		memset((char *)him6, 0, sizeof(struct sockaddr_in6));
		him6->sin6_port = him4->sin_port;
		u_long address = ntohl(him4->sin_addr.s_addr);
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
		return 1;
	} else {
		return 0;
   }
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

		/* If fd 0 is a socket it means we've been launched from inetd or
		 * xinetd. If it's a socket then check the family - if it's an
		 * IPv4 socket then we need to disable IPv6. */
	if (getsockname(0, (struct sockaddr *)&sa, &sa_len) == 0) {
		struct sockaddr *saP = (struct sockaddr *)&sa;
		if (saP->sa_family != AF_INET6) {
			return 0;
		}
	}

		/* Linux - check if any interface has an IPv6 address.
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

EIF_BOOLEAN en_ipv6_supported() {
	static int res = -1;
	if (res == -1) {
		res = ipv6_supported_();
	}
	return res;
}



void en_socket_stream_create (EIF_INTEGER *a_fd, EIF_INTEGER *a_fd1) {
	int fd;
	
	if (en_ipv6_available()) {
		fd = socket(AF_INET6, SOCK_STREAM, 0);
	} else {
		fd = socket(AF_INET, SOCK_STREAM, 0);
	}

	if (fd == -1) {
		eif_net_check(fd);
		return;
	}
	*a_fd = fd;
		/* fd1 not used in solaris/linux */
	*a_fd1 = 0;
}

void en_socket_datagram_create (EIF_INTEGER *a_fd, EIF_INTEGER *a_fd1) {
	int fd;
	int t = 1;

	if (en_ipv6_available()) {
		fd = socket(AF_INET6, SOCK_DGRAM, 0);
	} else {
		fd = socket(AF_INET, SOCK_DGRAM, 0);
	}

	if (fd == -1) {
		eif_net_check(fd);
		return;
	}

	*a_fd = fd;
	setsockopt(fd, SOL_SOCKET, SO_BROADCAST, (char*) &t, sizeof(int));

		/* On Linux for IPv6 sockets we must set the hop limit
		 * to 1 to be compatible with default ttl of 1 for IPv4 sockets. */
	if (en_ipv6_available()) {
		int ttl = 1;
		setsockopt(fd, IPPROTO_IPV6, IPV6_MULTICAST_HOPS, (char *)&ttl, sizeof(ttl));
	}

		/* fd1 not used in solaris/linux */
	*a_fd1 = 0;
}

void en_socket_stream_connect (EIF_INTEGER *a_fd, EIF_INTEGER *a_fd1, EIF_INTEGER *a_local_port, EIF_POINTER sockaddr, EIF_INTEGER timeout) {

	SOCKETADDRESS h;
	SOCKETADDRESS* him;

	int family;
	EIF_INTEGER fd;
	int ipv6_supported;
	int connect_res;

	ipv6_supported = en_ipv6_available();

	fd = *a_fd;

	if (convert_v4_to_v6_sockaddr((struct sockaddr*)&h, (struct sockaddr*)sockaddr)) {
		him = &h;
	} else {
		him = (SOCKETADDRESS*) sockaddr;
	}

	family = him->him.sa_family; 
	if (family == AF_INET6) {
		if (!ipv6_supported) {
			eraise ("Protocol family not supported", EN_PROG);
			return;
		}
	}

	if (timeout <= 0) {
		connect_res = connect(fd, (struct sockaddr *) him, SOCKETADDRESS_LEN(him));
	} else {
			/* A timeout was specified. We put the socket into non-blocking
			 * mode, connect, and then wait for the connection to be 
			 * established, fail, or timeout. */
		SET_NONBLOCKING(fd);

		connect_res = connect(fd, (struct sockaddr *)him, SOCKETADDRESS_LEN(him));

			/* connection not established immediately */
		if (connect_res != 0) {
			if (errno != EINPROGRESS) {
					/* TODO Handle Error */
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

				/* Wait for timout, connection established or
				 * connection failed. */
			connect_res = select(fd+1, 0, &wr, &ex, &t);

				/* Timeout before connection is established/failed so
				 * we throw exception and shutdown input/output to prevent
				 * socket from being used.
				 * The socket should be closed immediately by the caller. */
			 if (connect_res == 0) {
					/* TODO Handle Error */
				shutdown( fd, SHUT_RDWR);
				return;
			}
			if (!FD_ISSET(fd, &ex)) {
				connect_res = 0;
			} else {
				eraise("Unable to establish connection", EN_PROG);
				return;
			}
		}
		SET_BLOCKING(fd);
	}

	if (connect_res) {
		eraise("Unable to establish connection", EN_PROG);
		return;
	}

	*a_fd = fd;

		/* we need to initialize the local port field if bind was called
		 * previously to the connect (by the client) then localport field
		 * will already be initialized */
	if (*a_local_port == 0) {
			/* Now that we're a connected socket, let's extract the port number
			 * that the system chose for us and store it in the Socket object. */
		u_short port;
		int len = SOCKETADDRESS_LEN(him);
		if (getsockname(fd, (struct sockaddr *)him, &len) == -1) {
				/* TODO Handle Error  */
			return;
		}
		port = ntohs ((u_short)GET_PORT(him));
		*a_local_port = port;
	}
}

void en_socket_stream_bind (EIF_INTEGER *a_fd, EIF_INTEGER *a_fd1, EIF_INTEGER *a_local_port, EIF_POINTER sockaddr) {

	SOCKETADDRESS h;
	SOCKETADDRESS* him;
	int localport;
	int fd;
	int rv;

	if (convert_v4_to_v6_sockaddr((struct sockaddr*)&h, (struct sockaddr*)sockaddr)) {
		him = &h;
	} else {
		him = (SOCKETADDRESS*) sockaddr;
	}

	localport = ntohs ((u_short) GET_PORT (him));

	fd = *a_fd;
	rv = bind(fd, (struct sockaddr *)him, SOCKETADDRESS_LEN(him));

	if (rv == -1) {	
		eif_net_check(rv);
		return;
	}

		/* intialize the local port */
	if (localport == 0) {
			/* Now that we're a bound socket, let's extract the port number
			 * that the system chose for us and store it in the Socket object. */
		int len = SOCKETADDRESS_LEN(him);
		u_short port;

		if ((rv=getsockname(fd, (struct sockaddr *)him, &len)) == -1) {
			eif_net_check(rv);
			return;
		}
		port = ntohs ((u_short) GET_PORT (him));
		*a_local_port = port;
	} else {
		*a_local_port = localport;
	}
}

void en_socket_stream_listen (EIF_INTEGER *a_fd, EIF_INTEGER *a_fd1, EIF_POINTER sockaddr, EIF_INTEGER count) {
	eif_net_check(listen(*a_fd, count));
}


EIF_INTEGER en_socket_stream_accept (EIF_INTEGER fd, EIF_INTEGER fd1, EIF_INTEGER *a_last_fd, SOCKETADDRESS *him, EIF_INTEGER timeout) {
	int len;

	if (timeout) {
		int ret = net_timeout(fd, timeout);
		if (ret == 0) {
		eraise("Accept timed out", EN_PROG);
			return -1;
		} else if (ret == -1) {
			eraise("Socket closed", EN_PROG);
			return -1;
		} else if (ret == -2) {
			eraise("operation interrupted", EN_PROG);
			return -1;
		}
	}

	len = SOCKETADDRESS_LEN(him);

	fd = accept(fd, (struct sockaddr *)him, &len);
	if (fd < 0) {
		eif_net_check(fd);
	}
	return fd;
}

void en_socket_datagram_bind (EIF_INTEGER *a_fd, EIF_INTEGER *a_fd1, EIF_INTEGER *a_local_port, EIF_POINTER sockaddr) {
	// For now we reuse the stream socket implementation, but it could be changed in the feature
	en_socket_stream_bind (a_fd, a_fd1, a_local_port, sockaddr);
}


void en_socket_datagram_connect (EIF_INTEGER fd, EIF_INTEGER fd1, EIF_POINTER sockaddr) {

	SOCKETADDRESS h;
	SOCKETADDRESS* him;
	int family;
	int ipv6_supported;
	int connect_res;

	ipv6_supported = en_ipv6_available();

	if (convert_v4_to_v6_sockaddr((struct sockaddr*)&h, (struct sockaddr*)sockaddr)) {
		him = &h;
	} else {
		him = (SOCKETADDRESS*) sockaddr;
	}

	family = him->him.sa_family; 

	if (family == AF_INET6 && !ipv6_supported) {
		eraise ("Protocol family not supported", EN_PROG);
		return;
	}
    	
	connect_res = connect(fd, (struct sockaddr *)him, SOCKETADDRESS_LEN(him));
	if ( connect_res == -1) {
    		eraise("Unable to establish connection", EN_PROG);
	}
}

EIF_INTEGER en_socket_datagram_rcv_from (EIF_INTEGER fd, EIF_INTEGER fd1, EIF_INTEGER *a_last_fd, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags, EIF_INTEGER timeout, SOCKETADDRESS *him) {

	int result;
	int lenn = sizeof(SOCKETADDRESS);
	int ipv6_supported = en_ipv6_available();

	if (timeout) {
		int ret;
		ret = net_timeout(fd, timeout);
		if (ret <= 0) {
			if (ret == 0) {
				eraise("Receive timed out", EN_PROG);
			} else {
				eraise("Receive error", EN_PROG);
			}
			return -1;
		}
	}

	result = recvfrom (fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) him, &lenn);
	eif_net_check (result);
	
	return (EIF_INTEGER) result;
}

EIF_INTEGER en_socket_datagram_send_to (EIF_INTEGER fd, EIF_INTEGER fd1, EIF_POINTER buf, EIF_INTEGER len, EIF_INTEGER flags, SOCKETADDRESS *sockaddr) {

	int result = -1;
	SOCKETADDRESS h;
	SOCKETADDRESS* him;


	if (convert_v4_to_v6_sockaddr((struct sockaddr*)&h, (struct sockaddr*)sockaddr)) {
		him = &h;
	} else {
		him = (SOCKETADDRESS*) sockaddr;
	}

	result = sendto (fd, (char *) buf, (int) len, (int) flags, (struct sockaddr *) him, SOCKETADDRESS_LEN(him));
	eif_net_check (result);
	return (EIF_INTEGER) result;
}

void en_socket_close(int fd, int fd1) {
	if (fd != -1) {
		net_socket_close(fd);
	}

}
void en_socket_shutdown(int fd, int fd1) {
	if (fd != -1) {
		shutdown(fd, SHUT_RDWR);
	}
}
