/*

 #####   ######  #####   #    #   ####            ####
 #    #  #       #    #  #    #  #    #          #    #
 #    #  #####   #####   #    #  #               #
 #    #  #       #    #  #    #  #  ###   ###    #
 #    #  #       #    #  #    #  #    #   ###    #    #
 #####   ######  #####    ####    ####    ###     ####

	Debugging control.
*/

#include "eif_project.h"
#include "eif_config.h"
#include "eif_portable.h"
#include "eif_confmagic.h"		/* %%ss added for bcopy, bzero */
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

#undef STACK_CHUNK
#define STACK_CHUNK		200			/* Number of items in a stack chunk */
#define CALL_SZ			sizeof(struct dcall)
#define LIST_CHUNK		200			/* Number of items in a list chunk */
#define BODY_ID_SZ		sizeof(uint32)


/*#define DEBUG 63 */		/* Activate debugging code */

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
rt_shared struct dbinfo d_data;	/* Global debugger information */

/* The debugger, when in interactive mode, maintains the notion of run-time
 * context. That is to say the main stacks are saved and their content will be
 * restored undisturbed before resuming execution.
 */
rt_shared struct pgcontext d_cxt;	/* Main program context */
#endif /* !EIF_THREADS */

/* Context set up */
rt_public void dstart(void);			/* Beginning of melted feature execution */
rt_public void drun(int body_id);				/* Starting execution of debugged feature */

/* Step by step execution control */
rt_public void dnext(void);			/* Breakable point reached */
rt_public void set_breakpoint_number(int num);	/* Sets the n breakpoint to stop at*/

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

/* Values used for application interrupt */
int breakpoint_number = 0;
int recorded_breakpoint_number = 0;

/* Updating once supermelted routines */
rt_private void write_long(char *where, long int value);

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif


/*
 * Context set up and handling.
 */

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
		enomem(MTC_NOARG);						/* Critical exception */

	/* Initialize the calling context with the current IC value (which is the
	 * start of the byte code for the current feature), and save the context
	 * of the operational stack. Leave the control table alone, as there is
	 * no way to tell this is a debugging byte code at this point.
	 */

	context->dc_start = IC;				/* Current interpreter counter */
	context->dc_cur = (struct stochunk *) 0;
	context->dc_top = (struct item *) 0;
	context->dc_exec = (struct ex_vect *) 0;

	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
}

/*
 * Debugging hooks.
 */

rt_public void set_breakpoint_number (int num)
{
		/*
		 * Sets `n' breakpoint in which the application
		 * will ask the daemon if an interrupt was requested
		 */
	breakpoint_number = num;
}

rt_public void dnext(void)
{
	if (breakpoint_number >= recorded_breakpoint_number) {
		recorded_breakpoint_number = 1;
		dinterrupt();				/* Ask daemon whether application */
	}						/* should be interrupted here. */
	else
		recorded_breakpoint_number++;
}

/*
 * Breakpoints handling.
 */

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
	escontext(MTC why);				/* Save run-time context */
	dserver();					/* Put application in server mode */
	esresume(MTC_NOARG);					/* Restore run-time context */
#endif

	/* Returning from this routine will resume execution where it stopped */
}

