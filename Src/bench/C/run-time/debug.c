/*

 #####   ######  #####   #    #   ####            ####
 #    #  #       #    #  #    #  #    #          #    #
 #    #  #####   #####   #    #  #               #
 #    #  #       #    #  #    #  #  ###   ###    #
 #    #  #       #    #  #    #  #    #   ###    #    #
 #####   ######  #####    ####    ####    ###     ####

	Debugging control.
*/

#include "eif_portable.h"
#include "eif_confmagic.h"	
#include "eif_macros.h"
#include "eif_debug.h"
#include "eif_hashin.h"
#include "eif_malloc.h"
#include "eif_sig.h"
#include "eif_struct.h"
#include "eif_local.h"			/* For epop() */
#include "eif_out.h"			/* For build_out() */
#include "eif_hector.h"
#include "eif_interp.h"
#include "eif_update.h"
#include "eif_main.h"
#include "eif_lmalloc.h"
#include "eif_types.h"
#include "eif_except.h"
#include "eif_urgent.h"
#include "rt_garcol.h"
#include "eif_sig.h"				/* For signal description */
#include "eif_err_msg.h"
#include "eif_error.h"
#include "eif_project.h"

#ifdef EIF_THREADS
#include "rt_threads.h"
#endif

#include <signal.h>
#include <stdio.h>
#include <string.h>

#ifdef EIF_WIN32
#include "eif_console.h"
#include <winbase.h>	/* To call `ExitProcess' */
#endif

#ifdef CONCURRENT_EIFFEL
#include "eif_curextern.h"
#endif

#ifdef WORKBENCH
#ifndef NOHOOK					/* For debug_mode */
#include "server.h"				/* ../ipc/app */
#endif /* !NOHOOK */
#endif /* WORKBENCH */

#include <stdlib.h>				/* For exit(), abort() */
#include "eif_globals.h"


#define ITEM_SZ			sizeof(struct item)

#define clocnum exvect->ex_locnum
#define cargnum exvect->ex_argnum
#define cresult c_oitem(start + clocnum + cargnum + 1)
#define cloc(x) c_oitem(start + clocnum - (x))
#define carg(x) c_oitem(start + clocnum + cargnum + 1 - (x))
#define ccurrent c_oitem(start + clocnum)

#undef STACK_CHUNK
#define STACK_CHUNK				200			/* Number of items in a stack chunk */
#define CALL_SZ					sizeof(struct dcall)
#define LIST_CHUNK				200			/* Number of items in a list chunk */
#define BODY_ID_SZ				sizeof(uint32)

/*#define DEBUG 63 */					/* Activate debugging code */

/* For debugging */
#define dprintf(n)		if (DEBUG & (n)) printf
#define flush			fflush(stdout)

/* The debugging level is the body ID of the first debuggable feature. This
 * reduces to the size of the melted table.
 */
#define dlevel	0		/* FIXME */

#ifndef EIF_THREADS

/* Debugging stack. This stack records all the calls made to any melted feature
 * (i.e. it records also standard melted feature calls). In case an exception
 * occurs or a breakpoint is reached, this stack will be used to print arguments
 * values. It can also be used to inspect local variables in any of the
 * recorded routines, by simply shifting the context and resynchronizing the
 * interpreter registers.
 */
rt_shared struct dbstack db_stack = {
	(struct stdchunk *) 0,		/* st_hd */
	(struct stdchunk *) 0,		/* st_tl */
	(struct stdchunk *) 0,		/* st_cur */
	(struct dcall *) 0,			/* st_top */
	(struct dcall *) 0,			/* st_end */
};

/* Once list. This list records the body_id of once routines that have already
 * been called. This is usefull to prevent those routines to be supermelted
 * losing in that case their memory (whether they have already been called
 * and their result). This list is also needed to inspect result of
 * once functions in order to know if that result has already been evaluated.
 */
rt_shared struct id_list once_list = {
	(struct idlchunk *) 0,		/* idl_hd */
	(struct idlchunk *) 0,		/* idl_tl */
	(uint32 *) 0,				/* idl_last */
	(uint32 *) 0,				/* idl_end */
};

/* For faster reference, the current control table is memorized in a global
 * debugger status structure, along with the execution status and break point
 * hash table.
 */
rt_shared struct dbinfo d_data = {
	NULL,			/* db_start */
	0, 				/* db_status */
	0,				/* db_callstack_depth */
	0,				/* db_callstack_depth_stop */
	0				/* db_stepinto_mode */
};	/* Global debugger information */

/* The debugger, when in interactive mode, maintains the notion of run-time
 * context. That is to say the main stacks are saved and their content will be
 * restored undisturbed before resuming execution.
 */
rt_shared struct pgcontext d_cxt;	/* Main program context */

rt_shared struct opstack cop_stack = {
	(struct stochunk *) 0,	/* st_hd */
	(struct stochunk *) 0,	/* st_tl */
	(struct stochunk *) 0,	/* st_cur */
	(struct item *) 0,	/* st_top */
	(struct item *) 0,	/* st_end */
};
#endif /* !EIF_THREADS */

#ifdef WORKBENCH
rt_shared struct dbglobalinfo d_globaldata = {
	0,				/* db_discard_breakpoints */
	NULL			/* db_bpinfo */
#ifdef EIF_THREADS
	,NULL			/* db_mutex */
#endif /* EIF_THREADS */
};
#endif /* WORKBENCH */

#ifdef EIF_THREADS
#define DBGMTX_CREATE 	EIF_MUTEX_CREATE(d_globaldata.db_mutex, "Cannot create mutex for the debugger [dbreak]\n")
#define DBGMTX_DESTROY	EIF_MUTEX_DESTROY(d_globaldata.db_mutex, "Cannot destroy mutex for the debugger [dbreak]\n")
#define DBGMTX_LOCK   	EIF_MUTEX_LOCK(d_globaldata.db_mutex, "Cannot lock mutex for the debugger [dbreak]\n")
#define DBGMTX_UNLOCK 	EIF_MUTEX_UNLOCK(d_globaldata.db_mutex, "Cannot unlock mutex for the debugger [dbreak]\n")
#endif

/* Context set up */
rt_public void dstart(void);				/* Beginning of melted feature execution */
rt_public void drun(int body_id);			/* Starting execution of debugged feature */
rt_public void discard_breakpoints(void);	/* discard all breakpoints. used when we don't want to stop */ 
rt_public void undiscard_breakpoints(void);	/* un-discard all breakpoints. */

/* Step by step execution control */
rt_public void dstop(struct ex_vect *exvect, uint32 offset); /* Breakable point reached */
rt_public void dstop_nested(struct ex_vect *exvect, uint32 break_index); /* Breakable point in the middle of a nested call reached */
rt_public void set_breakpoint_count(int num);	/* Sets the n breakpoint to stop at*/
rt_public void dbreak_create_table(void);
rt_public void dbreak_free_table(void);
rt_private void set_breakpoint_in_table(int body_id, uint32 offset);
rt_private void remove_breakpoint_in_table(int body_id, uint32 offset);
rt_private int is_dbreak_set(int body_id, uint32 offset);
rt_private int should_be_interrupted(void);

/* Debugging stack handling routines */
rt_public struct dcall *dpush(register struct dcall *val);			/* Push value on stack */
rt_public struct dcall *dpop(void);			/* Pop value off stack */
rt_public struct dcall *dtop(void);			/* Current top value */
rt_private struct dcall *stack_allocate(register int size);	/* Allocate first chunk */
rt_private int stack_extend(register int size);				/* Extend stack size */
rt_private void npop(register int nb_items);					/* Pop 'n' items */
rt_private int nb_calls(void);					/* Number of calls registered */

/* Once list handling routines */
rt_public uint32 *onceadd(uint32 id);				/* Add once body_id to list */
rt_public uint32 *onceitem(register uint32 id);				/* Item with body_id in list */
rt_private uint32 *list_allocate(register int size);		/* Allocate first chunk */
rt_private int list_extend(register int size);				/* Extend list size */

/* Program context */
rt_shared void escontext(EIF_CONTEXT int why);				/* Save program context */
rt_shared void esresume(EIF_CONTEXT_NOARG);					/* Restore saved program context */
rt_private struct ex_vect *last_call(EIF_CONTEXT_NOARG);	/* Last call recorded on Eiffel stack */

/* Changing active routine */
rt_public void dmove(int offset);					/* Move inside calling context stack */
rt_private void call_down(int level);				/* Move cursor downwards */
rt_private void call_up(int level);					/* Move cursor upwards */

/* Updating once supermelted routines */
rt_private void write_long(char *where, long int value);

/* Values used for application interrupt */
rt_private int breakpoint_count = 10; /* default parameter */
rt_private int recorded_breakpoint_count = 1;

/* Value used to known where we stopped for the last time - used for nested call only */
rt_private int previous_bodyid = -1;
rt_private uint32 previous_break_index = (uint32) -1;

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif


