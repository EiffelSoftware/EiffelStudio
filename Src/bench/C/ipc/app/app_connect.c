/*

  ####    ####   #    #  #    #  ######   ####    #####           ####
 #    #  #    #  ##   #  ##   #  #       #    #     #            #    #
 #       #    #  # #  #  # #  #  #####   #          #            #
 #       #    #  #  # #  #  # #  #       #          #     ###    #
 #    #  #    #  #   ##  #   ##  #       #    #     #     ###    #    #
  ####    ####   #    #  #    #  ######   ####      #     ###     ####

	Connection with daemon (via named socket).
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "rt_err_msg.h"
#include <sys/types.h>
#include "eif_logfile.h"
#include <errno.h>
#include <stdio.h>

#ifdef HAS_SOCKET
#ifdef I_SYS_SOCKET
#include "sys/socket.h"
#endif
#include <netdb.h>
#endif

#ifdef I_SYS_UN
#include <sys/un.h>
#endif

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#define MAXPATH	108				/* Maximum path length */

#ifndef I_SYS_UN
struct sockaddr_un {			/* Definition of UNIX IPC domain */
	short sun_family;			/* AF_UNIX */
	char sun_path[108];			/* Path name */
};
#endif
	
rt_public int ised;				/* Socket used to talk with the ISE daemon */

rt_private struct sockaddr_un myaddr_un;	/* For local socket address */
rt_private struct sockaddr_un peeraddr_un;	/* For peer socket address */

rt_private char spath[MAXPATH];	/* The named socket location */

extern int errno;
extern char *getenv(const char *);

rt_private void compute_sock_name(void)
{
	char *name;

	name = getenv("ISED");
	if (name == (char *) 0) {
		print_err_msg(stderr, "variable ISED is not set\n");
		exit(1);
	}
	strncpy(spath, name, MAXPATH - 1);
}

rt_public void connect_daemon(void)
{
	/* Connect to daemon */

	int addrlen = sizeof(struct sockaddr_un);

	peeraddr_un.sun_family = AF_UNIX;
	compute_sock_name();
	strcpy(peeraddr_un.sun_path, spath);
	ised = socket(AF_UNIX, SOCK_STREAM, 0);
	if (ised == -1) {
		perror("socket");
		exit(1);
	}
	if (-1 == connect(ised, &peeraddr_un, strlen(peeraddr_un.sun_path) +
			sizeof(peeraddr_un.sun_family))) {
		perror("connect");
		exit(1);
	}
}

