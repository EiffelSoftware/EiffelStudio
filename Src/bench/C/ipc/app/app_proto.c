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
#include "rt_interp.h"
#include "rt_wbench.h"
#include "select.h"
#include "eif_hector.h"
#include "eif_bits.h"
#include "eif_eiffel.h"
#include "rt_interp.h"
#include "eif_memory.h"
#include "eif_debug.h"
#include "x2c.h"	/* For macro LNGPAD */
#include "proto.h"
#include "rt_assert.h"

#ifndef WORKBENCH
This module should not be compiled in non-workbench mode
#endif

/* Unified (Windows/Unix) Stream declaration */
#ifdef EIF_WIN32
extern STREAM *sp;
#endif

rt_public int rqstcnt = 0;			/* Request count */
rt_private char gc_stopped;
rt_private IDRF idrf;				/* IDR filter for serialize communications */

#ifdef EIF_WIN32
rt_private void adopt(EIF_LPSTREAM s, Opaque *what);
#else
rt_private void adopt(int s, Opaque *what);
#endif

rt_private void process_request(eif_stream s, Request *rqst);/* Dispatch request processing */
rt_private void inspect(eif_stream s, Opaque *what);		/* Object inspection */
rt_private void ipc_access(eif_stream s, Opaque *what);		/* Access object through hector */
rt_private void wean(eif_stream s, Opaque *what);			/* Wean adopted object */
rt_private void once_inspect(eif_stream s, Opaque *what);	/* Once routines inspection */
rt_private void obj_inspect(EIF_OBJ object);
rt_private void bit_inspect(EIF_OBJ object);
rt_private void string_inspect(EIF_OBJ object);				/* String object inspection */
rt_private void load_bc(int slots, int amount);				/* Load byte code information */
rt_private long sp_lower, sp_upper;							/* Special objects' bounds to be inspected */

extern char *simple_out(struct item *);	/* Out routine for simple time (from run-time) */

/* debugging function */
extern void set_breakpoint_count(int num);	/* Sets the breakpoint interrupt number */

/* Object/local modification routines */
extern unsigned char modify_local(uint32 stack_depth, uint32 loc_type, uint32 loc_number, struct item *new_value); /* modify a local variable/ an argument */
rt_private void modify_local_variable(long arg_stack_depth, long arg_loc_type, long arg_loc_number, struct item *ip);
rt_private unsigned char modify_attr(char *object, long attr_number, struct item *new_value);
rt_private void modify_object_attribute(long arg_addr, long arg_attr_number, struct item *new_value);

/* Dynamic function evaluation */
rt_private void opush_dmpitem(struct item *item);
rt_private struct item *previous_otop = NULL;
rt_private unsigned char otop_recorded = 0;
rt_private void dynamic_evaluation(eif_stream s, int fid, int stype, int is_extern, int is_precompiled, int is_basic_type);
extern struct item *dynamic_eval(int fid, int stype, int is_extern, int is_precompiled, int is_basic_type, struct item* previous_otop); /* dynamic evaluation of a feature (while debugging) */
extern uint32 critical_stack_depth;	/* Call stack depth at which a warning is sent to the debugger to prevent stack overflows. */
extern int already_warned; /* Have we already warned the user concerning a possible stack overflow? */

/* Private Constants */
#define NO_CURRMODIF	0
#define LOCAL_ITEM		1
#define OBJECT_ATTR		2
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

rt_public void arqsthandle(eif_stream s)
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

