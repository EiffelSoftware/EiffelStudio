/*

 #####   ######  #####   #    #   ####            ####
 #    #  #       #    #  #    #  #    #          #    #
 #    #  #####   #####   #    #  #               #
 #    #  #       #    #  #    #  #  ###   ###    #
 #    #  #       #    #  #    #  #    #   ###    #    #
 #####   ######  #####    ####    ####    ###     ####

	Debugging control.
*/

#include "config.h"
#include "portable.h"
#include "macros.h"
#include "debug.h"
#include "hashin.h"
#include "malloc.h"
#include "sig.h"
#include "struct.h"

#undef STACK_CHUNK
#define STACK_CHUNK		200			/* Number of items in a stack chunk */
#define CALL_SZ			sizeof(struct dcall)

/* The debugging level is the body ID of the first debuggable feature. This
 * reduces to the size of the melted table.
 */
#define dlevel	0		/* FIXME */

/* Debugging stack. This stack records all the calls made to any melted feature
 * (i.e. it records also standard melted feature calls). In case an exception
 * occurs or a breakpoint is reached, this stack will be used to print arguments
 * values. It can also be used to inspect local variables in any of the
 * recorded routines, by simply shifting the context and resynchronizing the
 * interpreter registers.
 */
shared struct dbstack db_stack = {
	(struct stdchunk *) 0,		/* st_hd */
	(struct stdchunk *) 0,		/* st_tl */
	(struct stdchunk *) 0,		/* st_cur */
	(struct dcall *) 0,			/* st_top */
	(struct dcall *) 0,			/* st_end */
};

/* For faster reference, the current control table is memorized in a global
 * debugger status structure, along with the execution status and break point
 * hash table.
 */
shared struct dbinfo d_data;	/* Global debugger information */

/* The debugger, when in interactive mode, maintains the notion of run-time
 * context. That is to say the main stacks are saved and their content will be
 * restored undisturbed before resuming execution.
 */
shared struct pgcontext d_cxt;	/* Main program context */

/* Context set up */
public void dstart();			/* Beginning of melted feature execution */
public void drun();				/* Starting execution of debugged feature */

/* Step by step execution control */
public void dnext();			/* Breakable point reached */

/* Breakpoint handling */
shared void dbreak();			/* Program execution stopped */

/* Debugging stack handling routines */
public struct dcall *dpush();			/* Push value on stack */
public struct dcall *dpop();			/* Pop value off stack */
public struct dcall *dtop();			/* Current top value */
private struct dcall *stack_allocate();	/* Allocate first chunk */
private int stack_extend();				/* Extend stack size */
private void npop();					/* Pop 'n' items */
private int nb_calls();					/* Number of calls registered */

/* Program context */
shared void escontext();				/* Save program context */
shared void esresume();					/* Restore saved program context */
private struct ex_vect *last_call();	/* Last call recorded on Eiffel stack */

/* Changing active routine */
public void dmove();					/* Move inside calling context stack */
private void call_down();				/* Move cursor downwards */
private void call_up();					/* Move cursor upwards */

/* From the interpreter */
extern struct opstack op_stack;			/* Operational stack */

#ifndef lint
private char *rcsid =
	"$Id$";
#endif


/*
 * Context set up and handling.
 */

