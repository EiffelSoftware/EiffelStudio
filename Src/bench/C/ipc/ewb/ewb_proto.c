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
#include "proto.h"
#include "com.h"
#include "stream.h"
#include "ewbio.h"
#include "transfer.h"

public int rqstcnt = 0;		/* Request count, must match with daemon's one */

/*
 * Sending requests - Receiving answers
 */

public void send_packet(s, rqst)
int s;				/* The connected socket */
Request *rqst;		/* The request to be sent */
{
	/* Sends an answer to the client */
	
	rqstcnt++;			/* One more request sent to daemon */

	/* Send the answer and propagate error report */
	if (-1 == net_send(s, rqst, OUT_RQST)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR send: %m (%e)");
#endif
		dexit(1);
	}

#ifdef DEBUG
	trace_request("sent", rqst);
#endif
}

public int recv_packet(s, dans)
int s;				/* The connected socket */
Request *dans;		/* The daemon's answer */
{
	/* Wait for an answer and fill in the Request structure, then de-serialize
	 * it. If an error occurs, return -1. Otherwise return 0;
	 */
	
	/* Wait for request */
	if (-1 == net_recv(s, dans, IN_RQST))
		return -1;		/* Connection lost, probably */

#ifdef DEBUG
	trace_request("got", dans);
#endif

	return 0;		/* All is ok */
}

/*
 * Protocol specific routines
 */

public int handshake(s)
int s;
{
	/* Handshake with daemon */

	char *name;			/* Value of ISED remotely computed */

	name = recv_str(s, (int *) 0);
	if (name == (char *) 0)
		return -1;
	
	printf("ISED='%s' export ISED\n", name);

	return 0;
}

public int shell(cmd)
char *cmd;
{
	/* Run specified shell command synchronously and return its execution
	 * status (0 for ok, 1 for failure).
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];

	rqst.rq_type = CMD;
	send_packet(writefd(sp), &rqst);
	if (-1 == send_str(sp, cmd)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return 1;
	}
	recv_packet(readfd(sp), &rqst);

	return AK_OK == rqst.rq_ack.ak_type ? 0 : 1;
}

public int background(cmd)
char *cmd;
{
	/* Run specified shell command asynchronously, and return the job number
	 * attached to it. The application will be notified with an ASYNACK when
	 * the status of this job is known. The notification will include the
	 * job number, of course, so that we know which job has completed.
	 * A -1 is returned if the command cannot be launched at all.
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];

	rqst.rq_type = ASYNCMD;
	rqst.rq_opaque.op_first = rqstcnt;	/* Use request count as job number */
	send_packet(writefd(sp), &rqst);
	if (-1 == send_str(sp, cmd)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return -1;			/* Cannot launch command */
	}

	return rqst.rq_opaque.op_first;		/* The command's job number */
}

public void hello(cmd)
char *cmd;
{
	/* Application's hello to ised */

	printf("Reply we got: %s\n", 0 == shell(cmd) ? "ok" : "failed");
}

public void app(cmd)
char *cmd;
{
	/* Start application */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];

	rqst.rq_type = APPLICATION;
	send_packet(writefd(sp), &rqst);
	send_str(sp, cmd);
	recv_packet(readfd(sp), &rqst);
	printf("Status we got: %s\n",
		AK_OK == rqst.rq_ack.ak_type ? "ok" : "failed");
}

public void greetings(msg)
char *msg;
{
	/* Send a greeting message to the application */

	STREAM *sp = stream_by_fd[EWBOUT];
	char *reply;
	char mesg[100];
	int length;

	tpipe(sp);
	twrite(msg, strlen(msg));
	reply = tread(&length);
	if (reply == (char *) 0) {
		printf("transmission problem?\n");
		return;
	}
	bcopy(reply, mesg, length);
	mesg[length] = '\0';
	printf("got %d bytes: %s\n", length, mesg);
	free(reply);
}