/*
 * Context set up and handling.
 */

rt_public void discard_breakpoints()
{
	/* This routine is called when we don't want to stop anymore
	 * The typical usage of this routine is made in emain.c
	 * At the end of the program, a final garbage collection occurs
	 * to avoid stopping into `dispose' feature, all breakable lines
	 * are discarded
	 */
	
	EIF_GET_CONTEXT
	/* We remove 1 from current value. So if we have the following scheme,
	 * the breakpoints remain discarded after the first call to
	 * undiscard_breakpoints.
	 * 
	 * discard_breakpoints
	 * ...
	 *    discard_breakpoints
	 *    ...
	 *    undiscard_breakpoints
	 * ...                        <-- breakpoints are still discarded.
	 * undiscard_breakpoints
	 * ...                        <-- breakpoints no more discarded.
	 */

	d_globaldata.db_discard_breakpoints++; 
}

rt_public void undiscard_breakpoints()
{
	/* This routine is called after a call to discard_breakpoints,
	 * when we want to re-take breakable line into account
	 */
	
	EIF_GET_CONTEXT
	/* We remove 1 from current value. So if we have the following scheme,
	 * the breakpoints remain discarded after the first call to
	 * undiscard_breakpoints.
	 * 
	 * discard_breakpoints
	 * ...
	 *    discard_breakpoints
	 *    ...
	 *    undiscard_breakpoints
	 * ...                        <-- breakpoints are still discarded.
	 * undiscard_breakpoints
	 * ...                        <-- breakpoints no more discarded.
	 */
	d_globaldata.db_discard_breakpoints--;
}

rt_public void dstart(EIF_CONTEXT_NOARG)
{
	/* This routine is called at the beginning of every melted feature. It
	 * builds up a calling context on the debugging stack and initializes it.
	 */
	EIF_GET_CONTEXT
	struct dcall *context;		/* The calling context */

	/* If the debugging stack is not empty, then we need to look at the current
	 * debugging context from the last melted feature, and, in case it was a
	 * step by step, then this feature must also be executed step by step.
	 * Otherwise, it's a continuation.
	 */

	d_data.db_status = DX_CONT;				/* Default execution status */
	if (
		db_stack.st_top != (struct dcall *) 0 &&		/* Stack allocated */
		db_stack.st_top != db_stack.st_hd->sk_arena		/* Not empty */
	) {
		context = dtop();					/* Context from previous routine */
		if (context->dc_status == DX_STEP)	/* Step by step execution? */
			d_data.db_status = DX_STEP;		/* This one propagates */
	}

	/* Attempt to get a new context and raise an exception which will transfer
	 * control outside of the current routine.
	 */
	context = dget();					/* Get new calling context */
	if (context == (struct dcall *) 0)	/* No more memory */
		enomem();						/* Critical exception */

	/* Initialize the calling context with the current IC value (which is the
	 * start of the byte code for the current feature), and save the context
	 * of the operational stack. Leave the control table alone, as there is
	 * no way to tell this is a debugging byte code at this point.
	 */

	context->dc_start = IC;				/* Current interpreter counter */
	context->dc_cur = (struct stochunk *) 0;
	context->dc_top = (struct item *) 0;
	context->dc_exec = (struct ex_vect *) 0;
}

rt_public void dexset(struct ex_vect *exvect)
                       		/* Execution vector */
{
	/* As soon as the associated execution vector is known (this is computed
	 * within the byte code itself), set it in the calling context. In the
	 * event an exception occurs after dstart() but before dexset(), there
	 * will be nothing on the Eiffel stack anyway. When dumping the Eiffel
	 * stack, this will identify melted features.
	 */

	dtop()->dc_exec = exvect;		/* Associate context with Eiffel stack */
}

rt_public void drun(int body_id)
            		/* Body ID of the current melted feature */
{
	/* The current feature is to be run under debugger control. Set-up the
	 * control table context and update the execution status. This marks the
	 * entrance into the feature's debugable byte code.
	 */

	struct dcall *context;			/* The calling context */

	context = dtop();				/* Active execution context */
	context->dc_body_id = body_id;	/* Make sure we know who this is */
	
	dsync();						/* Initialize cached data */
}

rt_public void dostk(EIF_CONTEXT_NOARG)
{
	/* Save the current operational stack context (the one after interpreter
	 * registers have been initialized) so that we can resynchronize the
	 * interpreter on any melted feature and get local and argument values.
	 */

	EIF_GET_CONTEXT
	struct dcall *context;		/* Current calling context */
	
	context = dtop();
	context->dc_cur = op_stack.st_cur;	/* Value suitable for sync_registers */
	context->dc_top = op_stack.st_top;
}

rt_public void dsync(void)
{
	/* Resynchronizes the debugger information structure when we return from a
	 * feature call. This is also called at the entrance of a feature call to
	 * initialize cached data.
	 */

	struct dcall *context;		/* Current calling context */

	EIF_GET_CONTEXT
	/* Reset execution status. It is important to restore that information, even
	 * if we are in a non-debuggable feature because the DX_STEP status must be
	 * propagated and the first time we will enter a debuggable feature, we'll
	 * stop thanks to the propagation work done in dstart()--RAM.
	 */

	context = dtop();
	d_data.db_status = context->dc_status;	/* Execution status */
	d_data.db_start = context->dc_start;	/* Used to compute offsets in BC */
}

rt_public void dstatus(int dx)
	{
	/* Set a new debugging status for the debugging of the last routine. This is
	 * a request from ewb, and we need to get the context of this last routine
	 * via the saved context. This will be done when we resume our context.
	 * We simply update the current cached information held in d_data.
	 */

	EIF_GET_CONTEXT
	d_data.db_status = dx;		/* Update execution status (RESUME request) */
	}

/*************************************************************************************************************************
* Debugging hooks.
*************************************************************************************************************************/

rt_public void set_breakpoint_count (int num)
	{
	/*
	 * Sets the number of hooks (dnext) that the application
	 * should go across before asking the daemon if an
	 * interrupt was requested
	 */
	breakpoint_count = num;
	}

rt_private int should_be_interrupted(void)
	{
	/* check if we should ask the daemon whether application should
	 * be interrupted. To speed up debugging, we don't ask the daemon
	 * at each instruction, but every 'breakpoint_count' instruction
	 * (i.e. breakpoint slot).
	 * 'recorded_breakpoint_count' is the number of times we
	 * have entered this function since last check
	 */

	if (recorded_breakpoint_count >= breakpoint_count)
		{
		recorded_breakpoint_count = 1;
		return 1; /* true */
		}

	/* else statement */
	recorded_breakpoint_count++;
	return 0; /* false */
	}

rt_public void dstop(struct ex_vect *exvect, uint32 break_index)
	/* args: ex_vect, current execution vector     */
	/*       break_index, current offset (i.e. line number in stoppoints mode) within feature */
	{
	/* update execution stack with current line number, i.e. offset */
	exvect->ex_linenum = break_index;
			
	if (debug_mode)
		{
		EIF_GET_CONTEXT	/* Not declared at the beggining because we only need it here.
						 * As dstop is called even when the application is not launched
						 * from Ebench, we can avoid the execution of this declaration
 						 * when the application is started from the command line
 						 */
#ifdef EIF_THREADS
		DBGMTX_LOCK;	/* Enter critical section */
#endif
									
		if (!d_globaldata.db_discard_breakpoints) /* test the 'discard_breakpoint' flag */
			{
			int bodyid = exvect->ex_bodyid;
			
			if (d_data.db_stepinto_mode /* test stepinto flag */
				||
				d_data.db_callstack_depth<d_data.db_callstack_depth_stop /* test the stack depth */
				||
				is_dbreak_set(bodyid, break_index)	/* test the presence of a breakpoint */
			   )
				{
				d_data.db_stepinto_mode = 0;		/* remove the stepinto flag if it was not already cleared */
				d_data.db_callstack_depth_stop = 0;	/* remove the stack stop if it was activated */
				dbreak(PG_BREAK);		 			/* stop the application */

				/* update previous value for next call (if it's a nested call) */
				previous_bodyid = bodyid;
				previous_break_index = break_index;
				}
			else if (should_be_interrupted())
				{
				if (dinterrupt())	/* Ask daemon whether application should be interrupted here.*/
					{
					/* update previous value for next call */
					previous_bodyid = bodyid;
					previous_break_index = break_index;
					}
				}
			}
#ifdef EIF_THREADS
		DBGMTX_UNLOCK; /* Leave critical section */
#endif
		}
	}

