/*

 #####   #####    ####    #####   ####            ####
 #    #  #    #  #    #     #    #    #          #    #
 #    #  #    #  #    #     #    #    #          #
 #####   #####   #    #     #    #    #   ###    #
 #       #   #   #    #     #    #    #   ###    #    #
 #       #    #   ####      #     ####    ###     ####

	Protocol handling. Send requests and wait for answers.
*/

#include "config.h"
#include "portable.h"
#include <stdio.h>		/* For error reports -- FIXME */
#include <sys/types.h>
#include "request.h"
#include "idrf.h"
#include "rqst_idrs.h"
#include "proto.h"

rt_public int rqstcnt = 0;		/* Request count, must match with daemon's one */

rt_private IDRF idrf;			/* IDR filter for serializations */

/*
 * IDR protocol initialization.
 */

rt_public void prt_init()
{
	if (-1 == idrf_create(&idrf, IDRF_SIZE))
		fatal_error("cannot initialize streams");		/* Run-time routine */
}

/*
 * Sending requests - Receiving answers
 */

rt_public void send_packet(s, rqst)
int s;				/* The connected socket */
Request *rqst;		/* The request to be sent */
{
	/* Sends an answer to the client */
	
	rqstcnt++;			/* One more request sent to daemon */
	idrf_pos(&idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&idrf.i_encode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unable to serialize request %d", rqst->rq_type);
#endif
		dexit(1);
	}

	/* Send the answer and propagate error report */
	if (-1 == net_send(s, idrs_buf(&idrf.i_encode), IDRF_SIZE)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR send: %m (%e)");
#endif
		dexit(1);
	}

#ifdef DEBUG
	trace_request("sent", rqst);
#endif
}

rt_public int recv_packet(s, dans)
int s;				/* The connected socket */
Request *dans;		/* The daemon's answer */
{
	/* Wait for an answer and fill in the Request structure, then de-serialize
	 * it. If an error occurs, return -1. Otherwise return 0;
	 */
	
	rqstcnt++;			/* One more request received */
	idrf_pos(&idrf);	/* Reposition IDR streams */

	/* Wait for request */
	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE)) {
#ifdef USE_ADD_LOG
		add_log(2, "SYSERR recv: %m (%e)");
#endif
		return -1;		/* Connection lost, probably */
	}

	/* Deserialize request */
	if (!idr_Request(&idrf.i_decode, dans)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot deserialize request");
#endif
		return -1;
	}

#ifdef DEBUG
	trace_request("got", dans);
#endif

	return 0;		/* All is ok */
}

