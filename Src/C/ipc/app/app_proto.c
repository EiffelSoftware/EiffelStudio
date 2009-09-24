/*
	description: "Protocol handling. Send requests and wait for answers."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "rt_err_msg.h"
#include <sys/types.h>
#include <signal.h>
#include "request.h"
#include "rqst_idrs.h"
#include "com.h"
#include "stream.h"
#include "app_transfer.h"
#include "ewbio.h"
#include "stack.h"
#include "idrs.h"
#include "rt_debug.h"
#include "eif_except.h"
#include "server.h"
#include "rt_wbench.h"
#include "rt_malloc.h"
#include "select.h"
#include "eif_hector.h"
#include "eif_bits.h"
#include "eif_eiffel.h"
#include "rt_interp.h"
#include "eif_memory.h"
#include "app_proto.h"
#include "rt_assert.h"
#include "rt_macros.h"
#include "rt_gen_types.h"
#include "rt_struct.h"
#include "rt_globals.h"
#include "rt_main.h" 	/* For debug_mode. */
#include "eif_local.h"	/* For epop() */
#include "eif_debug.h"	/* For rt addons */

#ifndef WORKBENCH
This module should not be compiled in non-workbench mode
#endif

rt_public int app_rqstcnt = 0;			/* Request count */
rt_private char gc_stopped;
rt_private IDRF app_idrf;				/* IDR filter for serialize communications */
rt_private char app_idrf_initialized = (char) 0;	/* IDR filter already initialized ? */

rt_private void adopt(EIF_PSTREAM s, Opaque *what);
rt_private void process_request(EIF_PSTREAM s, Request *rqst);/* Dispatch request processing */
rt_private void inspect(EIF_PSTREAM s, Opaque *what);		/* Object inspection */
rt_private void ipc_access(EIF_PSTREAM s, Opaque *what);		/* Access object through hector */
rt_private void wean(EIF_PSTREAM s, Opaque *what);			/* Wean adopted object */
rt_private void once_inspect(EIF_PSTREAM s, Opaque *what);	/* Once routines inspection */
rt_private void obj_inspect(EIF_OBJECT object);
rt_private void bit_inspect(EIF_REFERENCE object);
rt_private void string_inspect(EIF_OBJECT object);		/* String object inspection */
rt_private void load_bc(int slots, int amount);		/* Load byte code information */
rt_private void app_send_integer (EIF_PSTREAM sp, int val);
rt_private void app_send_reference (EIF_PSTREAM sp, EIF_REFERENCE ref, int dump_type);
rt_private void app_send_typed_value (EIF_PSTREAM sp, EIF_TYPED_VALUE *ip, int a_dmp_type);
rt_private void app_send_rt_uint_ptr_as_string (EIF_PSTREAM sp, rt_uint_ptr ref);
rt_private EIF_REFERENCE rt_boxed_expanded_item_at_index (EIF_REFERENCE a_obj, int a_index);

rt_private long sp_lower, sp_upper;					/* Special objects' bounds to be inspected */
rt_private rt_uint_ptr dthread_id;					/* Thread id used to precise current thread in debugger */

rt_private void set_check_assert (int v) ;	/* Set current assertion checking off/on */
rt_private void set_catcall_detection_mode (EIF_PSTREAM sp, int a_console, int a_dbg); /* Set catcall_detection mode */

/* debugging macro */
#ifdef EIF_THREADS
rt_private rt_uint_ptr dthread_id_saved;			/* Thread id used to backup previous current thread in debugger */
#define dthread_prepare() 														\
		CHECK("Thread context must be cleared", dthread_id_saved == 0); 		\
		dthread_id_saved = dbg_switch_to_thread(dthread_id);
#define dthread_restore() 														\
		CHECK("Thread context must be saved", dthread_id_saved != 0); 			\
		dthread_id_saved = dbg_switch_to_thread(dthread_id_saved); 					\
		dthread_id_saved = 0;	
#else
#define dthread_prepare();
#define dthread_restore();
#endif

/* Object/local modification routines */
extern unsigned char modify_local(uint32 stack_depth, uint32 loc_type, uint32 loc_number, EIF_TYPED_VALUE *new_value); /* modify a local variable/ an argument */
rt_private void modify_local_variable(long arg_stack_depth, long arg_loc_type, long arg_loc_number, EIF_TYPED_VALUE *ip);
rt_private unsigned char modify_attr(EIF_REFERENCE object, long attr_number, EIF_TYPED_VALUE *new_value);
rt_private void modify_object_attribute(rt_int_ptr arg_addr, long arg_attr_number, EIF_TYPED_VALUE *new_value);

/* Dynamic function evaluation */
rt_private void opush_dmpitem(EIF_TYPED_VALUE *item);
rt_private void opush_ref_offset_item(rt_int_ptr a_addr, int a_offset);
rt_private EIF_TYPED_VALUE *previous_otop = NULL;
rt_private rt_uint_ptr nb_pushed = 0;
rt_private void dynamic_evaluation(EIF_PSTREAM s, int fid_or_offset, int stype_or_origin, int dtype, int is_precompiled, int is_basic_type, int is_static_call);
rt_private void dbg_new_instance_of_type(EIF_PSTREAM s, EIF_TYPE_INDEX typeid);
rt_private void dbg_dump_rt_extension_object (EIF_PSTREAM sp);

/* Private Constants */
#define NO_CURRMODIF	0
#define LOCAL_ITEM		1
#define OBJECT_ATTR		2

/*
 * IDR protocol initialization.
 */

rt_public void app_prt_init(void)
{
	if (!app_idrf_initialized) {
		if (-1 == idrf_create(&app_idrf, IDRF_SIZE))
			fatal_error("cannot initialize streams");		/* Run-time routine */
		app_idrf_initialized = (char) 1;
	}
}

/*
 * Handling requests.
 */

rt_public void arqsthandle(EIF_PSTREAM sp)
{
	/* Given a connected socket, wait for a request and process it. Since it
	 * is an error at the application level to not be able to receive a packet,
	 * recv_packet will exit via esdie() as soon as the connection is broken.
	 */

	Request rqst;		/* The request we are waiting for */

	Request_Clean (rqst); /* zero recognized as non initialized -- Didier */

#ifdef EIF_WINDOWS
	app_recv_packet(sp, &rqst, FALSE);		/* Get request */
#else
	app_recv_packet(sp, &rqst);		/* Get request */
#endif

	process_request(sp, &rqst);	/* Process the received request */

#ifdef USE_ADD_LOG
		add_log(9, "app_arqsthandle done");
#endif
}

