/*

 #####   #####    ####    #####   ####            ####
 #    #  #    #  #    #     #    #    #          #    #
 #    #  #    #  #    #     #    #    #          #
 #####   #####   #    #     #    #    #   ###    #
 #       #   #   #    #     #    #    #   ###    #    #
 #       #    #   ####      #     ####    ###     ####

	Protocol handling. Send requests and wait for answers.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_err_msg.h"
#include <sys/types.h>

#ifdef EIF_WIN32
#include <signal.h>
#else
#include <sys/signal.h>
#endif

#include "request.h"
#include "rqst_idrs.h"
#include "com.h"
#include "stream.h"
#include "transfer.h"
#include "ewbio.h"
#include "stack.h"
#include "idrf.h"
#include "eif_debug.h"
#include "eif_except.h"
#include "server.h"
#include "eif_interp.h"
#include "select.h"
#include "eif_hector.h"
#include "eif_bits.h"
#include "eif_eiffel.h"
#include "eif_memory.h"
#include "eif_debug.h"
#include "proto.h"

#ifdef EIF_WIN32
#include "stream.h"
extern STREAM *sp;
#endif

extern void set_breakpoint_number(int num);	/* Sets the breakpoint interrupt number */
rt_public int rqstcnt = 0;				/* Request count */
rt_private char gc_stopped;

#ifdef EIF_WIN32
rt_private void process_request(STREAM *s, Request *rqst);	/* Dispatch request processing */
rt_private void inspect(STREAM *s, Opaque *what);			/* Object inspection */
rt_private void adopt(EIF_LPSTREAM s, Opaque *what);		/* Adopt object */
rt_private void ipc_access(EIF_LPSTREAM s, Opaque *what);	/* Access object through hector */
rt_private void wean(EIF_LPSTREAM s, Opaque *what);			/* Wean adopted object */
rt_private void load_bc(int slots, int amount);				/* Load byte code information */
rt_private void obj_inspect(EIF_OBJ object);
rt_private void bit_inspect(EIF_OBJ object);
rt_private void string_inspect(EIF_OBJ object);				/* String object inspection */
rt_private void once_inspect(EIF_LPSTREAM s, Opaque *what);	/* Once routines inspection */
#else
rt_private void process_request(int s, Request *rqst);		/* Dispatch request processing */
rt_private void inspect(int s, Opaque *what);				/* Object inspection */
rt_private void adopt(int s, Opaque *what);					/* Adopt object */
rt_private void ipc_access(int s, Opaque *what);			/* Access object through hector */
rt_private void wean(int s, Opaque *what);					/* Wean adopted object */
rt_private void load_bc(int slots, int amount);				/* Load byte code information */
rt_private void obj_inspect(EIF_OBJ object);
rt_private void bit_inspect(EIF_OBJ object);
rt_private void string_inspect(EIF_OBJ object);				/* String object inspection */
rt_private void once_inspect(int s, Opaque *what);			/* Once routines inspection */
#endif

rt_private long sp_lower, sp_upper; /* Special objects' bounds to be inspected */
rt_private IDRF idrf;				/* IDR filter for serialize communications */

extern char *simple_out(struct item *);	/* Out routine for simple time (from run-time) */

/*
 * IDR protocol initialization.
 */

rt_public void prt_init(void)
{
	if (-1 == idrf_create(&idrf, IDRF_SIZE))
		fatal_error("cannot initialize streams");		/* Run-time routine */
}

/*
 * Handling requests.
 */

#ifdef EIF_WIN32
rt_public void arqsthandle(STREAM *s)
#else
rt_public void arqsthandle(int s)
#endif
{
	/* Given a connected socket, wait for a request and process it. Since it
	 * is an error at the application level to not be able to receive a packet,
	 * recv_packet will exit via esdie() as soon as the connection is broken.
	 */

	Request rqst;		/* The request we are waiting for */

	Request_Clean (rqst); /* zero recognized as non initialized -- Didier */

#ifdef EIF_WIN32
	recv_packet(s, &rqst, FALSE);		/* Get request */
#else
	recv_packet(s, &rqst);		/* Get request */
#endif

	process_request(s, &rqst);	/* Process the received request */

#ifdef USE_ADD_LOG
		add_log(9, "arqsthandle done");
#endif
}

