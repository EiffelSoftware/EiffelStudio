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
#include <sys/signal.h>
#include "request.h"
#include "rqst_idrs.h"
#include "com.h"
#include "stream.h"
#include "transfer.h"
#include "ewbio.h"
#include "stack.h"
#include "idrf.h"
#include "debug.h"
#include "except.h"
#include "server.h"
#include "interp.h"
#include "select.h"

public int rqstcnt = 0;				/* Request count */
private char gc_stopped;

private void process_request();		/* Dispatch request processing */
private void inspect();				/* Object inspection */
private void load_bc();				/* Load byte code information */

private IDRF idrf;			/* IDR filter for serialize communications */

extern char *simple_out();	/* Out routine for simple time (from run-time) */

/*
 * IDR protocol initialization.
 */

public void prt_init()
{
	if (-1 == idrf_create(&idrf, IDRF_SIZE))
		fatal_error("cannot initialize streams");		/* Run-time routine */
}

/*
 * Handling requests.
 */

public void rqsthandle(s)
int s;
{
	/* Given a connected socket, wait for a request and process it. Since it
	 * is an error at the application level to not be able to receive a packet,
	 * recv_packet will exit via esdie() as soon as the connection is broken.
	 */
	
	Request rqst;		/* The request we are waiting for */

	Request_Clean (rqst); /* zero recognized as non initialized -- Didier */
	recv_packet(s, &rqst);		/* Get request */
	process_request(s, &rqst);	/* Process the received request */
}

private void process_request(s, rqst)
int s;						/* The connected socket */
Request *rqst;				/* The received request to be processed */
{
	/* Process the received request */

	STREAM *sp = stream_by_fd[s];

#define arg_1	rqst->rq_opaque.op_first
#define arg_2	rqst->rq_opaque.op_second
#define arg_3	rqst->rq_opaque.op_third

#ifdef USE_ADD_LOG
	add_log(9, "received request type %d", rqst->rq_type);
#endif

	switch (rqst->rq_type) {
	case INSPECT:					/* Object inspection */
		inspect(writefd (sp), &rqst->rq_opaque);
		break;
	case DUMP:						/* General stack dump request */
		send_stack(writefd (sp), arg_1);
		break;
	case MOVE:						/* Change active routine */
		dmove(arg_1);
		break;
	case BREAK:						/* Add/delete breakpoints */
		dsetbreak(arg_1, (uint32) arg_3, arg_2);
		break;
	case RESUME:					/* Resume execution */
		if (!gc_stopped) gc_run();
		dstatus(arg_1);				/* Debugger status (DX_STEP, DX_NEXT,..) */
#ifdef USE_ADD_LOG
		add_log(9, "RESUME");
		if ((void (*)()) 0 == rem_input(s))
			add_log(12, "rem_input: %s (%s)", s_strerror(), s_strname());
#else
		(void) rem_input(s);		/* Stop selection -> exit listening loop */
#endif
		break;
	case QUIT:						/* Die, immediately */
		esdie(0);
	case HELLO:							/* Initial handshake */
		send_ack(writefd(sp), AK_OK);	/* Ok, we're up */
		break;
	case KPALIVE:					/* Dummy request for connection checks */
		break;
	case LOAD:						/* Load byte code information */
		load_bc(arg_1, arg_2);
		break;
	}

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
	idrf_pos(&idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&idrf.i_encode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unable to serialize request %d", rqst->rq_type);
#endif
		fprintf(stderr, "GGGGGGGcannot serialize request, %d\n", rqst->rq_type);
		esdie(1);
	}

	/* Send the answer and propagate error report */
	if (-1 == net_send(s, idrs_buf(&idrf.i_encode), IDRF_SIZE)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR send: %m (%e)");
#endif
		fprintf(stderr, "cannot send request (Didier)\n");
		signal (SIGABRT, SIG_DFL);
		signal (SIGQUIT, SIG_DFL);
		abort ();
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
	 * it. If an error occurs, exit immediately. The signature has to be 'int',
	 * since some shared functions do expect that signature. However, since
	 * no error recovery will be possible at the application level once the
	 * debugging link to ised is broken, it is wise to exit by calling esdie().
	 */
	
	/* Wait for request */
	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE))
		esdie(1);		/* Connection lost, probably */

	idrf_pos(&idrf);	/* Reposition IDR streams */

	/* Deserialize request */
	if (!idr_Request(&idrf.i_decode, dans))
		esdie(1);

