/*

 ######  #####   #####    ####    #####   ####            ####
 #       #    #  #    #  #    #     #    #    #          #    #
 #####   #    #  #    #  #    #     #    #    #          #
 #       #####   #####   #    #     #    #    #   ###    #
 #       #       #   #   #    #     #    #    #   ###    #    #
 ######  #       #    #   ####      #     ####    ###     ####

	Eiffel workbench protocol-specific routines.

	Those must be in a file different from proto.c, since ewb is itself
	written in Eiffel and the run-time already has its own communication
	routines.
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

/*
 * Protocol specific routines
 */

rt_public int shell(cmd)
char *cmd;
{
	/* Run specified shell command synchronously and return its execution
	 * status (0 for ok, 1 for failure).
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];

	Request_Clean (rqst);	/* Recognized as non initialized -- Didier */ 

	rqst.rq_type = CMD;					/* Command will be run in foreground */
	send_packet(writefd(sp), &rqst);	/* Processing done by ised */
	if (-1 == send_str(sp, cmd)) {		/* Send command string */
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return 1;
	}
	recv_packet(readfd(sp), &rqst);

	return AK_OK == rqst.rq_ack.ak_type ? 0 : 1;
}

rt_public int background(cmd)
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

	Request_Clean (rqst);
	rqst.rq_type = ASYNCMD;				/* Daemon will run it in background */
	rqst.rq_opaque.op_first = rqstcnt;	/* Use request count as job number */
	send_packet(writefd(sp), &rqst);	/* Processing done by ised */
	if (-1 == send_str(sp, cmd)) {		/* Send command string */
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return -1;			/* Cannot launch command */
	}

	return rqst.rq_opaque.op_first;		/* The command's job number */
}

rt_public int app_start(cmd)
char *cmd;			/* The command string (without i/o redirection) */
{
	/* Start application under ised control and establish communication link
	 * with ewb for debugging purpose. Return 0 if ok, -1 for failure.
	 */

	Request rqst;
	STREAM *sp = stream_by_fd[EWBOUT];

	Request_Clean (rqst);
	rqst.rq_type = APPLICATION;			/* Request application start-up */
	send_packet(writefd(sp), &rqst);	/* Send request for ised processing */
	if (-1 == send_str(sp, cmd)) {		/* Send command string */
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot send command string");
#endif
		return -1;
	}
	recv_packet(readfd(sp), &rqst);		/* Acknowledgment */

	return AK_OK == rqst.rq_ack.ak_type ? 0 : -1;
}