#ifdef EIF_WIN32
rt_private void process_request(STREAM *s, Request *rqst)
#else
rt_private void process_request(int s, Request *rqst)
#endif
      						/* The connected socket */
              				/* The received request to be processed */
{
	/* Process the received request */

#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[s];
#endif

#define arg_1	rqst->rq_opaque.op_first
#define arg_2	rqst->rq_opaque.op_second
#define arg_3	rqst->rq_opaque.op_third

#ifdef USE_ADD_LOG
	add_log(9, "received request type %d", rqst->rq_type);
#endif

	switch (rqst->rq_type) {
	case INSPECT:					/* Object inspection */
#ifdef EIF_WIN32
		inspect (sp, &rqst->rq_opaque);
#else
		inspect(writefd(sp), &rqst->rq_opaque);
#endif
		break;
	case SP_LOWER:					/* Bounds for special object inspection */
		sp_lower = arg_3;
		break;
	case SP_UPPER:					/* Bounds for special object inspection */
		sp_upper = arg_3;
		break;
	case DUMP:						/* General stack dump request */
#ifdef EIF_WIN32
		send_stack(sp, arg_1);
#else
		send_stack(writefd (sp), arg_1);
#endif
		break;
	case MOVE:						/* Change active routine */
		dmove(arg_1);
		break;
	case BREAK:						/* Add/delete breakpoints */
		dsetbreak(arg_1, (uint32) arg_3, arg_2);
		break;
	case RESUME:					/* Resume execution */
		if (!gc_stopped) gc_run();
		set_breakpoint_number (arg_2);
		dstatus(arg_1);				/* Debugger status (DX_STEP, DX_NEXT,..) */

#ifdef EIF_WIN32
#ifdef USE_ADD_LOG
		add_log(9, "RESUME");
		if ((void (*)()) 0 == rem_input(sp))
			add_log(12, "rem_input: %s (%s)", s_strerror(), s_strname());
#else
		(void) rem_input(sp);		/* Stop selection -> exit listening loop */
#endif
#else
#ifdef USE_ADD_LOG
		add_log(9, "RESUME");
		if ((void (*)()) 0 == rem_input(s))
			add_log(12, "rem_input: %s (%s)", s_strerror(), s_strname());
#else
		(void) rem_input(s);		/* Stop selection -> exit listening loop */
#endif
#endif
		break;
	case QUIT:						/* Die, immediately */
		esdie(0);
	case HELLO:							/* Initial handshake */
#ifdef EIF_WIN32
		send_ack(sp, AK_OK);	/* Ok, we're up */
#else
		send_ack(writefd(sp), AK_OK);	/* Ok, we're up */
#endif
		break;
	case KPALIVE:					/* Dummy request for connection checks */
		break;
	case LOAD:						/* Load byte code information */
		load_bc(arg_1, arg_2);
		break;
	case ADOPT:						/* Adopt object */
#ifdef EIF_WIN32
		adopt(sp, &rqst->rq_opaque);
#else
		adopt(writefd(sp), &rqst->rq_opaque);
#endif
		break;
	case ACCESS:					/* Access object through hector */
#ifdef EIF_WIN32
		ipc_access(sp, &rqst->rq_opaque);
#else
		ipc_access(writefd(sp), &rqst->rq_opaque);
#endif
		break;
	case WEAN:						/* Wean adopted object */
#ifdef EIF_WIN32
		wean(sp, &rqst->rq_opaque);
#else
		wean(writefd(sp), &rqst->rq_opaque);
#endif
		break;
	case ONCE:						/* Once routines inspection */
#ifdef EIF_WIN32
		once_inspect(sp, &rqst->rq_opaque);
#else
		once_inspect(writefd(sp), &rqst->rq_opaque);
#endif
		break;
	case INTERRUPT_OK:				/* Stop execution and send call stack */
#ifdef EIF_WIN32
		(void) rem_input(sp);		/* exit listening loop */
#else
		(void) rem_input(s);		/* exit listening loop */
#endif
		dbreak(PG_INTERRUPT);
		break;
	case INTERRUPT_NO:				/* Resume execution with no further ado */
#ifdef EIF_WIN32
		(void) rem_input(sp);		/* exit listening loop */
#else
		(void) rem_input(s);		/* exit listening loop */
#endif
		break;
	}

#undef arg_1
#undef arg_2
#undef arg_3
}