public void dstart()
{
	/* This routine is called at the beginning of every melted feature. It
	 * builds up a calling context on the debugging stack and initializes it.
	 */

	struct dcall *context;		/* The calling context */

	/* If the debugging stack is not empty, then we need to look at the current
	 * debugging context from the last melted feature, and, in case it was a
	 * step by step, then this feature must also be executed step by step.
	 * Otherwise, it's a continuation.
	 */
	
	d_data.db_status = DX_CONT;				/* Default execution status */
	if (db_stack.st_top != db_stack.st_hd->sk_arena) {	/* Not empty */
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

public void dexset(exvect)
struct ex_vect *exvect;		/* Execution vector */
{
	/* As soon as the associated execution vector is known (this is computed
	 * within the byte code itself), set it in the calling context. In the
	 * event an exception occurs after dstart() but before dexset(), there
	 * will be nothing on the Eiffel stack anyway. When dumping the Eiffel
	 * stack, this will identify melted features.
	 */

	dtop()->dc_exec = exvect;		/* Associate context with Eiffel stack */
}

public void drun(body_id)
int body_id;		/* Body ID of the current melted feature */
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

public void dostk()
{
	/* Save the current operational stack context (the one after interpreter
	 * registers have been initialized) so that we can resynchronize the
	 * interpreter on any melted feature and get local and argument values.
	 */

	struct dcall *context;		/* Current calling context */

	context = dtop();
	context->dc_cur = op_stack.st_cur;	/* Value suitable for sync_registers */
	context->dc_top = op_stack.st_top;
}

public void dsync()
{
	/* Resynchronizes the debugger information structure when we return from a
	 * feature call. This is also called at the entrance of a feature call to
	 * initialize cached data.
	 */

	struct dcall *context;		/* Current calling context */
	int body_id;				/* Body ID of current feature */
	
	/* Reset execution status. It is important to restore that information, even
	 * if we are in a non-debuggable feature because the DX_STEP status must be
	 * propagated and the first time we will enter a debuggable feature, we'll
	 * stop thanks to the propagation work done in dstart()--RAM.
	 */

	context = dtop();
	d_data.db_status = context->dc_status;	/* Execution status */
	d_data.db_start = context->dc_start;	/* Used to compute offsets in BC */
}

public void dstatus(dx)
int dx;
{
	/* Set a new debugging status for the debugging of the last routine. This is
	 * a request from ewb, and we need to get the context of this last routine
	 * via the saved context. This will be done when we resume our context.
	 * We simply update the current cached information held in d_data.
	 */

	d_data.db_status = dx;		/* Update execution status (RESUME request) */
}

/*
 * Debugging hooks.
 */

public void dnext()
{
	/* We've reached the end of a "next" instruction, which is also a "step".
	 * This is always a break point unless the execution status is DX_CONT.
	 */

	if (d_data.db_status != DX_CONT)
		dbreak(PG_BREAK);			/* Break point reached */
}

/*
 * Breakpoints handling.
 */

shared void dbreak(why)
int why;
{
	/* Program execution stopped. The run-time context is saved and the
	 * application is put in a server mode, where it listens for workbench
	 * requests (object dump, variable printing, etc...). Leaving the server
	 * mode means the user wishes to resume execution. We then restore the
	 * run-time context and return.
	 */

	escontext(why);				/* Save run-time context */
	dserver();					/* Put application in server mode */
	esresume();					/* Restore run-time context */

	/* Returning from this routine will resume execution where it stopped */
}

public void dsetbreak(body_id, offset, what)
int body_id;		/* Debuggable feature whose info needed to be changed */
uint32 offset;		/* Offset within byte code */
int what;			/* Command (DT_SET, DT_REMOVE, ...) */
{
	/* Change the breakpoint information for debuggable feature whose body ID
	 * is 'body_id'. At the specified offset, we add/remove a breakpoint as
	 * indicated by 'what', which is the new breakpoint status.
	 * The presence of a breakpoint is signaled by a BC_BREAK, its absence by
	 * a BC_NEXT.
	 */

	char *where;				/* Location where breakpoint is written */

	where = melt[body_id - zeroc];		/* Start of byte code */
	where += offset;					/* And shifted by offset */

	switch (what) {
	case DT_SET:				/* Set a breakpoint */
		if (*where != BC_NEXT)
			panic("byte code botched");
		*where = BC_BREAK;
		break;
	case DT_REMOVE:				/* Remove a breakpoint */
		if (*where != BC_BREAK)
			panic("byte code botched");
		*where = BC_NEXT;
		break;
#ifdef MAY_PANIC
	default:
		panic("illegal breakpoint request");
#endif
	}
}

/*
 * Computing position within program.
 */

shared void ewhere(where)
struct where *where;		/* Structure filled in with current position */
{
	/* Compute position within the program, using the Eiffel execution stack to
	 * determine the lattest call. If the program was in a melted feature,
	 * the offset since the beginning of the byte code is also computed.
	 * NB: the position is not 100% reliable, as the program might well be
	 * within a C external function, but most of the time, it will be accurate.
	 */

	struct ex_vect *ex;				/* Call structure from Eiffel stack */
	struct dcall *dc;				/* Calling context structure */

	ex = last_call();				/* Last call recorded on execution stack */
	where->wh_name = ex->ex_rout;	/* Feature name */
	where->wh_obj = ex->ex_id;		/* Current value of Current */
	where->wh_origin = ex->ex_orig;	/* Where feature was written */

	/* Now compute things the remote process will like to know. First, the
	 * dynamic type of the current object...
	 */
	where->wh_type = Dtype(ex->ex_id);	/* Dynamic type */

	/* If the execution top calling context on the debugger's stack has its
	 * pointer within the Eiffel stack equal to 'ex', then we can say for sure
	 * that the program stopped in a melted feature and compute an offset.
	 * It is up to the workbench to make good use of that offset and compute
	 * a position within the original source code...
	 */

	dc = dtop();					/* Top calling structure recorded */
	if (dc->dc_exec != ex)			/* No match */
		where->wh_offset = -1;		/* Mark no valid offset */
	else
		where->wh_offset = IC - dc->dc_start;
}

private struct ex_vect *last_call()
{
	/* Get the first execution call from the top of the Eiffel execution trace.
	 * This is used by the debugging routines to find information on a feature.
	 * The stack is otherwise left undisturbed. Note that we do not even look
	 * at the trace stack (where pending exceptions are recorded) since the
	 * exception hook is executed prior any backtracking is done.
	 */

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
			item->ex_type == EX_RETY 		/* A retried feature call */
		)
			break;			/* Exit loop when found */
		expop(&eif_stack);	/* Will panic if we underflow, because we can't */
	}

#ifdef USE_STRUCT_COPY
	eif_stack = saved;		/* Restore saved stack context */
#else
	bcopy(&saved, &eif_stack, sizeof(struct xstack));
#endif

	return item;			/* Last call recorded on stack */
}