/* dstop for nested calls */
rt_public void dstop_nested(struct ex_vect *exvect, uint32 break_index)
	/* args: ex_vect, current execution vector     */
	/*       break_index, current offset (i.e. line number in stoppoints mode) within feature */
	{
	int bodyid;

	if (debug_mode)
		{	
		EIF_GET_CONTEXT	/* Not declared at the beggining because we only need it here.
	   					* As dstop if called even when the application is not launched
	   					* with Ebench, we can avoid the execution of this declaration
	   					* when the application is started from the command line
	   					*/

#ifdef EIF_THREADS
		DBGMTX_LOCK;	/* Enter critical section */
#endif
						
		if (d_globaldata.db_discard_breakpoints) /* test the 'discard_breakpoint' flag */
			return;

		bodyid = exvect->ex_bodyid;
			
		/* test if we are in a middle of a qualified call, if so, ignore stop */
		if (previous_bodyid==bodyid && previous_break_index==break_index)
			return;
			
		if (d_data.db_stepinto_mode || /* test stepinto flag */
			d_data.db_callstack_depth<d_data.db_callstack_depth_stop) /* test the stack depth */
			{
			d_data.db_stepinto_mode = 0;		/* remove the stepinto flag if it was not already cleared */
			d_data.db_callstack_depth_stop = 0;	/* remove the stack stop if it was activated */
			dbreak(PG_BREAK);		 			/* stop the application */
			}
		/* we don't test the other case: breakpoint & interruption to avoid stopping in the middle of a
		 * nested call
		 */

#ifdef EIF_THREADS
		DBGMTX_UNLOCK; /* Leave critical section */
#endif
		}
	}
/*************************************************************************************************************************
* Breakpoints handling.
*************************************************************************************************************************/

rt_shared void dbreak(EIF_CONTEXT int why)
	{
	/* Program execution stopped. The run-time context is saved and the
	 * application is put in a server mode, where it listens for workbench
	 * requests (object dump, variable printing, etc...). Leaving the server
	 * mode means the user wishes to resume execution. We then restore the
	 * run-time context and return.
	 */

#ifdef NEVER
	dserver();
#else
	escontext(why);				/* Save run-time context */
	dserver();					/* Put application in server mode */
	esresume();					/* Restore run-time context */
#endif

	/* Returning from this routine will resume execution where it stopped */
	}


/**************************************************************************/
/* NAME: dsetbreak                                                        */
/* ARGS: body_id: Debuggable feature whose info needed to be changed      */
/*       offset:  Offset within byte code                                 */
/*       what:    Command (DT_SET_REAL, DT_SET_STACK, DT_REMOVE_REAL, ..) */
/*------------------------------------------------------------------------*/
/* Change the breakpoint information for debuggable feature whose body ID */
/* is 'body_id'. At the specified offset, we add/remove a breakpoint as   */
/* indicated by 'what', which is the new breakpoint status.               */
/* 'what' can be 'DT_SET' to set a breakpoint, 'DT_REMOVE' to remove a    */
/* breakpoint, 'DT_SET_STEPINTO' to activate the stepinto flag            */
/* (next breakable point will be turned into a breakpoint. 'DT_SET_STACK' */
/* to put a stack-breakpoint (usefull for stepout & step-by-step)         */
/**************************************************************************/
rt_public void dsetbreak(int body_id, uint32 offset, int what)
	{
	EIF_GET_CONTEXT
	/* set a breakpoint according to its nature (what) */
	switch (what)
		{
		case DT_SET:
			/* update breakpoints information table */
			set_breakpoint_in_table(body_id, offset);
			break;
		case DT_REMOVE:
			/* update breakpoints information table */
			remove_breakpoint_in_table(body_id, offset);
			break;
		case DT_SET_STEPINTO:
			d_data.db_stepinto_mode = 1; /* set the stepinto mode to true */
			break;
		case DT_SET_STACK:
			/* set the minimum stack depth.. if the stack depth is below than */
			/* depth_stop, application  will stop (step by step, step out) */
			d_data.db_callstack_depth_stop = offset; /* offset = current stack depth */
			break;
		#ifdef MAY_PANIC
		default:
			eif_panic("debug.c, dsetbreak: Invalid breakpoint type");
		#endif
		}
	}

/**************************************************************************/
/* NAME: is_dbreak_set                                                    */
/* ARGS: body_id: feature where the breakpoint should be                  */
/*       offset:  Offset within byte code                                 */
/*------------------------------------------------------------------------*/
/* returns 1 if there is a breakpoint in the feature 'body_id' at the     */
/* offset  'offset' or if the stepindo flag is set, or if the stack depth */
/* is below the stack depth stop level                                    */
/* returns 0 if not, or if the discard_breakpoints flag is set (execution */
/* further than the root creation (when eiffel routine are called by the  */
/* garbage collector                                                      */
/**************************************************************************/
rt_private int is_dbreak_set(int body_id, uint32 offset)
	{
	EIF_GET_CONTEXT
	struct offset_list 	*curr_offset;
	struct db_bpinfo 	*curr_bpinfo;
	struct offset_list	*search_start_offset;

	/* check if a user breakpoint is set */
	for (curr_bpinfo = d_globaldata.db_bpinfo[body_id%BP_TABLE_SIZE]; (curr_bpinfo != NULL)&&(curr_bpinfo->body_id != body_id); curr_bpinfo = curr_bpinfo->next) {}

	if (curr_bpinfo != NULL)
		{
		/* look if we are after the last visited offset or not */
		if (offset>curr_bpinfo->last_offset)
			search_start_offset = curr_bpinfo->last_offset_list;
		else
			search_start_offset = curr_bpinfo->first_offset;

		/* we have found the good feature, now look for the good offset */
		for (curr_offset = search_start_offset; (curr_offset != NULL)&&(curr_offset->offset < offset); curr_offset = curr_offset->next) {}
	
		/* update last_offset & last_offset_list */
		curr_bpinfo->last_offset = offset;

		if (curr_offset != NULL && curr_offset->offset==offset)
			{
			/* we have found the good feature & the good offset. seems we have
			* found what we were looking for
			*/
			curr_bpinfo->last_offset_list = curr_offset->next; /* we go to the next because we are currently stopped at this offset */
			return 1;
			}
		else
			{
			/* the specified offset doesnt exists in the list of breakpoints for
			* this feature... too bad
			*/
			curr_bpinfo->last_offset_list = curr_offset;
			return 0;
			}
		}
	else
		return 0; /* the feature can't be found, so the breakpoint is not set */
	}

/**************************************************************************/
/* NAME: set_breakpoint_in_table                                          */
/* ARGS: body_id: feature where the breakpoint should be                  */
/*       offset:  Offset within byte code                                 */
/*------------------------------------------------------------------------*/
/* set a new breakpoint in the breakpoints table. if a breakpoint was     */
/* already set, it do nothing.                                            */
/**************************************************************************/
rt_private void set_breakpoint_in_table(int body_id, uint32 offset)
	{
	EIF_GET_CONTEXT
	struct offset_list 	*curr_offset;
	struct db_bpinfo 	*curr_bpinfo;
	struct offset_list 	*new_offset;
	struct offset_list 	*old_offset;
	struct db_bpinfo 	*new_bpinfo;
	int 				hash_code = body_id%BP_TABLE_SIZE;

	/* look for the good feature */
	for (curr_bpinfo = d_globaldata.db_bpinfo[hash_code]; (curr_bpinfo != NULL)&&(curr_bpinfo->body_id != body_id); curr_bpinfo = curr_bpinfo->next) {}

	if (curr_bpinfo != NULL)
		{
		/* we have found the good feature, now look for the good offset */
		for (curr_offset = curr_bpinfo->first_offset; (curr_offset != NULL)&&(curr_offset->offset < offset); curr_offset = curr_offset->next) {}
		
		if (curr_offset!=NULL && curr_offset->offset==offset)
			{
			/* we have found the good feature & the good offset. seems the breakpoint
			 * already exists. the job is done !!!
			 */
			return;
			}
		else
			{
			/* the specified offset doesnt exists in the list of breakpoints for
			 * this feature... we will just add our offset
			 */
			new_offset = (struct offset_list *)cmalloc(sizeof(struct offset_list));
			if (new_offset==NULL)
				enomem();
			new_offset->offset = offset;
			new_offset->next = curr_offset;
				
			/* first we go to the previous item in the list, in order to link our */
			/* new offset to the previous item */
			old_offset = curr_offset; /* save current offset */
			for (curr_offset=curr_bpinfo->first_offset; curr_offset!=NULL && curr_offset->next!=old_offset; curr_offset=curr_offset->next) {}
			if (curr_offset!=NULL && curr_offset->offset<offset)
				curr_offset->next = new_offset;
			else 
				curr_bpinfo->first_offset = new_offset;

			/* reset the offset precalculation about this feature */
			curr_bpinfo->last_offset_list = curr_bpinfo->first_offset;
			}
		}
	else
		{
		/* feature doesnt exists in the list.. we have to create a new
		 * cell for the feature, add information about this breakpoint
		 * in the new cell, and finally link the new cell with the list
		 */
		new_offset = (struct offset_list *)cmalloc(sizeof(struct offset_list));
		new_bpinfo = (struct db_bpinfo *)cmalloc(sizeof(struct db_bpinfo));
		if (new_offset==NULL || new_bpinfo==NULL)
			enomem();
		new_offset->offset = offset;
		new_offset->next = NULL;
		new_bpinfo->body_id = body_id;
		new_bpinfo->first_offset = new_offset;
		new_bpinfo->last_offset_list = new_offset;
		new_bpinfo->last_offset = 0;
		new_bpinfo->next = d_globaldata.db_bpinfo[hash_code];

		d_globaldata.db_bpinfo[hash_code] = new_bpinfo;
		}
	}