/*
 * Sending requests - Receiving answers
 */

#ifdef EIF_WIN32
rt_public void send_packet(STREAM *s, Request *rqst)
#else
rt_public void send_packet(int s, Request *rqst)
#endif
      				/* The connected socket */
              		/* The request to be sent */
{
	/* Sends an answer to the client */

	rqstcnt++;			/* One more request sent to daemon */
	idrf_pos(&idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&idrf.i_encode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unable to serialize request %d", rqst->rq_type);
#endif
		print_err_msg(stderr, "Cannot serialize request, %d\n", rqst->rq_type);
		esdie(1);
	}

	/* Send the answer and propagate error report */
	if (-1 == net_send(s, idrs_buf(&idrf.i_encode), IDRF_SIZE)) {
#ifdef USE_ADD_LOG
		add_log(1, "SYSERR send: %m (%e)");
#endif
		print_err_msg(stderr, "cannot send request\n");
		signal (SIGABRT, SIG_DFL);
#ifdef SIGQUIT
		signal (SIGQUIT, SIG_DFL);
#endif
		abort ();
	}

#ifdef DEBUG
	trace_request("sent", rqst);
#endif
}

#ifdef EIF_WIN32
rt_public int recv_packet(STREAM *s, Request *dans, BOOL reset)
#else
rt_public int recv_packet(int s, Request *dans)
#endif
      				/* The connected socket */
              		/* The daemon's answer */
{
	/* Wait for an answer and fill in the Request structure, then de-serialize
	 * it. If an error occurs, exit immediately. The signature has to be 'int',
	 * since some shared functions do expect that signature. However, since
	 * no error recovery will be possible at the application level once the
	 * debugging link to ised is broken, it is wise to exit by calling esdie().
	 */

	/* Wait for request */
#ifdef EIF_WIN32
	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE, reset))
#else
	if (-1 == net_recv(s, idrs_buf(&idrf.i_decode), IDRF_SIZE))
#endif
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

#ifdef EIF_WIN32
rt_public void stop_rqst(STREAM *s)
#else
rt_public void stop_rqst(int s)
#endif
{
	/* Send a stop request, using the Where structure to give the program
	 * current location. We also indicate why the program stopped and set
	 * a proper exception tag if that is the reason we stopped.
	 */
	EIF_GET_CONTEXT
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
	if (wh.wh_type == -1) {	/* Could not compute position */
		rqst.st_wh.wh_name = "Unknown";			/* Feature name */
		rqst.st_wh.wh_obj = (long) 0;			/* (char *) -> long for XDR */
		rqst.st_wh.wh_origin = 0;				/* Written where? */
		rqst.st_wh.wh_type = 0;					/* Dynamic type */
		rqst.st_wh.wh_offset = 0;				/* Offset in byte code */
	}
	else {
		rqst.st_wh.wh_name = wh.wh_name;		/* Feature name */
		rqst.st_wh.wh_obj = (long) wh.wh_obj;	/* (char *) -> long for XDR */
		rqst.st_wh.wh_origin = wh.wh_origin;	/* Written where? */
		rqst.st_wh.wh_type = wh.wh_type;		/* Dynamic type */
		rqst.st_wh.wh_offset = wh.wh_offset;	/* Offset in byte code */
	}

#undef st_status
#undef st_extag
#undef st_excode
#undef st_where

	send_packet(s, &rqst);	/* Send stopped notification */
	EIF_END_GET_CONTEXT
}

