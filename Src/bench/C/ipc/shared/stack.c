/*

  ####    #####    ##     ####   #    #           ####
 #          #     #  #   #    #  #   #           #    #
  ####      #    #    #  #       ####            #
      #     #    ######  #       #  #     ###    #
 #    #     #    #    #  #    #  #   #    ###    #    #
  ####      #    #    #   ####   #    #   ###     ####

	Sending various stack dumps...

	Here are a set of routines used by the communication routines to send
	the exception stacks. This package knows that the eif_trace stack must
	be read backwards, and also needs to know whether the aplication stopped
	because of an implicit exception or not.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_debug.h"
#include "eif_interp.h"
#include "eif_except.h"
#include "eif_garcol.h"
#include "eif_malloc.h"
#include "stack.h"
#include "com.h"
#include "request.h"
#include "eif_macros.h"
#include "eif_globals.h"

#ifdef EIF_WIN32
#include "stream.h"
#endif

#define EIF_IGNORE	-1	/*	We do not want this item sent, but there are still
					 *	items to send. Useful for getting rid of EX_OSTK
					 *	pseudo exception vector -- Didier
					 */

/* Record a stack context, while performing dumps, and restore it afterwards.
 * We have a provision here for all the possible stack we may inspect.
 */
rt_private struct xstack xstk_context;		/* Saved exception stack context */
rt_private struct dbstack dstk_context;	/* Saved calling stack context */
rt_private struct opstack istk_context;	/* Operational stack (interpreter) */
rt_private struct stack ostk_context;		/* Once stack */

rt_private int dump_mode;	/* Mode of the active dump we are currently using */
rt_private int is_first;	/* First item dumped? (matters for pending exception) */

/* Every stack has its own way of being dumped. During the initialization
 * process, this pointer is set to the correct function to be called. It may
 * also be temporarily overwritten in some nested operation (like dumping the
 * variables inside a routine, while in fact dumping the whole stack at a
 * higher level).
 */
rt_private struct dump *(*stk_next)(void);		/* Function used to perform dump */

/* Routine declarations */
#ifdef EIF_WIN32
rt_private void send_dump(STREAM *s, struct dump *dp);			/* Send XDR'ed dumped item to ewb */
#else
rt_private void send_dump(int s, struct dump *dp);			/* Send XDR'ed dumped item to ewb */
#endif

rt_private void stk_start(int what);			/* Initialize automaton */
rt_private void stk_end(int what);				/* Reset saved stack contexts */
rt_private struct dump *pending(void);		/* List pending exceptions */
rt_private struct dump *execution(void);	/* List execution stack */
rt_private struct dcall *safe_dtop(void);	/* Perform a safe dtop() without eif_panic */
rt_private void init_var_dump(struct dcall *call);		/* Initialize register context */
rt_private struct dump *variable(void);	/* Dump variables */
rt_private struct dump *local(int n);		/* Return local by number */
rt_private struct dump *argument(int n);	/* Return argument by number */
rt_private struct dump *once(void);		/* Dump once stack */

rt_private void show_dumped (struct dump d);
rt_private void show_vector(struct ex_vect *dump);

#ifdef EIF_WIN32
rt_public void send_stack(STREAM *s, int what)
#else
rt_public void send_stack(int s, int what)
#endif
      			/* The connected socket */
         		/* Which stack should be sent */
{
	/* This is the main routine. It send a whole stack dump to the remote
	 * process through the connected socket and via XDR. The end of the dump
	 * is indicated by a positive acknowledgment.
	 */

	struct dump *dp;			/* Pointer to static data where dump is */

	stk_start(what);			/* Initialize processing */
	while (dp = (stk_next)()){	/* While still some data to send */
		if ((int) dp != EIF_IGNORE)
			send_dump(s, dp);
	}
	stk_end (what);
	send_ack(s, AK_OK);			/* End of list -- you got everything */
}

#ifdef EIF_WIN32
rt_private void send_dump(STREAM *s, struct dump *dp)
#else
rt_private void send_dump(int s, struct dump *dp)
#endif
      				/* The connected socket */
                	/* Item to send */
{
	Request rqst;					/* What we send back */

	Request_Clean (rqst);
	rqst.rq_type = DUMPED;			/* A dumped stack item */
	bcopy(dp, &rqst.rq_dump, sizeof(struct dump));
	send_packet(s, &rqst);			/* Send to network */
}