rt_private void process_request(eif_stream s, Request *rqst)
      						/* The connected socket */
              				/* The received request to be processed */
{
	/* Process the received request */

#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[s];
#endif

static int curr_modify = NO_CURRMODIF;

#define arg_1	rqst->rq_opaque.op_first
#define arg_2	rqst->rq_opaque.op_second
#define arg_3	rqst->rq_opaque.op_third

#ifdef USE_ADD_LOG
	add_log(9, "received request type %d", rqst->rq_type);
#endif

	switch (rqst->rq_type) {
	case INSPECT:					/* Object inspection */
#ifdef EIF_WIN32
		inspect(sp, &rqst->rq_opaque);
#else
		inspect(writefd(sp), &rqst->rq_opaque);
#endif
		break;
	case SP_LOWER:					/* Bounds for special object inspection */
		sp_lower = arg_2;
		sp_upper = arg_3;
		break;
	case METAMORPHOSE:					/* Converts the top-level item on the operational stack to a reference type */
		metamorphose_top();
		break;
	case DUMP_VARIABLES:
#ifdef EIF_WIN32
		send_stack_variables(sp, arg_1);
#else
		send_stack_variables(writefd (sp), arg_1);
#endif
		break;
	case DUMP:						/* General stack dump request */
#ifdef EIF_WIN32
		send_stack(sp, (uint32) arg_1); /* Since we convert int -> uint32, passing -1 will inspect the whole stack. */
#else
		send_stack(writefd (sp), (uint32) arg_1);
#endif
		break;
	case DYNAMIC_EVAL: /* arg_1 = feature_id / arg2=static_type / arg3=is_external / arg4=is_precompiled / arg5=is_basic_type*/
#ifdef EIF_WIN32
		dynamic_evaluation(sp, arg_1, arg_2, arg_3 & 1, (arg_3 >> 1) & 1, (arg_3 >> 2) & 1);
#else
		dynamic_evaluation(writefd (sp), arg_1, arg_2, arg_3 & 1, (arg_3 >> 1) & 1, (arg_3 >> 2) & 1);
#endif
		break;
	case MODIFY_LOCAL:				/* modify the value of a local variable, an argument or the result */
		modify_local_variable(arg_1,arg_2,arg_3,NULL);	             /* of a feature in the call stack */
		curr_modify = LOCAL_ITEM;
		break;
	case MODIFY_ATTR:				/* modify the value of an attribute of an object */
		modify_object_attribute(arg_3,arg_1,NULL);
		curr_modify = OBJECT_ATTR;
		break;
	case DUMPED:					/* new value for the modified local variable / object / attribute */
		switch (curr_modify) {
			case LOCAL_ITEM:				
				modify_local_variable(0,0,0,rqst->rq_dump.dmp_item);
				break;
			case OBJECT_ATTR:
				modify_object_attribute(0,0,rqst->rq_dump.dmp_item);
				break;
			default: /* arguments for a forthcoming dynamic feature evalution */
				opush_dmpitem(rqst->rq_dump.dmp_item);
				break;
		}
		curr_modify = NO_CURRMODIF;
		break;
	case MOVE:						/* Change active routine */
		dmove(arg_1);
		break;
	case BREAK:						/* Add/delete breakpoints */
		dsetbreak(arg_1, (uint32) arg_3, arg_2);
		break;
	case RESUME:					/* Resume execution */
		if (!gc_stopped) gc_run();
		set_breakpoint_count (arg_2);
		critical_stack_depth = (uint32) arg_3;
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
	case OVERFLOW_DETECT:
		critical_stack_depth = (uint32) arg_3; /* We convert int => uint32, so that passing -1 never checks for stack overflows */
		already_warned = 0;
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

	gc_stopped = (char) !gc_ison();
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
	if (wh.wh_type == -1){	/* Could not compute position */
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
		rqst.st_wh.wh_offset = wh.wh_offset;	/* Offset in byte code for melted feature, line number for frozen one */
	}

#undef st_status
#undef st_extag
#undef st_excode
#undef st_where

	send_packet(s, &rqst);	/* Send stopped notification */
}

/* Encapsulate the 'modify_local' function */
rt_private void modify_local_variable(long arg_stack_depth, long arg_loc_type, long arg_loc_number, struct item *ip)
{
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif
		
	static long stack_depth = 0;
	static long loc_type = 0;
	static long loc_number = 0; 
	unsigned char result;
	
	if (ip == NULL) {
		/* first call: remember the depth, the type and the number */
		stack_depth = arg_stack_depth;
		loc_type = arg_loc_type;
		loc_number = arg_loc_number;	
	} else {
		/* second call, get the new value and call the function */
		result = modify_local(stack_depth, loc_type, loc_number, ip);
		
		/* send the acknowledgement */
#ifdef EIF_WIN32
		send_ack(sp, result);
#else
		send_ack(writefd(sp), result);
#endif

		/* prepare next call (will be a 'first') */
		stack_depth = 0;
		loc_type = 0;
		loc_number = 0;
	}
}

/* Encapsulate the 'modify_attr' function */
rt_private void modify_object_attribute(long arg_addr, long arg_attr_number, struct item *new_value)
{
#ifndef EIF_WIN32
	STREAM *sp = stream_by_fd[EWBOUT];
#endif

	static char *object = NULL;
	static long attr_number = 0;
	unsigned char result;
	
	if (new_value == NULL) {
		/* access the object through its hector address */
		object = (EIF_OBJECT)(&(eif_access((EIF_OBJECT) arg_addr)));
		object = eif_access(object);

		attr_number = arg_attr_number;	
	} else {
		/* second call, get the new value and call the function */
		result = modify_attr(object, attr_number, new_value);
		
		/* send the acknowledgement */
#ifdef EIF_WIN32
		send_ack(sp, result);
#else
		send_ack(writefd(sp), result);
#endif

		/* prepare next call (will be a 'first') */
		object = 0;
		attr_number = 0;
	}
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

	char *out = NULL;				/* Buffer where out form is stored */
	struct item *val = NULL;		/* Value in operational stack */
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
		val = ivalue(IV_LOCAL, what->op_second,0);
		break;
	case IN_ARG:					/* Argument inspection */
		val = ivalue(IV_ARG, what->op_second,0);
		break;
	case IN_CURRENT:				/* Value of Current */
		val = ivalue(IV_CURRENT,0,0);		/* %%zs misuse, added ",0" */
		break;
	case IN_RESULT:					/* Value of Result */
		val = ivalue(IV_RESULT,0,0);		/* %%zs misuse, added ",0" */
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
														/* the last argument is the number of  */
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
	sprintf(hector_addr, "0x%lX", (unsigned long) eif_adopt((EIF_OBJ) &physical_addr));
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
	sprintf(physical_addr, "0x%lX", (unsigned long) eif_access((EIF_OBJ) hector_addr));
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
	unsigned char *bc;					/* Location of loaded byte code */
	int i;

#ifdef USE_ADD_LOG
		add_log(9, "in load_bc slots %d amount %d", slots, amount);
#endif

	Request_Clean (rqst);
#ifdef EIF_WIN32
	send_ack(sp, AK_OK);				/* Extension succeeded */
#else
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
		bc = (unsigned char *) tread((int *) 0);			/* Get byte code in memory */
		if (bc == NULL) {			/* Not enough memory */
			send_ack(sp, AK_ERROR);		/* Notify failure */
			return;						/* And abort downloading */
		}
#ifdef USE_ADD_LOG
		add_log(9, "tread bytecode");
#endif
		drecord_bc((uint16) arg_1, (uint16) arg_2, bc);	/* Place byte code in run-time tables*/
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
		bc = (unsigned char *) tread((int *) 0);			/* Get byte code in memory */
		if (bc == NULL) {			/* Not enough memory */
			send_ack(s, AK_ERROR);		/* Notify failure */
			return;						/* And abort downloading */
		}
		drecord_bc((uint16) arg_1, (uint16) arg_2, bc);	/* Place byte code in run-time tables*/
		send_ack(s, AK_OK);				/* Byte code loaded successfully */
#endif
	}

#undef arg_1
#undef arg_2
}