#ifdef EIF_WIN32
rt_private void inspect(STREAM *s, Opaque *what)
#else
rt_private void inspect(int s, Opaque *what)
#endif
             		/* Generic structure describing request */
{
	/* Inspect an object and return its tagged out form back to ewb. The
	 * opaque structure describes the object we want. Note that the address
	 * is stored as a long, because XDR cannot pass pointers (without also
	 * sending the information referred to by this pointer).
	 */

	char *out;				/* Buffer where out form is stored */
	struct item *val;		/* Value in operational stack */
	char *addr;				/* Address of EIF_OBJ */


	switch (what->op_first) {		/* First value describes request */
	case IN_H_ADDR:					/* Hector address inspection */
		addr = (char *) what->op_third;		/* long -> (char *) */
		obj_inspect((EIF_OBJ)(&(eif_access((EIF_OBJ) addr))));
		return;
	case IN_BIT_ADDR:				/* Bit address inspection */
		addr = (char *) what->op_third;		/* long -> (char *) */
		bit_inspect((EIF_OBJ) &addr);
		return;
	case IN_STRING_ADDR:		/* String object inspection (hector addr) */
		addr = (char *) what->op_third;		/* long -> (char *) */
		string_inspect((EIF_OBJ)(&(eif_access((EIF_OBJ) addr))));
		return;
	case IN_ADDRESS:				/* Address inspection */
		addr = (char *) what->op_third;		/* long -> (char *) */
		out = dview((EIF_OBJ) &addr);
		break;
	case IN_LOCAL:					/* Local inspection */
		val = ivalue(MTC IV_LOCAL, what->op_second);
		break;
	case IN_ARG:					/* Argument inspection */
		val = ivalue(MTC IV_ARG, what->op_second);
		break;
	case IN_CURRENT:				/* Value of Current */
		val = ivalue(MTC IV_CURRENT,0);		/* %%zs misuse, added ",0" */
		break;
	case IN_RESULT:					/* Value of Result */
		val = ivalue(MTC IV_RESULT,0);		/* %%zs misuse, added ",0" */
		break;
	default:
		eif_panic("BUG inspect");
	}

	if (what->op_first != IN_ADDRESS)	/* Not an address request */
		out = simple_out(val);			/* May be a simple type */

	/* Now we got a string, holding the appropriate representation of the
	 * object. Send it to the remote process verbatim and free it.
	 */

	twrite(out, strlen(out));
	free(out);
}

#ifdef EIF_WIN32
rt_private void once_inspect(EIF_LPSTREAM s, Opaque *what)
#else
rt_private void once_inspect(int s, Opaque *what)
#endif
					/* The connected socket */
             		/* Generic structure describing request */
{
	/* Check whether a once routine has already been called. In this case
	 * its result may be ask by ewb.
	 */

	uint32 body_id = (uint32) what->op_third;	/* Body_id of once routine */

	switch (what->op_first) {		/* First value describes request */
	case OUT_CALLED:				/* Has once routine already been called? */
		if (onceitem(body_id) != (uint32 *)0)	/* body_id found in once list*/
			twrite("true", 4);
		else
			twrite("false", 5);
		break;
	case OUT_RESULT:			/* Result of already called once function */
		send_once_result(s, body_id, what->op_second);	/* Send result back to ewb */
														/* the last argument is the number of 
														/* arguments to be passed */
		break;
	default:
		eif_panic("BUG once inspect");
	}
}

#ifdef EIF_WIN32
rt_private void adopt(EIF_LPSTREAM s, Opaque *what)
#else
rt_private void adopt(int s, Opaque *what)
#endif
             		/* Generic structure describing request */
{
	/* Adopt an object and return its hector address back to ewb. The
	 * opaque structure describes the object. Note that the address
	 * is stored as a long, because XDR cannot pass pointers (without also
	 * sending the information referred to by this pointer).
	 */

	char *physical_addr;	/* Address of unprotected object */
	char hector_addr[20];	/* Buffer where indirection address is stored */

	physical_addr = (char *) what->op_third;
	sprintf(hector_addr, "0x%lX", eif_adopt((EIF_OBJ) &physical_addr));
	twrite(hector_addr, strlen(hector_addr));
}

#ifdef EIF_WIN32
rt_private void ipc_access(EIF_LPSTREAM s, Opaque *what)
#else
rt_private void ipc_access(int s, Opaque *what)
#endif

             		/* Generic structure describing request */
{
	/* Access an object through hector and return its physical address
	 * back to ewb. The opaque structure describes the object. Note
	 * that the address is stored as a long, because XDR cannot pass
	 * pointers (without also sending the information referred to by
	 * this pointer).
	 */

	char physical_addr[20];	/* Address of unprotected object */
	char *hector_addr;		/* Hector address with indirection */

	hector_addr = (char *) what->op_third;
	sprintf(physical_addr, "0x%lX", eif_access((EIF_OBJ) hector_addr));
	twrite(physical_addr, strlen(physical_addr));
}

