/*

  ####    ####   #    #  #    #  ######   ####    #####           ####
 #    #  #    #  ##   #  ##   #  #       #    #     #            #    #
 #       #    #  # #  #  # #  #  #####   #          #            #
 #       #    #  #  # #  #  # #  #       #          #     ###    #
 #    #  #    #  #   ##  #   ##  #       #    #     #     ###    #    #
  ####    ####   #    #  #    #  ######   ####      #     ###     ####

	Enables the workbench to connect/disconnect with ISE daemon.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_err_msg.h"
#include "shared.h"
#include <sys/types.h>

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

#include <ctype.h>			/* For isdigit() */
#include <stdio.h>			/* For error report */

rt_private char *name = "ewb";	/* Eiffel Work Bench -- FIXME */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_public int econnect(char *host)
           			/* The host we wish to connect to */
{
	/* This routine requests a connection to the ISE daemon. It
	 * returns the connected socket descriptor if connection is
	 * done, -1 if there was some kind of problem...
	 */

	int addrlen;					/* Size of sockaddr_in structure */
	int cs;							/* Connected socket descriptor */
	long timer;
	struct hostent *hp;				/* Pointer to host info */
	struct sockaddr_in addr;		/* For local socket address */
	struct sockaddr_in peer_addr;	/* For peer socket address */
	static struct servent *sp = 0;	/* Pointer to service info */

	/* Clear out address structures */
	memset (&addr, 0, sizeof(struct sockaddr_in));
	memset (&peer_addr, 0, sizeof(struct sockaddr_in));

	/* Initialize peer address */
	peer_addr.sin_family = AF_INET;

	/* Get host informations (daemon's host).
	 * The name can be either an Internet address like 192.54.158.1
	 * or an host name as defined in the host database.
	 */
	if (isdigit(*host)) {	/* Starts with number: Internet address */
		if (-1 == (peer_addr.sin_addr.s_addr = inet_addr(host))) {
			print_err_msg(stderr, "%s: %s is not a valid internet address\n", name, host);
			return -1;
		}
	} else {				/* Full name (alias) */
		hp = gethostbyname(host);
		if (hp == (struct hostent *) 0) {
			print_err_msg(stderr, "%s: %s not found in /etc/hosts\n", name, host);
			return -1;
		}
		peer_addr.sin_addr.s_addr = ((struct in_addr *)(hp->h_addr))->s_addr;
	}

	/* Find informations about the service used */
	if (sp == (struct servent *) 0) {	/* Do that only once */
		sp = getservbyname(SERVICE, "tcp");
		if (sp == (struct servent *) 0) {
			print_err_msg(stderr, "%s: %s not found in /etc/services\n", name, SERVICE);
			return -1;
		}
	}
	peer_addr.sin_port = sp->s_port;	/* set port for this service */

	/* Create the socket (connected one) */
	cs = socket(AF_INET, SOCK_STREAM, 0);
	if (cs == -1) {
		perror(name);
		print_err_msg(stderr, "%s: unable to create socket\n", name);
		return -1;
	}

	/* Now, try to connect to the daemon, identified by the
	 * address which was just built in peer_addr...
	 */

	if (connect(cs, &peer_addr, sizeof(struct sockaddr_in)) == -1) {
		/* This is the most expected error */
		print_err_msg(stderr, "%s: unable to connect to %s\n", name, host);
		return -1;
	}

	/* Since the connect call assigns a random address to the local
	 * end of this connection, we use getsockname to see what it assigned.
	 * Note that addrlen needs to be passed in as a pointer, because
	 * getsockname returns the actual length of the address
	 */
	addrlen = sizeof(struct sockaddr_in);
	if (getsockname(cs, &addr, &addrlen) == -1) {
		perror(name);
		print_err_msg(stderr, "%s: unable to read socket address\n", name);
		return -1;
	}

#ifdef CAN_KEEPALIVE
	/* Set SO_KEEPALIVE, in order to know if a connection
	 * broke itself (or has been suddenly broken by kill -9)
	 */
	if (-1 == setsockopt(cs, SOL_SOCKET, SO_KEEPALIVE, 0, 0)) {
		perror("setsockopt");
		print_err_msg(stderr, "%s: unable to set SO_KEEPALIVE\n", name);
		return -1;
	}
#endif

	/* Print out a startup message for the user */
	printf("Connected to %s\n", host);

	return cs;		/* All is done now */
}


rt_public int deconnect(int cs)
       			/* The connected socket */
{
	/* Close the daemon connection. Returns -1 if error, 0 otherwise */

	if (close(cs) == -1) {	/* Close connected socket */
		perror(name);
		print_err_msg(stderr, "%s: unable to close a socket (fd = %d)\n", name, cs);
		return -1;
	}

	return 0;
}