/*
 * Iterator initialization and final clean up.
 */

rt_private void stk_start(EIF_CONTEXT int what)
         		/* Dumping status wanted */
{
	/* Initialize the dumping procedure. This whole package is nothing more
	 * than a finite state automaton, though the transition tables are in
	 * my mind, this program being only an implicit translation. Any typos
	 * are mine :-) -- RAM
	 */
	EIF_GET_CONTEXT
	dump_mode = what;	/* Save working mode */

	/* Save the appropriate stack context, depending on the operations to
	 * be performed...
	 */

	switch (what) {
	case ST_PENDING:
		bcopy(&eif_trace, &xstk_context, sizeof(struct xstack));
		is_first = 1;
		stk_next = pending;
		break;
	case ST_CALL:
	case ST_FULL:
		bcopy(&eif_stack, &xstk_context, sizeof(struct xstack));
		bcopy(&db_stack, &dstk_context, sizeof(struct dbstack));
		bcopy(&op_stack, &istk_context, sizeof(struct opstack));
		stk_next = execution;
		break;
	case ST_LOCAL:
	case ST_ARG:
	case ST_VAR:
		bcopy(&op_stack, &istk_context, sizeof(struct opstack));
		init_var_dump(d_cxt.pg_active);
		stk_next = variable;
		break;
	case ST_ONCE:
		bcopy(&once_set, &ostk_context, sizeof(struct stack));
		stk_next = once;
		break;
	default:
		eif_panic("illegal dump request");
	}
	EIF_END_GET_CONTEXT
}

rt_private void stk_end(EIF_CONTEXT int what)
{
	/* Restore context of all the stack we had to modify/inspect */
	EIF_GET_CONTEXT

	switch (what) {
	case ST_PENDING:
		bcopy(&xstk_context, &eif_trace, sizeof(struct xstack));
		break;
	case ST_CALL:
	case ST_FULL:
		bcopy(&xstk_context, &eif_stack, sizeof(struct xstack));
		bcopy(&dstk_context, &db_stack, sizeof(struct dbstack));
		/* Fall through */
	case ST_LOCAL:
	case ST_ARG:
	case ST_VAR:
		bcopy(&istk_context, &op_stack, sizeof(struct opstack));
		break;
	case ST_ONCE:
		bcopy(&ostk_context, &once_set, sizeof(struct stack));
		break;
	}
	EIF_END_GET_CONTEXT
}

/*
 * Dumping the pending exceptions.
 */

rt_private struct dump *pending(void)
{
	/* Get the next pending exception record from the exception stack.
	 * The stack is read from the bottom. A special case is made for the
	 * very first item dumped, because an implict exception left the faulty
	 * vector on top of the eif_stack execution stack.
	 */
	EIF_GET_CONTEXT
	struct ex_vect *top;				/* Exception vector */
	static struct dump dumped;			/* Item returned */

	dumped.dmp_type = DMP_VECT;			/* Structure contains vector */

	if (is_first) {							/* Very first item dumped */
		is_first = 0;						/* Don't come here twice */
		if (d_cxt.pg_status == PG_VIOL)	{	/* Implicitely raised exception */
			top = extop(&eif_stack);		/* Faulty vector */
			dumped.dmp_vect = top;
			return &dumped;					/* Pointer to static data */
		}
	}

	/* Normal case: get a new vector from bottom of the stack. The exnext()
	 * function returns a null pointer when the top of the stack has been
	 * reached. Note that absolutely no interpretation is done. It is up to
	 * ewb to correctly reconstruct the missing information by parsing the
	 * items it gets.
	 */

	top = exnext();						/* Fetch next vector */
	if (top == (struct ex_vect *) 0)	/* Reached top of stack */
		return (struct dump *) 0;		/* Signal end of stack */

	dumped.dmp_vect = top;

	return &dumped;			/* Pointer to static data */

	EIF_END_GET_CONTEXT
}

/*
 * Dumping of the execution stack.
 */

