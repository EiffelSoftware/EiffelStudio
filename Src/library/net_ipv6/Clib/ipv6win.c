#include "ipv6.h"

static int net_bind(int s, struct sockaddr *him, int len)
{
	int rv = bind(s, him, len);

	if (rv == SOCKET_ERROR) {
			/* If bind fails with WSAEACCES it means that a privileged
			 * process has done an exclusive bind (NT SP4/2000/XP only). */
		if (WSAGetLastError() == WSAEACCES) {
			WSASetLastError(WSAEADDRINUSE);
		}
	}
	return rv;
}

static int net_bindV6(struct ipv6bind* b) {
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
		ret = net_bind (b->ipv4_fd, (struct sockaddr *)b->addr, sizeof (struct sockaddr_in));
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
		ret = net_bind (b->ipv6_fd, (struct sockaddr *)b->addr, sizeof (struct sockaddr_in6));
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

	rv = net_bind (fd, (struct sockaddr *)b->addr, SOCKETADDRESS_LEN(b->addr));
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
	if ((rv=net_bind (ofd, (struct sockaddr *) &oaddr, SOCKETADDRESS_LEN (&oaddr))) == SOCKET_ERROR) {
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
			rv = net_bind (ofd, (struct sockaddr *)&oaddr, SOCKETADDRESS_LEN(&oaddr));
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
			rv = net_bind (fd, (struct sockaddr *)b->addr, SOCKETADDRESS_LEN(b->addr));

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
static int net_get_default_tos() {
	static int default_tos = -1;
	OSVERSIONINFO ver;
	HKEY hKey;
	LONG ret;

		/* If default ToS already determined then return it */
	if (default_tos >= 0) {
		return default_tos;
	}

		/* Assume default is "normal service" */	
	default_tos = 0;

		/* Which OS is this? */
	ver.dwOSVersionInfoSize = sizeof(ver);
	GetVersionEx(&ver);

	/* If 2000 or greater then no default ToS in registry */
	if (ver.dwPlatformId == VER_PLATFORM_WIN32_NT) {
		if (ver.dwMajorVersion >= 5) {
			return default_tos;
		}
	}

	/* Query the registry to see if a Default ToS has been set.
	 * Different registry entry for NT vs 95/98/ME. */
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

		ret = RegQueryValueEx(hKey, "DefaultTOS", NULL, &ulType, (LPBYTE)&dwDefaultTOS, &dwLen);
		RegCloseKey(hKey);
		if (ret == ERROR_SUCCESS) {
			default_tos = (int)dwDefaultTOS;
		}
	}
	return default_tos;
}

static int net_get_sock_opt(int s, int level, int optname, void *optval, int *optlen)
{
	int rv;

	rv = getsockopt(s, level, optname, optval, optlen);

		/* IPPROTO_IP/IP_TOS is not supported on some Windows
		 * editions so return the default type-of-service
		 * value. */
	if (rv == SOCKET_ERROR) {
		if (WSAGetLastError() == WSAENOPROTOOPT && level == IPPROTO_IP && optname == IP_TOS) {
			int *tos;
			tos = (int *)optval;
			*tos = net_get_default_tos();
			rv = 0;
		}
	}

	return rv;
}

static int net_set_sock_opt(int s, int level, int optname, const void *optval, int optlen)
{
	int rv;

	if (level == IPPROTO_IP && optname == IP_TOS) {
		int *tos = (int *)optval;
		*tos &= (IPTOS_TOS_MASK | IPTOS_PREC_MASK);
	}

	rv = setsockopt(s, level, optname, optval, optlen);

	if (rv == SOCKET_ERROR) {
			/* IP_TOS & IP_MULTICAST_LOOP can't be set on some versions
			 * of Windows. */
		if
			((WSAGetLastError() == WSAENOPROTOOPT) && (level == IPPROTO_IP) &&
			(optname == IP_TOS || optname == IP_MULTICAST_LOOP))
		{
			rv = 0;
		}

			/* IP_TOS can't be set on unbound UDP sockets. */
		if ((WSAGetLastError() == WSAEINVAL) && (level == IPPROTO_IP) && (optname == IP_TOS)) {
			rv = 0;
		}
	}

	return rv;
}

static int net_socket_close(int fd) {
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

EIF_BOOLEAN en_ipv6_supported() {
	static int res = -1;
	if (res == -1) {
		HMODULE lib;
		int fd = socket(AF_INET6, SOCK_STREAM, 0);
		if (fd < 0) {
			return (res = 0);
		} 
		closesocket (fd);
		if ((lib = LoadLibrary ("ws2_32.dll")) == 0) {
			return (res = 0);
		}
		if (GetProcAddress (lib, "getaddrinfo") == 0) {
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

static SOCKET check_socket_bounds (SOCKET l_socket) {
#ifdef EIF_64_BITS
		/* On 64-bit system `SOCKET' is actually a pointer. For the moment, we check that
		 * it is not coded on the whole 64-bit. */
	if (l_socket != INVALID_SOCKET) {
		if ((l_socket & RTU64C(0x00000000FFFFFFFF)) != l_socket) {
				/* We are in trouble. Raise an exception for the moment. */
			eraise ("Descriptor too big to be represented as INTEGER_32", EN_PROG);
		}
	}
#endif
	return l_socket;
}


void en_socket_stream_create (EIF_OBJECT current) {
	SOCKET fd, fd1;

	EIF_NET_INITIALIZE;

	fd = check_socket_bounds(socket(AF_INET, SOCK_STREAM, 0));

	if (fd == INVALID_SOCKET) {
		eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
		eif_net_check ((int)fd);
		return;
	} else {
			/* Set socket attribute so it is not passed to any child process */
		SetHandleInformation((HANDLE)fd, HANDLE_FLAG_INHERIT, FALSE);
		eif_field (eif_access(current), "fd", EIF_INTEGER) = (int) fd;
	}
	if (en_ipv6_available()) {
		fd1 = check_socket_bounds(socket(AF_INET6, SOCK_STREAM, 0));
		if (fd1 == INVALID_SOCKET) {
			eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
			eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
			net_socket_close(fd);
			eif_net_check ((int)fd1);
			return;
		} else {
				/* Set socket attribute so it is not passed to any child process */
			SetHandleInformation((HANDLE)fd1, HANDLE_FLAG_INHERIT, FALSE);
			eif_field (eif_access(current), "fd1", EIF_INTEGER) = (int)fd1;
		}
	} else {
		eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
	}
}

void en_socket_datagram_create (EIF_OBJECT current) {
	SOCKET fd, fd1;
	int t = TRUE;
	DWORD x1, x2; /* ignored result codes */

	EIF_NET_INITIALIZE;
	fd = check_socket_bounds(socket (AF_INET, SOCK_DGRAM, 0));

	if (fd == INVALID_SOCKET) {
		eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
		eif_net_check ((int)fd);
		return;
	} else {
			/* Set socket attribute so it is not passed to any child process */
		SetHandleInformation((HANDLE)fd, HANDLE_FLAG_INHERIT, FALSE);
		eif_field (eif_access(current), "fd", EIF_INTEGER) = (int)fd;
		net_set_sock_opt(fd, SOL_SOCKET, SO_BROADCAST, (char*)&t, sizeof(BOOL));
	}

	if (en_ipv6_available()) {
			/* SIO_UDP_CONNRESET fixes a bug introduced in Windows 2000, which
			 * returns connection reset errors un connected UDP sockets (as well
			 * as connected sockets. The solution is to only enable this feature
			 * when the socket is connected */
		t = FALSE; 
		WSAIoctl(fd,SIO_UDP_CONNRESET,&t,sizeof(t),&x1,sizeof(x1),&x2,0,0);
		t = TRUE;
		fd1 = check_socket_bounds(socket (AF_INET6, SOCK_DGRAM, 0));

		if (fd1 == INVALID_SOCKET) {
			eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
			eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
			eif_net_check ((int)fd1);
			return;
		} else {
			net_set_sock_opt(fd1, SOL_SOCKET, SO_BROADCAST, (char*)&t, sizeof(BOOL));
			t = FALSE;
			WSAIoctl(fd1,SIO_UDP_CONNRESET,&t,sizeof(t),&x1,sizeof(x1),&x2,0,0);
			SetHandleInformation((HANDLE)fd1, HANDLE_FLAG_INHERIT, FALSE);
			eif_field (eif_access(current), "fd1", EIF_INTEGER) = fd1;
		}
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
		if (!ipv6_supported) {
			eraise ("Protocol family not supported", EN_PROG);
			return;
		} else {
			if (fd1 == -1) {
				eraise ("Destination unreachable", EN_PROG);
				return;
			}
				/* close the v4 socket, and set fd to be the v6 socket */
			eif_field (eif_access(current), "fd", EIF_INTEGER) = fd1;
			eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
			net_socket_close(fd); 
			fd = fd1;
		}
	} else {
		if (fd1 != -1) {
				/* close the v6 socket */
			eif_field (eif_access(current), "fd1", EIF_INTEGER) = -1;
			net_socket_close(fd1); 
		}
		if (fd == -1) {
			eraise ("Destination unreachable", EN_PROG);
			return;
		} 
	}

	if (timeout <= 0) {
		connect_res = connect(fd, (struct sockaddr *) him, SOCKETADDRESS_LEN(him));
	} else {
		int optval;
		int optlen = sizeof(optval);

			/* make socket non-blocking */
		optval = 1;
		ioctlsocket( fd, FIONBIO, &optval );

			/* initiate the connect */
		connect_res = connect(fd, (struct sockaddr *) him, SOCKETADDRESS_LEN(him));
		if (connect_res == SOCKET_ERROR) {
			if (WSAGetLastError() == WSAEWOULDBLOCK) {
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
					shutdown( fd, SD_BOTH );
					 	/* make socket blocking again - just in case */
					optval = 0;
					ioctlsocket( fd, FIONBIO, &optval );
					eraise("connect timed out", EN_PROG);
					return;
				}

					/* We must now determine if the connection has been established
					 * or if it has failed. The logic here is designed to work around
					 * bug on Windows NT whereby using getsockopt to obtain the 
					 * last error (SO_ERROR) indicates there is no error. The workaround
					 * on NT is to allow winsock to be scheduled and this is done by
					 * yielding and retrying. As yielding is problematic in heavy
					 * load conditions we attempt up to 3 times to get the error reason. */
				if (!FD_ISSET(fd, &ex)) {
					connect_res = 0;
				} else {
					int retry;
					for (retry=0; retry<3; retry++) {
						net_get_sock_opt(fd, SOL_SOCKET, SO_ERROR, (char*)&connect_res, &optlen);
						if (connect_res) {
							break;
						}
						Sleep(0);
					}

					if (connect_res == 0) {
						eraise("Unable to establish connection", EN_PROG);
						return;
					}
				}
			}
		}

			/* make socket blocking again */
		optval = 0;
		ioctlsocket(fd, FIONBIO, &optval);
	}

	if (connect_res) {
		eif_net_check(connect_res);
		return;
	}

	eif_field (eif_access(current), "fd", EIF_INTEGER) = fd;

		/* we need to initialize the local port field if bind was called
		 * previously to the connect (by the client) then localport field
		 * will already be initialized. */
	if (localport == 0) {
			/* Now that we're a connected socket, let's extract the port number
			 * that the system chose for us and store it in the Socket object. */
		u_short port;
		int len = SOCKETADDRESS_LEN(him);
		if (getsockname(fd, (struct sockaddr *)him, &len) == -1) {
			if (WSAGetLastError() == WSAENOTSOCK) {
				eraise("Socket closed", EN_PROG);
			} else {
				eraise("getsockname failed", EN_PROG);
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
		rv = net_bindV6(&v6bind);
		if (rv != -1) {
				/* check if the fds have changed */
			if (v6bind.ipv4_fd != fd) {
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
		rv = net_bind(fd, (struct sockaddr *)him, SOCKETADDRESS_LEN(him));
	}

	if (rv == -1) {	
		eraise("bind error", EN_PROG);
		return;
	}

		/* intialize the local port */
	if (localport == 0) {
			/* Now that we're a bound socket, let's extract the port number
			 * that the system chose for us and store it in the Socket object. */
		int len = SOCKETADDRESS_LEN(him);
		u_short port;
		fd = him->him.sa_family == AF_INET? fd: fd1;

		if ((rv=getsockname(fd, (struct sockaddr *)him, &len)) == -1) {
			eif_net_check(rv);
			return;
		}
		port = ntohs ((u_short) GET_PORT (him));
		eif_field (eif_access(current), "the_local_port", EIF_INTEGER) = port;
	} else {
		eif_field (eif_access(current), "the_local_port", EIF_INTEGER) = localport;
	}
}

void en_socket_stream_listen (EIF_OBJECT current, EIF_POINTER sockaddr, EIF_INTEGER count) {
	int fd, fd1;
	SOCKETADDRESS *addr;
	int ipv6_supported;
	int res;

	EIF_NET_INITIALIZE;

	addr = (SOCKETADDRESS*) sockaddr;
	ipv6_supported = en_ipv6_available();

	fd = eif_field (eif_access(current), "fd", EIF_INTEGER);

	if (addr->him.sa_family == AF_INET || IN6ADDR_ISANY(&addr->him6)) {
			/* listen on v4 */
		if ((res=listen(fd, count)) == -1) {
			eif_net_check(res);
		}
	} else {
		net_socket_close(fd);
		eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
	}

	if (ipv6_supported) {
		fd1 = eif_field (eif_access(current), "fd1", EIF_INTEGER);
		if (addr->him.sa_family == AF_INET6 || addr->him4.sin_addr.s_addr == INADDR_ANY) {
				/* listen on v6 */
			if ((res=listen(fd1, count)) == -1) {
				eif_net_check(res);
			}
		} else {
			net_socket_close(fd1);
			eif_field (eif_access(current), "fd", EIF_INTEGER) = -1;
		}
	}
}



EIF_INTEGER en_socket_stream_accept (EIF_OBJECT current, SOCKETADDRESS *him, EIF_INTEGER timeout) {

	int fd=-1, fd1=-1;
	int len;
	SOCKET accepted;

	EIF_NET_INITIALIZE;

	fd = eif_field (eif_access(current), "fd", EIF_INTEGER);
	fd1 = eif_field (eif_access(current), "fd1", EIF_INTEGER);

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
			eraise("Accept timed out", EN_PROG);
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
			eraise("select failed", EN_PROG);
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
			ret = net_timeout(fd, timeout);
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
	}

	accepted = check_socket_bounds(accept(fd, (struct sockaddr *)him, &len));
	if (accepted == INVALID_SOCKET) {
		eif_net_check ((int)accepted);
		return -1;
	} else {
		return (int)accepted;
	}
}

void en_socket_close(int fd, int fd1) {
	if (fd != -1) {
		net_socket_close(fd);
	}
	if (fd1 != -1) {
		net_socket_close(fd1);
	}
}