rt_private void process_request(EIF_PSTREAM sp, Request *rqst)
      						/* The connected socket */
              				/* The received request to be processed */
{
	/* Process the received request */


static int curr_modify = NO_CURRMODIF;

#define arg_1		rqst->rq_opaque.op_1
#define arg_2		rqst->rq_opaque.op_2
#define arg_3_p		rqst->rq_opaque.op_3 /* rt_uint_ptr */
#define arg_3		(int) rqst->rq_opaque.op_3
#define arg_4		rqst->rq_opaque.op_4

#ifdef USE_ADD_LOG
	add_log(9, "received request type %d", rqst->rq_type);
#endif

	switch (rqst->rq_type) {
	case INSPECT:					/* Object inspection */
		inspect(sp, &rqst->rq_opaque);
		break;
	case SP_LOWER:					/* Bounds for special object inspection */
		sp_lower = arg_2;
		sp_upper = arg_3;
		break;
	case METAMORPHOSE:					/* Converts the top-level item on the operational stack to a reference type */
		{
			RT_GET_CONTEXT
			metamorphose_top(op_stack.st_cur, op_stack.st_top);
		}
		break;
	case CHANGE_THREAD:					/* Thread id used to precise current thread in debugger */
		dthread_id = (rt_uint_ptr) arg_1;
		break;
	case DUMP_VARIABLES:
		dthread_prepare();
		send_stack_variables(sp, arg_1);
		dthread_restore();
		break;
	case DUMP_THREADS:
		CHECK("DUMP_THREADS: not yet implemented", 0);	
			/* 
			 * This is not yet implemented, 
			 * and probably will be removed
			 * if we don't find a portable way to get thread OS id, name, and priority 
			 */
		break;
	case DUMP_STACK:						/* General stack dump request */
		dthread_prepare();
		{
			EIF_GET_CONTEXT
			app_send_integer (sp, d_data.db_callstack_depth);		/* Callstack depth */
			send_stack(sp, (uint32) arg_1); /* Since we convert int -> uint32, passing -1 will inspect the whole stack. */
		}
		dthread_restore();
		break;
	case DYNAMIC_EVAL: /* arg_1 = feature_id / arg2=static_type / arg3=dynamic_type / arg4=is_external / arg5=is_precompiled / arg6=is_basic_type / arg7=is_static_call */
		{
			dthread_prepare();
			dynamic_evaluation(sp, arg_1, arg_2, arg_3, (arg_4 >> 1) & 1, (arg_4 >> 2) & 1, (arg_4 >> 3) & 1);
			dthread_restore();
		}
		break;
	case LAST_EXCEPTION:
		/* return last_exception() */
		{
			EIF_TYPED_VALUE excpt;	/* Exception's object */
			memset (&excpt, 0, sizeof(EIF_TYPED_VALUE));
			excpt.it_ref = last_exception();	/* Get last exception */
			excpt.type = SK_REF;
			if (excpt.it_ref != NULL) {
				excpt.type = excpt.type | Dtype(excpt.it_ref);
			}
			app_send_typed_value (sp, &excpt, DMP_EXCEPTION_ITEM);
		}
		break;
	case LAST_RTCC_INFO:
		/* return last RTCC information */
		{
			EIF_GET_CONTEXT
			if (d_data.rtdata.rtcc.pos > 0) {
				app_send_integer(sp, 3);
				app_send_integer(sp, d_data.rtdata.rtcc.pos);
				app_send_integer(sp, d_data.rtdata.rtcc.expect);
				app_send_integer(sp, d_data.rtdata.rtcc.actual);
			} else {
				app_send_integer(sp, 0);
			}
		}
		break;
	case NEW_INSTANCE:
		dbg_new_instance_of_type (sp, (EIF_TYPE_INDEX) arg_1);
		break;
	case MODIFY_LOCAL:				/* modify the value of a local variable, an argument or the result */
		modify_local_variable(arg_1,arg_2,arg_3,NULL);	             /* of a feature in the call stack */
		curr_modify = LOCAL_ITEM;
		break;
	case MODIFY_ATTR:				/* modify the value of an attribute of an object */
		modify_object_attribute(arg_3_p, arg_1, NULL);
		curr_modify = OBJECT_ATTR;
		break;
	case DUMPED_WITH_OFFSET:	
		dthread_prepare();
		opush_ref_offset_item(arg_3_p, (int) arg_2);
		dthread_restore();
		break;
	case DUMPED:					/* new value for the modified local variable / object / attribute */
		dthread_prepare();
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
		dthread_restore();
		break;
	case RT_OPERATION:
		dthread_prepare();
		switch (arg_1) {
			case RQST_RTOP_DUMP_OBJECT:
				dbg_dump_rt_extension_object(sp);
				break;
			case RQST_RTOP_EXEC_REPLAY:
				/*    arg_2: record; arg_3: value (0 or 1) */
				/* or arg_2: up,down,left,right; arg_3: steps */
				{
					if (arg_2 == RTDBG_OP_REPLAY_RECORD) {
						EIF_GET_CONTEXT
						is_inside_rt_eiffel_code = 0;
						if (rt_extension_obj == NULL) {
								/* Do not enable exec recording if `rt_extension_obj' is not available ! */
							exec_recording_enabled = 0;
						} else {
							exec_recording_enabled = ((int) arg_3 == 1)?1:0;
						}
					};
				};
				break;
			case RQST_RTOP_SET_CATCALL_DETECTION:
				set_catcall_detection_mode (sp, (int) arg_2, (int) arg_3);
				break;
			default:
				break;
		}
		dthread_restore();
		break;
	case MOVE:			
			/* Change active routine */
		 dmove(arg_1);
		break;
	case CLEAR_BREAKPOINTS:				/* Clear breakpoints table */
		dbreak_clear_table();
		break;
	case BREAK:						/* Add/delete breakpoints */
		dsetbreak(arg_1, arg_3, arg_2);
		break;
	case RESUME:					/* Resume execution */
		if (!gc_stopped) eif_gc_run();
		set_breakpoint_count (arg_2);
		critical_stack_depth = (uint32) arg_3;
		dstatus(arg_1);				/* Debugger status (DX_STEP, DX_NEXT,..) */

#ifdef USE_ADD_LOG
		add_log(9, "RESUME");
		if ((void (*)()) 0 == rem_input(sp))
			add_log(12, "rem_input: %s (%s)", s_strerror(), s_strname());
#else
		(void) rem_input(sp);		/* Stop selection -> exit listening loop */
#endif
		break;
	case QUIT:						/* Die, immediately */
		esdie(0);
	case HELLO:							/* Initial handshake */
		send_ack(sp, AK_OK);	/* Ok, we're up */
		break;
	case KPALIVE:					/* Dummy request for connection checks */
		break;
	case LOAD:						/* Load byte code information */
		load_bc(arg_1, arg_2);
		break;
	case ADOPT:						/* Adopt object */
		adopt(sp, &rqst->rq_opaque);
		break;
	case ACCESS:					/* Access object through hector */
		ipc_access(sp, &rqst->rq_opaque);
		break;
	case WEAN:						/* Wean adopted object */
		wean(sp, &rqst->rq_opaque);
		break;
	case ONCE:						/* Once routines inspection */
		dthread_prepare();
		once_inspect(sp, &rqst->rq_opaque);
		dthread_restore();
		break;
	case INTERRUPT_OK:				/* Stop execution and send call stack */
		(void) rem_input(sp);		/* exit listening loop */
		dbreak(PG_INTERRUPT, 1);	/* We will wait to make sure that the application will stop. */
		break;
	case INTERRUPT_NO:				/* Resume execution with no further ado */
		(void) rem_input(sp);		/* exit listening loop */
		break;
	case OVERFLOW_DETECT:
		critical_stack_depth = (uint32) arg_3; /* We convert int => uint32, so that passing -1 never checks for stack overflows */
		already_warned = 0;
		break;
	case EWB_SET_ASSERTION_CHECK:
		set_check_assert ((int) arg_1);
		break;
	}

#undef arg_1
#undef arg_2
#undef arg_3
#undef arg_3_p
#undef arg_4
}

/*
 * Sending requests - Receiving answers
 */