rt_private struct dump *execution(void)
{
	/* Get the next execution vector from the top of eif_stack. Whenever a
	 * vector associated with a melted routine is reached, we also send
	 * the arguments (and possibly the locals in ST_FULL mode). This is why
	 * we keep an internal state about the status of the last vector.
	 */
	EIF_GET_CONTEXT
	struct ex_vect *top;				/* Exception vector */
	static struct ex_vect copy;			/* copy of the exception vector */
	struct dump *dp;					/* Partial dump pointer */
	struct dcall *dc;					/* Debugger's calling context */
	static struct dump dumped;			/* Item returned */
	static int last_melted = 0;			/* True when last was melted */
	static int arg_done = 0;			/* True when arguments processed */
	static int loc_done = 0;			/* True when locals processed */
	static int argn = 0;				/* Argument number */
	static int locn = 0;				/* Local number */
	long hack;							/* Temporary solution: 2 integers sent in one */

	/* When the last exception vector returned was melted, we want to send
	 * the routine arguments (if any), and maybe the local variables.
	 * So instead of sending another exception vector, we start returning
	 * interpreter cells--RAM.
	 */

	if (last_melted) {					/* Last vector was melted */
		if (!arg_done) {				/* There are still some arguments */
			dp = argument(argn++);			/* Get next argument */
			if (dp != (struct dump *) 0){	/* Got it */
				return dp;					/* An argument dump */
			}
			arg_done = 1;					/* No more arguments */
			argn = 0;						/* Reset number for next vector */
			dumped.dmp_type = DMP_VOID;		/* Tell ebench there are no more */
			return &dumped;					/* arguments to be sent. */
		}
		if (dump_mode == ST_FULL && !loc_done) {	/* But we need locals */
			dp = local(locn++);				/* Get next local */
			if (dp != (struct dump *) 0){	/* Got one */
				return dp;					/* A local variable dump */
			}
			loc_done = 1;
			locn = 0;						/* Reset for next vector */
			dumped.dmp_type = DMP_VOID;		/* Tell ebench there are no more */
			return &dumped;					/* locals to be sent. */
		}
		dpop();							/* Remove calling context now */
		last_melted = 0;				/* A priori, next vector not melted */
	}

	/* We either finished dealing with previous melted vector, or it was simply
	 * not associated with a melted feature. So go on and grab next one, unless
	 * the end of the stack has been reached.
	 */
	if (eif_stack.st_cur->sk_arena == eif_stack.st_top){
		return (struct dump *) 0;	/* Reached end of stack */
	}
/*	expop(&eif_stack); */				/* Remove top vector logically */
/*	top = extop(&eif_stack);*/		/* And get a pointer to it (ghost!) */
/*	printf ("extop done \n"); */

	top = extop (&eif_stack); 		/* Let's do it the right way -- Didier */
	expop (&eif_stack);

	if ( !(
			(top->ex_type == EX_CALL ||		/* A feature call (1st call) */
			 top->ex_type == EX_RETY ||		/* A retried feature call */
			 top->ex_type == EX_RESC) &&	/* A rescue clause */
			 top->exu.exur.exur_id != 0)
	)
		return (struct dump *) EIF_IGNORE;		/* This vector should not be sent */

	/* Now check whether by chance the vector associated with the callling
	 * context on top of the debugger's stack is precisely the one we've just
	 * popped. That would mean we reached a melted feature...
	 */
	dc = safe_dtop();				/* Returns null pointer if empty */
	if (dc != (struct dcall *) 0){	/* Stack not empty */
		if (dc->dc_exec == top) {	/* We've reached a melted feature */
			last_melted = 1;		/* Calling context will be popped later */
			arg_done = 0;
			loc_done = 0;
			init_var_dump(dc);		/* Make this feature "active" */
		}
	}

	/* Finally, build up the dumped structure for the current vector. If this
	 * vector is associated with a melted feature, the next call to this routine
	 * will dump the arguments and possibluy the local variables.
	 */

	dumped.dmp_type = last_melted ? DMP_MELTED : DMP_VECT;	/* Structure contains vector */
	copy = *top;
	dumped.dmp_vect = &copy; /* static variable  -- Didier */

	/* Temporary hack:
	 * With the time constraints we had it was not an option to change the
	 * protocol in order to send the origin type and the dynamic type
	 * sowe use the same integer to send bith values with a 16 bit shift
	 */

	if (dumped.dmp_vect -> ex_type){
		hack = dumped.dmp_vect -> exu.exur.exur_orig;
		hack <<= 16;
		hack += Dtype(dumped.dmp_vect -> exu.exur.exur_id);
		dumped.dmp_vect -> exu.exur.exur_orig = hack;
	}

	return &dumped;			/* Pointer to static data */

	EIF_END_GET_CONTEXT
}