/**************************************************************************/
/* NAME: remove_breakpoint_in_table                                       */
/* ARGS: body_id: feature where the breakpoint is set in                  */
/*       offset:  Offset within byte code                                 */
/*------------------------------------------------------------------------*/
/* remove a breakpoint in the breakpoints table. if a breakpoint doesn't  */
/* exist, it do nothing.                                                  */
/**************************************************************************/
rt_private void remove_breakpoint_in_table(int body_id, uint32 offset)
	{
	EIF_GET_CONTEXT
	struct offset_list 	*curr_offset;
	struct offset_list 	*old_offset;
	struct db_bpinfo 	*curr_bpinfo;
	struct db_bpinfo 	*old_bpinfo;
	int 				hash_code = body_id%BP_TABLE_SIZE;

	/* look for the good feature */
	for (curr_bpinfo = d_globaldata.db_bpinfo[hash_code]; (curr_bpinfo != NULL)&&(curr_bpinfo->body_id != body_id); curr_bpinfo = curr_bpinfo->next) {}

	if (curr_bpinfo != NULL)
		{
		/* we have found the good feature, now look for the good offset */
		curr_offset = curr_bpinfo->first_offset;
		
		/* is the first offset in the list the good one ? */
		if (curr_offset->offset == offset)
			{
			/* YEP ! it is */
			curr_bpinfo->first_offset = curr_offset->next; /* remove the offset from the list */
			xfree((char *)curr_offset);
			}
		else
			{
			/* no, so let's find it */
			for (curr_offset = curr_bpinfo->first_offset; (curr_offset->next != NULL)&&(curr_offset->next->offset != offset); curr_offset = curr_offset->next) {}
			
			if (curr_offset->next != NULL)
				{
				old_offset = curr_offset->next; /* that's the one we were looking for */
				curr_offset->next = old_offset->next; /* remove the offset from the list */
				xfree((char *)old_offset);

				/* reset the offset precalculation about this feature */
				curr_bpinfo->last_offset_list = curr_bpinfo->first_offset;
				}
			else
				{
				/* this fearture didn't have a breakpoint set for this offset, so
				 * the job is already done
				 */
				}
			}

		/* now, we remove the body_id information if there is no more breakpoint inside this feature */
		if (curr_bpinfo->first_offset == NULL)
			{
			old_bpinfo = curr_bpinfo;
			if (curr_bpinfo == d_globaldata.db_bpinfo[hash_code])
				{
				d_globaldata.db_bpinfo[hash_code] = curr_bpinfo->next;
				xfree((char *)curr_bpinfo);
				}
			else
				{
				for (curr_bpinfo = d_globaldata.db_bpinfo[hash_code]; (curr_bpinfo->next !=NULL)&&(curr_bpinfo->next!=old_bpinfo); curr_bpinfo = curr_bpinfo->next) {}
				if (curr_bpinfo != NULL)
					{
					curr_bpinfo->next = old_bpinfo->next;
					xfree((char *)old_bpinfo);
					}
				}
			}
		}
	else
		{
		/* this feature didn't have any breakpoint set, so the job is already done */
		}
	}

/**************************************************************************/
/* NAME: dbreak_create_table                                              */
/*------------------------------------------------------------------------*/
/* create the breakpoints table used to handle breakpoints                */
/**************************************************************************/
rt_public void dbreak_create_table(void)
	{
	EIF_GET_CONTEXT

#ifdef EIF_THREADS
	/* create the mutex used to access the table safely between threads */
	DBGMTX_CREATE;
#endif
	/* allocate memory for BP_TABLE_SIZE pointers */
	d_globaldata.db_bpinfo = (struct db_bpinfo **)cmalloc(BP_TABLE_SIZE*sizeof(struct db_bpinfo *));
	if (d_globaldata.db_bpinfo == NULL)
		enomem();
	
	/* wipe out the allocated structure */
	memset((char *)d_globaldata.db_bpinfo, 0, BP_TABLE_SIZE*sizeof(struct db_bpinfo *));
	}

/* Computing position within program. */
rt_shared void ewhere(struct where *where)
                    		/* Structure filled in with current position */
{
	/* Compute position within the program, using the Eiffel execution stack to
	 * determine the lattest call. If the program was in a melted feature,
	 * the offset since the beginning of the byte code is also computed.
	 * NB: the position is not 100% reliable, as the program might well be
	 * within a C external function, but most of the time, it will be accurate.
	 */
	struct ex_vect 	*ex;		/* Call structure from Eiffel stack */
	int	 			body_id;  	/* body id of current feature */

	ex = last_call();				/* Last call recorded on execution stack */
	body_id = ex->ex_bodyid;		/* body_id of current feature */
	where->wh_name = ex->ex_rout;	/* Feature name */
	where->wh_obj = ex->ex_id;		/* Current value of Current */
	where->wh_origin = ex->ex_orig;	/* Where feature was written */

	/* Now compute things the remote process will like to know. First, the
	 * dynamic type of the current object...
	 */
	if (ex->ex_id != 0)
		where->wh_type = Dtype(ex->ex_id);	/* Dynamic type */
	else
		where->wh_type = -1;

	/* If the execution top calling context on the debugger's stack has its
	 * pointer within the Eiffel stack equal to 'ex', then we can say for sure
	 * that the program stopped in a melted feature and compute an offset.
	 * It is up to the workbench to make good use of that offset and compute
	 * a position within the original source code...
	 */

	/* update break index (ie line number in stoppoint view) */
	where->wh_offset = ex->ex_linenum;
}

rt_private struct ex_vect *last_call(EIF_CONTEXT_NOARG)
{
	/* Get the first execution call from the top of the Eiffel execution trace.
	 * This is used by the debugging routines to find information on a feature.
	 * The stack is otherwise left undisturbed. Note that we do not even look
	 * at the trace stack (where pending exceptions are recorded) since the
	 * exception hook is executed prior any backtracking is done.
	 */
	EIF_GET_CONTEXT
	register1 struct ex_vect *item;	/* Item we deal with */
	struct xstack saved;			/* Saved stack context */

	memcpy (&saved, &eif_stack, sizeof(struct xstack));

	item = extop (&eif_stack);
	while (item) {							/* While not found */
		if (
			item->ex_type == EX_CALL ||		/* A feature call (1st call) */
			item->ex_type == EX_RETY ||		/* A retried feature call */
			item->ex_type == EX_RESC 		/* A rescue clause */
		)
			break;			/* Exit loop when found */
		expop(&eif_stack);	/* Will eif_panic if we underflow, because we can't */
		item = extop (&eif_stack);
	}

	memcpy (&eif_stack, &saved, sizeof(struct xstack));

	return item;			/* Last call recorded on stack */
}

/*
 * Saving and restoring program context.
 */

rt_shared void escontext(EIF_CONTEXT int why)
        			/* Reason why program stopped */
{
	/* Whenever the program stops, the main run-time stacks are preserved.
	 * Under work bench control, the user may modify those stack, for instance
	 * to perform a stack dump or to inspect a given local variable.
	 */
	EIF_GET_CONTEXT
		
	memcpy (&d_cxt.pg_debugger, &db_stack, sizeof(struct dbstack));
	memcpy (&d_cxt.pg_interp, &op_stack, sizeof(struct opstack));
	memcpy (&d_cxt.pg_stack, &eif_stack, sizeof(struct xstack));
	memcpy (&d_cxt.pg_trace, &eif_trace, sizeof(struct xstack));

	d_cxt.pg_status = why;			/* Why did we stop? */
	d_cxt.pg_IC = IC;				/* Save interpreter counter */
	d_cxt.pg_calls = nb_calls();	/* Number of calls currently recorded */

	/* Compute active routine. If debugging stack is empty, there is none.
	 * Otherwise, we take the last calling context recorded on the stack.
	 */

	if (db_stack.st_top == db_stack.st_cur->sk_arena) {
		d_cxt.pg_active = (struct dcall *) 0;	/* No active routine */
		d_cxt.pg_index = -1;					/* No index */
	} else {
		d_cxt.pg_active = dtop();				/* Last recorded routine */
		d_cxt.pg_index = d_cxt.pg_calls;		/* Its index within stack */
	}
}