rt_public void app_send_packet(EIF_PSTREAM sp, Request *rqst)
      				/* The connected socket */
              		/* The request to be sent */
{
	/* Sends an answer to the client */

	app_rqstcnt++;			/* One more request sent to daemon */
	idrf_reset_pos(&app_idrf);	/* Reposition IDR streams */

	/* Serialize the request */
	if (!idr_Request(&app_idrf.i_encode, rqst)) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR unable to serialize request %d", rqst->rq_type);
#endif
		print_err_msg(stderr, "Cannot serialize request, %d\n", rqst->rq_type);
		esdie(1);
	}

	/* Send the answer and propagate error report */
	if (-1 == net_send(sp, idrs_buf(&app_idrf.i_encode), IDRF_SIZE)) {
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

rt_public int app_recv_packet(EIF_PSTREAM s, Request *rqst
#ifdef EIF_WINDOWS
		, BOOL reset
#endif
		)
      				/* The connected socket */
              		/* The daemon's answer */
{
	int result = 0;
	/* Wait for an answer and fill in the Request structure, then de-serialize
	 * it. If an error occurs, exit immediately. The signature has to be 'int',
	 * since some shared functions do expect that signature. However, since
	 * no error recovery will be possible at the application level once the
	 * debugging link to ised is broken, it is wise to exit by calling esdie().
	 */

	/* Wait for request */
 	if (-1 == net_recv(s, idrs_buf(&app_idrf.i_decode), IDRF_SIZE
#ifdef EIF_WINDOWS
		, reset
#endif
		)) {
		result = -1;
		esdie(1);		/* Connection lost, probably */
	}

	idrf_reset_pos(&app_idrf);	/* Reposition IDR streams */

	/* Deserialize request */
	if (!idr_Request(&app_idrf.i_decode, rqst)) {
		result = -1;
		esdie(1);
	}

#ifdef DEBUG
	trace_request("got", rqst);
#endif

	return result;		/* All is ok, for lint */
}

/*
 * Send routines
 */

rt_private void app_send_rt_uint_ptr_as_string (EIF_PSTREAM sp, rt_uint_ptr ref)
{
	/* Send reference `ref' */
	char addr[20]; /* FIXME jfiat [2008/01/14] : think portability ... 32, 64 ... */
	sprintf(addr, "0x%" EIF_POINTER_DISPLAY, (rt_uint_ptr) ref);
	app_twrite(addr, strlen(addr));
}

rt_private void app_send_integer (EIF_PSTREAM sp, EIF_INTEGER val)
{
	/* Send int value `val' */
	app_twrite(&val, sizeof(EIF_INTEGER));
}

rt_private void app_send_reference (EIF_PSTREAM sp, EIF_REFERENCE ref, int a_dmp_type)
{
	/* 
	 * Send reference `ref' using dmp_type `a_dmp_type'
	 *	 `a_dmp_type' is either DMP_ITEM, or DMP_EXCEPTION_ITEM
	 */

	EIF_TYPED_VALUE ip;
	memset (&ip, 0, sizeof(EIF_TYPED_VALUE));
	if (ref != NULL) {
		ip.it_ref = (EIF_REFERENCE) ref;
		ip.type = SK_REF | Dtype(ip.it_ref);
	} else {
		ip.it_ref = (EIF_REFERENCE) 0;
		ip.type = SK_VOID;
	}
	app_send_typed_value (sp, &ip, a_dmp_type);
}

rt_private void app_send_typed_value (EIF_PSTREAM sp, EIF_TYPED_VALUE *ip, int a_dmp_type)
{
	/* 
	 * Send EIF_TYPED_VALUE `ip' using dmp_type `a_dmp_type'
	 *	 `a_dmp_type' is either DMP_ITEM, or DMP_EXCEPTION_ITEM or DMP_VOID
	 */

	Request rqst;					/* What we send */
	struct dump dumped;				/* Item sent */

	dumped.dmp_type = a_dmp_type;	/* We are dumping a `a_dmp_type' */
	dumped.dmp_item = ip;
	Request_Clean (rqst);
	rqst.rq_type = DUMPED;			/* A dumped stack item */
	memcpy (&rqst.rq_dump, &dumped, sizeof(struct dump));
	app_send_packet(sp, &rqst);		/* Send to network */
}


/*
 * Protocol specific routines
 */

rt_public void stop_rqst(EIF_PSTREAM sp)
{
	/* Send a stop request, using the Where structure to give the program
	 * current location. We also indicate why the program stopped and set
	 * a proper exception tag if that is the reason we stopped.
	 */
	RT_GET_CONTEXT
	Request rqst;			/* XDR request built */
	struct where wh;		/* Where did the program stop? */

#define st_status	rq_stop.st_why
#define st_excep	rq_stop.st_exception
#define st_wh		rq_stop.st_where

	gc_stopped = (char) !eif_gc_ison();
	eif_gc_stop();

	Request_Clean (rqst);
	rqst.rq_type = STOPPED;				/* Stop request */
	rqst.st_status = d_cxt.pg_status;	/* Why we stopped */
	rqst.st_excep = 2;					/* Exception occurred ? */

	/* If we stopped because an exception has occurred, 
	 * also give the exception data.
	 */
	switch (d_cxt.pg_status) {
		case PG_RAISE:						/* Explicitely raised exception */
		case PG_VIOL:						/* Implicitely raised exception */
			rqst.st_excep = 1;				/* Exception occurred ? */
	}

	ewhere(&wh);			/* Find out where we are */
	if (wh.wh_type == -1){	/* Could not compute position */
		rqst.st_wh.wh_name = "Unknown";			/* Feature name */
		rqst.st_wh.wh_obj = (rt_int_ptr) NULL;	/* (char *) -> rt_int_ptr for XDR */
		rqst.st_wh.wh_origin = 0;				/* Written where? */
		rqst.st_wh.wh_type = 0;					/* Dynamic type */
		rqst.st_wh.wh_offset = 0;				/* Offset in byte code */
		rqst.st_wh.wh_nested = 0;				/* breakable nested index */
		rqst.st_wh.wh_thread_id = (rt_int_ptr) 0;			/* Thread id -> rt_int_ptr for XDR */
	} 
	else {
		rqst.st_wh.wh_name = wh.wh_name;			/* Feature name */
		rqst.st_wh.wh_obj = (rt_int_ptr) wh.wh_obj;	/* (char *) -> rt_int_ptr for XDR */
		rqst.st_wh.wh_origin = wh.wh_origin;		/* Written where? */
		rqst.st_wh.wh_type = wh.wh_type;			/* Dynamic type */
		rqst.st_wh.wh_offset = wh.wh_offset;		/* Offset in byte code for melted feature, line number for frozen one */
		rqst.st_wh.wh_nested = wh.wh_nested;		/* breakable nested index */

#ifdef EIF_THREADS
		dthread_id = (rt_uint_ptr) eif_thr_context->tid;
#else
		dthread_id = (rt_uint_ptr) 0;
#endif
		rqst.st_wh.wh_thread_id = (rt_int_ptr) dthread_id; 	/* Current Thread id  -> rt_int_ptr for XDR */
	}

	app_send_packet(sp, &rqst);	/* Send stopped notification */

#undef st_status
#undef st_exception
#undef st_where

}

rt_public void notify_rqst(EIF_PSTREAM sp, int ev_type, rt_uint_ptr ev_data)
{
	/* Send a notification
	 */
	Request rqst;			/* XDR request built */
	Request_Clean (rqst);
	rqst.rq_type = NOTIFIED;/* Notify request */
	rqst.rq_event.st_type = ev_type;
	rqst.rq_event.st_data = ev_data;
	app_send_packet(sp, &rqst);	/* Send notification */
}

rt_shared void dnotify(int evt_type, rt_uint_ptr evt_data)
{
	if (!debug_mode)		/* If not in debugging mode */
		return ;			/* Resume execution immediately */
	notify_rqst(app_sp, evt_type, evt_data);		/* Notify workbench we stopped */
}


/* Encapsulate the 'modify_local' function */
rt_private void modify_local_variable(long arg_stack_depth, long arg_loc_type, long arg_loc_number, EIF_TYPED_VALUE *ip)
{
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
		send_ack(app_sp, result);

		/* prepare next call (will be a 'first') */
		stack_depth = 0;
		loc_type = 0;
		loc_number = 0;
	}
}

/* Encapsulate the 'modify_attr' function */
rt_private void modify_object_attribute(rt_int_ptr arg_addr, long arg_attr_number, EIF_TYPED_VALUE *new_value)
{
	static EIF_REFERENCE object = NULL;
	static long attr_number = 0;
	unsigned char result;
	
	if (new_value == NULL) {
	   if (arg_addr) {
				/* access the object through its hector address */
#ifdef ISE_GC
			object = eif_access((EIF_OBJECT)(&(eif_access((EIF_OBJECT) arg_addr))));
#else
			object = (EIF_REFERENCE) (arg_addr);
#endif
			attr_number = arg_attr_number;	
		}
	} else {
		/* second call, get the new value and call the function */
		result = modify_attr(object, attr_number, new_value);
		
		/* send the acknowledgement */
		send_ack(app_sp, result);

		/* prepare next call (will be a 'first') */
		object = NULL;
		attr_number = 0;
	}
}