/*
 *		Routines for inspecting an Eiffel object.
 */


rt_private void rec_inspect(EIF_REFERENCE object);
rt_private void rec_sinspect(EIF_REFERENCE object);

rt_private void obj_inspect(EIF_OBJ object)
{
	uint32 flags;		/* Object flags */
	EIF_BOOLEAN is_special;
	int32 dtype;
	EIF_REFERENCE ref = eif_access(object);

	flags = HEADER(ref)->ov_flags;
	is_special = EIF_TEST(flags & EO_SPEC);	
	twrite (&is_special, sizeof(EIF_BOOLEAN));
		/* Send class dynamic id */
	dtype = Deif_bid(flags);
	twrite (&dtype, sizeof(int32));
					
	if (is_special) {
			/* Send items recursively */
		rec_sinspect(ref);
	} else {
			/* Inspect recursively `object' */
		rec_inspect(ref);
	}
}

rt_private void rec_inspect(EIF_REFERENCE object)
{
	/* Inspect recursively `object''s attribute */

	register2 struct cnode *obj_desc;		/* Object type description */
	int32 nb_attr;							/* Attribute number */
	register4 uint32 *types;				/* Attribute types */
	register4 int32 *cn_attr;				/* Attribute keys */
	long offset;
	register5 int16 dtype;				/* Object dynamic type */
	EIF_REFERENCE o_ref;
	EIF_REFERENCE reference;				/* Reference attribute */
	register7 char **names;					/* Attribute names */
	char *name;
	long i;
	uint32 type, sk_type, ref_flags;

	dtype = Dtype(object);
	obj_desc = &System(dtype);
	nb_attr = obj_desc->cn_nbattr;
	names = obj_desc->cn_names;
	types = obj_desc->cn_types;

	cn_attr = obj_desc->cn_attr;

		/* Send the attribute number */
	twrite (&nb_attr, sizeof(int32));

	for (i = 0; i < nb_attr; i++) {

		/* Send attribute name */
		name = names[i];
		twrite (name, strlen(name));

		/* Send attribute value */
		type = types[i];
		CAttrOffs(offset,cn_attr[i],dtype);
		o_ref = object + offset;
		sk_type = type & SK_HEAD;
		if (sk_type != SK_REF)
			twrite (&sk_type, sizeof(uint32));

		switch(sk_type) {
		case SK_POINTER: twrite (o_ref, sizeof(EIF_POINTER)); break;
		case SK_BOOL: twrite (o_ref, sizeof(EIF_BOOLEAN)); break;
		case SK_CHAR: twrite (o_ref, sizeof(EIF_CHARACTER)); break;
		case SK_WCHAR: twrite (o_ref, sizeof(EIF_WIDE_CHAR)); break;
		case SK_INT8: twrite (o_ref, sizeof(EIF_INTEGER_8)); break;
		case SK_INT16: twrite (o_ref, sizeof(EIF_INTEGER_16)); break;
		case SK_INT32: twrite (o_ref, sizeof(EIF_INTEGER_32)); break;
		case SK_INT64: twrite (o_ref, sizeof(EIF_INTEGER_64)); break;
		case SK_FLOAT: twrite (o_ref, sizeof(EIF_REAL)); break;
		case SK_DOUBLE: twrite (o_ref, sizeof (EIF_DOUBLE)); break;
		case SK_BIT:
			{
				char *buf = b_out (o_ref);
				twrite (buf, strlen(buf));
				xfree(buf);
			}
			break;
		case SK_EXP:
			{
				int32 dtype = Dtype(o_ref);
				twrite (&dtype, sizeof(int32));
				rec_inspect(o_ref);
			}
			break;
		default:
			{
					/* Object reference */
			  	EIF_BOOLEAN is_special = EIF_FALSE, is_void = FALSE;

				reference = *(EIF_REFERENCE *)o_ref;
				if (reference) {
					ref_flags = HEADER(reference)->ov_flags;
					if (ref_flags & EO_C) {
						sk_type = SK_POINTER;
						twrite (&sk_type, sizeof(uint32));
						twrite (reference, sizeof(EIF_POINTER));
					} else {
						twrite (&sk_type, sizeof(uint32));
						if (ref_flags & EO_SPEC) {
							is_special = EIF_TRUE;
							twrite (&is_special, sizeof(EIF_BOOLEAN));
							rec_sinspect (reference);
						} else {
							int32 dtype = Dtype(reference);
							twrite (&is_special, sizeof(EIF_BOOLEAN));
							twrite (&is_void, sizeof(EIF_BOOLEAN));
							twrite (&dtype, sizeof(int32));
							twrite (&reference, sizeof(EIF_POINTER));
						}
					}
				} else {
					is_void = EIF_TRUE;
					twrite (&sk_type, sizeof(uint32));
					twrite (&is_special, sizeof(EIF_BOOLEAN));
					twrite (&is_void, sizeof(EIF_BOOLEAN));
				}
			}
		}
	}
}

