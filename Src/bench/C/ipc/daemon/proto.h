/*

 #####   #####    ####    #####   ####           #    #
 #    #  #    #  #    #     #    #    #          #    #
 #    #  #    #  #    #     #    #    #          ######
 #####   #####   #    #     #    #    #   ###    #    #
 #       #   #   #    #     #    #    #   ###    #    #
 #       #    #   ####      #     ####    ###    #    #

	Some structures and defines used to ensure protocol.
*/

#ifndef _proto_h_
#define _proto_h_

#include "request.h"
#include "stream.h"

/* The daemon flags are used to control the communication parameters with
 * the remote client (workbench).
 */
struct d_flags {				/* Daemon flags (protocol with client) */
	unsigned int d_rqst;		/* Number of requests proceeded */
	unsigned int d_sent;		/* Number of requests sent */
	STREAM *d_cs;				/* Connected stream with ewb */
	STREAM *d_as;				/* Connected stream with application */
	int d_ewb;					/* Workbench pid */
	int d_app;					/* Application pid */
};

#define rqstcnt		d_data.d_rqst
#define rqstsent	d_data.d_sent

extern struct d_flags d_data;	/* Global daemon's status */

/* Routine declarations */
extern void rqsthandle();			/* General request processor */
extern void apphandle();			/* Handle messages from application */
extern void send_packet();			/* Send an asnwer to client */
extern int recv_packet();			/* Receive data from client */

#endif