rt_shared void esresume(EIF_CONTEXT_NOARG)
{
	/* Resume execution context by restoring all the run-time stacks in the
	 * status they had when the program stopped. We also update the run-time
	 * debugging mode, as specified by the workbench (e.g. a step after an
	 * exception will stop at the first instruction before rescue clause).
	 */
	EIF_GET_CONTEXT
	struct dcall *context;			/* Current calling context */

	memcpy (&db_stack, &d_cxt.pg_debugger, sizeof(struct dbstack));
	memcpy (&op_stack, &d_cxt.pg_interp, sizeof(struct opstack));
	memcpy (&eif_stack, &d_cxt.pg_stack, sizeof(struct xstack));
	memcpy (&eif_trace, &d_cxt.pg_trace, sizeof(struct xstack));

	IC = d_cxt.pg_IC;			/* Resume execution where we stopped */

	/* Update debugging status for the current routine. This is the value of
	 * the current d_data.db_status field, which must have been set up by the
	 * dstatus() routine (which could not update it directly in the calling
	 * status stack, as it might have changed while the application was in
	 * server mode--RAM).
	 */

	if (db_stack.st_top != db_stack.st_cur->sk_arena) {	/* Stack not empty */
		context = dtop();
		context->dc_status = d_data.db_status;
	} else
		context = (struct dcall *) 0;

	/* Resynchronize interpreter registers if necessary. This must be done
	 * AFTER the debugging status has been updated, since sync_registers() will
	 * call dsync() and that function resynchronizes d_data by using values from
	 * the current calling context. Ouch!--RAM.
	 */

	if (context != (struct dcall *) 0)
		sync_registers(context->dc_cur, context->dc_top);

	d_cxt.pg_status = PG_RUN;	/* Program is running */
}

/*
 * Context stack handling.
 */

rt_private struct dcall *stack_allocate(register int size)
                   					/* Initial size */
{
	/* The debugging stack is created, with size 'size'.
	 * Return the arena value (bottom of stack).
	 */

	EIF_GET_CONTEXT
	register2 struct dcall *arena;		/* Address for the arena */
	register3 struct stdchunk *chunk;	/* Address of the chunk */

	size *= CALL_SZ;
	size += sizeof(*chunk);
	chunk = (struct stdchunk *) cmalloc(size);
	if (chunk == (struct stdchunk *) 0)
		return (struct dcall *) 0;		/* Malloc failed for some reason */

	SIGBLOCK;
	db_stack.st_hd = chunk;						/* New stack (head of list) */
	db_stack.st_tl = chunk;						/* One chunk for now */
	db_stack.st_cur = chunk;					/* Current chunk */
	arena = (struct dcall *) (chunk + 1);		/* Header of chunk */
	db_stack.st_top = arena;					/* Empty stack */
	chunk->sk_arena = arena;					/* Base address */
	db_stack.st_end = chunk->sk_end = (struct dcall *)
		((char *) chunk + size);		/* First free location beyond stack */
	chunk->sk_next = (struct stdchunk *) 0;
	chunk->sk_prev = (struct stdchunk *) 0;
	SIGRESUME;

	return arena;			/* Stack allocated */
}

/* Stack handling routine. The following code has been cut/paste from the one
 * found in garcol.c and local.c as of this day. Hence the similarities and the
 * possible differences. What changes basically is that instead of storing
 * (char *) elements, we now store (struct dcall) ones.
 */

rt_public struct dcall *dpush(register struct dcall *val)
{
	/* Push value 'val' on top of the debugging stack. If it fails, raise
	 * an "Out of memory" exception. If 'val' is a null pointer, simply
	 * get a new cell at the top of the stack.
	 */

	EIF_GET_CONTEXT
	register1 struct dcall *top = db_stack.st_top;	/* Top of stack */
	
	/* Stack created at initialization time via initdb */

	if (db_stack.st_end == top) {
		/* The end of the current stack chunk has been reached. If there is
		 * a chunk allocated after the current one, use it, otherwise create
		 * a new one and insert it in the list.
		 */
		SIGBLOCK;
		if (db_stack.st_cur == db_stack.st_tl) {	/* Reached last chunk */
			if (-1 == stack_extend(STACK_CHUNK))
				enomem();
			top = db_stack.st_top;					/* New top */
		} else {
			register2 struct stdchunk *current;		/* New current chunk */

			/* Update the new stack context (main structure) */
			current = db_stack.st_cur = db_stack.st_cur->sk_next;
			top = db_stack.st_top = current->sk_arena;
			db_stack.st_end = current->sk_end;
		}
		SIGRESUME;
	}

	db_stack.st_top = top + 1;			/* Points to next free location */
	if (val != (struct dcall *) 0){		/* If value was provided */
		memcpy (top, val, CALL_SZ);		/* Push it on the stack */
	} else {
		memset (top, 0, CALL_SZ);
	}

	return top;				/* Address of allocated item */
}

rt_private int stack_extend(register int size)
                   					/* Size of new chunk to be added */
{
	/* The debugging stack is extended and the stack structure is updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */

	EIF_GET_CONTEXT
	register2 struct dcall *arena;		/* Address for the arena */
	register3 struct stdchunk *chunk;	/* Address of the chunk */
	
	size *= CALL_SZ;
	size += sizeof(*chunk);
	chunk = (struct stdchunk *) cmalloc(size);
	if (chunk == (struct stdchunk *) 0)
		return -1;		/* Malloc failed for some reason */

	SIGBLOCK;
	arena = (struct dcall *) (chunk + 1);		/* Header of chunk */
	chunk->sk_next = (struct stdchunk *) 0;		/* Last chunk in list */
	chunk->sk_prev = db_stack.st_tl;			/* Preceded by the old tail */
	db_stack.st_tl->sk_next = chunk;			/* Maintain link w/previous */
	db_stack.st_tl = chunk;						/* New tail */
	chunk->sk_arena = arena;					/* Where items are stored */
	chunk->sk_end = (struct dcall *)
		((char *) chunk + size);				/* First item beyond chunk */
	db_stack.st_top = arena;					/* New top */
	db_stack.st_end = chunk->sk_end;			/* End of current chunk */
	db_stack.st_cur = chunk;					/* New current chunk */
	SIGRESUME;

	return 0;			/* Everything is ok */
}

rt_public struct dcall *dpop(void)
{
	/* Removes one item from the debugging stack and return a pointer to
	 * the removed item, which also happens to be the first free location.
	 */
	
	EIF_GET_CONTEXT
	register1 struct dcall *top = db_stack.st_top;	/* Top of the stack */
	register2 struct stdchunk *s;			/* To walk through stack chunks */
	register3 struct dcall *arena;			/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. This avoids pointer manipulation (walking along the stack)
	 * which may induce swapping, who knows?
	 */

	arena = db_stack.st_cur->sk_arena;
	if (--top >= arena) {			/* Hopefully, we remain in current chunk */
		db_stack.st_top = top;		/* Yes! Update top */
		return top;					/* Done, we're lucky */
	}

	/* Unusual case: top is just in the first place of next chunk */
	
	SIGBLOCK;
	s = db_stack.st_cur = db_stack.st_cur->sk_prev;

#ifdef MAY_PANIC
	if (s == (struct stdchunk *) 0)
		eif_panic("debugging stack underflow");
#endif

	top = db_stack.st_end = s->sk_end;
	db_stack.st_top = --top;
	SIGRESUME;

	return db_stack.st_top;
}

rt_private void npop(register int nb_items)
{
	/* Removes 'nb_items' from the debugging stack */

	EIF_GET_CONTEXT
	register2 struct dcall *top;		/* Current top of debugging stack */
	register3 struct stdchunk *s;		/* To walk through stack chunks */
	register4 struct dcall *arena;		/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. That would indeed make popping very efficient.
	 */

	arena = db_stack.st_cur->sk_arena;
	top = db_stack.st_top;
	top -= nb_items;				/* Hopefully, we remain in current chunk */
	if (top >= arena) {
		db_stack.st_top = top;		/* Yes! Update top */
		return;						/* Done, how lucky we were! */
	}

	/* Normal case (which should be reasonably rare): we have to pop more
	 * than the number of items in the current chunk. Loop until we popped
	 * enough items (one iteration should be the norm).
	 */

	SIGBLOCK;				/* Critical section begins */

	top = db_stack.st_top;
	for (s = db_stack.st_cur; nb_items > 0; /* empty */) {
		arena = s->sk_arena;
		nb_items -= top - arena;
		if (nb_items <= 0) {			/* Have we gone too far? */
			top = arena - nb_items;		/* Yes, reset top correctly */
			break;						/* Done */
		}
		s = s->sk_prev;					/* Look at previous chunk */
		if (s)
			top = s->sk_end;			/* Top at the end of previous chunk */
		else
			break;						/* We reached the bottom */
	}
		
#ifdef MAY_PANIC
	/* Consistency check: we cannot have reached the end of the stack */
	if (s == (struct stdchunk *) 0)
		eif_panic("debugging stack underflow");
#endif

	/* Update the stack structure */
	db_stack.st_cur = s;
	db_stack.st_top = top;
	db_stack.st_end = s->sk_end;

	SIGRESUME;				/* End of critical section */
}