#ifdef DEBUG
	trace_request("got", dans);
#endif

	return 0;		/* All is ok, for lint */
}

/*
 * Protocol specific routines
 */

public void stop_rqst(s)
int s;
{
	/* Send a stop request, using the Where structure to give the program
	 * current location. We also indicate why the program stopped and set
	 * a proper exception tag if that is the reason we stopped.
	 */

	Request rqst;			/* XDR request built */
	struct where wh;		/* Where did the program stop? */

#define st_status	rq_stop.st_why
#define st_extag	rq_stop.st_tag
#define st_excode	rq_stop.st_code
#define st_wh		rq_stop.st_where

	gc_stopped = !gc_ison();
	gc_stop();

	Request_Clean (rqst);
	rqst.rq_type = STOPPED;				/* Stop request */
	rqst.st_status = d_cxt.pg_status;	/* Why we stopped */
	rqst.st_extag = "";			/* No exception tag by default */

	/* If we stopped because an exception has occurred, also give the
	 * exception code.
	 */
	switch (d_cxt.pg_status) {
	case PG_RAISE:						/* Explicitely raised exception */
	case PG_VIOL:						/* Implicitely raised exception */
		rqst.st_excode = echval;		/* Exception code */
		if (echtg != (char *) 0)		/* XDR might not like a null pointer */
			rqst.rq_stop.st_tag = echtg;	/* Exception tag computed */
		else
			rqst.rq_stop.st_tag = "";
	}

	ewhere(&wh);			/* Find out where we are */
	rqst.st_wh.wh_name = wh.wh_name;		/* Feature name */
	rqst.st_wh.wh_obj = (long) wh.wh_obj;	/* (char *) -> long for XDR */
	rqst.st_wh.wh_origin = wh.wh_origin;	/* Written where? */
	rqst.st_wh.wh_type = wh.wh_type;		/* Dynamic type */
	rqst.st_wh.wh_offset = wh.wh_offset;	/* Offset in byte code */

#undef st_status
#undef st_extag
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

private void load_bc(slots, amount)
int slots;		/* Number of new slots needed in the melting table */
int amount;		/* Amount of byte codes to be downloaded */
{
	/* Upon receiving a LOAD request, the application attempts to download the
	 * byte code from the compiler. The 'slots' parameters indicates the amount
	 * of new slots for the melting table, so that we can pre-extend it once
	 * and for all. An acknowledgment is then sent back. If that extension
	 * succeeeded, we attempt to load each byte code, one by one, punctuating
	 * each loading with an acknowledgment. We stop as soon as there is an
	 * error, of course.
	 */

	STREAM *sp = stream_by_fd[EWBOUT];
	Request rqst;				/* Loading BYTECODE request */
	char *bc;					/* Location of loaded byte code */
	int s = writefd(sp);		/* Writing "socket" */
	int r = readfd(sp);			/* Reading "socket" */
	int i;

	Request_Clean (rqst);
	if (-1 == dmake_room(slots)) {		/* Extend melting table */
		send_ack(s, AK_ERROR);			/* Notify failure */
		return;							/* Abort procedure */
	} else
		send_ack(s, AK_OK);				/* Extension succeeded */

#define arg_1	rqst.rq_opaque.op_first
#define arg_2	rqst.rq_opaque.op_second

	/* The byte codes have a BYTECODE leading request giving the body index
	 * and body ID information, which is followed by a transfer request to
	 * download the byte code itself.
	 */

	for (i = 0; i < amount; i++) {		/* Now loop to get all byte codes */
		recv_packet(r, &rqst);			/* Read BYTECODE request */
		if (rqst.rq_type != BYTECODE) {	/* Wrong request */
			send_ack(s, AK_PROTO);		/* Protocol error */
			return;
		}
		bc = tread((int *) 0);			/* Get byte code in memory */
		if (bc == (char *) 0) {			/* Not enough memory */
			send_ack(s, AK_ERROR);		/* Notify failure */
			return;						/* And abort downloading */
		}
		drecord_bc(arg_1, arg_2, bc);	/* Place byte code in run-time tables */
		send_ack(s, AK_OK);				/* Byte code loaded successfully */
	}

#undef arg_1
#undef arg_2
}