rt_public void dsetbreak(int body_id, uint32 offset, int what)
            		/* Debuggable feature whose info needed to be changed */
              		/* Offset within byte code */
         			/* Command (DT_SET, DT_REMOVE, ...) */
{
	/* Change the breakpoint information for debuggable feature whose body ID
	 * is 'body_id'. At the specified offset, we add/remove a breakpoint as
	 * indicated by 'what', which is the new breakpoint status.
	 * The presence of a breakpoint is signaled by a BC_BREAK, its absence by
	 * a BC_NEXT.
	 */

	char *where;				/* Location where breakpoint is written */

	where = melt[body_id];				/* Start of byte code */
	where += offset;					/* And shifted by offset */

	switch (what) {
	case DT_SET:				/* Set a breakpoint */
		if ((*where != BC_NEXT) && (*where != BC_BREAK))
			eif_panic(MTC "byte code botched");
		*where = BC_BREAK;
		break;
	case DT_REMOVE:				/* Remove a breakpoint */
		if ((*where != BC_NEXT) && (*where != BC_BREAK))
			eif_panic(MTC "byte code botched");
		*where = BC_NEXT;
		break;
#ifdef MAY_PANIC
	default:
		eif_panic("illegal breakpoint request");
#endif
	}
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
	EIF_GET_CONTEXT
	struct ex_vect *ex;				/* Call structure from Eiffel stack */
	struct dcall *dc;				/* Calling context structure */

	ex = last_call(MTC_NOARG);		/* Last call recorded on execution stack */
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

	dc = dtop();					/* Top calling structure recorded */
	if (dc == (struct dcall *) 0) {
		return;	
	}
	if (dc->dc_exec != ex)			/* No match */
		where->wh_offset = -1;		/* Mark no valid offset */
	else
		where->wh_offset = IC - dc->dc_start;

	EIF_END_GET_CONTEXT
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

#ifdef USE_STRUCT_COPY
	saved = eif_stack;		/* Save stack context */
#else
	bcopy(&eif_stack, &saved, sizeof(struct xstack));
#endif

	while (item = extop(&eif_stack)) {		/* While not found */
		if (
			item->ex_type == EX_CALL ||		/* A feature call (1st call) */
			item->ex_type == EX_RETY ||		/* A retried feature call */
			item->ex_type == EX_RESC 		/* A rescue clause */
		)
			break;			/* Exit loop when found */
		expop(&eif_stack);	/* Will eif_panic if we underflow, because we can't */
	}

#ifdef USE_STRUCT_COPY
	eif_stack = saved;		/* Restore saved stack context */
#else
	bcopy(&saved, &eif_stack, sizeof(struct xstack));
#endif

	return item;			/* Last call recorded on stack */

	EIF_END_GET_CONTEXT
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

#ifdef USE_STRUCT_COPY
	d_cxt.pg_debugger = db_stack;
	d_cxt.pg_interp = op_stack;
	d_cxt.pg_stack = eif_stack;
	d_cxt.pg_trace = eif_trace;
#else
	bcopy(&db_stack, &d_cxt.pg_debugger, sizeof(struct dbstack));
	bcopy(&op_stack, &d_cxt.pg_interp, sizeof(struct opstack));
	bcopy(&eif_stack, &d_cxt.pg_stack, sizeof(struct xstack));
	bcopy(&eif_trace, &d_cxt.pg_trace, sizeof(struct xstack));
#endif

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
	EIF_END_GET_CONTEXT
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

#ifdef USE_STRUCT_COPY
	db_stack = d_cxt.pg_debugger;
	op_stack = d_cxt.pg_interp;
	eif_stack = d_cxt.pg_stack;
	eif_trace = d_cxt.pg_trace;
#else
	bcopy(&d_cxt.pg_debugger, &db_stack, sizeof(struct dbstack));
	bcopy(&d_cxt.pg_interp, &op_stack, sizeof(struct opstack));
	bcopy(&d_cxt.pg_stack, &eif_stack, sizeof(struct xstack));
	bcopy(&d_cxt.pg_trace, &eif_trace, sizeof(struct xstack));
#endif

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
		sync_registers(MTC context->dc_cur, context->dc_top);

	d_cxt.pg_status = PG_RUN;	/* Program is running */

	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
				enomem(MTC_NOARG);
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
	if (val != (struct dcall *) 0)		/* If value was provided */
		bcopy(val, top, CALL_SZ);		/* Push it on the stack */
	else
		bzero(top, CALL_SZ);

	return top;				/* Address of allocated item */
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
}

rt_public void initdb(void)
{
	/* Initialize debugger stack and once list */

	struct dcall *top;			/* Arena for first stack chunk */
	uint32 *list_arena;			/* Arena for first list chunk */

	top = stack_allocate(STACK_CHUNK);		/* Create one */
	if (top == (struct dcall *) 0)	 		/* Could not create stack */
		fatal_error(MTC "can't create debugger stack");

	list_arena = list_allocate(LIST_CHUNK);		/* Create one */
	if (list_arena == (uint32 *) 0)		 		/* Could not create list */
		fatal_error(MTC "can't create once list");
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
	EIF_END_GET_CONTEXT
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
	sync_registers(MTC active->dc_cur, active->dc_top);
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
}