rt_public struct dcall *dtop(void)
{

	/* Returns a pointer to the top of the stack or a NULL pointer if
	 * stack is empty. I assume a value has already been pushed (i.e. the
	 * stack has been created).
	 */

	register1 struct dcall *last_item;		/* Address of last item stored */
	register2 struct stdchunk *prev;		/* Previous chunk in stack */

	EIF_GET_CONTEXT
	last_item = db_stack.st_top - 1;
	if (last_item >= db_stack.st_cur->sk_arena)
		return last_item;
	
	/* It seems the current top of the stack (i.e. the next free location)
	 * is at the left edge of a chunk. Look for previous chunk then...
	 */
	prev = db_stack.st_cur->sk_prev;

	if (prev == (struct stdchunk *) 0)		/* The stack is empty */
		return (struct dcall *) 0;

#ifdef MAY_PANIC
	if (prev == (struct stdchunk *) 0)
		eif_panic("debugging stack is empty");
#endif
	
	return prev->sk_end - 1;			/* Last item of previous chunk */
}

rt_public void initdb(void)
{
	/* Initialize debugger stack and once list */

	struct dcall *top;			/* Arena for first stack chunk */
	uint32 *list_arena;			/* Arena for first list chunk */

	top = stack_allocate(STACK_CHUNK);		/* Create one */
	if (top == (struct dcall *) 0)	 		/* Could not create stack */
		fatal_error("can't create debugger stack");

	list_arena = list_allocate(LIST_CHUNK);		/* Create one */
	if (list_arena == (uint32 *) 0)		 		/* Could not create list */
		fatal_error("can't create once list");
}

rt_private int nb_calls(void)
{
	/* Gives the number of calling records on the stack */

	register2 struct stdchunk *s;	/* To walk through the list */
	register3 int n = 0;			/* Number of items */
	register4 int done = 0;			/* Top of stack not reached yet */

	EIF_GET_CONTEXT
	for (s = db_stack.st_hd; s && !done; s = s->sk_next) {
		if (s != db_stack.st_cur)
			n += s->sk_end - s->sk_arena;			/* The whole chunk */
		else {
			n += db_stack.st_top - s->sk_arena;		/* Stop at the top */
			done = 1;								/* Reached end of stack */
		}
	}

	return n;		/* Number of objects held in stack */
}

/*
 * Changing the currenly active routine.
 */

rt_public void dmove(int offset)
           		/* Offset by which cursor should move within context stack */
{
	/* Calling this routine will change the active routine by moving the
	 * current calling context pointer by 'offset', positive will move towards
	 * the top of the stack, negative will move it downwards. The information
	 * about this new calling context is fetched and the interpreter registers
	 * are re-synchronized.
	 */

	struct dcall *active;		/* Active routine's context */

	if (offset > 0)
		call_up(offset);
	else
		call_down(-offset);

	active = dtop();
	sync_registers(active->dc_cur, active->dc_top);
}

rt_private void call_down(int level)
          		/* Delta by which we should move active cursor */
{
	/* Artificially decrease the top of the calling stack context to move the
	 * active routine "cursor" downwards. Primitive range checking is done,
	 * because npop() will panic if we give it too much to pop.
	 */

	EIF_GET_CONTEXT
		
	if (d_cxt.pg_index - level < 1)
		level = d_cxt.pg_index - 1;

	d_cxt.pg_index -= level;

	npop(level);				/* It will do the work for us */
}

rt_private void call_up(int level)
          		/* Delta by which we should move active cursor */
{
	/* Artificially increase the top of the calling stack context to move the
	 * active routine "cursor" upwards. Primitive range checking is done,
	 * because it's cheap.
	 */

	struct dcall *top;			/* Current top op operational stack */
	struct stdchunk *s;			/* To walk trhough stack chunks */
	struct dcall *end;			/* Once cell above end of current chunk */

	EIF_GET_CONTEXT
	if (level + d_cxt.pg_index > d_cxt.pg_calls)
		level = d_cxt.pg_calls - d_cxt.pg_index;

	d_cxt.pg_index += level;

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. This will make this "pushing" efficient.
	 */
	
	end = db_stack.st_cur->sk_end;
	top = db_stack.st_top;
	top += level;				/* Hopefully, we remain in current chunk */
	if (top < end) {			/* Still within chunk boundaries */
		db_stack.st_top = top;	/* Yes! Update top */
		return;
	}

	/* Normal case: we have to push more than the number of free locations
	 * in the current chunk. Look until we pushed enough items.
	 */

	top = db_stack.st_top;
	for (s = db_stack.st_cur; level > 0; /* empty */) {
		end = s->sk_end;
		level -= end - top;		/* Number of items we stuff in this chunk */
		if (level <= 0) {		/* Have we gone too far? */
			top = end - level;	/* Yes, reset top correctly */
			break;				/* Done */
		}
		s = s->sk_next;
		if (s)
			top = s->sk_arena;	/* Top at beginning of next chunk */
		else
			break;				/* We reached the pysical top */
	}

#ifdef MAY_PANIC
	/* Consistency check: we cannot have reached the top of the stack */
	if (s == (struct stdchunk *) 0)
		eif_panic("debugger stack overflow");
#endif

	/* Update the stack structure */
	db_stack.st_cur = s;
	db_stack.st_top = top;
	db_stack.st_end = s->sk_end;
}

/*
 * Viewing objects.
 */

rt_shared char *dview(EIF_OBJECT root)
{
	/* Compute the tagged out form for object 'root' and return a pointer to
	 * the location of the C buffer holding the string. Note that the
	 * build_out() run-time routine expects an EIF_OBJECT pointer.
	 */

	char *out;					/* Where out form is stored */
	
	out = build_out (root);
	return out;		/* To-be-freed pointer to the tagged out representation */
}

/*
 * Debuggable byte-code loading.
 */

rt_public void drecord_bc(uint16 old_body_id, uint16 body_id, unsigned char *addr)
             		/* Body index for byte code */
            		/* ID of byte code (index in melt table) */
           			/* Address where byte code is stored */
{
	EIF_GET_CONTEXT
	/* Update the melting table by introducing the new debuggable byte
	 * code into the system. We know the byte code has to be recorded
	 * in the melting table.
	 */

#ifdef DEBUG
	dprintf(4) ("drecord_bc: recording 0x%lx (%d), idx: %d, id: %d\n", addr, body_id, old_body_id, body_id);
#endif
	
	if (egc_frozen[old_body_id]) {			/* The routine was frozen */
		mpatidtab[body_id] = 				/* Get the pattern id from the */
			egc_fpatidtab[old_body_id];		/* frozen table of pattern ids */
		melt[body_id] = addr;				/* And record new byte code */

#ifdef DEBUG
	dprintf(4) ("mpatidtab[%d] = %d\n", body_id, mpatidtab[body_id]);
	dprintf(4) ("melt [%d] = 0x%lx\n", body_id, addr);
#endif

	} else {
			/* We don't need to get the pattern id since the
			 * `old_body_id' and `body_id' should be equal.
			 */
		melt[body_id] = addr;			/* And record new byte code */

#ifdef DEBUG
	dprintf(4)("mpatidtab[%d] = %d\n", body_id, mpatidtab[body_id]);
	dprintf(4)("melt [%d] = 0x%lx\n", body_id, addr);
#endif

	}

	if (*addr) {
		/* It's a once routine
		 * Assign a key to it */
		write_long ((char *) (addr + 1), EIF_once_count);
		EIF_once_count++;	/* Increment dynamically the number of onces */
			/* Allocate room for once values */
		EIF_once_values = (char **) eif_realloc ((void *) EIF_once_values, EIF_once_count * sizeof (char *));
			/* needs eif_malloc: it crashes otherwise 
			 * on some pure C-ansi compiler (SGI)*/
		if (EIF_once_values == (char **) 0) /* Out of memory */
			enomem(); /* Raise an out-of memory exceptions */
	}
}

/*
 * Once list handling.
 */

rt_private uint32 *list_allocate(register int size)
                   					/* Initial size */
{
	/* The once list is created, with size 'size'.
	 * Return the arena value.
	 */

	EIF_GET_CONTEXT
	register2 uint32 *arena;			/* Address for the arena */
	register3 struct idlchunk *chunk;	/* Address of the chunk */

	size *= BODY_ID_SZ;
	size += sizeof(*chunk);
	chunk = (struct idlchunk *) cmalloc(size);
	if (chunk == (struct idlchunk *) 0)
		return (uint32 *) 0;			/* Malloc failed for some reason */

	SIGBLOCK;
	once_list.idl_hd = chunk;			/* New list (head of list) */
	once_list.idl_tl = chunk;			/* One chunk for now */
	arena = (uint32 *) (chunk + 1);		/* Header of chunk */
	once_list.idl_last = arena;			/* Empty list */
	chunk->idl_arena = arena;			/* Base address */
	once_list.idl_end = chunk->idl_end = (uint32 *)
		((char *) chunk + size);		/* First free location beyond list */
	chunk->idl_next = (struct idlchunk *) 0;
	chunk->idl_prev = (struct idlchunk *) 0;
	SIGRESUME;

	return arena;			/* List allocated */
}

