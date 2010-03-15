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
	Unix domain specifics
*/

#ifdef __VMS	/* resolve module name clash with .../C/run-time/local.c */
#pragma module NET_LOCAL
#endif /* __VMS */

#include "eif_config.h"
#include "eif_portable.h"	/* required for VMS, recommended for all */ 

#if defined EIF_VMS || defined VXWORKS
    /* This module just won't compile under those platforms; give it up now. */
int net_local_is_empty = 0;

#else /* EIF_VMS */

#include <sys/types.h>
#ifdef I_SYS_TIME
#include <sys/time.h>
#endif
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
#ifdef I_SYS_UN
#include <sys/un.h>
#endif

#include <string.h>

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