/*
 * Viewing objects.
 */

rt_shared char *dview(EIF_OBJ root)
{
	/* Compute the tagged out form for object 'root' and return a pointer to
	 * the location of the C buffer holding the string. Note that the
	 * build_out() run-time routine expects an EIF_OBJ pointer.
	 */

	char *out;					/* Where out form is stored */

	out = build_out (root);
	return out;		/* To-be-freed pointer to the tagged out representation */
}

/*
 * Debuggable byte-code loading.
 */

rt_public int dmake_room(int new_entries_number)
        		/* Amount of new entries in melting table */
{
	/* Pre-extend the melting table, making room for the new byte codes entries.
	 * This avoids successive eif_realloc() which could cause fragmentation within
	 * the C memory. The function returns -1 in case of error.
	 * The table containing the pattern ids of the melted routines also
	 * needs to be reallocated.
	 */

	char **new_melt;			/* New melting table address */
	int *new_mpatidtab;			/* New melted pattern id table */

	if (new_entries_number == 0)				/* Table does not need any extension */
		return 0;				/* Everything is fine */

#ifdef DEBUG
	dprintf(4)("dmake_room: extending melt (0x%lx), %d items by %d\n",
		 melt, melt_count, new_entries_number);
	dprintf(4)("dmake_room: extending mpatidtab (0x%lx), %d items by %d\n",
		 mpatidtab, melt_count, new_entries_number);
#endif

	if (melt == (char **) 0) {
		new_melt = (char **) cmalloc(new_entries_number * sizeof(char *));
		new_mpatidtab = (int *) cmalloc(new_entries_number * sizeof(int));
	}
	else {
		new_melt = (char **) crealloc((char *)(melt + zeroc), (melt_count + new_entries_number) * sizeof(char *));
		new_mpatidtab = (int *) crealloc((char *)(mpatidtab + zeroc), (melt_count + new_entries_number) * sizeof(int));
	}
	if ((new_melt == (char **) 0) || (new_mpatidtab == (int *) 0))
		return -1;				/* Not enough memory for extension */

	melt_count += new_entries_number;				/* New melting table size */
	melt = new_melt - zeroc;			/* Melting table address may have changed */
	mpatidtab = new_mpatidtab - zeroc;	/* Melted pattern id table may heve changed */
	
#ifdef DEBUG
	dprintf(4)("dmake_room: extension ok, melt now at 0x%lx, %d items\n",
		 melt, melt_count);
	dprintf(4)("dmake_room: extension ok, mpatidtab now at 0x%lx, %d items\n",
		 mpatidtab, melt_count);
#endif

	return 0;					/* Reallocation ok */
}

