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
#include "rt_interp.h"
#include "eif_except.h"
#include "eif_garcol.h"
#include "eif_malloc.h"
#include "stack.h"
#include "com.h"
#include "request.h"
#include "eif_macros.h"
#include "eif_globals.h"
#include <string.h>

#define EIF_IGNORE	-1	/*	We do not want this item sent, but there are still
						 *	items to send. Useful for getting rid of EX_OSTK
						 *	pseudo exception vector -- Didier
						 */

#define EIF_NO_ITEM (uint32) 0xFFFFFFFF

/* Record a stack context, while performing dumps, and restore it afterwards.
 * We have a provision here for all the possible stack we may inspect.
 */
rt_private struct xstack xstk_context;	/* Saved exception stack context */
rt_private struct dbstack dstk_context;	/* Saved calling stack context */
rt_private struct opstack istk_context;	/* Operational stack (interpreter) */

/* Private Routines declarations */
rt_private void 		send_dump(eif_stream s, struct dump *dp);	/* Send XDR'ed dumped item to ewb */
rt_private void 		save_stacks(void);							/* Initialize automaton */
rt_private void 		restore_stacks(void);						/* Reset saved stack contexts */
rt_private struct dump 	*get_next_execution_vector(void);			/* List execution stack */
rt_private struct dump	*get_next_variable(uint32 start);			/* Dump the locals and arguments of current feature */
rt_private struct dcall *safe_dtop(void);							/* Perform a safe dtop() without eif_panic */
rt_private void 		init_var_dump(struct dcall *call);			/* Initialize register context */
rt_private uint32		go_ith_stack_level(int level);				/* Go to the i-th level down the stack */
rt_private struct dump 	*variable_item(int variable_type, int n, uint32 start); /* Dump a local or an argument of active feature */

/* Public Routines declarations */
rt_public void 			send_stack(eif_stream s, uint32 elem_nb);					/* Dump the application */
rt_public unsigned char modify_local(uint32 stack_depth, uint32 loc_type, 
                                     uint32 loc_number, struct item *new_value); /* modify a local value */
rt_public void			send_stack_variables(eif_stream s, int where);	/* Dump the locals and arguments of a feature */
rt_public void 			send_once_result(eif_stream s, uint32 body_id, int arg_num); /* dump the results of onces feature */

/* extern Routines used */
extern struct item 	*c_oitem(uint32 n); /* from debug.c - Returns a pointer to the item at position `n' down the stack */

/*-------------------------
 - Routine implementation -
 -------------------------*/


/************************************************************************** 
 * NAME: send_stack                                                       * 
 * ARGS: s   : the connected socket                                       * 
 *------------------------------------------------------------------------* 
 * This is the main routine. It send at most elem_nb elements to the remote*
 * process through the connected socket and via XDR. The end of the dump  *
 * is indicated by a positive acknowledgment.                             *
 **************************************************************************/
 rt_public void send_stack(eif_stream s, uint32 elem_nb)
	{
	struct dump *dp;			/* Pointer to static data where dump is */
	uint32 sent = 0;
	
	save_stacks();				/* Initialize processing */
	dp = get_next_execution_vector();
	while (dp && (sent < elem_nb)) {	/* While still some data to send */
		if ((int) dp != EIF_IGNORE)
			send_dump(s, dp);
		dp = get_next_execution_vector();
		sent++;
	}
	restore_stacks();
	send_ack(s, AK_OK);			/* End of list -- you got everything */
	}

/************************************************************************** 
 * NAME: send_stack_variables                                             * 
 * ARGS: s    : the connected socket                                      * 
 *       where: level in the stack where the current feature is located   * 
 *------------------------------------------------------------------------* 
 * Dump the arguments and the locals of the 'where-th' feature down the   *
 * stack. where=1 means dumping the locals of the feature located on top  *
 * of the stack                                                           *
 **************************************************************************/
rt_public void send_stack_variables(eif_stream s, int where)
{
	/* This is the main routine. It send a whole stack dump to the remote
	 * process through the connected socket and via XDR. The end of the dump
	 * is indicated by a positive acknowledgment.
	 */
	struct dump *dp;			/* Pointer to static data where dump is */
	uint32 start;				/* start of the frozen operational stack */

	save_stacks(); /* preserve stacks */

		/* go to the specified level */
	start = go_ith_stack_level(where);

		/* then dump the variables */
	if (start != EIF_NO_ITEM) {
		dp = get_next_variable (start);
		while (dp) {	/* While still some data to send */
			if ((int) dp != EIF_IGNORE)
				send_dump(s, dp);
			dp = get_next_variable (start);
		}
		send_ack(s, AK_OK);			/* End of list -- you got everything */
	}

	restore_stacks(); /* restore stacks */
}