#ifdef EIF_WIN32
rt_private void wean(EIF_LPSTREAM s, Opaque *what)
#else
rt_private void wean(int s, Opaque *what)
#endif

             		/* Generic structure describing request */
{
	/* Wean an adopted object. The opaque structure describes the object.
	 * Note that the address is stored as a long, because XDR cannot pass
	 * pointers (without also sending the information referred to by
	 * this pointer).
	 */

	char *hector_addr;		/* Hector address with indirection */

	hector_addr = (char *) what->op_third;
	eif_wean((EIF_OBJ) hector_addr);
}

rt_private void load_bc(int slots, int amount)
          		/* Number of new slots needed in the melting table */
           		/* Amount of byte codes to be downloaded */
{
	/* Upon receiving a LOAD request, the application attempts to download the
	 * byte code from the compiler. The 'slots' parameters indicates the amount
	 * of new slots for the melting table, so that we can pre-extend it once
	 * and for all. An acknowledgment is then sent back. If that extension
	 * succeeeded, we attempt to load each byte code, one by one, punctuating
	 * each loading with an acknowledgment. We stop as soon as there is an
	 * error, of course.
	 */

#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
	int s = writefd(sp);		/* Writing "socket" */
	int r = readfd(sp);			/* Reading "socket" */
#endif

	Request rqst;				/* Loading BYTECODE request */
	char *bc;					/* Location of loaded byte code */
	int i;

#ifdef USE_ADD_LOG
		add_log(9, "in load_bc slots %d amount %d", slots, amount);
#endif

	Request_Clean (rqst);
	if (-1 == dmake_room(slots)) {		/* Extend melting table */
#ifdef EIF_WIN32
		send_ack(sp, AK_ERROR);			/* Notify failure */
		return;							/* Abort procedure */
	} else
		send_ack(sp, AK_OK);				/* Extension succeeded */
#else
		send_ack(s, AK_ERROR);			/* Notify failure */
		return;							/* Abort procedure */
	} else
		send_ack(s, AK_OK);				/* Extension succeeded */
#endif

#ifdef USE_ADD_LOG
		add_log(9, "made room");
#endif

#define arg_1	rqst.rq_opaque.op_first
#define arg_2	rqst.rq_opaque.op_second

	/* The byte codes have a BYTECODE leading request giving the body index
	 * and body ID information, which is followed by a transfer request to
	 * download the byte code itself.
	 */

	for (i = 0; i < amount; i++) {		/* Now loop to get all byte codes */
#ifdef USE_ADD_LOG
		add_log(9, "in load_bc loop");
#endif
#ifdef EIF_WIN32
		recv_packet(sp, &rqst, TRUE);			/* Read BYTECODE request */
		if (rqst.rq_type != BYTECODE) {	/* Wrong request */
			send_ack(sp, AK_PROTO);		/* Protocol error */
			return;
		}
#ifdef USE_ADD_LOG
		add_log(9, "received packet BYTECODE");
#endif
		bc = tread((int *) 0);			/* Get byte code in memory */
		if (bc == (char *) 0) {			/* Not enough memory */
			send_ack(sp, AK_ERROR);		/* Notify failure */
			return;						/* And abort downloading */
		}
#ifdef USE_ADD_LOG
		add_log(9, "tread bytecode");
#endif
		drecord_bc(arg_1, arg_2, bc);	/* Place byte code in run-time tables*/
#ifdef USE_ADD_LOG
		add_log(9, "recorded bc");
#endif
		send_ack(sp, AK_OK);				/* Byte code loaded successfully */
#ifdef USE_ADD_LOG
		add_log(9, "sent ack");
#endif

#else
		recv_packet(r, &rqst);			/* Read BYTECODE request */
		if (rqst.rq_type != BYTECODE) {	/* Wrong request */
			send_ack(s, AK_PROTO);		/* Protocol error */
			return;
		}
#ifdef USE_ADD_LOG
		add_log(9, "received packet BYTECODE");
#endif
		bc = tread((int *) 0);			/* Get byte code in memory */
		if (bc == (char *) 0) {			/* Not enough memory */
			send_ack(s, AK_ERROR);		/* Notify failure */
			return;						/* And abort downloading */
		}
		drecord_bc(arg_1, arg_2, bc);	/* Place byte code in run-time tables*/
		send_ack(s, AK_OK);				/* Byte code loaded successfully */
#endif
	}