rt_private void inspect(EIF_PSTREAM s, Opaque *what)
             		/* Generic structure describing request */
{
		/* Inspect an object. The opaque structure describes the object we want.
		 * Note that the address is stored as a long, because XDR cannot pass
		 * pointers (without also sending the information referred to by this pointer).
		 */
	char *addr;				/* Address of EIF_OBJECT */
	EIF_OBJECT obj;
	

	switch (what->op_1) {		/* First value describes request */
	case IN_H_ADDR:					/* Hector address inspection */
		addr = (char *) what->op_3;		/* long -> (char *) */
		if (what->op_2 > 0) {
			/* Note: op_2 contains the offset */
			EIF_REFERENCE ref = rt_boxed_expanded_item_at_index(eif_access((EIF_OBJECT) addr), what->op_2 - 1);
			obj = (EIF_OBJECT) (&ref);
		} else {
#ifdef ISE_GC
			obj = ((EIF_OBJECT)(&(eif_access((EIF_OBJECT) addr))));
#else
			obj = (EIF_OBJECT) addr;
#endif
		}
		obj_inspect(obj);
		return;
	case IN_BIT_ADDR:				/* Bit address inspection */
		addr = (char *) what->op_3;		/* long -> (char *) */
		bit_inspect(addr);
		return;
	case IN_STRING_ADDR:		/* String object inspection (hector addr) */
		addr = (char *) what->op_3;		/* long -> (char *) */
#ifdef ISE_GC
		string_inspect((EIF_OBJECT)(&(eif_access((EIF_OBJECT) addr))));
#else
		obj_inspect((EIF_OBJECT) addr);
#endif
		return;
	default:
		eif_panic("Unmatched inspect value in `inspect'.");
	}
}

rt_private void once_inspect(EIF_PSTREAM sp, Opaque *what)
					/* The connected socket */
             		/* Generic structure describing request */
{
	/* Check whether a once routine has already been called. In this case
	 * its result may be ask by ewb.
	 */

	EIF_GET_CONTEXT

	int volatile is_process_once = 0;	/* Is once routine process-relative? */
	static char buf[BUFSIZ];

	BODY_INDEX b_index;
	ONCE_INDEX o_index;
	MTOT OResult = (MTOT) 0;				/* Item for once data */
#ifdef EIF_THREADS
	EIF_process_once_value_t * POResult = NULL;	/* Process-relative once data */
#define GetOResult(o_index, is_process_once)	\
		if (is_process_once) {								\
			POResult = EIF_process_once_values + o_index;	\
			OResult = &(POResult -> value);					\
		} else 												\
		OResult = MTOI(o_index);
#else
#define GetOResult(o_index, is_process_once)	\
		OResult = MTOI(o_index);
#endif
	
	
	switch (what->op_1) {			/* First value describes request */
	case OUT_INDEX:					/* ONCE_INDEX for the once routine */
	 	b_index = (BODY_INDEX) what->op_3;	/* Body_id of once routine */
#ifdef EIF_THREADS
		is_process_once = (what->op_2 == OUT_ONCE_PER_PROCESS);
		if (is_process_once) {
			o_index = process_once_index (b_index);
		} else 
#endif
			o_index = once_index (b_index);
		sprintf(buf, "%u", o_index);
		app_twrite(buf, strlen(buf));
		break;
	case OUT_CALLED:				/* Has once routine already been called? */
		o_index = (ONCE_INDEX) what->op_3;
		GetOResult(o_index, (what->op_2 == OUT_ONCE_PER_PROCESS));
		if (MTOD(OResult)) {
			app_twrite("true", 4);
		} else {
			app_twrite("false", 5);
		}
		break;
	case OUT_DATA_PER_PROCESS:			/* Result of already called once function */
		is_process_once = 1;
	case OUT_DATA_PER_THREAD:
		o_index = (ONCE_INDEX) what->op_3;
		GetOResult(o_index, is_process_once);
		if (MTOD(OResult)) {
				/* Done ? */
			app_twrite("true", 4);
				/* Failed ? */
			if (MTOF(OResult) && *MTOF(OResult)) {
				app_twrite("true", 4);
				app_send_reference(sp, *MTOF(OResult), DMP_EXCEPTION_ITEM);
			} else {
				app_twrite("false", 5);
					/* Result */
				if (((int) what->op_2) != 0) {
					send_once_result(sp, OResult, (int) what->op_2);	/* Send result back to ewb */
															/* the last argument is the expected type */
				}
			}
		} else {
			app_twrite("false", 5);
		}
		break;
	default:
		eif_panic("BUG once inspect");
	}
}

rt_private void set_catcall_detection_mode (EIF_PSTREAM sp, int a_console, int a_dbg) 
{
	/* Set current catcall_detection mode off/on */
	app_send_integer (sp, catcall_detection_console_enabled);
	app_send_integer (sp, catcall_detection_debugger_enabled);
	set_catcall_detection_console(a_console);
	set_catcall_detection_debugger(a_dbg);
}

rt_private void set_check_assert (int v) 
{
	/* Set current assertion checking off/on */
	EIF_BOOLEAN old_value;
	old_value = c_check_assert (EIF_TEST(v == 1));
	if (old_value == EIF_TRUE) {
		app_twrite("true", 4);
	} else {
		app_twrite("false", 5);
	}
}

rt_private void adopt(EIF_PSTREAM sp, Opaque *what)
             		/* Generic structure describing request */
{
	/* Adopt an object and return its hector address back to ewb. The
	 * opaque structure describes the object. Note that the address
	 * is stored as a long, because XDR cannot pass pointers (without also
	 * sending the information referred to by this pointer).
	 */

	char *physical_addr;	/* Address of unprotected object */
	int offset;
	physical_addr = (char *) what->op_3;
	offset = what->op_2;
	if (offset > 0) {
		/* We are passing hector address + offset */
		app_send_rt_uint_ptr_as_string (sp, (rt_uint_ptr) eif_protect((EIF_REFERENCE) rt_boxed_expanded_item_at_index(eif_access((EIF_OBJECT) physical_addr), offset - 1)));
	} else {
		app_send_rt_uint_ptr_as_string (sp, (rt_uint_ptr) eif_adopt((EIF_OBJECT) &physical_addr));
	}
}

rt_private void ipc_access(EIF_PSTREAM sp, Opaque *what)

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
	int offset;

	hector_addr = (char *) what->op_3;
	offset = what->op_2;
	if (offset > 0) {
		/* We are passing hector address + offset */
		sprintf(physical_addr, "0x%" EIF_POINTER_DISPLAY, (rt_uint_ptr) eif_access((EIF_OBJECT) rt_boxed_expanded_item_at_index(eif_access((EIF_OBJECT) hector_addr), offset - 1)));
	} else {
		sprintf(physical_addr, "0x%" EIF_POINTER_DISPLAY, (rt_uint_ptr) eif_access((EIF_OBJECT) hector_addr));
	}
	app_twrite(physical_addr, strlen(physical_addr));
}