rt_public uint32 *onceadd(uint32 id)
{
	/* Add body_id 'id' to end of the once list. If it fails, raise
	 * an "Out of memory" exception.
	 */

	EIF_GET_CONTEXT
	register1 uint32 *last = once_list.idl_last;/* Last free element of list */

	/* List created at initialization time via initdb */

	if (once_list.idl_end == last) {
		/* The end of the current stack chunk has been reached. Create
		 * a new one and insert it in the list.
		 */
		SIGBLOCK;
		if (-1 == list_extend(LIST_CHUNK))
			enomem();
		last = once_list.idl_last;		/* New last */
		SIGRESUME;
	}

	once_list.idl_last = last + 1;		/* Points to next free location */
	memcpy (last, &id, BODY_ID_SZ);		/* Add `id' in the list */

	return last;						/* Address of allocated item */
}

rt_private int list_extend(register int size)
                   					/* Size of new chunk to be added */
{
	/* The once list is extended and the list structure is updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */

	EIF_GET_CONTEXT
	register2 uint32 *arena;			/* Address for the arena */
	register3 struct idlchunk *chunk;	/* Address of the chunk */

	size *= BODY_ID_SZ;
	size += sizeof(*chunk);
	chunk = (struct idlchunk *) cmalloc(size);
	if (chunk == (struct idlchunk *) 0)
		return -1;		/* Malloc failed for some reason */

	SIGBLOCK;
	arena = (uint32 *) (chunk + 1);				/* Header of chunk */
	chunk->idl_next = (struct idlchunk *) 0;	/* Last chunk in list */
	chunk->idl_prev = once_list.idl_tl;			/* Preceded by the old tail */
	once_list.idl_tl->idl_next = chunk;			/* Maintain link w/previous */
	once_list.idl_tl = chunk;					/* New tail */
	chunk->idl_arena = arena;					/* Where items are stored */
	chunk->idl_end = (uint32 *)
		((char *) chunk + size);				/* First item beyond chunk */
	once_list.idl_last = arena;					/* New top */
	once_list.idl_end = chunk->idl_end;			/* End of current chunk */
	SIGRESUME;

	return 0;			/* Everything is ok */
}

rt_public uint32 *onceitem(register uint32 id)
{
	/* Returns a pointer to the element of the list with body_id `id'
	 * or a NULL pointer if that value is not found. I assume that the
	 * list has been created.
	 */

	EIF_GET_CONTEXT
	register2 struct idlchunk *chunk;	/* To walk through the list */
	register3 uint32 *item;				/* To walk through the chunk */
	register4 int done = 0;				/* Last element of list not reached */

	for (chunk = once_list.idl_hd; chunk && !done; chunk = chunk->idl_next) {
		if (chunk != once_list.idl_tl)
			for (item = chunk->idl_arena; item != chunk->idl_end; item++) {
				if (*item == id)
					return item;
			}
		else {	/* Stop at last element */
			for (item = chunk->idl_arena; item != once_list.idl_last; item++) {
				if (*item == id)
					return item;
			}
			done = 1;								/* Reached end of list */
		}
	}

	return (uint32 *)0;		/* val not found */
}

rt_public struct item *docall(EIF_CONTEXT register uint32 body_id, register int arg_num) /* %%ss mt last caller */
                         		/* body id of the once function */
                      			/* Number of arguments */
{
	/* Call the routine identified by `body_id'. This routine is supposed to
	 * be an already called once function with `arg_num' arguments. `arg_num'+1
	 * NULL items are push on the operational stack (fuction's arguments plus
	 * target of the call) before the function call and the result is popped
	 * from that stack and returned. Since the once function has already been
	 * called, the arguments on the operational stack are just popped during
	 * the call without any further evaluation. These args can therefore be
	 * Null items. The registers do not need to be resynchronized, even if
	 * the once function is melted, because in that case we just inspect
	 * the header part of the byte code without modifying any registers.
	 */
	EIF_GET_CONTEXT
	unsigned char *OLD_IC;				/* IC back up */
	uint32 pid;					/* Pattern id of the frozen feature */
	register3 int i;

	for (i = 0; i <= arg_num ; i++)		/* Push arg_num + 1 null items */
		iget();							/* on the operational stack */

	OLD_IC = IC;				/* IC back up */
	if (egc_frozen [body_id]) { 
			/* Frozen feature */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id], 0);		/* Call pattern */
	} else
		xinterp(melt[body_id]);
	IC = OLD_IC;				/* Restore IC back-up */

	return opop();				/* Return the result of the once function */
								/* and remove it from the operational stack */
}

rt_private void write_long(char *where, long int value)
{
	/* Routine taken from `update.c' and this one should be modified in relation
	 * to the content of `update.c' */
	/* Write 'value' in possibly mis-aligned address 'where' */

	union {
		char xtract[sizeof(long)];
		long value;
	} xlong;
	register1 char *p = (char *) &xlong;
	register2 int i;

	xlong.value = value;

	for (i = 0; i < sizeof(long); i++)
		where [i] = *p++;
}

/************************************************************************ 
 * FILE:    newdebug.c 
 * PURPOSE: functions to handle local variables and arguments recording
 *          and displaying
 * AUTHOR:  Jerome BOUAZIZ - Arnaud PICHERY
 ************************************************************************/

rt_public struct item *c_stack_allocate(EIF_CONTEXT register int size)
				   					/* Initial size */
{
	/* The operational stack is created, with size 'size'.
	 * Return the arena value (bottom of stack).
	 */

	EIF_GET_CONTEXT
	register2 struct item *arena;		/* Address for the arena */
	register3 struct stochunk *chunk;	/* Address of the chunk */

	size *= ITEM_SZ;
	size += sizeof(*chunk);
	chunk = (struct stochunk *) cmalloc(size);
	if (chunk == (struct stochunk *) 0)
		return (struct item *) 0;		/* Malloc failed for some reason */

	cop_stack.st_hd = chunk;						/* New stack (head of list) */
	cop_stack.st_tl = chunk;						/* One chunk for now */
	cop_stack.st_cur = chunk;					/* Current chunk */
	arena = (struct item *) (chunk + 1);		/* Header of chunk */
	cop_stack.st_top = arena;					/* Empty stack */
	chunk->sk_arena = arena;					/* Base address */
	cop_stack.st_end = chunk->sk_end = (struct item *)
		((char *) chunk + size);		/* First free location beyond stack */
	chunk->sk_next = (struct stochunk *) 0;
	chunk->sk_prev = (struct stochunk *) 0;

	return arena;			/* Stack allocated */
}

rt_public void insert_local_var (uint32 type, void *ptr)
{
	struct item *new_local;
	
	/* insert new local variable/argument on the stack */
	new_local = c_opush((struct item *)0);
	new_local->type = type;
	new_local->it_addr = ptr;
}

/* Stack handling routine. The following code has been cut/paste from the one
 * found in garcol.c and local.c as of this day. Hence the similarities and the
 * possible differences. What changes basically is that instead of storing
 * (char *) elements, we now store (struct item) ones.
 */

rt_public struct item *c_opush(EIF_CONTEXT register struct item *val)
{
	/* Push value 'val' on top of the operational stack. If it fails, raise
	 * an "Out of memory" exception. If 'val' is a null pointer, simply
	 * get a new cell at the top of the stack.
	 */
	EIF_GET_CONTEXT
	register1 struct item *top = cop_stack.st_top;	/* Top of stack */
	
	if (top == (struct item *) 0)	{			/* No stack yet? */
		top = c_stack_allocate(STACK_CHUNK);	/* Create one */
		if (top == (struct item *) 0)	 		/* Could not create stack */
			enomem(MTC_NOARG);					/* No more memory */
	}

	if (cop_stack.st_end == top) {
		/* The end of the current stack chunk has been reached. If there is
		 * a chunk allocated after the current one, use it, otherwise create
		 * a new one and insert it in the list.
		 */
		SIGBLOCK;									/* Critical section */
		if (cop_stack.st_cur == cop_stack.st_tl) {	/* Reached last chunk */
			if (-1 == c_stack_extend(STACK_CHUNK))
				enomem(MTC_NOARG);
			top = cop_stack.st_top;					/* New top */
		} else {
			register2 struct stochunk *current;		/* New current chunk */

			/* Update the new stack context (main structure) */
			current = cop_stack.st_cur = cop_stack.st_cur->sk_next;
			top = cop_stack.st_top = current->sk_arena;
			cop_stack.st_end = current->sk_end;
		}
		SIGRESUME;				/* Restore signal handling */
	}

	cop_stack.st_top = top + 1;			/* Points to next free location */
	if (val != (struct item *) 0)		/* If value was provided */
		memcpy(top, val, ITEM_SZ);		/* Push it on the stack */

	return top;				/* Address of allocated item */
}

