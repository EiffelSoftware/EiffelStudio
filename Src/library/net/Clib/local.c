/*
	Unix domain specifics
*/

#include "eif_config.h"

#ifdef EIF_VMS
    /* This module just won't compile under VMS; give it up now. */
int net_local_is_empty = 0;

#else /* EIF_VMS */

#include <sys/types.h>
#include <sys/time.h>
#include <errno.h>
#ifndef BSD
#define BSD_COMP
#endif
#include <sys/ioctl.h>
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
#include <sys/un.h>

#include <string.h>

#include "eif_bitmask.h"

EIF_INTEGER unix_address_size()
	/*x Size of unix domain address data structure */
{
	return (EIF_INTEGER) sizeof(struct sockaddr_un);
}

void set_unix_family(EIF_POINTER add, EIF_INTEGER family)
	/*x set the unix domain socket family (?!) */
{
	((struct sockaddr_un *) add)->sun_family = (u_short) family;
}

EIF_INTEGER get_unix_family(EIF_POINTER add)
	/*x get the unix domain socket family (?!) */
{
	return (EIF_INTEGER) ((struct sockaddr_un *) add)->sun_family;
}

void set_unix_sock_path(EIF_POINTER add, EIF_POINTER path)
	/*x set the unix domain socket path name */
{
	memcpy(((struct sockaddr_un *)add)->sun_path, (char *) path, strlen((char *) path));
}

EIF_POINTER get_unix_sock_path(EIF_POINTER add)
	/*x get the unix domain socket path name */
{
	return (EIF_POINTER) ((struct sockaddr_un *)add)->sun_path;
}

#endif  /* EIF_VMS */