rt_private void wean(EIF_PSTREAM sp, Opaque *what)
             		/* Generic structure describing request */
{
	/* Wean an adopted object. The opaque structure describes the object.
	 * Note that the address is stored as a long, because XDR cannot pass
	 * pointers (without also sending the information referred to by
	 * this pointer).
	 */

	char *hector_addr;		/* Hector address with indirection */
	int offset;

	hector_addr = (char *) what->op_3;
	offset = what->op_2;
	if (offset > 0) {
		/* We are passing hector address + offset */
		eif_wean((EIF_OBJECT) rt_boxed_expanded_item_at_index(eif_access((EIF_OBJECT) hector_addr), offset - 1));
	} else {
		eif_wean((EIF_OBJECT) hector_addr);
	}
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

	EIF_PSTREAM sp = app_sp;

	Request rqst;				/* Loading BYTECODE request */
	unsigned char *bc;					/* Location of loaded byte code */
	int i;

#ifdef USE_ADD_LOG
		add_log(9, "in load_bc slots %d amount %d", slots, amount);
#endif

	Request_Clean (rqst);
	send_ack(sp, AK_OK);				/* Extension succeeded */

#ifdef USE_ADD_LOG
		add_log(9, "made room");
#endif

#define arg_1	rqst.rq_opaque.op_1
#define arg_2	rqst.rq_opaque.op_2

	/* The byte codes have a BYTECODE leading request giving the body index
	 * and body ID information, which is followed by a transfer request to
	 * download the byte code itself.
	 */

	for (i = 0; i < amount; i++) {		/* Now loop to get all byte codes */
#ifdef USE_ADD_LOG
		add_log(9, "in load_bc loop");
#endif

		/* Read BYTECODE request */
#ifdef EIF_WINDOWS
		app_recv_packet(sp, &rqst, TRUE);			
#else
		app_recv_packet(sp, &rqst);
#endif
		if (rqst.rq_type != BYTECODE) {	/* Wrong request */
			send_ack(sp, AK_PROTO);		/* Protocol error */
			return;
		}
#ifdef USE_ADD_LOG
		add_log(9, "received packet BYTECODE");
#endif
		bc = (unsigned char *) app_tread((int *) 0);			/* Get byte code in memory */
		if (bc == NULL) {			/* Not enough memory */
			send_ack(sp, AK_ERROR);		/* Notify failure */
			return;						/* And abort downloading */
		}
#ifdef USE_ADD_LOG
		add_log(9, "app_tread bytecode");
#endif
		drecord_bc((BODY_INDEX) arg_1, (BODY_INDEX) arg_2, bc);	/* Place byte code in run-time tables*/
#ifdef USE_ADD_LOG
		add_log(9, "recorded bc");
#endif
		send_ack(sp, AK_OK);				/* Byte code loaded successfully */
#ifdef USE_ADD_LOG
		add_log(9, "sent ack");
#endif
	}

#undef arg_1
#undef arg_2
}

/*
 *		Routines for inspecting an Eiffel object.
 */


rt_private void rec_inspect(EIF_REFERENCE object);
rt_private void rec_sinspect(EIF_REFERENCE object, EIF_BOOLEAN skip_items);
rt_private void rec_tinspect(EIF_REFERENCE object);

rt_private void obj_inspect(EIF_OBJECT object)
{
	uint32 flags;		/* Object lags */
	EIF_BOOLEAN is_special, is_tuple;
	int32 dtype;
	EIF_REFERENCE ref = eif_access(object);
	if (ref == NULL) {
		is_special = EIF_FALSE;
		is_tuple = EIF_FALSE;
		app_twrite (&is_special, sizeof(EIF_BOOLEAN));
		app_twrite (&is_tuple, sizeof(EIF_BOOLEAN));
			/* Send -1 as dynamic id to notify an issue */
		dtype = -1;
		app_twrite (&dtype, sizeof(int32));
		return;
	}
	flags = HEADER(ref)->ov_flags;
	is_special = EIF_TEST(flags & EO_SPEC);	
	is_tuple = EIF_TEST(flags & EO_TUPLE);	
	app_twrite (&is_special, sizeof(EIF_BOOLEAN));
	app_twrite (&is_tuple, sizeof(EIF_BOOLEAN));
		/* Send class dynamic id */
	dtype = Dtype(ref);
	app_twrite (&dtype, sizeof(int32));
					
	if (is_special) {
			/* Send items recursively */
		if (is_tuple) {
			rec_tinspect(ref);
		} else {
			rec_sinspect(ref, EIF_FALSE);
		}
	} else {
			/* Inspect recursively `object' */
		rec_inspect(ref);
	}
}

rt_private void rec_inspect(EIF_REFERENCE object)
{
	/* Inspect recursively `object''s attribute */

	struct cnode *obj_desc;		/* Object type description */
	int32 nb_attr;							/* Attribute number */
	uint32 *types;				/* Attribute types */
	int32 *cn_attr;				/* Attribute keys */
	long offset;
	EIF_TYPE_INDEX dtype;				/* Object dynamic type */
	EIF_REFERENCE o_ref;
	EIF_REFERENCE reference;				/* Reference attribute */
	char **names;					/* Attribute names */
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
	app_twrite (&nb_attr, sizeof(int32));

	for (i = 0; i < nb_attr; i++) {

		/* Send attribute name */
		name = names[i];
		app_twrite (name, strlen(name));

		/* Send attribute value */
		type = types[i];
		CAttrOffs(offset,cn_attr[i],dtype);
		o_ref = object + offset;
		sk_type = type & SK_HEAD;
		if (sk_type != SK_REF)
			app_twrite (&sk_type, sizeof(uint32));

		switch(sk_type) {
		case SK_POINTER: app_twrite (o_ref, sizeof(EIF_POINTER)); break;
		case SK_BOOL: app_twrite (o_ref, sizeof(EIF_BOOLEAN)); break;
		case SK_CHAR: app_twrite (o_ref, sizeof(EIF_CHARACTER)); break;
		case SK_WCHAR: app_twrite (o_ref, sizeof(EIF_WIDE_CHAR)); break;
		case SK_UINT8: app_twrite (o_ref, sizeof(EIF_NATURAL_8)); break;
		case SK_UINT16: app_twrite (o_ref, sizeof(EIF_NATURAL_16)); break;
		case SK_UINT32: app_twrite (o_ref, sizeof(EIF_NATURAL_32)); break;
		case SK_UINT64: app_twrite (o_ref, sizeof(EIF_NATURAL_64)); break;
		case SK_INT8: app_twrite (o_ref, sizeof(EIF_INTEGER_8)); break;
		case SK_INT16: app_twrite (o_ref, sizeof(EIF_INTEGER_16)); break;
		case SK_INT32: app_twrite (o_ref, sizeof(EIF_INTEGER_32)); break;
		case SK_INT64: app_twrite (o_ref, sizeof(EIF_INTEGER_64)); break;
		case SK_REAL32: app_twrite (o_ref, sizeof(EIF_REAL_32)); break;
		case SK_REAL64: app_twrite (o_ref, sizeof (EIF_REAL_64)); break;
		case SK_BIT:
			bit_inspect(o_ref);
			break;
		case SK_EXP:
			{
				int32 dtype = Dtype(o_ref);
				app_twrite (&dtype, sizeof(int32));
				app_twrite (&o_ref, sizeof(EIF_POINTER));
			}
			break;
		default:
			{
					/* Object reference */
			  	EIF_BOOLEAN is_special = EIF_FALSE, is_void = FALSE;

				reference = *(EIF_REFERENCE *)o_ref;
				if (reference) {
					int32 dtype = Dtype(reference);
					ref_flags = HEADER(reference)->ov_flags;
					app_twrite (&sk_type, sizeof(uint32));
					if (ref_flags & EO_SPEC) {
						EIF_BOOLEAN is_tuple = EIF_TEST(ref_flags & EO_TUPLE);
						is_special = EIF_TRUE;
						app_twrite (&is_special, sizeof(EIF_BOOLEAN));
						app_twrite (&is_tuple, sizeof(EIF_BOOLEAN));
						if (is_tuple) {
							app_twrite (&dtype, sizeof(int32));
							app_twrite (&reference, sizeof(EIF_POINTER));
						} else {
							rec_sinspect (reference, EIF_TRUE);
						}
					} else {
						app_twrite (&is_special, sizeof(EIF_BOOLEAN));
						app_twrite (&is_void, sizeof(EIF_BOOLEAN));
						app_twrite (&dtype, sizeof(int32));
						app_twrite (&reference, sizeof(EIF_POINTER));
					}
				} else {
					is_void = EIF_TRUE;
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&is_special, sizeof(EIF_BOOLEAN));
					app_twrite (&is_void, sizeof(EIF_BOOLEAN));
				}
			}
		}
	}
}