rt_private struct dcall *safe_dtop(void)
{
	/* This is a wrapper to the dtop() feature, which tests whether the stack
	 * is empty before calling it: the dtop() routine will raise a eif_panic if
	 * there is nothing on the stack. Here, we only return a null pointer.
	 */

	EIF_GET_CONTEXT
	if (db_stack.st_top && db_stack.st_top == db_stack.st_hd->sk_arena)
		return (struct dcall *) 0;

	return dtop();		/* Stack is not empty */
	EIF_END_GET_CONTEXT
}

/*
 * Dumping arguments and/or locals.
 */

rt_private void init_var_dump(struct dcall *call)
		/* Calling context for "active" feature */
{
	/* Initializes the interpreter registers for dumping variables from feature
	 * associated with calling context. This has to be done before ivalue()
	 * can reliably be called to get local variables.
	 */

	if (call == (struct dcall *) 0)
		return;

	sync_registers(MTC call->dc_cur, call->dc_top);
}

rt_private struct dump *variable(void)
{
	/* Dump the variables from the current routine, according to the global
	 * status flag. The interpreter registers are supposed to be correctly
	 * synchronized.
	 */

	struct dump *dp;					/* Partial dump pointer */
	static int arg_done = 0;			/* True when arguments processed */
	static int argn = 0;				/* Argument number */
	static int locn = 0;				/* Local number */

	EIF_GET_CONTEXT
	if (d_cxt.pg_active == (struct dcall *) 0)
		return (struct dump *) 0;		/* No active routine */

	switch (dump_mode) {
	case ST_LOCAL:						/* Dump locals only */
		dp = local(locn++);				/* Fetch next local variable */
		break;
	case ST_ARG:						/* Dump arguments only */
		dp = argument(argn++);			/* Fetch next argument variable */
		break;
	case ST_VAR:						/* Dump arguments and locals */
		if (!arg_done) {				/* There are still some arguments */
			dp = argument(argn++);		/* Get next argument */
			if (dp != (struct dump *) 0)
				break;
			arg_done = 1;				/* No more arguments */
		}
		dp = local(locn++);				/* Get next local then */
		break;
	default:
		eif_panic("illegal variable request");
	}

	if (dp == (struct dump *) 0) {		/* Finished: reset static vars */
		arg_done = 0;
		argn = 0;
		locn = 0;
	}

	return dp;			/* Pointer to static data or null */
	EIF_END_GET_CONTEXT
}

rt_private struct dump *local(int n)
{
	/* Return the nth local, or a void pointer if we reached the end of the
	 * local variable. By convention, if the routine has n declared local
	 * variable, then n+1 is the Result, provided the routine is not a
	 * procedure.
	 */

	uint32 type;
	struct item *ip;					/* Partial item pointer */
	static struct dump dumped;			/* Item returned */

	ip = ivalue(MTC IV_LOCAL, n);
	if (ip == (struct item *) 0)
		return (struct dump *) 0;

	dumped.dmp_type = DMP_ITEM;			/* We are dumping a variable */
	dumped.dmp_item = ip;

	/* Because the interpreter (from time to time) does not care about the
	 * consistency between SK_DTYPE of an item and EO_TYPE of its referenced
	 * object, we have to resynchronize these two entities before sending
	 * that item to ewb (which relies on that consistency).
	 */
	type = ip->type & SK_HEAD;
	if ((type == SK_EXP || type == SK_REF) && (ip->it_ref != (char *)0))
		ip->type = type | Dtype(ip->it_ref);

	return &dumped;			/* Pointer to static data */
}

