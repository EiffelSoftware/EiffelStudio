/*

  ####    ####   #    #  #    #  ######   ####    #####           ####
 #    #  #    #  ##   #  ##   #  #       #    #     #            #    #
 #       #    #  # #  #  # #  #  #####   #          #            #
 #       #    #  #  # #  #  # #  #       #          #     ###    #
 #    #  #    #  #   ##  #   ##  #       #    #     #     ###    #    #
  ####    ####   #    #  #    #  ######   ####      #     ###     ####

	Connection with daemon.
*/

#include "config.h"
#include "portable.h"
#include <sys/types.h>
#include "logfile.h"
#include <errno.h>
#include <stdio.h>

#ifdef HAS_SOCKET
#include <sys/socket.h>
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
	
public int ised;				/* Socket used to talk with the ISE daemon */

private struct sockaddr_un myaddr_un;	/* For local socket address */
private struct sockaddr_un peeraddr_un;	/* For peer socket address */

private char spath[MAXPATH];	/* The named socket location */

extern int errno;
extern char *getenv();

private void compute_sock_name()
{
	char *name;

	name = getenv("ISED");
	if (name == (char *) 0) {
		fprintf(stderr, "variable ISED is not set\n");
		exit(1);
	}
	strncpy(spath, name, MAXPATH - 1);
}

public void connect_daemon()
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