#undef arg_1
#undef arg_2
}


/*
 *		Routines for inspecting an Eiffel object.
 */

#define BUF_SIZE 512
rt_private char buffer[BUF_SIZE];

rt_private void rec_inspect(register1 char *object);
rt_private void rec_sinspect(register1 char *object);

rt_private void obj_inspect(EIF_OBJ object)
{
	uint32 flags;		/* Object flags */

	flags = HEADER(eif_access(object))->ov_flags;

	if (flags & EO_SPEC) {
		/* Special object */
		sprintf(buffer, "%s", "SPECIAL");
		twrite (buffer, strlen(buffer));
		/* Send items recursively */
		rec_sinspect(eif_access(object));
	} else {
		/* Send instance class name and object id */
		sprintf(buffer, "%s", System(flags & EO_TYPE).cn_generator);
		twrite (buffer, strlen(buffer));
		sprintf(buffer, "%ld", (flags & EO_TYPE));
		twrite (buffer, strlen(buffer));
		/* Inspect recursively `object' */
		rec_inspect(eif_access(object));
	}
}

rt_private void rec_inspect(register1 char *object)
{
	/* Inspect recursively `object''s attribute */

	register2 struct cnode *obj_desc;		/* Object type description */
	register3 long nb_attr;					/* Attribute number */
	register4 uint32 *types;				/* Attribute types */
#ifndef WORKBENCH
	register6 long **offsets;				/* Attribute offsets table */
#else
	register4 int32 *cn_attr;				/* Attribute keys */
	long offset;
#endif
	register5 int16 dyn_type;				/* Object dynamic type */
	char *o_ref;
	register7 char **names;					/* Attribute names */
	char *reference;						/* Reference attribute */
	long i;
	uint32 type, ref_flags;

	dyn_type = Dtype(object);
	obj_desc = &System(dyn_type);
	nb_attr = obj_desc->cn_nbattr;
	names = obj_desc->cn_names;
	types = obj_desc->cn_types;

#ifndef WORKBENCH
	offsets = obj_desc->cn_offsets;
#else
	cn_attr = obj_desc->cn_attr;
#endif

	/* Send the attribute number */
	sprintf(buffer, "%ld", nb_attr);
	twrite (buffer, strlen(buffer));

	for (i = 0; i < nb_attr; i++) {

		/* Send attribute name */
		sprintf(buffer, "%s", names[i]);
		twrite (buffer, strlen(buffer));

		/* Send attribute value */
		type = types[i];
#ifndef WORKBENCH
		o_ref = object + (offsets[i])[dyn_type];
#else
		CAttrOffs(offset,cn_attr[i],dyn_type);
		o_ref = object + offset;
#endif
		switch(type & SK_HEAD) {
		case SK_POINTER:
			/* Pointer attribute */
			sprintf(buffer, "POINTER");
			twrite (buffer, strlen(buffer));
			sprintf(buffer, "0x%lX", *(fnptr *)o_ref);
			twrite (buffer, strlen(buffer));
			break;
		case SK_BOOL:
			/* Boolean attribute */
			sprintf(buffer, "BOOLEAN");
			twrite (buffer, strlen(buffer));
			sprintf(buffer, "%s", (*o_ref ? "True" : "False"));
			twrite (buffer, strlen(buffer));
			break;
		case SK_CHAR:
			/* Character attribute */
			sprintf(buffer, "CHARACTER");
			twrite (buffer, strlen(buffer));
			sprintf(buffer, "%d", *o_ref);
			twrite (buffer, strlen(buffer));
			break;
		case SK_INT:
			/* Integer attribute */
			sprintf(buffer, "INTEGER");
			twrite (buffer, strlen(buffer));
			sprintf(buffer, "%ld", *(long *)o_ref);
			twrite (buffer, strlen(buffer));
			break;
		case SK_FLOAT:
			/* Real attribute */
			sprintf(buffer, "REAL");
			twrite (buffer, strlen(buffer));
			sprintf(buffer, "%g", *(float *)o_ref);
			twrite (buffer, strlen(buffer));
			break;
		case SK_DOUBLE:
			/* Double attribute */
			sprintf(buffer, "DOUBLE");
			twrite (buffer, strlen(buffer));
			sprintf(buffer, "%.17g", *(double *)o_ref);
			twrite (buffer, strlen(buffer));
			break;
		case SK_BIT:
			sprintf(buffer, "BIT");
			twrite (buffer, strlen(buffer));
			{
				char *str = b_out(o_ref);
				sprintf(buffer, "%s", str);
				twrite (buffer, strlen(buffer));
				xfree(str);
			}
			break;
		case SK_EXP:
			/* Expanded attribute */
			sprintf(buffer, "expanded");
			twrite (buffer, strlen(buffer));
			sprintf(buffer, "%ld", Dtype(o_ref));
			twrite (buffer, strlen(buffer));
			rec_inspect((char *)o_ref);
			break;
		default:
			/* Object reference */
			reference = *(char **)o_ref;
			if (0 != reference) {
				ref_flags = HEADER(reference)->ov_flags;
				if (ref_flags & EO_C) {
					sprintf(buffer, "POINTER");
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "0x%lX", reference);
					twrite (buffer, strlen(buffer));
				} else if (ref_flags & EO_SPEC) {
					/* Special object */
					sprintf(buffer, "SPECIAL");
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "0x%lX", reference);
					twrite (buffer, strlen(buffer));
					rec_sinspect (reference);
				} else {
					sprintf(buffer, "reference");
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "%ld", Dtype(reference));
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "0x%lX", reference);
					twrite (buffer, strlen(buffer));
				}
			} else {
				sprintf(buffer, "reference");
				twrite (buffer, strlen(buffer));
				sprintf(buffer, "%ld", (type & SK_DTYPE));
				twrite (buffer, strlen(buffer));
				sprintf(buffer, "Void");
				twrite (buffer, strlen(buffer));
			}
		}
	}
}

