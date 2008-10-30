#include "ipv6.h"

static EIF_BOOLEAN prefer_ipv4 = 0;

void en_set_prefer_ipv4(EIF_BOOLEAN prefer) {
    prefer_ipv4 = prefer;
}

EIF_BOOLEAN en_get_prefer_ipv4() {
    return prefer_ipv4;
}

EIF_BOOLEAN en_ipv6_available() {
    return !en_get_prefer_ipv4() && en_ipv6_supported();
}

int en_socket_address_len() {
    return sizeof(SOCKETADDRESS);
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
        // I dont' think we should provide the detailed error message 
        // user in this case except probably for EAI_NODATA - "No address associated with nodename"
        // So we just return 0 for now
	res = 0;
    } 
    return res;
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
    EIF_NET_INITIALIZE;

    if (gethostname(data, 256) == -1) {
	strcpy(data, "localhost");
    }
}