rt_public void drecord_bc(int body_idx, int body_id, char *addr)
             		/* Body index for byte code (index in dispatch table) */
            		/* ID of byte code (index in melt table) */
           			/* Address where byte code is stored */
{
	/* Update the dispatch table and the melting table by introducing the
	 * new debuggable byte code into the system. We know the byte code has
	 * to be recorded in the melting table, which means body_id > zeroc.
	 */

	uint32 old_body_id;

#ifdef DEBUG
	dprintf(4)("drecord_bc: recording 0x%lx (%d), idx: %d, id: %d\n",
		 addr, body_id - zeroc, body_idx, body_id);
#endif

	old_body_id = dispatch[body_idx];
	if (old_body_id < zeroc) {			/* The routine was frozen */
		mpatidtab[body_id] = 			/* Get the pattern id from the */
			egc_fpatidtab[old_body_id];		/* frozen table of pattern ids */
		melt[body_id] = addr;			/* And record new byte code */

#ifdef DEBUG
	dprintf(4)("mpatidtab[%d] = %d\n", body_id - zeroc, mpatidtab[body_id]);
	dprintf(4)("melt [%d] = 0x%lx\n", body_id - zeroc, addr);
#endif

	} else

#ifndef DLE

	{
			/* We don't need to get the pattern id since the
			 * `old_body_id' and `body_id' should be equal.
			 */
		melt[body_id] = addr;			/* And record new byte code */

#ifdef DEBUG
	dprintf(4)("mpatidtab[%d] = %d\n", body_id - zeroc, mpatidtab[body_id]);
	dprintf(4)("melt [%d] = 0x%lx\n", body_id - zeroc, addr);
#endif

	}

#else

	if (old_body_id < dle_level) {
			/* The old routine was melted.
			 * We don't need to get the pattern id since the
			 * `old_body_id' and `body_id' should be equal.
			 */
		melt[body_id] = addr;			/* And record new byte code */

#ifdef DEBUG
	dprintf(4)("mpatidtab[%d] = %d\n", body_id - zeroc, mpatidtab[body_id]);
	dprintf(4)("melt [%d] = 0x%lx\n", body_id - zeroc, addr);
#endif

	} else if (old_body_id < dle_zeroc) {
			/* The old routine was frozen */
		dle_mpatidtab[body_id] = 			/* Get the pattern id from the */
			dle_fpatidtab[old_body_id];		/* frozen table of pattern ids */
		dle_melt[body_id] = addr;			/* And record new byte code */

#ifdef DEBUG
	dprintf(4)("dle_mpatidtab[%d] = %d\n", 
			body_id - dle_zeroc, dle_mpatidtab[body_id]);
	dprintf(4)("dle_melt [%d] = 0x%lx\n", body_id - dle_zeroc, addr);
#endif

	} else {
			/* The old routine was melted.
			 * We don't need to get the pattern id since the
			 * `old_body_id' and `body_id' should be equal.
			 */
		dle_melt[body_id] = addr;			/* And record new byte code */

#ifdef DEBUG
	dprintf(4)("dle_mpatidtab[%d] = %d\n", 
			body_id - dle_zeroc, dle_mpatidtab[body_id]);
	dprintf(4)("dle_melt [%d] = 0x%lx\n", body_id - dle_zeroc, addr);
#endif
	}

#endif

	dispatch[body_idx] = body_id;		/* Set-up indirection table */

	if (*addr) {
		/* It's a once routine
		 * Assign a key to it */
		write_long (addr + 1, EIF_once_count);
		EIF_once_count++;	/* Increment dynamically the number of onces */
			/* Allocate room for once values */
		EIF_once_values = (char **) realloc ((void *) EIF_once_values, EIF_once_count * sizeof (char *));
			/* needs malloc; crashes otherwise on some pure C-ansi compiler (SGI)*/
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
	EIF_END_GET_CONTEXT
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
			enomem(MTC_NOARG);
		last = once_list.idl_last;		/* New last */
		SIGRESUME;
	}

	once_list.idl_last = last + 1;		/* Points to next free location */
	bcopy(&id, last, BODY_ID_SZ);		/* Add `id' in the list */

	return last;						/* Address of allocated item */
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	char *old_IC;				/* IC back up */
	uint32 pid;					/* Pattern id of the frozen feature */
	register3 i;

	for (i = 0; i <= arg_num ; i++)		/* Push arg_num + 1 null items */
		iget();							/* on the operational stack */

	old_IC = IC;				/* IC back up */
	if (body_id < zeroc) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id], 0);		/* Call pattern */
	} else
#ifndef DLE
		xinterp(MTC melt[body_id]);
#else
	if (body_id < dle_level)
			/* Static melted level */
		xinterp(MTC melt[body_id]);
	else if (body_id < dle_zeroc) {
			/* Dynamic frozen level */
		pid = (uint32) DLEFPatId(body_id);
		(pattern[pid].toc)(dle_frozen[body_id], 0);		/* Call pattern */
	} else
			/* Dynamic melted level */
		xinterp(MTC dle_melt[body_id]);
#endif
	IC = old_IC;				/* Restore IC back-up */

	return opop();				/* Return the result of the once function */
								/* and remove it from the operational stack */
	EIF_END_GET_CONTEXT
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