rt_private struct dump *argument(int n)
{
	/* Return the nth argument, or a void pointer if we reached the end of the
	 * argument list.
	 */

	uint32 type;
	struct item *ip;					/* Partial item pointer */
	static struct dump dumped;			/* Item returned */

	ip = ivalue(MTC IV_ARG, n);
	if (ip == (struct item *) 0)
		return (struct dump *) 0;

	dumped.dmp_type = DMP_ITEM;			/* We are dumping a variable */
	dumped.dmp_item = ip;

	/* Because the interpreter (from time to time) does not care about the
	 * consistency between SK_DTYPE of an item and EO_TYPE of its referenced
	 * object, we have to resynchronize these two entities before sending
	 * that item to ewb (which relies on that consistency).
	 */
	type = ip->type & SK_HEAD;
	if ((type == SK_EXP || type == SK_REF) && (ip->it_ref != (char *)0))
		ip->type = type | Dtype(ip->it_ref);

	return &dumped;			/* Pointer to static data */
}

/*
 * Dumping of the once stack.
 */

rt_private struct dump *once(void)
{
	/* Dumping of the once stack */
	EIF_GET_CONTEXT
	char *obj;							/* Object in once Result variable */
	static struct dump dumped;			/* Item returned */

	if (once_set.st_top == (char **) 0)	/* Stack not created yet */
		return (struct dump *) 0;

	if (once_set.st_top == once_set.st_hd->sk_arena)
		return (struct dump *) 0;			/* Stack is empty */

	epop(&once_set, 1);						/* Remove item logically */
	obj = *once_set.st_top;					/* Get it through indirection */

	dumped.dmp_type = DMP_OBJ;				/* We are dumping an object */
	dumped.dmp_obj.obj_addr = obj;			/* Record object's address */
	if (obj != (char *) 0)					/* Not void object */
		dumped.dmp_obj.obj_type =			/* Get its dynamic type */
			HEADER(obj)->ov_flags & EO_TYPE;

	return &dumped;			/* Pointer to static data */
	EIF_END_GET_CONTEXT
}

/*
 * Dumping result of an already called once function
 */

#ifdef EIF_WIN32
rt_public void send_once_result(STREAM *s, uint32 body_id, int arg_num)
#else
rt_public void send_once_result(int s, uint32 body_id, int arg_num)
#endif
      				/* The connected socket */
               		/* body id of the once function */
            		/* Number of arguments */
{
	/* Ask the debugger for the result of already called once function
	 * and send the result back to ewb.
	 */

	uint32 type;
	struct item *ip;					/* Partial item pointer */
	struct dump dumped;					/* Item to send */

	ip = docall(MTC body_id, arg_num);
	dumped.dmp_type = DMP_ITEM;			/* We are dumping a variable */
	dumped.dmp_item = ip;

	/* Because the interpreter (from time to time) does not care about the
	 * consistency between SK_DTYPE of an item and EO_TYPE of its referenced
	 * object, we have to resynchronize these two entities before sending
	 * that item to ewb (which relies on that consistency).
	 */
	type = ip->type & SK_HEAD;
	if ((type == SK_EXP || type == SK_REF) && (ip->it_ref != (char *)0))
		ip->type = type | Dtype(ip->it_ref);

	send_dump(s, &dumped);
}


rt_private void show_dumped (struct dump d)
{
	struct ex_vect *dmpu;
	switch (d.dmp_type) {
		case DMP_MELTED:
		case DMP_VECT:
			printf ("Vector	");
			dmpu = d.dmpu.dmpu_vect;
			show_vector (dmpu);
			return;
		default:
			printf ("unknown dump\n");
	}
}

rt_private void show_vector (struct ex_vect *dmpu)
{
		printf ("VECTOR %lx\n", (char *) dmpu);
		printf ("type = %i; retry = %i; rescue = %i\n", dmpu -> ex_type,
			dmpu -> ex_retry, dmpu -> ex_rescue);
		printf ("obj_id = %i, rout_name = %s orig = %i\n",
			dmpu -> exu.exur.exur_id, dmpu -> exu.exur.exur_rout,
			dmpu -> exu.exur.exur_orig);
}
