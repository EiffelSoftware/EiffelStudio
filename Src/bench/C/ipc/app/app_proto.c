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
#include "com.h"
#include "stream.h"
#include "transfer.h"

#ifdef THE_REAL_THING
#include "debug.h"
#include "except.h"
#include "server.h"
#include "interp.h"
#include "stack.h"
#endif
public void greetings();	/* For tests */

public int rqstcnt = 0;				/* Request count */

private void process_request();		/* Dispatch request processing */
private void inspect();				/* Object inspection */

/*
 * Handling requests.
 */

public void rqsthandle(s)
int s;
{
	/* Given a connected socket, wait for a request and process it */
	
	Request rqst;		/* The request we are waiting for */

#ifdef THE_REAL_THING
	if (-1 == recv_packet(s, &rqst))		/* Get request */
		return;
#endif

	process_request(s, &rqst);		/* Process the received request */
}

private void process_request(s, rqst)
int s;						/* The connected socket */
Request *rqst;				/* The received request to be processed */
{
	/* Process the received request */

#define arg_1	rqst->rq_opaque.op_first
#define arg_2	rqst->rq_opaque.op_second
#define arg_3	rqst->rq_opaque.op_third

#ifdef THE_REAL_THING
	switch (rqst->rq_type) {
	case INSPECT:					/* Object inspection */
		inspect(s, &rqst->rq_opaque);
		break;
	case DUMP:						/* General stack dump request */
		send_stack(s, arg_1);
		break;
	case MOVE:						/* Change active routine */
		dmove(arg_1);
		break;
	case BREAK:						/* Add/delete breakpoints */
		dsetbreak(arg_1, (uint32) arg_3, arg_2);
		break;
	case RESUME:					/* Resume execution */
		dstatus(arg_1);				/* Debugger status (DX_STEP, DX_NEXT,..) */
		(void) rem_input(s);		/* Stop selection -> exit listening loop */
		break;
	case QUIT:						/* Die, immediately */
		exit(0);
	case KPALIVE:					/* Dummy request for connection checks */
		break;
	}
#else
	greetings(s);
#endif

#undef arg_1
#undef arg_2
#undef arg_3
}

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
		add_log(1, "SYSERR send: %m (%e)");
		fprintf(stderr, "cannot send request\n");
		exit(1);
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

public void greetings(s)
int s;
{
	/* Application's hello to workbench */

	char test[100];
	char *got;
	STREAM *sp = stream_by_fd[s];

	tpipe(sp);
	got = tread((int *) 0);
	printf("Message we got: %s\n", got);
	sprintf(test, "and this is a reply to '%s'%c", got, '\0');
	free(got);
	twrite(test, strlen(test));
}

#ifdef THE_REAL_THING

public void stop_rqst(s)
int s;
{
	/* Send a stop request, using the Where structure to give the program
	 * current location. We also indicate why the program stopped and set
	 * a proper exception tag if that is the reason we stopped.
	 */

	Request rqst;			/* XDR request built */
	struct where wh;		/* Where did the program stop? */

#define st_status	rq_stop.st_why.op_first
#define st_excode	rq_stop.st_why.op_second
#define st_wh		rq_stop.st_where

	rqst.rq_type = STOPPED;				/* Stop request */
	rqst.st_status = d_cxt.pg_status;	/* Why we stopped */
	rqst.rq_stop.st_tag = "";			/* No exception tag by default */

	/* If we stopped because an exception has occurred, also give the
	 * exception code.
	 */
	switch (d_cxt.pg_status) {
	case PG_RAISE:						/* Explicitely raised exception */
	case PG_VIOL:						/* Implicitely raised exception */
		rqst.st_excode = echval;		/* Exception code */
		if (echtg != (char *) 0)		/* XDR might not like a null pointer */
			rqst.rq_stop.st_tag = echtg;	/* Exception tag computed */
	}

	ewhere(&wh);			/* Find out where we are */
	rqst.st_wh.wh_name = wh.wh_name;		/* Feature name */
	rqst.st_wh.wh_obj = (long) wh.wh_obj;	/* (char *) -> long for XDR */
	rqst.st_wh.wh_origin = wh.wh_origin;	/* Written where? */
	rqst.st_wh.wh_type = wh.wh_type;		/* Dynamic type */
	rqst.st_wh.wh_offset = wh.wh_offset;	/* Offset in byte code */

#undef st_status
#undef st_excode
#undef st_where

	send_packet(s, &rqst);	/* Send stopped notification */
}

private void inspect(s, what)
int s;
Opaque *what;		/* Generic structure describing request */
{
	/* Inspect an object and return its tagged out form back to ewb. The
	 * opaque structure describes the object we want. Note that the address
	 * is stored as a long, because XDR cannot pass pointers (without also
	 * sending the information referred to by this pointer).
	 */

	char *out;				/* Buffer where out form is stored */
	struct item *val;		/* Value in operational stack */

	switch (what->op_first) {		/* First value describes request */
	case IN_ADDRESS:				/* Address inspection */
		out = dview((char *) what->op_third);	/* long -> (char *) */
		break;
	case IN_LOCAL:					/* Local inspection */
		val = ivalue(IV_LOCAL, what->op_second);
		break;
	case IN_ARG:					/* Argument inspection */
		val = ivalue(IV_ARG, what->op_second);
		break;
	case IN_CURRENT:				/* Value of Current */
		val = ivalue(IV_CURRENT);
		break;
	case IN_RESULT:					/* Value of Result */
		val = ivalue(IV_RESULT);
	default:
		panic("BUG inspect");
	}

	if (what->op_first != IN_ADDRESS)	/* Not an address request */
		out = simple_out(val);			/* May be a simple type */

	/* Now we got a string, holding the appropriate representation of the
	 * object. Send it to the remote process verbatim and free it.
	 */
	
	twrite(out, strlen(out));
	free(out);
}

#endif /* THE_REAL_THING */