/************************************************************************** 
 * NAME: send_dump                                                        * 
 * ARGS: s: the connected socket                                          * 
 *       dp: the item to send                                             * 
 *------------------------------------------------------------------------* 
 * Send a packed containing the dump item 'dp'                            *
 **************************************************************************/
rt_private void send_dump(eif_stream s, struct dump *dp)
	{
	Request rqst;					/* What we send back */

	Request_Clean (rqst);
	rqst.rq_type = DUMPED;			/* A dumped stack item */
	memcpy (&rqst.rq_dump, dp, sizeof(struct dump));
	send_packet(s, &rqst);			/* Send to network */
	}

/************************************************************************** 
 * NAME: save_stacks                                                      * 
 *------------------------------------------------------------------------* 
 * Save the appropriate stack context, depending on the operations to     *
 * be performed...                                                        *
 **************************************************************************/
rt_private void save_stacks(void)
	{
	EIF_GET_CONTEXT

	/* Save the appropriate stack context, depending on the operations to
	 * be performed... */
	memcpy (&xstk_context, &eif_stack, sizeof(struct xstack));
	memcpy (&dstk_context, &db_stack, sizeof(struct dbstack));
	memcpy (&istk_context, &op_stack, sizeof(struct opstack));
	}
	
/************************************************************************** 
 * NAME: restore_stacks                                                   * 
 *------------------------------------------------------------------------* 
 * Restore context of all the stack we had to modify/inspect              *
 **************************************************************************/
rt_private void restore_stacks(void)
	{
	EIF_GET_CONTEXT

	/* Restore context of all the stack we had to modify/inspect */
	memcpy (&eif_stack, &xstk_context, sizeof(struct xstack));
	memcpy (&db_stack, &dstk_context, sizeof(struct dbstack));
	memcpy (&op_stack, &istk_context, sizeof(struct opstack));
	}

/************************************************************************** 
 * NAME: execution_without_variables                                      * 
 * RET : the dump item we should send to EiffelStudio                      * 
 *------------------------------------------------------------------------* 
 * Dump the call stack - locals and arguments excluded                    *
 *                                                                        *
 * Get the next execution vector from the top of eif_stack. Whenever a    *
 * vector associated with a melted routine is reached, we also send       *
 * the arguments (and possibly the locals in ST_FULL mode). This is why   *
 * we keep an internal state about the status of the last vector.         *
 **************************************************************************/
rt_private struct dump *get_next_execution_vector(void)
	{
	EIF_GET_CONTEXT

	struct ex_vect *top;		/* Exception vector */
	static struct ex_vect copy;	/* copy of the exception vector */
	static struct dump dumped;	/* Item returned */
	long hack;					/* Temporary solution: 2 integers sent in one */
	struct dcall *dc;			/* Debugger's calling context */

	/* We either finished dealing with previous vector, or it was simply
	 * not associated with a feature. So go on and grab next one, unless
	 * the end of the stack has been reached.
	 */
	if (eif_stack.st_cur->sk_arena == eif_stack.st_top)
		{
		/* Reached end of chunck, go to previous chunck if any */
		if (eif_stack.st_cur->sk_prev == NULL)
			return NULL; /* no previous chunck ==> end of stack */

		/* There is a previous chunck, switch to it */
		eif_stack.st_cur = eif_stack.st_cur->sk_prev;
		eif_stack.st_top = eif_stack.st_cur->sk_end;
		eif_stack.st_end = eif_stack.st_cur->sk_end;
		}

	top = extop (&eif_stack); 		/* Let's do it the right way -- Didier */
	expop (&eif_stack);

	if ( !( (top->ex_type == EX_CALL ||	top->ex_type == EX_RETY || top->ex_type == EX_RESC) && top->exu.exur.exur_id != 0))
		return (struct dump *) EIF_IGNORE;		/* This vector should not be sent */

	/* Build up the dumped structure for the current vector. If this
	 * vector is associated with a melted feature, the next call to this routine
	 * will dump the arguments and possibluy the local variables.
	 */
	dc = safe_dtop();				/* Returns null pointer if empty */
	if (dc != NULL && (dc->dc_exec == top))	/* We've reached a melted feature */
		{
		init_var_dump(dc);		/* Make this feature "active" */
		dumped.dmp_type = DMP_MELTED;	/* Structure contains melted feature */
		dpop();
		}
	else
		dumped.dmp_type = DMP_VECT;	/* Structure contains frozen feature */


	copy = *top;
	dumped.dmp_vect = (struct debug_ex_vect *)&copy; /* static variable  -- Didier */

	/* Temporary hack:
	 * With the time constraints we had it was not an option to change the
	 * protocol in order to send the origin type and the dynamic type
	 * so we use the same integer to send both values with a 16 bit shift
	 */

	if (dumped.dmp_vect -> ex_type)
		{
		hack = dumped.dmp_vect -> exu.exur.exur_orig;
		hack <<= 16;
		hack += Dtype(dumped.dmp_vect -> exu.exur.exur_id);
		dumped.dmp_vect -> exu.exur.exur_orig = hack;
		}
	
	return &dumped;			/* Pointer to static data */
	}