rt_private void rec_sinspect(EIF_REFERENCE object)
{
	/* Inspect special object */

	union overhead *zone;		/* Object header */
	register5 uint32 flags;		/* Object flags */
	register3 long sp_index;	/* Element index */
	register4 long elem_size;	/* Element size */
	char *o_ref;
	char *reference;
	int32 count;					/* Element count */
	uint32 nb_attr, sk_type;
	long sp_start = 0, sp_end;		/* Bounds for inspection */
	int32 dtype;
	static char buffer[BUFSIZ]; 	/* Buffer used for converting integers into a string */

		/* Send address of Current object */
	twrite (&object, sizeof (EIF_POINTER));

	zone = HEADER(object);
	o_ref = (EIF_REFERENCE) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
	count = *(EIF_INTEGER *) o_ref;
	elem_size = *(EIF_INTEGER *) (o_ref + sizeof(EIF_INTEGER));
	flags = zone->ov_flags;
	dtype = Deif_bid(flags);

		/* Send the capacity of the special object */
	twrite (&count, sizeof(int32));

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

		/* Compute number of items that will be inspected */
	if (sp_start > sp_end)
		nb_attr = 0;
	else
		nb_attr = sp_end - sp_start + 1;
	  
		/* Send the number of items to be inspected */
	twrite (&nb_attr, sizeof(uint32));

		/* Send the items within the bounds */
	if (nb_attr > 0) {
		if (!(flags & EO_REF)) {
			if (flags & EO_COMP) {
				for (o_ref = object + OVERHEAD + (sp_start * elem_size),
									sp_index = sp_start; sp_index <= sp_end;
									sp_index++, o_ref += elem_size) {
					sprintf(buffer, "%ld", sp_index);
					twrite (buffer, strlen(buffer));
					sk_type = SK_EXP;
					twrite (&sk_type, sizeof(uint32));
					dtype = Dtype(o_ref);
					twrite (&dtype, sizeof(int32));
					rec_inspect(o_ref);
				}
			} else {
				if (dtype == egc_sp_char)
				  	sk_type = SK_CHAR;
				else if (dtype == egc_sp_wchar)
				  	sk_type = SK_WCHAR;
				else if (dtype == egc_sp_int8)
				  	sk_type = SK_INT8;
				else if (dtype == egc_sp_int16)
				  	sk_type = SK_INT16;
				else if (dtype == egc_sp_int32)
				  	sk_type = SK_INT32;
				else if (dtype == egc_sp_int64)
				  	sk_type = SK_INT64;
				else if (dtype == egc_sp_bool)
				  	sk_type = SK_BOOL;
				else if (dtype == egc_sp_real)
				  	sk_type = SK_FLOAT;
				else if (dtype == egc_sp_double)
				  	sk_type = SK_DOUBLE;
				else if (dtype == egc_sp_pointer)
				  	sk_type = SK_POINTER;
				else {
				  	CHECK("Must be a bit", 1);	/* We cannot check that at the moment */
				  	sk_type = SK_BIT;
				}

				for (o_ref = object + (sp_start * elem_size),
									sp_index = sp_start; sp_index <= sp_end;
									sp_index++, o_ref += elem_size) {
					sprintf(buffer, "%ld", sp_index);
					twrite (buffer, strlen(buffer));

					twrite (&sk_type, sizeof(uint32));

					switch(sk_type) {
					case SK_POINTER: twrite (o_ref, sizeof(EIF_POINTER)); break;
					case SK_BOOL: twrite (o_ref, sizeof(EIF_BOOLEAN)); break;
					case SK_CHAR: twrite (o_ref, sizeof(EIF_CHARACTER)); break;
					case SK_WCHAR: twrite (o_ref, sizeof(EIF_WIDE_CHAR)); break;
					case SK_INT8: twrite (o_ref, sizeof(EIF_INTEGER_8)); break;
					case SK_INT16: twrite (o_ref, sizeof(EIF_INTEGER_16)); break;
					case SK_INT32: twrite (o_ref, sizeof(EIF_INTEGER_32)); break;
					case SK_INT64: twrite (o_ref, sizeof(EIF_INTEGER_64)); break;
					case SK_FLOAT: twrite (o_ref, sizeof(EIF_REAL)); break;
					case SK_DOUBLE: twrite (o_ref, sizeof (EIF_DOUBLE)); break;
					case SK_BIT:
						{
							char *buf = b_out (*(EIF_REFERENCE *) o_ref);
							twrite (buf, strlen(buf));
							xfree(buf);
						}
						break;
					}
				}
			}
		} else {
			EIF_BOOLEAN is_void = EIF_FALSE;
			EIF_BOOLEAN is_special = EIF_FALSE;
			uint32 sk_type = SK_REF;
			for (o_ref = (char *) ((char **)object + sp_start),
						sp_index = sp_start; sp_index <= sp_end; sp_index++,
						o_ref = (char *) ((char **)o_ref + 1)) {
				sprintf(buffer, "%ld", sp_index);
				twrite (buffer, strlen(buffer));
				reference = *(char **)o_ref;
				if (!reference) {
					is_void = EIF_TRUE;
					twrite (&sk_type, sizeof(uint32));
					twrite (&is_special, sizeof(EIF_BOOLEAN));
					twrite (&is_void, sizeof(EIF_BOOLEAN));
					is_void = EIF_FALSE;
				} else if (HEADER(reference)->ov_flags & EO_C) {
					sk_type = SK_POINTER;
					twrite (&sk_type, sizeof(uint32));
					twrite (&reference, sizeof(EIF_POINTER));
					sk_type = SK_REF;
				} else {
					dtype = Dtype(reference);
					twrite (&sk_type, sizeof(uint32));
					twrite (&is_special, sizeof(EIF_BOOLEAN));
					twrite (&is_void, sizeof(EIF_BOOLEAN));
					twrite (&dtype, sizeof(int32));
					twrite (&reference, sizeof(EIF_POINTER));
				}
			}
		}
	}
}

