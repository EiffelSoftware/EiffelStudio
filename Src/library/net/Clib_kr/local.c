#include "config.h"

#include <sys/types.h>
#include <sys/time.h>
#include <errno.h>
#ifndef BSD
#define BSD_COMP
#endif
#include <sys/ioctl.h>
#include "cecil.h"

#ifdef I_SYS_SOCKET
#include <sys/socket.h>
#include <netdb.h>
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
#include <sys/un.h>

#include "bitmask.h"

EIF_INTEGER unix_address_size ()
{
	return (EIF_INTEGER) sizeof (struct sockaddr_un);
}

void set_unix_family (add, family)
EIF_POINTER add;
EIF_INTEGER family;
{
	((struct sockaddr_un *) add)->sun_family = (u_short) family;
}

EIF_INTEGER get_unix_family (add)
EIF_POINTER add;
{
	return (EIF_INTEGER) ((struct sockaddr_un *) add)->sun_family;
}

void set_unix_sock_path (add, path)
EIF_POINTER add;
EIF_POINTER path;
{
	strncpy(((struct sockaddr_un *)add)->sun_path, (char *) path, strlen ((char *) path));
}

EIF_POINTER get_unix_sock_path (add)
EIF_POINTER add;
{
	return (EIF_POINTER) ((struct sockaddr_un *)add)->sun_path;
}