/************************************************************************** 
 * NAME: safe_dtop                                                        * 
 * RET : a pointer to the top of the stack                                * 
 *------------------------------------------------------------------------* 
 * This is a wrapper to the dtop() feature, which tests whether the stack *
 * is empty before calling it: the dtop() routine will raise a eif_panic  *
 * if there is nothing on the stack. Here, we only return a null pointer. *
 **************************************************************************/
rt_private struct dcall *safe_dtop(void)
	{
	EIF_GET_CONTEXT
	if (db_stack.st_top && db_stack.st_top == db_stack.st_hd->sk_arena)
		return NULL;

	return dtop();		/* Stack is not empty */
	}

/*
 * Dumping arguments and/or locals.
 */

/************************************************************************** 
 * NAME: init_var_dump                                                    * 
 * ARGS: call: Calling context for "active" feature                       *
 *------------------------------------------------------------------------* 
 * Initializes the interpreter registers for dumping variables from       *
 * feature associated with calling context. This has to be done before    *
 * ivalue() can reliably be called to get local variables.                *
 **************************************************************************/
rt_private void init_var_dump(struct dcall *call)
	{
	if (call == NULL)
		return;

	/* melted feature, synchronize the registers */
	sync_registers(call->dc_cur, call->dc_top);
	}

/************************************************************************** 
 * NAME: go_ith_stack_level                                               * 
 * ARGS: level: where we should go down the stack                         *
 * RET : position of locals/arguments for active feature if it's frozen   *
 *       EIF_NO_ITEM otherwise                                            *
 *------------------------------------------------------------------------* 
 * Go down the stack. This is done before dumping the locals and the      *
 * arguments of a feature located on level `level' down the stack         *
 **************************************************************************/
rt_private uint32 go_ith_stack_level(int level)
	{
	EIF_GET_CONTEXT

	struct ex_vect *top;		/* Exception vector */
	struct ex_vect copy;		/* copy of the exception vector */
	struct dcall *dc;			/* Debugger's calling context */
	uint32 start = 0;			/* start of operation stack for current feature */
								/* within whole operation stack */
	int i;						/* Current level */

	for (i=0; i<level; i++)
		{
		/* We either finished dealing with previous melted vector, or it was simply
	   	* not associated with a melted feature. So go on and grab next one, unless
   		* the end of the stack has been reached.
   		*/
		if (eif_stack.st_cur->sk_arena == eif_stack.st_top)
			return EIF_NO_ITEM;	/* Error...Reached end of stack */

		top = extop (&eif_stack); 		/* Let's do it the right way -- Didier */
		expop (&eif_stack);

		if ( !( (top->ex_type == EX_CALL ||	top->ex_type == EX_RETY || top->ex_type == EX_RESC) && top->exu.exur.exur_id != 0))
			{
			i--;		/* Rewind - This item should not be taken into account. */
			continue;	/* This vector should be ignored */
			}

		/* Now check whether by chance the vector associated with the callling
	   	* context on top of the debugger's stack is precisely the one we've just
   		* popped. That would mean we reached a melted feature...
   		*/
		dc = safe_dtop();				/* Returns null pointer if empty */
		if (dc != NULL && (dc->dc_exec == top))	/* We've reached a melted feature */
			{
			init_var_dump(dc);		/* Make this feature "active" */
			if (i!=level-1)
				dpop();
			}
		else
			{
			copy = *top;
			if (i!=level-1)
				start += copy.ex_locnum + copy.ex_argnum + 2; /* + 2 = + Current + result */
			}
		}
	return start;			/* Pointer to static data */
	}