/*
 * Saving and restoring program context.
 */

shared void escontext(why)
int why;			/* Reason why program stopped */
{
	/* Whenever the program stops, the main run-time stacks are preserved.
	 * Under work bench control, the user may modify those stack, for instance
	 * to perform a stack dump or to inspect a given local variable.
	 */

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
}

shared void esresume()
{
	/* Resume execution context by restoring all the run-time stacks in the
	 * status they had when the program stopped. We also update the run-time
	 * debugging mode, as specified by the workbench (e.g. a step after an
	 * exception will stop at the first instruction before rescue clause).
	 */

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
		sync_registers(context->dc_cur, context->dc_top);

	d_cxt.pg_status = PG_RUN;	/* Program is running */
}

/*
 * Context stack handling.
 */

private struct dcall *stack_allocate(size)
register1 int size;					/* Initial size */
{
	/* The debugging stack is created, with size 'size'.
	 * Return the arena value (bottom of stack).
	 */

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

public struct dcall *dpush(val)
register2 struct dcall *val;
{
	/* Push value 'val' on top of the debugging stack. If it fails, raise
	 * an "Out of memory" exception. If 'val' is a null pointer, simply
	 * get a new cell at the top of the stack.
	 */

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
	if (val != (struct dcall *) 0)		/* If value was provided */
		bcopy(val, top, CALL_SZ);		/* Push it on the stack */

	return top;				/* Address of allocated item */
}

private int stack_extend(size)
register1 int size;					/* Size of new chunk to be added */
{
	/* The debugging stack is extended and the stack structure is updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */

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

public struct dcall *dpop()
{
	/* Removes one item from the debugging stack and return a pointer to
	 * the removed item, which also happens to be the first free location.
	 */
	
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
		panic("debugging stack underflow");
#endif

	top = db_stack.st_end = s->sk_end;
	db_stack.st_top = --top;
	SIGRESUME;

	return db_stack.st_top;
}

private void npop(nb_items)
register1 int nb_items;
{
	/* Removes 'nb_items' from the debugging stack */

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
		panic("debugging stack underflow");
#endif

	/* Update the stack structure */
	db_stack.st_cur = s;
	db_stack.st_top = top;
	db_stack.st_end = s->sk_end;

	SIGRESUME;				/* End of critical section */
}

public struct dcall *dtop()
{
	/* Returns a pointer to the top of the stack or a NULL pointer if
	 * stack is empty. I assume a value has already been pushed (i.e. the
	 * stack has been created).
	 */
	
	register1 struct dcall *last_item;		/* Address of last item stored */
	register2 struct stdchunk *prev;		/* Previous chunk in stack */

	last_item = db_stack.st_top - 1;
	if (last_item >= db_stack.st_cur->sk_arena)
		return last_item;
	
	/* It seems the current top of the stack (i.e. the next free location)
	 * is at the left edge of a chunk. Look for previous chunk then...
	 */
	prev = db_stack.st_cur->sk_prev;

#ifdef MAY_PANIC
	if (prev == (struct stdchunk *) 0)
		panic("debugging stack is empty");
#endif
	
	return prev->sk_end - 1;			/* Last item of previous chunk */
}

public void initdb()
{
	/* Initialize debugger stack */

	struct dcall *top;			/* Arena for first stack chunk */

	top = stack_allocate(STACK_CHUNK);		/* Create one */
	if (top == (struct dcall *) 0)	 		/* Could not create stack */
		fatal("can't create debugger stack");
}

private int nb_calls()
{
	/* Gives the number of calling records on the stack */

	register2 struct stdchunk *s;	/* To walk through the list */
	register3 int n = 0;			/* Number of items */
	register4 int done = 0;			/* Top of stack not reached yet */

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

public void dmove(offset)
int offset;		/* Offset by which cursor should move within context stack */
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

private void call_down(level)
int level;		/* Delta by which we should move active cursor */
{
	/* Artificially increase the top of the calling stack context to move the
	 * active routine "cursor" upwards. Primitive range checking is done,
	 * because npop() will panic if we give it too much to pop.
	 */

	if (d_cxt.pg_index - level < 1)
		level = d_cxt.pg_index - 1;

	d_cxt.pg_index -= level;

	npop(level);				/* It will do the work for us */
}

private void call_up(level)
int level;		/* Delta by which we should move active cursor */
{
	/* Artificially increase the top of the calling stack context to move the
	 * active routine "cursor" upwards. Primitive range checking is done,
	 * because it's cheap.
	 */

	struct dcall *top;			/* Current top op operational stack */
	struct stdchunk *s;			/* To walk trhough stack chunks */
	struct dcall *end;			/* Once cell above end of current chunk */

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
		panic("debugger stack overflow");
#endif

	/* Update the stack structure */
	db_stack.st_cur = s;
	db_stack.st_top = top;
	db_stack.st_end = s->sk_end;
}

dserver()
{
	/* Temporary -- FIXME */
}