rt_public int c_stack_extend(EIF_CONTEXT register int size)
				   					/* Size of new chunk to be added */
{
	/* The operational stack is extended and the stack structure is updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */
	EIF_GET_CONTEXT
	register2 struct item *arena;		/* Address for the arena */
	register3 struct stochunk *chunk;	/* Address of the chunk */

	size *= ITEM_SZ;
	size += sizeof(*chunk);
	chunk = (struct stochunk *) cmalloc(size);
	if (chunk == (struct stochunk *) 0)
		return -1;		/* Malloc failed for some reason */

	SIGBLOCK;									/* Critical section */
	arena = (struct item *) (chunk + 1);		/* Header of chunk */
	chunk->sk_next = (struct stochunk *) 0;		/* Last chunk in list */
	chunk->sk_prev = cop_stack.st_tl;			/* Preceded by the old tail */
	cop_stack.st_tl->sk_next = chunk;			/* Maintain link w/previous */
	cop_stack.st_tl = chunk;						/* New tail */
	chunk->sk_arena = arena;					/* Where items are stored */
	chunk->sk_end = (struct item *)
		((char *) chunk + size);				/* First item beyond chunk */
	cop_stack.st_top = arena;					/* New top */
	cop_stack.st_end = chunk->sk_end;			/* End of current chunk */
	cop_stack.st_cur = chunk;					/* New current chunk */
	SIGRESUME;									/* Restore signal handling */

	return 0;			/* Everything is ok */
}

rt_public void clean_local_vars (int n)
{
	c_npop(n);
}

rt_public struct item *c_opop(void)
{
	/* Removes one item from the operational stack and return a pointer to
	 * the removed item, which also happens to be the first free location.
	 */
	EIF_GET_CONTEXT
	register1 struct item *top = cop_stack.st_top;	/* Top of the stack */
	register2 struct stochunk *s;			/* To walk through stack chunks */
	register3 struct item *arena;			/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. This avoids pointer manipulation (walking along the stack)
	 * which may induce swapping, who knows?
	 */

	arena = cop_stack.st_cur->sk_arena;
	if (--top >= arena) {			/* Hopefully, we remain in current chunk */
		cop_stack.st_top = top;		/* Yes! Update top */
		return top;					/* Done, we're lucky */
	}

	/* Unusual case: top is just in the first place of next chunk */

	SIGBLOCK;
	s = cop_stack.st_cur = cop_stack.st_cur->sk_prev;

#ifdef MAY_PANIC
	if (s == (struct stochunk *) 0)
		eif_panic("operational stack underflow");
#endif

	top = cop_stack.st_end = s->sk_end;
	cop_stack.st_top = --top;
	SIGRESUME;

	return cop_stack.st_top;
}

rt_public void c_npop(register int nb_items)
{
	/* Removes 'nb_items' from the operational stack. Occasionaly, we also
	 * try to truncate the unused chunks from the tail of the stack. We do
	 * not do that in c_opop() because that would create an overhead...
	 */
	EIF_GET_CONTEXT
	register2 struct item *top;			/* Current top of operational stack */
	register3 struct stochunk *s;		/* To walk through stack chunks */
	register4 struct item *arena;		/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. That would indeed make popping very efficient.
	 */

	arena = cop_stack.st_cur->sk_arena;
	top = cop_stack.st_top;
	top -= nb_items;				/* Hopefully, we remain in current chunk */
	if (top >= arena) {
		cop_stack.st_top = top;		/* Yes! Update top */
		return;						/* Done, how lucky we were! */
	}

	/* Normal case (which should be reasonably rare): we have to pop more
	 * than the number of items in the current chunk. Loop until we popped
	 * enough items (one iteration should be the norm).
	 */

	SIGBLOCK;			/* Entering protected section */

	top = cop_stack.st_top;
	for (s = cop_stack.st_cur; nb_items > 0; /* empty */) {
		arena = s->sk_arena;
		nb_items -= top - arena;
		if (nb_items <= 0) {			/* Have we gone too far? */
			top = arena - nb_items;		/* Yes, reset top correctly */
			break;						/* Done */
		}
		s = s->sk_prev;					/* Look at previous chunk */
		if (s)
			top = s->sk_end;			/* Top at the end of previous chunk */
		else
			break;						/* We reached the bottom */
	}
		
#ifdef MAY_PANIC
	/* Consistency check: we cannot have reached the end of the stack */
	if (s == (struct stochunk *) 0)
		eif_panic("operational stack underflow");
#endif

	/* Update the stack structure */
	cop_stack.st_cur = s;
	cop_stack.st_top = top;
	cop_stack.st_end = s->sk_end;

	SIGRESUME;						/* End of protected section */

	/* There is not much overhead calling c_stack_truncate(), because this is
	 * only done when we are popping at a chunk edge. We have to make sure the
	 * program is running though, as popping done in debugging mode is only
	 * temporary--RAM.
	 */

	if (d_cxt.pg_status == PG_RUN)	/* Program is running */
		c_stack_truncate();			/* Eventually remove unused chunks */
}

rt_public struct item *c_otop(EIF_CONTEXT_NOARG)
{
	/* Returns a pointer to the top of the stack or a NULL pointer if
	 * stack is empty. I assume a value has already been pushed (i.e. the
	 * stack has been created).
	 */
	
	EIF_GET_CONTEXT
	register1 struct item *last_item;		/* Address of last item stored */
	register2 struct stochunk *prev;		/* Previous chunk in stack */

	last_item = cop_stack.st_top - 1;
	if (last_item >= cop_stack.st_cur->sk_arena)
		return last_item;
	
	/* It seems the current top of the stack (i.e. the next free location)
	 * is at the left edge of a chunk. Look for previous chunk then...
	 */
	prev = cop_stack.st_cur->sk_prev;

#ifdef MAY_PANIC
	if (prev == (struct stochunk *) 0)
		eif_panic("operational stack is empty");
#endif
	
	return prev->sk_end - 1;			/* Last item of previous chunk */
}

rt_public struct item *c_oitem(uint32 n)
	{
	/* Returns a pointer to the item at position `n' down the stack or a NULL pointer if */ 
	/* stack is empty. It assumes a value has already been pushed (i.e. the stack has been created). */
	EIF_GET_CONTEXT
	struct item		*access_item;	/* Address of item we try to access */
	struct stochunk	*prev;			/* Previous chunk in stack */
	struct stochunk	*curr;			/* Current chunk in stack */

	access_item = (cop_stack.st_top - 1 - n);
	if (access_item >= (cop_stack.st_cur->sk_arena))
		return access_item;

	/* It seems the item is at the left edge of a chunk. Look for previous chunk then... */
	prev = cop_stack.st_cur;

	do
		{
		/* Item is not in the current chunk. Let's see if it's not in the previous one */
		curr = prev;
		prev = prev->sk_prev;

		if (prev == NULL)
			return NULL; /* operational stack is empty, we return NULL */
		access_item = prev->sk_end - (curr->sk_arena - access_item);
		}
	while (access_item < prev->sk_arena);
		
	return access_item;
	}

rt_public void c_stack_truncate(EIF_CONTEXT_NOARG)
{
	/* Free unused chunks in the stack. If the current chunk has at least
	 * MIN_FREE locations, then we may free all the chunks starting with the
	 * next one. Otherwise, we skip the next chunk and free the remainder.
	 */

	EIF_GET_CONTEXT
	register2 struct item *top;		/* The current top of the stack */
	struct stochunk *next;			/* Address of next chunk */

	/* We know the program is running, because this function is only called
	 * via c_npop(), and c_npop() cannot be called by the debugger--RAM.
	 */

	top = cop_stack.st_top;					/* The first free location */
	if (cop_stack.st_end - top > MIN_FREE) {	/* Enough locations left */
		cop_stack.st_tl = cop_stack.st_cur;	/* Last chunk from now on */
		c_wipe_out(cop_stack.st_cur->sk_next);	/* Free starting at next chunk */
	} else {								/* Current chunk is nearly full */
		next = cop_stack.st_cur->sk_next;	/* We are followed by 'next' */
		if (next != (struct stochunk *) 0) {/* There is indeed a next chunk */
			cop_stack.st_tl = next;			/* New tail chunk */
			c_wipe_out(next->sk_next);		/* Skip it, wipe out remainder */
		}
	}
}

rt_public void c_wipe_out(register struct stochunk *chunk)
									/* First chunk to be freed */
{
	/* Free all the chunks after 'chunk' */

	register2 struct stochunk *next;	/* Address of next chunk */

	if (chunk == (struct stochunk *) 0)	/* No chunk */
		return;							/* Nothing to be done */

	chunk->sk_prev->sk_next = (struct stochunk *) 0;	/* Previous is last */

	for (
		next = chunk->sk_next;
		chunk != (struct stochunk *) 0;
		chunk = next, next = chunk ? chunk->sk_next : chunk
	)
		xfree((char *) chunk);
}