/************************************************************************** 
 * NAME: variables                                                        * 
 * ARGS: start: position of locals/arguments of active feature if it's    *
 *              frozen                                                    *
 *------------------------------------------------------------------------* 
 * Dump the locals and the arguments of the active feature (call go_ith_  *
 * stack_level to make a given feature active)                            *
 * (The interpreter registers are supposed to be correctly synchronized)  *
 **************************************************************************/
rt_private struct dump *get_next_variable(uint32 start)
	{
	static struct dump dumped;			/* Item returned */
	struct dump *dp;					/* Partial dump pointer */
	static int arg_done = 0;			/* True when arguments processed */
	static int argn = 0;				/* Argument number */
	static int locn = 0;				/* Local number */

	if (!arg_done)						/* There are still some arguments */
		{
		dp = variable_item(IV_ARG,argn++,start);	/* Get next argument */
		if (dp != (struct dump *) 0)
			return dp;
		arg_done = 1;					/* No more arguments */
		dumped.dmp_type = DMP_VOID;		/* Tell ebench there are no more */
		return &dumped;					/* arguments to be sent. */
		}
	else
		dp = variable_item(IV_LOCAL,locn++,start);	/* Get next local then */
			
	if (dp == (struct dump *) 0)		/* Finished: reset static vars */
		{
		arg_done = 0;
		argn = 0;
		locn = 0;
		}

	return dp;			/* Pointer to static data or null */
	}

/************************************************************************** 
 * NAME: variable_item                                                    * 
 * ARGS: n: number of the argument to get.                                *
 *       variable_type: IV_ARG to get an argument,                        *
 *                      IV_LOCAL to get a local variable                  *
 *       start: position of locals/arguments of active feature if it's    *
 *              frozen                                                    *
 * RET : Return a dumped item containing the asked item or NULL           *
 *------------------------------------------------------------------------* 
 * Return the nth argument/local variable, or a void pointer if we        *
 * reached the end of the argument/local variable list.                   *
 **************************************************************************/
rt_private struct dump *variable_item(int variable_type, int n, uint32 start)
	{
	uint32 type;
	struct item *ip;					/* Partial item pointer */
	static struct dump dumped;			/* Item returned */

	ip = ivalue(variable_type, n, start);
	if (ip == NULL)
		return NULL;

	dumped.dmp_type = DMP_ITEM;			/* We are dumping a variable */
	dumped.dmp_item = ip;

	/* Because the interpreter (from time to time) does not care about the
	 * consistency between SK_DTYPE of an item and EO_TYPE of its referenced
	 * object, we have to resynchronize these two entities before sending
	 * that item to ewb (which relies on that consistency).
	 */
	type = ip->type & SK_HEAD;
	if ((type == SK_EXP || type == SK_REF) && (ip->it_ref != NULL))
		ip->type = type | Dtype(ip->it_ref);

	return &dumped;			/* Pointer to static data */
	}

/************************************************************************** 
 * NAME: send_once_result                                                 * 
 * ARGS: s      : the connected socket                                    * 
 *       body_id: body id of the once function                            *
 *       arg_num: Number of arguments                                     *
 *------------------------------------------------------------------------* 
 * Ask the debugger for the result of already called once function        *
 * and send the result back to EiffelStudio                                *
 **************************************************************************/
rt_public void send_once_result(eif_stream s, uint32 body_id, int arg_num)
	{
	uint32 type;
	struct item *ip;					/* Partial item pointer */
	struct dump dumped;					/* Item to send */

	ip = docall(body_id, arg_num);
	dumped.dmp_type = DMP_ITEM;			/* We are dumping a variable */
	dumped.dmp_item = ip;

	/* Because the interpreter (from time to time) does not care about the
	 * consistency between SK_DTYPE of an item and EO_TYPE of its referenced
	 * object, we have to resynchronize these two entities before sending
	 * that item to ewb (which relies on that consistency).
	 */
	type = ip->type & SK_HEAD;
	if ((type == SK_EXP || type == SK_REF) && (ip->it_ref != NULL))
		ip->type = type | Dtype(ip->it_ref);

	send_dump(s, &dumped);
	}