rt_private void rec_sinspect(EIF_REFERENCE object, EIF_BOOLEAN skip_items)
{
	/* Inspect special object */

	union overhead *zone;		/* Object header */
	uint32 flags;		/* Object flags */
	long sp_index;	/* Element index */
	rt_uint_ptr elem_size;	/* Element size */
	char *o_ref;
	char *reference;
	int32 count,capacity;					/* Element count */
	uint32 nb_attr, sk_type;
	long sp_start, sp_end;		/* Bounds for inspection */
	uint32 dtype;
	static char buffer[BUFSIZ]; 	/* Buffer used for converting integers into a string */

		/* Send address of Current object */
	app_twrite (&object, sizeof (EIF_POINTER));

	zone = HEADER(object);
	count = RT_SPECIAL_COUNT(object);
	capacity = RT_SPECIAL_CAPACITY(object);
	elem_size = RT_SPECIAL_ELEM_SIZE(object);
	flags = zone->ov_flags;
	dtype = Dtype(object);

		/* Send the count of the special object */
	app_twrite (&count, sizeof(int32));

		/* Send the capacity of the special object */
	app_twrite (&capacity, sizeof(int32));

	if (skip_items == EIF_FALSE) {
		/* Compute the number of items within the bounds */
		if (sp_upper < 0) {				/* A negative `sp_upper' means `count' */
			sp_end = count - 1;
		} else if (count > sp_upper + 1) {	/* Must be truncated */
			sp_end = sp_upper;
		} else {						/* No need to truncate */
			sp_end = count - 1;
		}
		if (sp_lower > 0) {		/* Must be truncated */
			sp_start = sp_lower;
		} else {
				/* A negative `sp_lower' means 0 */
			sp_start = 0;
		}

			/* Compute number of items that will be inspected */
		if (sp_start > sp_end)
			nb_attr = 0;
		else
			nb_attr = sp_end - sp_start + 1;
	  
			/* Send the number of items to be inspected */
		app_twrite (&nb_attr, sizeof(uint32));

			/* Send the items within the bounds */
		if (nb_attr > 0) {
			if (flags & EO_COMP) {
					/* Special of expanded object. */
				for (o_ref = object + OVERHEAD + ((rt_uint_ptr) sp_start * elem_size),
							sp_index = sp_start; sp_index <= sp_end;
							sp_index++, o_ref += elem_size) {
					sprintf(buffer, "%ld", sp_index);
					app_twrite (buffer, strlen(buffer));
					sk_type = SK_EXP;
					app_twrite (&sk_type, sizeof(uint32));
					dtype = Dtype(o_ref);
					app_twrite (&dtype, sizeof(int32));
/* For SPECIAL object containing expanded objects
 * we need to send the data right away, since there is no (hector) address associated with
 * the expanded objects, there are known from the SPECIAL object + index, 
 * and that's it. So there is no sense to send this "fake" address
 * 					app_twrite (&o_ref, sizeof(EIF_POINTER)); */
					rec_inspect(o_ref);
				}
			} else if (!(flags & EO_REF)) {
					/* Special of basic types. */
				if (dtype == egc_sp_char)
					sk_type = SK_CHAR;
				else if (dtype == egc_sp_wchar)
					sk_type = SK_WCHAR;
				else if (dtype == egc_sp_uint8)
					sk_type = SK_UINT8;
				else if (dtype == egc_sp_uint16)
					sk_type = SK_UINT16;
				else if (dtype == egc_sp_uint32)
					sk_type = SK_UINT32;
				else if (dtype == egc_sp_uint64)
					sk_type = SK_UINT64;
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
				else if (dtype == egc_sp_real32)
					sk_type = SK_REAL32;
				else if (dtype == egc_sp_real64)
					sk_type = SK_REAL64;
				else if (dtype == egc_sp_pointer)
					sk_type = SK_POINTER;
				else {
					CHECK("Must be a bit", dtype == egc_bit_dtype);
					sk_type = SK_BIT;
				}

				for (o_ref = object + ((rt_uint_ptr) sp_start * elem_size),
									sp_index = sp_start; sp_index <= sp_end;
									sp_index++, o_ref += elem_size) {
					sprintf(buffer, "%ld", sp_index);
					app_twrite (buffer, strlen(buffer));

					app_twrite (&sk_type, sizeof(uint32));

					switch(sk_type) {
					case SK_POINTER: app_twrite (o_ref, sizeof(EIF_POINTER)); break;
					case SK_BOOL: app_twrite (o_ref, sizeof(EIF_BOOLEAN)); break;
					case SK_CHAR: app_twrite (o_ref, sizeof(EIF_CHARACTER)); break;
					case SK_WCHAR: app_twrite (o_ref, sizeof(EIF_WIDE_CHAR)); break;
					case SK_UINT8: app_twrite (o_ref, sizeof(EIF_NATURAL_8)); break;
					case SK_UINT16: app_twrite (o_ref, sizeof(EIF_NATURAL_16)); break;
					case SK_UINT32: app_twrite (o_ref, sizeof(EIF_NATURAL_32)); break;
					case SK_UINT64: app_twrite (o_ref, sizeof(EIF_NATURAL_64)); break;
					case SK_INT8: app_twrite (o_ref, sizeof(EIF_INTEGER_8)); break;
					case SK_INT16: app_twrite (o_ref, sizeof(EIF_INTEGER_16)); break;
					case SK_INT32: app_twrite (o_ref, sizeof(EIF_INTEGER_32)); break;
					case SK_INT64: app_twrite (o_ref, sizeof(EIF_INTEGER_64)); break;
					case SK_REAL32: app_twrite (o_ref, sizeof(EIF_REAL_32)); break;
					case SK_REAL64: app_twrite (o_ref, sizeof (EIF_REAL_64)); break;
					case SK_BIT:
						bit_inspect (eif_access(o_ref));
						break;
					}
				}
			} else {
					/* Special of reference. */
				EIF_BOOLEAN is_void = EIF_FALSE;
				EIF_BOOLEAN is_special = EIF_FALSE;
				EIF_BOOLEAN is_tuple = EIF_FALSE;
				uint32 sk_type = SK_REF;
				for (o_ref = (char *) ((char **)object + sp_start),
							sp_index = sp_start; sp_index <= sp_end; 
							sp_index++, o_ref = (char *) ((char **)o_ref + 1)) {
					sprintf(buffer, "%ld", sp_index);
					app_twrite (buffer, strlen(buffer));
					reference = *(char **)o_ref;
					if (!reference) {
						is_void = EIF_TRUE;
						app_twrite (&sk_type, sizeof(uint32));
						app_twrite (&is_special, sizeof(EIF_BOOLEAN));
						app_twrite (&is_void, sizeof(EIF_BOOLEAN));
						is_void = EIF_FALSE;
					} else {
						dtype = Dtype(reference);
						app_twrite (&sk_type, sizeof(uint32));
						if (HEADER(reference)->ov_flags & EO_SPEC) {
							is_special = EIF_TRUE;
							is_tuple = EIF_TEST(HEADER(reference)->ov_flags & EO_TUPLE);

							app_twrite (&is_special, sizeof(EIF_BOOLEAN));
							app_twrite (&is_tuple, sizeof(EIF_BOOLEAN));
							if (is_tuple) {
								app_twrite (&dtype, sizeof(int32));
								app_twrite (&reference, sizeof(EIF_POINTER));
								is_tuple = EIF_FALSE;
							} else {
								rec_sinspect (reference, EIF_TRUE);
							}
							is_special = EIF_FALSE;
						} else {
							app_twrite (&is_special, sizeof(EIF_BOOLEAN));
							app_twrite (&is_void, sizeof(EIF_BOOLEAN));

							app_twrite (&dtype, sizeof(int32));
							app_twrite (&reference, sizeof(EIF_POINTER));
						}
					}
				}
			}
		}
	}
}