rt_private void bit_inspect(EIF_OBJ object)
               		/* Reference to a bit object (= BIT_REF) */
{
	char *buf = b_out(*(EIF_REFERENCE *) object);
	twrite (buf, strlen(buf));
	xfree(buf);
}

rt_private void string_inspect(EIF_OBJ object)
               		/* Reference to a string object */
{
		/* Inspect the string object to get the string value */

	register2 struct cnode *obj_desc;		/* Object type description */
	register3 long nb_attr;					/* Attribute number */
	register4 int32 *cn_attr;				/* Attribute keys */
	long offset;
	register5 int16 dtype;				/* Object dynamic type */
	char *o_ref;
	register7 char **names;					/* Attribute names */
	char *reference;
	long i, string_count = 0;
	char *string_area = NULL;

	reference = eif_access(object);
	dtype = Dtype(reference);
	obj_desc = &System(dtype);
	nb_attr = obj_desc->cn_nbattr;
	names = obj_desc->cn_names;
	cn_attr = obj_desc->cn_attr;

	for (i = 0; i < nb_attr; i++) {
		CAttrOffs(offset,cn_attr[i],dtype);
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

rt_private unsigned char smodify_attr(char *object, long attr_number, struct item *new_value)
	{
	/* Modify an attribute of a special object */

	union overhead *zone;		/* Object header */
	uint32 flags;				/* Object flags */
	long elem_size;				/* Element size */
	char *o_ref;
	long count;					/* Element count */
	int dtype;
	char *new_object_attr;		/* new value for the attribute (if new value is a reference) */
	unsigned char error_code = 0;

	zone = HEADER(object);
	o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
	count = *(long *) o_ref;
	elem_size = *(long *) (o_ref + sizeof(long));
	flags = zone->ov_flags;
	dtype = (int) Deif_bid(flags);

	/* Send the items within the bounds */
	if (!(flags & EO_REF)) {
		if (flags & EO_COMP) { /* expanded object */
			error_code = 2;
		} else {
			o_ref = object + (attr_number * elem_size);
			switch(new_value->type & SK_HEAD) {
				case SK_POINTER: /* Pointer attribute */
					*(char **)o_ref = new_value->it_ptr;
					break;
				case SK_BOOL: /* Boolean attribute */
				case SK_CHAR: /* Character attribute */
					*(EIF_CHARACTER *)o_ref = new_value->it_char;
					break;
				case SK_WCHAR: /* Character attribute */
					*(EIF_WIDE_CHAR *)o_ref = new_value->it_wchar;
					break;
				case SK_INT8: /* Integer attribute */
					*(EIF_INTEGER_8 *)o_ref = new_value->it_int8;
					break;
				case SK_INT16: /* Integer attribute */
					*(EIF_INTEGER_16 *)o_ref = new_value->it_int16;
					break;
				case SK_INT32: /* Integer attribute */
					*(EIF_INTEGER_32 *)o_ref = new_value->it_int32;
					break;
				case SK_INT64: /* Integer attribute */
					*(EIF_INTEGER_64 *)o_ref = new_value->it_int64;
					break;
				case SK_FLOAT: /* Real attribute */
					*(EIF_REAL *)o_ref = new_value->it_float;
					break;
				case SK_DOUBLE: /* Double attribute */
					*(EIF_DOUBLE *)o_ref = new_value->it_double;
					break;
				case SK_BIT: /* Bit attribute */
					/* FIXME ARNAUD: To do... */
					return 1; /* not yet implemented */
				default: 
					return 1; /* unexpected value */
			}
		}
	} else {
		switch(new_value->type & SK_HEAD) {
			case SK_STRING:
				*(char **)o_ref = RTMS(new_value->it_ref);
				break;
			default: /* Object reference */
				o_ref = (char *) ((char **)object + attr_number);

				/* access the object through its hector address */
				new_object_attr = (EIF_OBJECT)(&(eif_access((EIF_OBJECT) (new_value->it_ref))));
				new_object_attr = eif_access(new_object_attr);
				*(char **)o_ref = new_object_attr;
				/* inform the GC that new_value is now referrenced as `object' */
				RTAS_OPT(new_object_attr,attr_number,object);
				break;
		}
	}

	return error_code;
}

/* addr: address of the object where attribute to modify lies */
/* attr_number: */
/* new_value: */
rt_private unsigned char modify_attr(char *object, long attr_number, struct item *new_value)
{
	/* modify recursively `object''s attribute */

	struct cnode *obj_desc;		/* Object type description */
	long nb_attr;				/* Attribute number */
	uint32 *types;				/* Attribute types */
	int32 *cn_attr;				/* Attribute keys */
	long offset;				/* Offset of the attribute within object structure */
	int16 dtype;				/* Object dynamic type */
	char *o_ref;				/* Attribute address */
	uint32 type;				/* Dynamic type of the attribute */
	char *new_object_attr;		/* new value for the attribute (if new value is a reference) */
	uint32 ref_flags;


	dtype = Dtype(object);
	obj_desc = &System(dtype);
	ref_flags = HEADER(object)->ov_flags;

	if (ref_flags & EO_SPEC) {
		/* Special object */
		return smodify_attr(object, attr_number, new_value);
	} else {
		/* get characteristic of the object */
		nb_attr = obj_desc->cn_nbattr;
		types = obj_desc->cn_types;
		cn_attr = obj_desc->cn_attr;
	
		/* check that the given attribute number is not out-of-bounds */
		if (attr_number > nb_attr)
			return 1; /* error */
		
		type = types[attr_number];
		CAttrOffs(offset,cn_attr[attr_number],dtype);
		o_ref = object + offset;

		switch(new_value->type & SK_HEAD) {
			case SK_POINTER: /* Pointer attribute */
				*(char **)o_ref = new_value->it_ptr;
				break;
			case SK_BOOL: /* Boolean attribute */
			case SK_CHAR: /* Character attribute */
				*(EIF_CHARACTER *)o_ref = new_value->it_char;
				break;
			case SK_WCHAR: /* Character attribute */
				*(EIF_WIDE_CHAR *)o_ref = new_value->it_wchar;
				break;
			case SK_INT8: /* Integer attribute */
				*(EIF_INTEGER_8 *)o_ref = new_value->it_int8;
				break;
			case SK_INT16: /* Integer attribute */
				*(EIF_INTEGER_16 *)o_ref = new_value->it_int16;
				break;
			case SK_INT32: /* Integer attribute */
				*(EIF_INTEGER_32 *)o_ref = new_value->it_int32;
				break;
			case SK_INT64: /* Integer attribute */
				*(EIF_INTEGER_64 *)o_ref = new_value->it_int64;
				break;
			case SK_FLOAT: /* Real attribute */
				*(EIF_REAL *)o_ref = new_value->it_float;
				break;
			case SK_DOUBLE: /* Double attribute */
				*(EIF_DOUBLE *)o_ref = new_value->it_double;
				break;
			case SK_STRING:
				*(char **)o_ref = RTMS(new_value->it_ref);
				break;
			case SK_BIT: /* Bit attribute */
				/* FIXME ARNAUD: To do... */
				return 1; /* error: not yet implemented */
			case SK_EXP: /* Expanded attribute - unauthorized action */
				return 2;
			default: /* Object reference */
				/* access the object through its hector address */
				new_object_attr = (EIF_OBJECT)(&(eif_access((EIF_OBJECT) (new_value->it_ref))));
				new_object_attr = eif_access(new_object_attr);
				*(char **)o_ref = new_object_attr;
				/* inform the GC that new_value is now referrenced is `object' */
				RTAR(new_object_attr,object);
				break;
		}
	}
	return 0;
}

rt_private void opush_dmpitem(struct item *item)
	{
	if (otop_recorded==0)
		{
		previous_otop = otop();
		otop_recorded = 1;
		}

	switch (item->type & SK_HEAD)
		{
		case SK_REF:
			if (item->it_ref != 0)
				item->it_ref = eif_access(item->it_ref); /* unprotect this object */
			break;
		case SK_STRING:
			item->it_ref = RTMS(item->it_ref);
			break;
		default:
			/* do nothing. leave the item as it is */
			break;
		}
	opush(item);
	}

#ifdef EIF_WIN32
rt_private void dynamic_evaluation(STREAM *s, int fid, int stype, int is_extern, int is_precompiled, int is_basic_type)
#else
rt_private void dynamic_evaluation(int s, int fid, int stype, int is_extern, int is_precompiled, int is_basic_type)
#endif
	{
	struct item *ip;
	Request rqst;					/* What we send back */
	struct dump dumped;			/* Item returned */

	Request_Clean (rqst);
	rqst.rq_type = DUMPED;			/* A dumped stack item */

	ip = dynamic_eval(fid,stype, is_extern, is_precompiled, is_basic_type, previous_otop);
	if (ip == (struct item *) 0)
		{
		dumped.dmp_type = DMP_VOID;		/* Tell ebench there are no more */
		dumped.dmp_item = NULL;			/* arguments to be sent. */
		}
	else
		{
		dumped.dmp_type = DMP_ITEM;			/* We are dumping a variable */
		dumped.dmp_item = ip;
		}
	memcpy (&rqst.rq_dump, &dumped, sizeof(struct dump));
	send_packet(s, &rqst);			/* Send to network */

	/* reset info concerning otop */
	previous_otop = NULL;
	otop_recorded = 0;
	}