/************************************************************************** 
 * NAME: modify_local                                                     * 
 * ARGS: loc_depth : Depth where the feature is situated inside callstack * 
 *       loc_type  : Type of the local. Can be DLT_ARGUMENT=0             * 
 *                   DLT_LOCALVAR=1 or DLT_RESULT=2                       * 
 *       loc_number: number of the argument/local variable on the stack   * 
 *       new_value : new value to assign to the local                     * 
 * RET:  returns                                                          * 
 *           0 if the local item has beem successfully modified.          * 
 *           1 if something else went wrong.                              *  
 *           2 if you have tried to modify an expanded reference.         * 
 *           3 if you have passed a bad value for loc_type			      *  
 *------------------------------------------------------------------------* 
 * modify the value of a local variable / an argument / the result        * 
 * of a feature with the given new value                                  * 
 **************************************************************************/
rt_public unsigned char modify_local(uint32 stack_depth, uint32 loc_type, uint32 loc_number, struct item *new_value)
	{
	EIF_GET_CONTEXT

	struct ex_vect	*top = NULL; 		/* Exception vector */
	struct item 	*ip = NULL;			/* Partial dump pointer */
	uint32 			start = 0;			/* start of operation stack for current feature within whole operation stack */
	char 			*new_object = NULL;	/* new value for the local variable if it's a reference */
	unsigned char 	error_code = 0;		/* error code - different from zero means that an error occurred */

	save_stacks(); /* save context */
	start = go_ith_stack_level(stack_depth); /* go down the the call stack to set our feature "active" */

	/* get the address of the local item */
	switch(loc_type)
		{
		case DLT_ARGUMENT:
			ip = ivalue(IV_ARG, loc_number-1, start);
			break;
		
		case DLT_LOCALVAR:
			ip = ivalue(IV_LOCAL, loc_number-1, start);
			break;

		case DLT_RESULT:
			top = extop (&eif_stack);
			ip = ivalue(IV_LOCAL, top->ex_locnum, start);
			break;
		default:
			error_code = 3; /* bad value for loc_type */
			goto lblError_restore_context;
		}

	restore_stacks(); /* restore context (so that RTMS can run properly) */

	/* modify the local item */
	switch (new_value->type & SK_HEAD)
		{
		case SK_BOOL:
		case SK_CHAR:
			*(EIF_CHARACTER *)(ip->it_addr) = new_value->it_char;
			break;
		case SK_WCHAR:
			*(EIF_WIDE_CHAR *)(ip->it_addr) = new_value->it_wchar;
			break;
		case SK_INT8:
			*(EIF_INTEGER_8 *)(ip->it_addr) = new_value->it_int8;
			break;
		case SK_INT16:
			*(EIF_INTEGER_16 *)(ip->it_addr) = new_value->it_int16;
			break;
		case SK_INT32:
			*(EIF_INTEGER_32 *)(ip->it_addr) = new_value->it_int32;
			break;
		case SK_INT64:
			*(EIF_INTEGER_64 *)(ip->it_addr) = new_value->it_int64;
			break;
		case SK_FLOAT:
			*(EIF_REAL *)(ip->it_addr) = new_value->it_float;
			break;
		case SK_DOUBLE:
			*(EIF_DOUBLE *)(ip->it_addr) = new_value->it_double;
			break;
		case SK_POINTER:
			*(EIF_POINTER *)(ip->it_addr) = new_value->it_ptr;
			break;
		case SK_STRING:
			*(EIF_REFERENCE *)(ip->it_addr) = RTMS(new_value->it_ref);
			break;
		case SK_REF:
			new_object = (EIF_OBJECT)(&(eif_access((EIF_OBJECT) (new_value->it_ref))));
			new_object = eif_access(new_object);
			*(EIF_REFERENCE *)(ip->it_addr) = new_object;
			break;
		case SK_BIT:
			error_code = 1; /* not yet implemented */
			goto lblError;
		case SK_EXP:
			error_code = 2; /* modifying  an expanded reference is not allowed */
			goto lblError;
		default:
			/* unexpected value, error: set the error flag */
			error_code = 1;
			goto lblError;
		}

	/* everything went ok, error_code is equal to 0 */
lblError_restore_context:
	restore_stacks(); /* restore context */

lblError:
	return error_code;
	}