rt_private void rec_tinspect(EIF_REFERENCE object)
{
	/* Inspect special object */

	int32 count, i;
	uint32 sk_type;
	static char buffer[BUFSIZ]; 	/* Buffer used for converting integers into a string */

		/* Send address of Current object */
	app_twrite (&object, sizeof (EIF_POINTER));

	count = RT_SPECIAL_COUNT(object);

		/* Send the capacity of the special object */
	app_twrite (&count, sizeof(int32));

		/* Send the number of items to be inspected */
	app_twrite (&count, sizeof(uint32));

		/* Send the items within the bounds */
	if (count > 0) {
		EIF_TYPED_VALUE * l_item = (EIF_TYPED_VALUE *) object;
			/* Don't forget that first element of TUPLE is the BOOLEAN
			 * `object_comparison' attribute. */
		for (i = 0; count > 0; count--, i++, l_item++) {
			sprintf (buffer, "%d", i);
			app_twrite (buffer, strlen(buffer));
			sk_type = eif_tuple_item_sk_type(l_item);
			switch (sk_type) {
				case SK_UINT8:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_natural_8_tuple_item(l_item), sizeof(EIF_NATURAL_8));
					break;
				case SK_UINT16:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_natural_16_tuple_item(l_item), sizeof(EIF_NATURAL_16));
					break;
				case SK_UINT32:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_natural_32_tuple_item(l_item), sizeof(EIF_NATURAL_32));
					break;
				case SK_UINT64:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_natural_64_tuple_item(l_item), sizeof(EIF_NATURAL_64));
					break;
				case SK_INT8:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_integer_8_tuple_item(l_item), sizeof(EIF_INTEGER_8));
					break;
				case SK_INT16:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_integer_16_tuple_item(l_item), sizeof(EIF_INTEGER_16));
					break;
				case SK_INT32:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_integer_32_tuple_item(l_item), sizeof(EIF_INTEGER_32));
					break;
				case SK_INT64:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_integer_64_tuple_item(l_item), sizeof(EIF_INTEGER_64));
					break;
				case SK_BOOL:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_boolean_tuple_item(l_item), sizeof(EIF_BOOLEAN));
					break;
				case SK_CHAR:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_character_tuple_item(l_item), sizeof(EIF_CHARACTER));
					break;
				case SK_REAL64:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_real_64_tuple_item(l_item), sizeof(EIF_REAL_64));
					break;
				case SK_REAL32:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_real_32_tuple_item(l_item), sizeof(EIF_REAL_32));
					break;
				case SK_POINTER:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_pointer_tuple_item(l_item), sizeof(EIF_POINTER));
					break;
				case SK_WCHAR:
					app_twrite (&sk_type, sizeof(uint32));
					app_twrite (&eif_wide_character_tuple_item(l_item), sizeof(EIF_WIDE_CHAR));
					break;
				case SK_REF:
					{
						EIF_BOOLEAN is_special = EIF_FALSE, is_void = FALSE;
						EIF_REFERENCE reference = eif_reference_tuple_item(l_item);
						app_twrite (&sk_type, sizeof(uint32));

						if (reference) {
							uint32 ref_flags = HEADER(reference)->ov_flags;
							int32 dtype = Dtype(reference);
							if (ref_flags & EO_SPEC) {
								EIF_BOOLEAN is_tuple = EIF_TEST(ref_flags & EO_TUPLE);
								is_special = EIF_TRUE;
								app_twrite (&is_special, sizeof(EIF_BOOLEAN));
								app_twrite (&is_tuple, sizeof(EIF_BOOLEAN));
								if (is_tuple) {
									app_twrite (&dtype, sizeof(int32));
									app_twrite (&reference, sizeof(EIF_POINTER));
								} else {
									rec_sinspect (reference, EIF_TRUE);
								}
							} else {
								app_twrite (&is_special, sizeof(EIF_BOOLEAN));
								app_twrite (&is_void, sizeof(EIF_BOOLEAN));
								app_twrite (&dtype, sizeof(int32));
								app_twrite (&reference, sizeof(EIF_POINTER));
							}
						} else {
							is_void = EIF_TRUE;
							app_twrite (&is_special, sizeof(EIF_BOOLEAN));
							app_twrite (&is_void, sizeof(EIF_BOOLEAN));
						}
						break;
					}
			}
		}
	}
}

rt_private void bit_inspect(EIF_REFERENCE object)
               		/* Reference to a bit object (= BIT_REF) */
{
	char *buf = b_out(object);
	app_twrite (buf, strlen(buf));
	eif_rt_xfree(buf);
}

rt_private void string_inspect(EIF_OBJECT object)
               		/* Reference to a string object */
{
		/* Inspect the string object to get the string value */

	struct cnode *obj_desc;		/* Object type description */
	long nb_attr;					/* Attribute number */
	int32 *cn_attr;				/* Attribute keys */
	long offset;
	EIF_TYPE_INDEX dtype;				/* Object dynamic type */
	char *o_ref;
	char **names;					/* Attribute names */
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
	CHECK("has string area", string_area);
	if (string_count > DEFAULT_SLICE + 1)	/* Send only the beginning of */
		string_count = DEFAULT_SLICE + 1;	/* the string if it is too big */
	app_twrite (string_area, string_count);
}

rt_private unsigned char smodify_attr(char *object, long attr_number, EIF_TYPED_VALUE *new_value)
	{
	/* Modify an attribute of a special object */

	union overhead *zone;		/* Object header */
	uint32 flags;				/* Object flags */
	rt_uint_ptr elem_size;				/* Element size */
	char *o_ref;
	char *new_object_attr;		/* new value for the attribute (if new value is a reference) */
	unsigned char error_code = 0;

	REQUIRE("is_special", RT_IS_SPECIAL(object));

	zone = HEADER(object);
	elem_size = RT_SPECIAL_ELEM_SIZE(object);
	flags = zone->ov_flags;

	/* Send the items within the bounds */
	if (!(flags & EO_REF)) {
		if (flags & EO_COMP) { /* expanded object */
			error_code = 2;
		} else {
			o_ref = object + ((rt_uint_ptr) attr_number * elem_size);
			switch(new_value->type & SK_HEAD) {
				case SK_POINTER: *(char **)o_ref = new_value->it_ptr; break;
				case SK_BOOL:
				case SK_CHAR: *(EIF_CHARACTER *)o_ref = new_value->it_char; break;
				case SK_WCHAR: *(EIF_WIDE_CHAR *)o_ref = new_value->it_wchar; break;
				case SK_UINT8: *(EIF_NATURAL_8 *)o_ref = new_value->it_uint8; break;
				case SK_UINT16: *(EIF_NATURAL_16 *)o_ref = new_value->it_uint16; break;
				case SK_UINT32: *(EIF_NATURAL_32 *)o_ref = new_value->it_uint32; break;
				case SK_UINT64: *(EIF_NATURAL_64 *)o_ref = new_value->it_uint64; break;
				case SK_INT8: *(EIF_INTEGER_8 *)o_ref = new_value->it_int8; break;
				case SK_INT16: *(EIF_INTEGER_16 *)o_ref = new_value->it_int16; break;
				case SK_INT32: *(EIF_INTEGER_32 *)o_ref = new_value->it_int32; break;
				case SK_INT64: *(EIF_INTEGER_64 *)o_ref = new_value->it_int64; break;
				case SK_REAL32: *(EIF_REAL_32 *)o_ref = new_value->it_real32; break;
				case SK_REAL64: *(EIF_REAL_64 *)o_ref = new_value->it_real64; break;
				case SK_BIT: 
					/* FIXME ARNAUD: To do... */
					return 1; /* not yet implemented */
				default: 
					return 1; /* unexpected value */
			}
		}
	} else {
		switch(new_value->type & SK_HEAD) {
			case SK_STRING:
				*(char **)object = RTMS(new_value->it_ref);
				break;
			default: /* Object reference */
				o_ref = (char *) ((char **)object + attr_number);

				/* access the object through its hector address */
#ifdef ISE_GC
				new_object_attr = eif_access((EIF_OBJECT)(&(eif_access((EIF_OBJECT) (new_value->it_ref)))));
#else
				new_object_attr = (EIF_REFERENCE) (new_value->it_ref);
#endif
				*(EIF_REFERENCE *)o_ref = new_object_attr;
				/* inform the GC that new_value is now referrenced as `object' */
				RTAR(object, new_object_attr);
				break;
		}
	}

	return error_code;
}