rt_private void rec_sinspect(register1 char *object)
{
	/* Inspect special object */

	union overhead *zone;		/* Object header */
	register5 uint32 flags;		/* Object flags */
	register3 long sp_index;	/* Element index */
	register4 long elem_size;	/* Element size */
	char *o_ref;
	char *reference;
	long count;					/* Element count */
	long sp_start, sp_end;		/* Bounds for inspection */
	int dt_type;

	zone = HEADER(object);
	o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
	count = *(long *) o_ref;
	elem_size = *(long *) (o_ref + sizeof(long));
	flags = zone->ov_flags;
	dt_type = (int) (flags & EO_TYPE);

	/* Send the capacity of the special object */
	sprintf(buffer, "%ld", count);
	twrite (buffer, strlen(buffer));

	/* Compute the number of items within the bounds */
	if (sp_upper < 0)				/* A negative `sp_upper' means `count' */
		sp_end = count - 1;
	else if (count > sp_upper + 1)	/* Must be truncated */
		sp_end = sp_upper;
	else							/* No need to truncate */
		sp_end = count - 1;
	if (sp_lower <= 0)				/* A negative `sp_lower' means 0 */
		sp_start = 0;
	else if (sp_lower > 0)			/* Must be truncated */
		sp_start = sp_lower;

	if (sp_start > sp_end) {		/* No item within the bounds */
		/* Send the number of items to be inspected */
		sprintf(buffer, "0");
		twrite (buffer, strlen(buffer));
	} else {
		/* Send the number of items to be inspected */
		sprintf(buffer, "%ld", sp_end - sp_start + 1);
		twrite (buffer, strlen(buffer));

		/* Send the items within the bounds */
		if (!(flags & EO_REF))
			if (flags & EO_COMP)
				for (o_ref = object + OVERHEAD + (sp_start * elem_size),
									sp_index = sp_start; sp_index <= sp_end;
									sp_index++, o_ref += elem_size) {
					sprintf(buffer, "%ld", sp_index);
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "expanded");
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "%ld", Dtype(o_ref));
					twrite (buffer, strlen(buffer));
					rec_inspect(o_ref);
				}
			else
				for (o_ref = object + (sp_start * elem_size),
									sp_index = sp_start; sp_index <= sp_end;
									sp_index++, o_ref += elem_size) {
					sprintf(buffer, "%ld", sp_index);
					twrite (buffer, strlen(buffer));
					if (dt_type == egc_sp_char) {
						sprintf(buffer, "CHARACTER");
						twrite (buffer, strlen(buffer));
						sprintf(buffer, "%d", *o_ref);
						twrite (buffer, strlen(buffer));
					} else if (dt_type == egc_sp_int) {
						sprintf(buffer, "INTEGER");
						twrite (buffer, strlen(buffer));
						sprintf(buffer, "%ld", *(long *)o_ref);
						twrite (buffer, strlen(buffer));
					} else if (dt_type == egc_sp_bool) {
						sprintf(buffer, "BOOLEAN");
						twrite (buffer, strlen(buffer));
						sprintf(buffer, "%s", (*o_ref ? "True" : "False"));
						twrite (buffer, strlen(buffer));
					} else if (dt_type == egc_sp_real) {
						sprintf(buffer, "REAL");
						twrite (buffer, strlen(buffer));
						sprintf(buffer, "%g", *(float *)o_ref);
						twrite (buffer, strlen(buffer));
					} else if (dt_type == egc_sp_double) {
						sprintf(buffer, "DOUBLE");
						twrite (buffer, strlen(buffer));
						sprintf(buffer, "%.17g", *(double *)o_ref);
						twrite (buffer, strlen(buffer));
					} else if (dt_type == egc_sp_pointer) {
						sprintf(buffer, "POINTER");
						twrite (buffer, strlen(buffer));
						sprintf(buffer, "0x%lX", *(fnptr *)o_ref);
						twrite (buffer, strlen(buffer));
					} else {
						/* Must be bit */
						sprintf(buffer, "BIT");
						twrite (buffer, strlen(buffer));
						sprintf(buffer, "%s", b_out(*(char **)o_ref));
						twrite (buffer, strlen(buffer));
					}
				}
		else
			for (o_ref = (char *) ((char **)object + sp_start),
						sp_index = sp_start; sp_index <= sp_end; sp_index++,
						o_ref = (char *) ((char **)o_ref + 1)) {
				sprintf(buffer, "%ld", sp_index);
				twrite (buffer, strlen(buffer));
				reference = *(char **)o_ref;
				if (0 == reference) {
					sprintf(buffer, "Void");
					twrite (buffer, strlen(buffer));
						/* Send "Void" twice: one for the type and */
						/* the other for the value of the item. */
					twrite (buffer, strlen(buffer));
				} else if (HEADER(reference)->ov_flags & EO_C) {
					sprintf(buffer, "POINTER");
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "0x%lX", reference);
					twrite (buffer, strlen(buffer));
				} else {
					sprintf(buffer, "reference");
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "%ld", Dtype(reference));
					twrite (buffer, strlen(buffer));
					sprintf(buffer, "0x%lX", reference);
					twrite (buffer, strlen(buffer));
				}
			}
		}
}

rt_private void bit_inspect(EIF_OBJ object)
               		/* Reference to a bit object (= BIT_REF) */
{
	sprintf(buffer, "%s", b_out(*(char **)object));
	twrite (buffer, strlen(buffer));
}

rt_private void string_inspect(EIF_OBJ object)
               		/* Reference to a string object */
{
		/* Inspect the string object to get the string value */

	register2 struct cnode *obj_desc;		/* Object type description */
	register3 long nb_attr;					/* Attribute number */
	register4 int32 *cn_attr;				/* Attribute keys */
	long offset;
	register5 int16 dyn_type;				/* Object dynamic type */
	char *o_ref;
	register7 char **names;					/* Attribute names */
	char *reference;
	long i, string_count = 0;
	char *string_area;

	reference = eif_access(object);
	dyn_type = Dtype(reference);
	obj_desc = &System(dyn_type);
	nb_attr = obj_desc->cn_nbattr;
	names = obj_desc->cn_names;
	cn_attr = obj_desc->cn_attr;

	for (i = 0; i < nb_attr; i++) {
		CAttrOffs(offset,cn_attr[i],dyn_type);
		o_ref = reference + offset;
		if (strcmp(names[i], "count") == 0) {
			string_count = *(long *) o_ref;
		} else if (strcmp(names[i], "area") == 0) {
			string_area = *(char **) o_ref;
		}
	}
	if (string_count > DEFAULT_SLICE + 1)	/* Send only the beginning of */
		string_count = DEFAULT_SLICE + 1;	/* the string if it is too big */
	twrite (string_area, string_count);
}