/* addr: address of the object where attribute to modify lies */
/* attr_number: */
/* new_value: */
rt_private unsigned char modify_attr(EIF_REFERENCE object, long attr_number, EIF_TYPED_VALUE *new_value)
{
	/* modify recursively `object''s attribute */

	struct cnode *obj_desc;		/* Object type description */
	long nb_attr;				/* Attribute number */
	int32 *cn_attr;				/* Attribute keys */
	long offset;				/* Offset of the attribute within object structure */
	EIF_TYPE_INDEX dtype;			/* Object dynamic type */
	char *o_ref;				/* Attribute address */
	char *new_object_attr;		/* new value for the attribute (if new value is a reference) */
	uint32 ref_flags;


	dtype = Dtype(object);
	obj_desc = &System(dtype);
	ref_flags = HEADER(object)->ov_flags;

	if (ref_flags & EO_SPEC) {
		if (ref_flags & EO_TUPLE) {
			/* FIXME: to implement */
		} else {
			/* Special object */
			return smodify_attr(object, attr_number, new_value);
		}
	} else {
		/* get characteristic of the object */
		nb_attr = obj_desc->cn_nbattr;
		cn_attr = obj_desc->cn_attr;
	
		/* check that the given attribute number is not out-of-bounds */
		if (attr_number > nb_attr)
			return 1; /* error */
		
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
			case SK_REAL32: /* Real attribute */
				*(EIF_REAL_32 *)o_ref = new_value->it_real32;
				break;
			case SK_REAL64: /* Double attribute */
				*(EIF_REAL_64 *)o_ref = new_value->it_real64;
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
#ifdef ISE_GC
				new_object_attr = eif_access((EIF_OBJECT)(&(eif_access((EIF_OBJECT) (new_value->it_ref)))));
#else
				new_object_attr = (EIF_REFERENCE) (new_value->it_ref);
#endif
				*(EIF_REFERENCE *)o_ref = new_object_attr;
				/* inform the GC that new_value is now referrenced is `object' */
				RTAR(object, new_object_attr);
				break;
		}
	}
	return 0;
}

rt_private void opush_dmpitem(EIF_TYPED_VALUE *item)
{
	switch (item->type & SK_HEAD) {
		case SK_REF:
			if (item->it_ref) {
				item->it_ref = eif_access(item->it_ref); /* unprotect this object */
			}
			break;
		case SK_STRING:
			item->it_ref = RTMS(item->it_ref);
			break;
		default:
			/* do nothing. leave the item as it is */
			break;
	}
	opush(item);
	if (previous_otop == NULL) {
			/* First call in pushing arguments for a debugger evaluation, record top of stack
			 * prior the push. We do not do it before the call to `opush' in the event that
			 * the stack has not yet been created in which case `otop' would be NULL. */
		previous_otop = otop();
		CHECK("has_top", previous_otop);
		previous_otop--;
	}
	nb_pushed++;
}

rt_private void opush_ref_offset_item(rt_int_ptr a_addr, int a_offset)
{
	/* Used for items of SPECIAL [expanded] */
	EIF_TYPED_VALUE item;
	EIF_REFERENCE obj;

#ifdef ISE_GC
	obj = eif_access((EIF_OBJECT) a_addr);
#else
	obj = (EIF_REFERENCE) (arg_addr);
#endif

	item.type = SK_REF|SK_EXP;
	item.it_r = rt_boxed_expanded_item_at_index (obj, a_offset - 1);

	opush(&item);
	if (previous_otop == NULL) {
			/* First call in pushing arguments for a debugger evaluation, record top of stack
			 * prior the push. We do not do it before the call to `opush' in the event that
			 * the stack has not yet been created in which case `otop' would be NULL. */
		previous_otop = otop();
		CHECK("has_top", previous_otop);
		previous_otop--;
	}
	nb_pushed++;
}

rt_private EIF_REFERENCE rt_boxed_expanded_item_at_index (EIF_REFERENCE a_obj, int a_index)
{
	/* 
	 * boxed expanded item referenced by hector address `a_obj' and `a_index' as offset 
	 */

	REQUIRE("is_special", RT_IS_SPECIAL(a_obj));
	if (a_index < 0) {
		eraise ("index_large_enough", EN_RT_CHECK);
	}
	if (a_index >= RT_SPECIAL_COUNT(a_obj)) {
		eraise ("index_small_enough", EN_RT_CHECK);
	}
	return RTCL(a_obj + OVERHEAD + (rt_uint_ptr) a_index * RT_SPECIAL_ELEM_SIZE(a_obj));
}

rt_private void dbg_dump_rt_extension_object (EIF_PSTREAM sp)
{
	/* Dump the rt_extension_obj */

	app_send_reference (sp, rt_extension_obj, DMP_ITEM);
}

rt_private void dbg_new_instance_of_type (EIF_PSTREAM sp, EIF_TYPE_INDEX typeid)
{
	/* Must be the typeid of a Reference class */

	EIF_TYPED_VALUE *ip = NULL;
	Request rqst;				/* What we receive and send back */
	EIF_REFERENCE tmp = NULL;
	EIF_REFERENCE loc1 = NULL;
	EIF_TYPE_ID tid;
	char* s = NULL;

	/* Get type name */
	Request_Clean (rqst);
	/* Get request */
#ifdef EIF_WINDOWS
	if (-1 == app_recv_packet(sp, &rqst, TRUE)) 
#else
	if (-1 == app_recv_packet(sp, &rqst))
#endif
	{
		send_ack(sp, AK_ERROR);		/* Protocol error */
		return;
	}
	if (rqst.rq_type == DUMPED && rqst.rq_dump.dmp_type == DMP_ITEM) {
		ip = rqst.rq_dump.dmp_item;
		if ((ip != NULL) && (ip->type & SK_HEAD) == SK_STRING) {
			s = (char*) ip->it_ref;
		}
		ip = NULL;
	}
	if (s == NULL) {
		send_ack(sp, AK_ERROR);		/* Protocol error */
	} else {
		send_ack(sp, AK_OK);
		tid = eif_type_id(s);
		if (tid != -1) {
			CHECK("valid tid", rt_valid_type_index(tid));
			loc1 = RTLNSMART((EIF_TYPE_INDEX) tid);
		}
		if (loc1 != NULL) {
			tmp = (EIF_REFERENCE) RTCCL(loc1); /* clone */
		}
		app_send_reference (sp, tmp, DMP_ITEM);
	}
}

rt_private void dynamic_evaluation (EIF_PSTREAM sp, int fid_or_offset, int stype_or_origin, int dtype, int is_precompiled, int is_basic_type, int is_static_call)
{
	EIF_TYPED_VALUE ip;

	int b = exec_recording_enabled;
	int exception_occured = 0;	/* Exception occurred ? */

	exec_recording_enabled = 0; /* Disable execution recording status */

	dynamic_eval_dbg(fid_or_offset,stype_or_origin, dtype, is_precompiled, is_basic_type, is_static_call, previous_otop, nb_pushed, &exception_occured, &ip);

	if (ip.type == SK_VOID) {
		app_send_typed_value (sp, NULL, DMP_VOID);
	} else {
		if (exception_occured == 1) {
			app_send_typed_value (sp, &ip, DMP_EXCEPTION_ITEM);
		} else {
			app_send_typed_value (sp, &ip, DMP_ITEM);
		}
	}

	/* reset info concerning otop */
	previous_otop = NULL;
	nb_pushed = 0;

	exec_recording_enabled = b; /* Restore execution recording status */
}

