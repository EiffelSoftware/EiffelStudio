/*

 ######  #    #   ####   ######  #####    #####           ####
 #        #  #   #    #  #       #    #     #            #    #
 #####     ##    #       #####   #    #     #            #
 #         ##    #       #       #####      #     ###    #
 #        #  #   #    #  #       #          #     ###    #    #
 ######  #    #   ####   ######  #          #     ###     ####

	Exception handling routines.

	If this file is compiled with -DTEST, it will produce a standalone
	executable.
*/

#include "config.h"
#include <stdio.h>
#include <signal.h>
#include "except.h"
#include "local.h"
#include "urgent.h"
#include "sig.h"				/* For signal description */
#include "macros.h"
#include "debug.h"

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#undef STACK_CHUNK
#undef MIN_FREE
#define STACK_CHUNK		400		/* Number of exception vectors in a chunk */
#define MIN_FREE		50		/* Minimum free locations to clean next chunk */

/* Failure yields a specific code. For a given execution vector 'v', the macro
 * xcode gives the associated exception code for the trace stack. Note that
 * for GC purposes, the value of EX_* constants starts at EX_START, not 0--RAM.
 */
#define xcode(v) ex_tagc[(v)->ex_type - EX_START];

/* For debugging */
#define dprintf(n)		if (DEBUG & (n)) printf

/* Stack of current execution. On entrance, each routine pushes the address
 * of its own execution vector structure (held in the process's stack).
 * The exception trace records all the unresolved exceptions. For the case where
 * multiple exceptions occurred and we entered different rescue clauses, we
 * have to store the exception levels along with the unsolved exceptions.
 */
public struct xstack eif_stack = {		/* Calling stack */
	(struct stxchunk *) 0,				/* st_hd */
	(struct stxchunk *) 0,				/* st_tl */
	(struct stxchunk *) 0,				/* st_cur */
	(struct ex_vect *) 0,				/* st_top */
	(struct ex_vect *) 0,				/* st_end */
	(struct ex_vect *) 0,				/* st_bot */
};
public struct xstack eif_trace = {		/* Exception trace */
	(struct stxchunk *) 0,				/* st_hd */
	(struct stxchunk *) 0,				/* st_tl */
	(struct stxchunk *) 0,				/* st_cur */
	(struct ex_vect *) 0,				/* st_top */
	(struct ex_vect *) 0,				/* st_end */
	(struct ex_vect *) 0,				/* st_bot */
};

/* Array of ignored exceptions. The EN_BYE exception is a run-time panic that
 * can never be caught, even by a rescue. The EN_OMEM cannot be ignored but can
 * be caught. It is raised by the run-time system when there is not enough
 * memory to ensure a correct Eiffel execution. The EN_FATAL exception is a
 * run-time fatal error which cannot be caught nor ignored.
 */
public unsigned char ex_ign[EN_NEX];	/* Item set to 1 to ignore exception */

/* Stack of current exception flags. This is used to control the assertion
 * checking (e.g. disable it when already in assertion checking).
 */
public struct except exdata = {
	1,				/* ex_chk */
	0,				/* ex_val */
	0,				/* ex_nomem */
	0,				/* ex_level */
	0,				/* ex_orig */
	(char *) 0,		/* ex_tag */
	(char *) 0,		/* ex_otag */
};

#ifdef WORKBENCH
/* Array of ignored exceptions, from the debugger's point of view. Normally
 * an exception stops the program to allow user inspection of the objects.
 */
public unsigned char db_ign[EN_NEX];	/* Item set to 1 to ignore exception */
#endif

/* Structure used to store routine information during exception stack dumps
 * (gathered thanks to stack look-ahead).
 */
private struct exprint except;		/* Where exception has been raised */

/* Exception handling mechanism */
public void enomem();			/* A critical "No more memory" exception */
public struct ex_vect *exret();	/* Retries execution of routine */
public void exinv();			/* Invariant record */
public void exasrt();			/* Assertion record */
public void eraise();			/* Raises an Eiffel exception */
public void eviol();			/* Signals assertion violation */
public void exfail();			/* Signals: reached end of a rescue clause */
public void panic();			/* Run-time raised panic */
public void fatal_error();			/* Run-time raised fatal errors */
shared void xraise();			/* Raises an exception with no tag */
public struct ex_vect *exset();	/* Set execution stack on routine entrance */
#ifndef WORKBENCH
public struct ex_vect *exft();	/* Entry in feature with rescue clause */
#endif

/* Exception recovery mechanism */
public void exok();				/* Resumption has been successful */
private char *backtrack();		/* Backtrack in the calling stack */
private void excur();			/* Current exception code in previous level */
private void exorig();			/* Original exception code in previous level */
private char *extag();			/* Recompute exception tag */
private void exception();		/* Debugger hook */

/* Stack handling routines */
public void expop();				/* Pops an execution vector off */
private void stack_truncate();		/* Truncate stack if necessary */
private void wipe_out();			/* Remove unneeded chunk from stack */
shared struct ex_vect *exget();		/* Get a new vector on stack */
private int stack_extend();			/* Extends size of stack */
private struct ex_vect *stack_allocate();	/* Creates an empty stack */
shared struct ex_vect *extop();		/* Top of Eiffel stack */
shared struct ex_vect *exnext();	/* Next item at bottom of trace stack */
private int exend();				/* True if end of trace stack reached */

/* User-level dumps */
public void esfail();				/* Eiffel system failure */
private void dump_core();			/* Dumps a core for debugging infos */
private char *exception_string();	/* Name of an exception */
private void dump_trace_stack();	/* Dumps the Eiffel trace stack */
private struct ex_vect *find_call();	/* Find enclosing call ID */
private void recursive_dump();		/* Dump the stack at a given level */
private void print_top();			/* Prints top value of the stack */

/* Pre-defined exception tags (29 chars max please, otherwise truncated).
 * A final point is added at the end. Here is a 29 chars string template:
 *	"It is a 29 characters string."
 */
private char *ex_tag[] = {
	(char *) 0,							/* Nothing */
	"Applied to void reference.",		/* EN_VOID */
	"No more memory.",					/* EN_MEM */
	"Precondition violated.",			/* EN_PRE */
	"Postcondition violated.",			/* EN_POST */
	"Floating point exception.",		/* EN_FLOAT */
	"Class invariant violated.",		/* EN_CINV */
	"Assertion violated.",				/* EN_CHECK */
	"Routine failure.",					/* EN_FAIL */
	"Unmatched inspect value.",			/* EN_WHEN */
	"Non-decreasing loop variant.",		/* EN_VAR */
	"Loop invariant violated.",			/* EN_LINV */
	"Operating system signal.",			/* EN_SIG */
	"Eiffel run-time panic.",			/* EN_BYE */
	"Exception in rescue clause.",		/* EN_RESC */
	"Out of memory.",					/* EN_OMEM */
	"Resumption attempt failed.",		/* EN_RES */
	"Create on deferred.",				/* EN_CDEF */
	"External event.",					/* EN_EXT */
	"Void assigned to expanded.",		/* EN_VEXP */
	"Exception in signal handler.",		/* EN_HDLR */
	"I/O error.",						/* EN_IO */
	"Operating system error.",			/* EN_SYS */
	"Retrieval error.",					/* EN_RETR */
	"Developer exception.",				/* EN_PROG */
	"Eiffel run-time fatal error.",		/* EN_FATAL */
#ifdef WORKBENCH
	"$ applied on melted feature.",		/* EN_DOL */
#endif
};

/* Converts a vector's type in the stack to an exception code, i.e. given a
 * vector in the stack, which exception has to be raised?
 */
private int ex_tagc[] = {
	EN_FAIL,		/* EX_CALL */
	EN_PRE,			/* EX_PRE */
	EN_POST,		/* EX_POST */
	EN_CINV,		/* EX_CINV */
	EN_RESC,		/* EX_RESC */
	EN_RES,			/* EX_RETY */
	EN_LINV,		/* EX_LINV */
	EN_VAR,			/* EX_VAR */
	EN_CHECK,		/* EX_CHECK */
	EN_HDLR,		/* EX_HDLR */
	EN_CINV,		/* EX_INVC */
	EN_OSTK,		/* EX_OSTK */
};

/* Strings used as separator for Eiffel stack dumps */
private char *retried =
"===============================================================================";
private char *failed =
"-------------------------------------------------------------------------------";
private char *branch_enter =
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ entering level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
private char *branch_exit =
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ back to level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";

/* Commonly used error messages */
private char *botched = "Eiffel stack botched";
private char *vanished = "main entry point vanished";

extern char *ename;					/* Name of the Eiffel program running */
extern char *root_obj;				/* Address of the root object */
extern int errno;					/* System call error status */
extern char *error_tag();			/* English description out of errno code */
extern void reclaim();				/* GC routine used to collect objects */

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	0		/* Smallest debug level */
#endif

/* Structure used by the test routines */
struct test {
	char *class;		/* Class name */
	char *name;			/* Routine name */
	char *origin;		/* Routine written in */
};

extern struct test test_system[];	/* Array of pseudo-system description */

/* These are default values for tests */
#define Class(x)		test_system[(int) x].class
#define Origin(x)		test_system[(int) x].class
#undef Dtype
#define Dtype(x)		0
#else
#define Class(x)		System(Dtype(x)).cn_generator
#define Origin(x)		System(x).cn_generator
#endif

#ifdef DEBUG
private void dump_vector();			/* Dump an execution vector on stdout */
#endif

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

/* Throughout the routines which maintain the execution stack, we must be *very*
 * careful about signals, which may occur between any two machine instruction
 * codes. Sections which manipulate the stack cannot be interrupted by signals,
 * and are enclosed between a pair of macros SIGBLOCK and SIGRESUME, which
 * respectively block the signals (from the run-time point's of view) and then
 * resume normal handling, eventually sending those signals which were caught
 * during the critical section.
 */

public void enomem()
{
	/* Raises the "Out of memory" exception. Due to the special nature of this
	 * exception, we may not have been able to push everything we wanted on the
	 * Eiffel stack. So set a special flag to indicate that in case the stack
	 * is dumped. Note however that the calling stack is always consistent in
	 * the sense that the run-time can safely unwind the stack to get back to
	 * a previous call.
	 */
	
	echmem |= MEM_FULL;		/* We dramatically ran out of memory */
	xraise(EN_OMEM);		/* The "Out of memory" stuff */
}

public struct ex_vect *exset(name, origin, object)
char *name;				/* The routine name */
int origin;				/* The origin of the routine */
char *object;			/* The object on which the routine is applied */
{
	/* Sets the execution vector with the routine's parameters, so that we
	 * can produce an execution stack in case of routine failure. This brand new
	 * vector is then pushed on the Eiffel stack.
	 * This routine is normally called at the very top of each Eiffel routine;
	 * it returns the address of the exception vector or raises an exception.
	 */

	register1 struct ex_vect *vector;	/* The exception vector */

	SIGBLOCK;				/* Critical section, protected against signals */

	/* Attempt to get a new vector for the current routine. If we can't, we
	 * have to raise an exception which will transfer control outside of the
	 * current routine anyway. The current call won't be mentionned in the stack
	 * trace. Logically, it is as if we had never entered in this routine.
	 */
	vector = exget(&eif_stack);	 /* Get brand new vector on the Eiffel stack */
	if (vector == (struct ex_vect *) 0)		/* No more memory */
		enomem();							/* Critical exception */

	vector->ex_type = EX_CALL;		/* Signals entry in a new routine */
	vector->ex_retry = 0;			/* Function not retried (yet!) */
	vector->ex_jbuf = (char *) 0;	/* As far as we know, no rescue clause */
	vector->ex_rout = name;			/* Set the routine name */
	vector->ex_orig = origin;		/* And its origin (where it was written) */
	vector->ex_id = object;			/* The value of Current (Object ID) */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	return vector;		/* Execution vector of current Eiffel routine */
}

#ifndef WORKBENCH
public struct ex_vect *exft()
{
	/* Get an execution vector, in final mode. We don't bother setting the
	 * feature name or the object ID as there is no stack dump in final mode.
	 */

	register1 struct ex_vect *vector;	/* The exception vector */

	SIGBLOCK;				/* Critical section, protected against signals */

	/* Attempt to get a new vector for the current routine. If we can't, we
	 * have to raise an exception which will transfer control outside of the
	 * current routine anyway. The current call won't be mentionned in the stack
	 * trace. Logically, it is as if we had never entered in this routine.
	 */
	vector = exget(&eif_stack);	 /* Get brand new vector on the Eiffel stack */
	if (vector == (struct ex_vect *) 0)		/* No more memory */
		enomem();							/* Critical exception */

	vector->ex_type = EX_CALL;		/* Signals entry in a new routine */
	vector->ex_retry = 0;			/* Function not retried (yet!) */
	vector->ex_jbuf = (char *) 0;	/* As far as we know, no rescue clause */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	return vector;		/* Execution vector of current Eiffel routine */
}
#endif

public struct ex_vect *exret(rout_vect)
register1 struct ex_vect *rout_vect;	/* Exec. vector of enclosing routine */
{
	/* An exception was caught in the enclosing routine and transferred the
	 * control to the "rescue" clause. The program now reached a "retry"
	 * instruction so control has to be transferred again at the start of
	 * the Eiffel routine.
	 * For the history mechanism, we have to push a new execution vector on
	 * the stack, stating we retried the routine, after having poped off the
	 * top which must be of EX_RESC type (this ensures we'll have room to
	 * push the vector, hehe!--RAM).
	 * The routine returns the address of the new execution vector for
	 * the Eiffel routine we're in.
	 */

	struct ex_vect *last_item;		/* Item at the top of the calling stack */

	last_item = extop(&eif_stack);		/* Make sure top is EX_RESC */

#ifdef MAY_PANIC
	if (last_item->ex_type != EX_RESC)
		panic(botched);
#endif
	
	SIGBLOCK;				/* Critical section, protected against signals */

	/* Normally we should pop off this vector and get a new one, but it is so
	 * much simpler (and faster) to simply replace the top by the new vector.
	 * Copy the routine vector of the original routine, changing the type
	 * to EX_RETY to signal it has been retried. Note that the setjmp buffer
	 * address is kept.
	 */
	bcopy(rout_vect, last_item, sizeof(struct ex_vect));
	last_item->ex_type = EX_RETY;		/* Signals a retry */

	/* Pop off the EN_ILVL record on the Eiffel trace stack. This record was
	 * pushed while backtracking from the original EX_CALL or EX_RETY record.
	 * (the one associated with the routine we are currently retrying).
	 * Also signal in the Eiffel trace stack that the last call has been
	 * retried (resumption attempt).
	 */
	rout_vect = extop(&eif_trace);		/* Top of exception trace stack */

#ifdef MAY_PANIC
	if (rout_vect->ex_type != EN_ILVL)
		panic(botched);
#endif

	expop(&eif_trace);					/* Remove EN_ILVL */
	echlvl--;							/* And decrease exception level */
	rout_vect = extop(&eif_trace);		/* Top of exception trace stack */

#ifdef MAY_PANIC
	switch (rout_vect->ex_type) {		/* Consistency check */
	case EN_FAIL:						/* Routine failure */
	case EN_RES:						/* Resumption failed */
		rout_vect->ex_retry = 1;		/* Function has been retried */
		break;							/* Ok for these two */
	default:
		panic(botched);
	}
#else
	rout_vect->ex_retry = 1;		/* Function has been retried */
#endif

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	return last_item;	/* Execution vector for new routine invokation */
}

public void exinv(tag, object)
register2 char *tag;		/* Assertion tag */
register3 char *object;		/* The object on which invariant is checked */
{
	/* Checking of the invariant 'tag' on 'object' */
	
	register1 struct ex_vect *vector;		/* The execution vector */

	SIGBLOCK;			/* Critical section, protected against signals */

	vector = exget(&eif_stack);				/* Get an execution vector */
	if (vector == (struct ex_vect *) 0) {	/* No more memory */
		echmem |= MEM_FULL;					/* Exception stack incomplete */
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* May be ignored */
	}

	vector->ex_type = EX_CINV;		/* Class invariant checking */
	vector->ex_name = tag;			/* The associated assertion tag */
	vector->ex_oid = object;		/* The value of Current (object ID) */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

public void exasrt(tag, type)
char *tag;								/* Assertion's tag */
int type;								/* Type of assertion */
{
	/* Whenever an assertion is checked, an execution vector must be pushed on
	 * the Eiffel calling stack (eif_stack). In case of exception, this will
	 * help providing the exception trace.
	 * This routine records an assertion 'type' whose tag is 'tag'.
	 */

	register1 struct ex_vect *vector;		/* The execution vector */

	SIGBLOCK;			/* Critical section, protected against signals */

	vector = exget(&eif_stack);				/* Get an execution vector */
	if (vector == (struct ex_vect *) 0) {	/* No more memory */
		echmem |= MEM_FULL;					/* Exception stack incomplete */
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* Exception may be ignored */
	}

	/* The ex_where field for EX_PRE is set only during backtracking */

	vector->ex_type = type;					/* Assertion's type */
	vector->ex_name = tag;					/* Assertion's tag */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

/* The following function was originally designed to catch exceptions from the
 * interpreter, but is now widely used to provide a run-time catching of the
 * exceptions and perform some cleanup (e.g. in a retrieve operation).
 */

public void excatch(jmp)
char *jmp;		/* The jump buffer used to catch exception */
{
	/* Push a pseudo EX_OSTK execution vector on the exception stack. Whenever
	 * a call to a melted feature is done from C, we have to save the state of
	 * the operational stack, in case an exception occurs. This vector will
	 * provide a setjmp() buffer to backtrack. If an exception occurs in the
	 * interpreter and is not catched by any interpreted routine, then we will
	 * return to the point where the EX_OSTK vector was pushed and it will then
	 * be possible to restore the saved stack context (i.e. clean up the mess
	 * from the failed melted routines).
	 */
	
	register1 struct ex_vect *vector;		/* The execution vector */

	SIGBLOCK;			/* Critical section, protected against signals */

	vector = exget(&eif_stack);				/* Get an execution vector */
	if (vector == (struct ex_vect *) 0) {	/* No more memory */
		echmem |= MEM_FULL;					/* Exception stack incomplete */
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* May be ignored */
	}

	vector->ex_type = EX_OSTK;		/* Operational stack cleaner */
	vector->ex_jbuf = jmp;			/* Set catching point */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

public void exhdlr(handler, sig)
Signal_t (*handler)();			/* The signal handler to be called */
int sig;						/* Caught signal */
{
	/* A signal was caught and we are about to transfer control to a signal
	 * handler. Should an exception occur in the handler, it has to be trapped
	 * and reported to the interrupted routine (in effect, we enter a new
	 * level before calling the handler).
	 * Moreover, some nasty things could happen if the exception handler called
	 * the garbage collector, so it is disabled before calling the handler.
	 * This means no longjmp() must appear in the handler or the GC will remain
	 * stopped forever (we have to provide our onw setjmp/longjmp mechanism
	 * which will know about the exception stack)--RAM.
	 */

	register1 struct ex_vect *trace;		/* Top of Eiffel trace stack */
	jmp_buf env;							/* Environment saving for setjmp */
	char gc_status;							/* Saved GC status */

	/* There is no need to protect against signals here, as this routine can
	 * only be called via the signal handler, which takes care of blocking
	 * them for us...
	 */

	if (echmem & MEM_FSTK)			/* Eiffel stack is full */
		enomem();					/* Critical exception */

	/* Before getting an execution vector, we must disable the GC. Indeed, we
	 * must guarantee the garbage collector will NEVER be called within the
	 * interruption or some dangling references may appear due to objects
	 * moves--RAM.
	 */

	gc_status = g_data.status;		/* Save GC current status */
	g_data.status |= GC_STOP;		/* Stop garbage collection anyway */
	g_data.status |= GC_SIG;		/* Signals entering in signal handler */

	trace = exget(&eif_trace);		/* Get a new execution vector */
	if (trace == (struct ex_vect *) 0) {	/* Can't have it */
		echmem |= MEM_FSTK;					/* Stack is full */
		g_data.status = gc_status;			/* Restore previous GC status */
		enomem();							/* We ran out of memory */
	}

	trace->ex_type = EN_ILVL;		/* New exception level on stack */
	trace->ex_lvl = ++echlvl;		/* Record new level */

	/* If we come here, we were able to get a vector for EN_ILVL. If we cannot
	 * get one for EX_HDLR, this is a non-critical "No more memory" exception.
	 */
	
	trace = exget(&eif_stack);		/* Vector to record entry in handler */
	if (trace == (struct ex_vect *) 0) {	/* Can't have it */
		echmem |= MEM_FULL;					/* Exception stack incomplete */
		expop(&eif_trace);					/* Remove EN_ILVL vector */
		echlvl--;							/* We did not enter a new level */
		g_data.status = gc_status;			/* Restore previous GC status */
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* Which may be ignored */
	}

	trace->ex_type = EX_HDLR;		/* Enter in a signal handler */

	/* It is now time to call the handler after all those silly "stack"
	 * considerations. We put a setjmp to ensure we'll regain control should
	 * an exception occur, so that garbage collection may be enabled again.
	 */

	if (setjmp(env)) {				/* Returning from an exception */
		g_data.status = gc_status;	/* Restore previous GC status */
		xraise(EN_HDLR);			/* Raise exception in signal handler */
		return;						/* Exception ignored */
	}
	trace->ex_jbuf = (char *) env;	/* Save setjmp buffer address */
	(handler)(sig);					/* LISPish call to signal handler :-) */
	g_data.status = gc_status;		/* Restore saved GC status */
	expop(&eif_trace);				/* Remove EN_ILVL record */
	expop(&eif_stack);				/* And EX_HDLR vector */
}

public void exfail()
{
	/* The routine whose execution vector is 'exvect' has reached the end
	 * of its rescue clause. So it will fail. Set the ex_rescue flag in case
	 * we have to dump the exception trace and pops off the EX_RESC vector
	 * on eif_stack and the EN_ILVL record on top of eif_trace (pushed on
	 * entry in the rescue clause).
	 */

	SIGBLOCK;			/* Critical section, protected against signals */

	expop(&eif_stack);	/* Remove EX_RESC vector */
	expop(&eif_trace);	/* As well as EN_ILVL */
	echlvl--;			/* Decrease by one level */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	eviol();			/* And raise exception in caller */
}

public void exresc(rout_vect)
register2 struct ex_vect *rout_vect;
{
	/* Signals entry in rescue clause. As we may enter a new exception level
	 * should an exception occur in the clause, push a "New level" on the
	 * Eiffel trace stack and signal we've been in the rescue of the current
	 * call (top of Eiffel trace stack).
	 */
	
	register1 struct ex_vect *trace;	/* Top of Eiffel trace item */

	SIGBLOCK;			/* Critical section, protected against signals */

	trace = extop(&eif_trace);		/* Should be a calling vector */

#ifdef MAY_PANIC
	/* Panic if the top of the stack is not a calling vector. We may have
	 * run out of memory, but we cannot continue with an incorrect stack,
	 * that could break the program's consistency.
	 */
	switch (trace->ex_type) {
	case EN_FAIL:
	case EN_RES:
		trace->ex_rescue = 1;		/* Signals entry in rescue clause */
		break;
	default:
		panic(botched);
	}
#else
	trace->ex_rescue = 1;		/* Signals entry in rescue clause */
#endif

	if (!(echmem & MEM_FSTK)) {				/* Eiffel trace not full */
		trace = exget(&eif_trace);			/* Record entry in new level */
		if (trace == (struct ex_vect *) 0) {
			echmem |= MEM_FSTK;				/* Stack is full */
			enomem();						/* Critical exception */
		}
		trace->ex_type = EN_ILVL;			/* New exception level */
		trace->ex_lvl = ++echlvl;			/* Record new level */
	} else
		echlvl++;

	trace = exget(&eif_stack);				/* Get an execution vector */
	if (trace == (struct ex_vect *) 0) {	/* No more memory */
		echmem |= MEM_FULL;					/* Exception stack incomplete */
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* If exception is ignored */
	}

	bcopy(rout_vect, trace, sizeof(struct ex_vect));
	trace->ex_type = EX_RESC;		/* Physical entry in rescue clause */
	trace->ex_rescue = 0;			/* Meaningless from now on */
	trace->ex_retry = 0;			/* So is this */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

public void xraise(code)
int code;
{
	/* Raises an Eiffel exception of the given code with no associated tag */

	eraise((char *) 0, code);
}

public void eraise(tag, num)
char *tag;
long num;			/* May be called from Eiffel, and INTEGER is long */
{
	/* Raises the exception whose number is 'num'. The execution code is set,
	 * then the stack is unwound up to the first non-null jum_buf pointer.
	 * The 'tag' is used to record the exception tag. This does not work for
	 * all the exceptions (e.g. it has no meaning for an operating system
	 * signal).
	 */
	
	struct ex_vect *trace;		/* The stack trace entry */

	if (echmem & MEM_PANIC)		/* In panic mode, do nothing */
		return;

	if (echmem & MEM_FATAL)		/* In fatal error mode, panic! */
		panic("exception in fatal mode");

	/* Excepted for EN_OMEM, check whether the user wants to ignore the
	 * exception or not. If so, return immediately.
	 */
	if (num != EN_OMEM && num < EN_NEX && ex_ign[num])
		return;			/* Exception is ignored */

	SIGBLOCK;			/* Critical section, protected against signals */
	echval = num;		/* Set exception number */

	/* Save the exception on the exception trace stack, if possible. If that
	 * stack is full, raise the EN_OMEM memory exception if not currently done.
	 */
	if (!(echmem & MEM_FSTK)) {		/* If stack is not full */
		trace = exget(&eif_trace);
		if (trace == (struct ex_vect *) 0) {	/* Stack is full now */
			echmem |= MEM_FULL;					/* Signal it */
			if (num != EN_OMEM)					/* If not already there */
				enomem();						/* Raise an out of memory */
		} else {
			trace->ex_type = num;		/* Exception code */
			switch (num) {
			case EN_SIG:				/* Received a signal */
				trace->ex_sig = echsig;	/* Record its number */
				break;
			case EN_SYS:				/* Operating system error */
			case EN_IO:					/* I/O error */
				trace->ex_errno = errno;
				break;
			default:
				trace->ex_name = tag;	/* Record its tag */
				trace->ex_where = 0;	/* Unknown location (yet) */
			}
		}
	}

	/* Set up 'echtg' to be the tag of the current exception, if one can be
	 * computed, otherwise it is a null pointer. This will be used by the
	 * debugger in its stop notification request.
	 */

	switch (num) {
	case EN_SIG:			/* Signal received */
		echtg = signame(trace->ex_sig);
		break;
	case EN_SYS:			/* Operating system error */
	case EN_IO:				/* I/O error */
		echtg = error_tag(trace->ex_errno);
		break;
	default:
		echtg = tag;
	}

	/* Maintain the notion of original exception at this level, despite any
	 * extra explicit raises, by recomputing the code each time. Due to the
	 * way exorig() works, we have to fake the entry in a new exception level
	 * prior to the call.
	 */
	echlvl++;			/* Have to fake a nesting level */
	exorig();			/* Recompute original exception code */
	echlvl--;			/* Restore nesting level */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	exception(PG_RAISE);	/* Debugger hook -- explicitly raised exception */
	ereturn();				/* Go back to last recorded rescue entry */

	/* NOTREACHED */
}

public void eviol()
{
	/* An assertion violation occurred, or the routine reached the end of its
	 * rescue clause with no 'retry'. Set the exception code matching the
	 * execution vector at the top of the stack and start backtracking, unless
	 * we have to ignore the exception.
	 */
	
	struct ex_vect *vector;			/* The stack vector entry at the top */
	int code;						/* Exception code */

	/* Derive exception code from the information held in the top level vector
	 * in the Eiffel call stack. If the exception is ignored, pop the offending
	 * vector and leave 'echval' undisturbed. Otherwise, set 'echval' to the
	 * code of the current exception and start backtracking.
	 */

	vector = extop(&eif_stack);		/* Top level vector */
	code = xcode(vector);			/* Failure yields a specific code */
	if (code < EN_NEX && ex_ign[code]) {	/* Exception to be ignored */
		expop(&eif_stack);					/* Remove the faulty vector */
		return;
	}


	/* Set up 'echtg' to be the tag of the current exception, if one can be
	 * computed, otherwise it is a null pointer. This will be used by the
	 * debugger in its stop notification request.
	 */

	echval = code;				/* Keep track of the last exception code */
	echtg = vector->ex_name;	/* Record exception tag, if any */

	/* Maintain the notion of original exception at this level, despite any
	 * extra implicit raises, by recomputing the code each time. Due to the
	 * way exorig() works, we have to fake the entry in a new exception level
	 * prior to the call.
	 */
	echlvl++;			/* Have to fake a nesting level */
	exorig();			/* Recompute original exception code */
	echlvl--;			/* Restore nesting level */

	exception(PG_VIOL);		/* Debugger hook -- implicitely raised exception */
	ereturn();				/* Go back to last recorded rescue entry */

	/* NOTREACHED */
}

public void ereturn()
{
	/* Return to the first setjmp buffer stored in the exception stack. The
	 * bottom of the stack (created by the main routine) always has a valid
	 * return point anyway, but returning there causes the immediate system
	 * failure and the dumping of the exception stack held in eif_trace.
	 */

	char *rescue;					/* The rescue setjmp buffer */

	/* The backtracking operation is not a critical operation, so to speak.
	 * Nonetheless, I wish to protect its execution so as to avoid poblems
	 * should a signal occur right in the middle of the whole operation--RAM.
	 */

	SIGBLOCK;						/* Critical section */
	rescue = backtrack();			/* Attempt rescue */
	SIGRESUME;						/* Dispatch queued signals */

	if (rescue != (char *) 0)
		longjmp(rescue, echval);	/* Setjmp will return the exception code */

	panic(vanished);				/* main() should have created a vector */
	/* NOTREACHED */
}

private char *backtrack()
{
	/* Assuming an exception has occurred, start the backtracking process in
	 * order to find a valid branching point (routine with a rescue clause). If
	 * none can be found, return a null pointer, otherwise return the address
	 * of the jmp_buf environment.
	 * There is no real concern for being really fast here, so I've chosen to
	 * rely on existing interface functions instead of hardwiring a loop--RAM.
	 */

	register1 struct ex_vect *top;		/* Top of calling stack */
	register2 struct ex_vect *trace;	/* The stack trace entry */

	while (top = extop(&eif_stack)) {	/* While bottom not reached */

		/* Whether or not there is a rescue clause for the top of the stack
		 * (indicated by the jmp_buf pointer), we need to push the current
		 * execution vector on the trace stack. If we then fail in the rescue
		 * clause, we'll be able to signal failure before giving the exception
		 * stack raised by the execution of this rescue clause. I hope this
		 * is clear enough--RAM.
		 */

#ifdef DEBUG
		dump_vector("backtrack: top of eif_stack", top);
#endif

		if (!(echmem & MEM_FSTK)) {		/* If Eiffel trace stack is not full */
			trace = exget(&eif_trace);	/* New vector on the exception stack */
			if (trace == (struct ex_vect *) 0) {		/* No more memory */
				echmem |= MEM_FSTK;						/* Stack full now */
				enomem();								/* Critical exception */
			}
			bcopy(top, trace, sizeof(struct ex_vect));	/* Record exception */
			trace->ex_type = xcode(top);				/* Exception code */
		}
		expop(&eif_stack);			/* Vector no longer needed on stack */

		/* Now analyze the contents of the topmost exception vector. If it is
		 * a call or a retry vector, it may hold a valid setjmp buffer. In that
		 * case, we finished our processing and may return that address.
		 * Updating of the tracing stack is done on the fly. Note that even
		 * though there is no execution stack produced in final mode, we need
		 * to build the trace stack, as it is also a track of the pending
		 * exceptions which could be made user-visible via the EXCEPTION class.
		 */

		switch (top->ex_type) {			/* Type of execution vector stored */
		case EX_CALL:					/* A main routine entrance */
			/* Fall through */
		case EX_RETY:					/* A retried routine */
			/* If a setjmp buffer is found, we're entering in a new exception
			 * level. We'll jump in a rescue clause and the generated C code
			 * will call exresc(), which will push a "New level" on stack.
			 */
			if (top->ex_jbuf && !(echmem & MEM_SPEC)) 	/* Not in panic */
				return top->ex_jbuf;		/* We found a valid setjmp buffer */
			break;
		case EX_OSTK:					/* Exception catcher */
			/* Here we are: we caught the exception from the interpreter. There
			 * must be a valid setjmp buffer attached to that vector. Returning
			 * to that point will enable the run-time to clean-up the stack
			 * filled in by the (failed) melted routines.
			 * This has been enhanced to make a general exception catcher, hence
			 * it is also defined in final mode.
			 */
			expop(&eif_trace);			/* Catching must remain invisible */
			if (!(echmem & MEM_SPEC))	/* Not in panic */
				return top->ex_jbuf;	/* Setjmp buffer exists */
			break;
		case EX_RESC:					/* A rescue clause (failed) */
			/* We reached the end of an execution level. Push an "end of level"
			 * pseudo-record on the exception trace stack BEFORE the EX_RESC
			 * record on the stack. Indeed, the failure of the rescue clause
			 * occurs in a level below the exceptions raised by the execution
			 * of that rescue clause.
			 */
			exorig();							/* Restore original setting */
			if (!(echmem & MEM_FSTK)) {			/* Eiffel trace not full */
				top = exget(&eif_trace);		/* Record end of level */
				if (top == (struct ex_vect *) 0) {
					echmem |= MEM_FSTK;			/* Stack is full */
					enomem();					/* Critical exception */
				}
				bcopy(trace, top, sizeof(struct ex_vect));	/* Shift record */
				trace->ex_type = EN_OLVL;	/* Exit one exception level */
				trace->ex_lvl = echlvl--;	/* Level we're comming from */
			} else
				echlvl--;
			/* The exception in rescue clause is implicitely raised here by
			 * setting the echval variable (which records the current exception)
			 * and continuing the backtracking. In effect, this will raise an
			 * exception in the caller. Note that the original exception was
			 * restored in 'echorg' by the exorig() call.
			 */
			echval = EN_RESC;			/* Exception in rescue clause */
			echtg = (char *) 0;			/* No associated tag */
			break;
		case EX_HDLR:					/* Signal handler routine failed */
			/* Push an "end of level" pseudo-record on the exception trace stack
			 * in place of the EN_HDLR record. As we must have a valid setjmp
			 * buffer address in the vector, we'll jump back to the exhdlr
			 * routine, which will be in charge of raising the exception. This
			 * is why we may safely replace the existing EN_HDLR record--RAM.
			 */
			trace->ex_type = EN_OLVL;		/* Exit one exception level */
			trace->ex_lvl = echlvl--;		/* Level we're comming from */
#ifdef MAY_PANIC
			if (top->ex_jbuf) {				/* There is a setjmp buffer */
				if (!(echmem & MEM_SPEC))	/* Not in panic mode */
					return top->ex_jbuf;	/* Address of env buffer */
			} else
				panic(botched);				/* There has to be a buffer */
#else
			if (!(echmem & MEM_SPEC))		/* Not in panic mode */
				return top->ex_jbuf;		/* Address of env buffer */
#endif
			break;
		case EX_PRE:					/* A precondition was violated */
			/* An EX_CALL must follow on the stack (it cannot be an EX_RETY as
			 * preconditions are not rechecked when a retry occurs). Take it and
			 * initializes the ex_where field correctly. For a pre-condition,
			 * the exception is raised in the caller hence the caller must
			 * disappear from the stack...
			 */
			top = extop(&eif_stack);
#ifdef MAY_PANIC
			if (top == (struct ex_vect *) 0)
				panic(botched);
#endif
#ifdef WORKBENCH
			/* In workbench mode, it is possible to have a precondition melted,
			 * but the code frozen. Hence we need to slurp the exception catcher
			 * stacked by the interpreter, without disturbing the normal
			 * behaviour which is to raise the exception in the caller. But we
			 * also have to honour the vector and return in the interpreter in
			 * order to clean the operational stack (that's the purpose of this
			 * exception trap).
			 */
		{
			char *jbuf = (char *) 0;			/* Setjmp buffer from EX_OSTK */

			if (top->ex_type == EX_OSTK) {		/* Melted pre-condition */
				jbuf = top->ex_jbuf;			/* Save setjmp buffer */
				expop(&eif_stack);				/* Remove catching vector */
				top = extop(&eif_stack);		/* Update top */
			}
#endif
#ifdef MAY_PANIC
			switch (top->ex_type) {
			case EX_CALL:			/* Precondition violated in a call */
				trace->ex_where = top->ex_rout;	/* Save routine name */
				trace->ex_from = top->ex_orig;	/* Where it comes from */
				trace->ex_oid = top->ex_id;		/* And object ID */
				expop(&eif_stack);				/* Exception raised in caller */
				break;
			default:
				panic(botched);
				/* NOTREACHED */
			}
#else
			trace->ex_where = top->ex_rout;	/* Save routine name */
			trace->ex_from = top->ex_orig;	/* Where it comes from */
			trace->ex_oid = top->ex_id;		/* And object ID */
			expop(&eif_stack);				/* Exception raised in caller */
#endif
#ifdef WORKBENCH
			/* In workbench mode, if we detected an EX_OSTK catching record,
			 * then the ex_jbuf entry in the trace vector is a non-null pointer.
			 */
			if (jbuf != (char *) 0 && !(echmem & MEM_SPEC))
				return jbuf;			/* Setjmp buffer from EX_OSTK */
		}
#endif
			break;
		default:
			break;		/* No special processing needed */
		}

#ifdef DEBUG
		dump_vector("backtrack: top of eif_trace", trace);
#endif

	}

	return (char *) 0;	/* No setjmp buffer found */
}

public void exok()
{
	/* Signals that the call recorded at the top of the stack has finished
	 * normally (eventually via resumption). Pop off the values on the
	 * execution stack until the first EX_CALL structure. Also pop off values
	 * from the exception trace stack (those matching our level).
	 * It's not our concern to deal with the local variable stack. This routine
	 * is called only before returning from a routine with a rescue clause.
	 */
	
	register1 struct ex_vect *top;		/* Top of calling stack */
	register2 struct stxchunk *start;	/* First chunk in trace stack */
	register3 int type;					/* Type of execution vector */

	/* If 'echval' is set to zero, then no exception occurred, so return
	 * immediately. Otherwise, pop off the stack until we reach an execution
	 * vector, which will be popped off by the normal ending of the routine.
	 * (The generated C code does not optimize the call to exok() by first
	 * testing the value of 'echval', nor does the interpreter hence the test
	 * here--RAM).
	 */

	if (echval == 0)
		return;							/* No exception occurred */
	
	SIGBLOCK;			/* Critical section, protected against signals */

	while (top = extop(&eif_stack)) {	/* Find last enclosing call */
		type = top->ex_type;			/* Type of the current vector */
		if (type == EX_CALL || type == EX_RESC || type == EX_RETY)
			break;						/* We found a calling record */
		expop(&eif_stack);				/* Will panic if we underflow */
	}
		
	/* Now deal with the trace stack. If the exception level is 0, we can reset
	 * the whole stack. Otherwise, we have to unwind it until we find the
	 * "New level" pseudo-vector.
	 */
	if (echlvl == 0) {			/* Optimization (no nested exceptions) */
		start = eif_trace.st_cur = eif_trace.st_hd;	/* Back to first chunk */
		eif_trace.st_top = start->sk_arena;			/* Reset initial state */
		eif_trace.st_end = start->sk_end;			/* Stack has been cleared */
		echval = 0;				/* No more pending exception */
		echmem = 0;				/* We seem to have recovered from out of mem */
		echorg = 0;				/* No more original exception */
	} else {					/* Normal case (should rarely occur) */
		while (top = extop(&eif_trace)) {
			if (top->ex_type == EN_ILVL && top->ex_lvl == echlvl)
				break;			/* Found matching level record */
			expop(&eif_trace);	/* Will panic if we underflow */
		}
		echmem &= ~MEM_FSTK;	/* Eiffel trace stack no longer full */
		if ((struct ex_vect *) 0 == extop(&eif_trace)) {	/* Empty stack */
			echval = 0;			/* No more pending exception */
			echmem = 0;			/* We have recovered from this out of mem */
			echorg = 0;			/* No more original exception */
		} else {				/* Still some exceptions pending */
			exorig();			/* Update values from original exception */
			excur();			/* Recompute current exception at this level */
		}
	}

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

private void excur()
{
	/* Compute the value of the current exception which was pushed on the
	 * exception trace stack, at the previous execution level. The run-time
	 * maintains this notion of 'current exception' (the last one which was
	 * raised) and it is normally carried by 'echval'. Also reset 'echtg' to be
	 * the current exception tag.
	 */

	struct xstack context;		/* Saved stack context */
	struct ex_vect *top;		/* Walk through stack */

#ifdef MAY_PANIC
	if (echlvl < 1)				/* There has to be at least one nesting level */
		panic(botched);
#endif

#ifdef USE_STRUCT_COPY
	context = eif_trace;
#else
	bcopy(&eif_trace, &context, sizeof(struct xstack));
#endif

	/* The current top at this point is an EN_ILVL record, so the last exception
	 * which occurred at the previous level is just the one below.
	 */

	expop(&eif_trace);			/* This removes the EN_ILVL record */
	top = exget(&eif_trace);	/* Last exception at previous level */
	echval = top->ex_type;		/* Current exception code */
	echtg = extag(top);			/* Recompute exception tag */

#ifdef USE_STRUCT_COPY
	eif_trace = context;
#else
	bcopy(&context, &eif_trace, sizeof(struct xstack));
#endif
}

private void exorig()
{
	/* Compute the value of the original exception which started to fill in
	 * the exception trace stack, at the previous execution level. The run-time
	 * maintains this notion of 'original exception' (the one which started it
	 * all) and it is normally carried by 'echorg'. Also reset 'echotag' to be
	 * the original exception tag.
	 */

	struct xstack context;		/* Saved stack context */
	struct ex_vect *top;		/* Walk through stack */
	int poped;					/* Number of vectors already poped */

#ifdef MAY_PANIC
	if (echlvl < 1)				/* There has to be at least one nesting level */
		panic(botched);
#endif

	/* If there is only one nesting level, then the exception which started it
	 * all is at the bottom of the stack, since we enter a new level each time
	 * we execute a rescue clause.
	 */

	if (echlvl == 1) {				/* Only one level -> bottom of stack */
		if (eif_trace.st_hd == (struct stxchunk *) 0) {		/* No stack yet */
			echorg = echval;				/* Original is current exception */
			echotag = echtg;				/* As well as original tag */
			return;
		}
		top = eif_trace.st_hd->sk_arena;	/* This is the bottom */
		if (top == eif_trace.st_top) {		/* Empty stack (yes, can happen) */
			echorg = echval;				/* Original is current exception */
			echotag = echtg;				/* As well as original tag */
		} else {
			echorg = top->ex_type;			/* Get original exception code */
			echotag = extag(top);			/* And recompute tag */
		}
		return;
	}

	/* We are in level 'echlvl' and the exception which started it all is the
	 * one just above the EX_ILVL record at level 'echlvl - 1' (i.e. the
	 * previous nesting level).
	 */

#ifdef USE_STRUCT_COPY
	context = eif_trace;
#else
	bcopy(&eif_trace, &context, sizeof(struct xstack));
#endif

	poped = 0;		/* If top is the EN_ILVL vector, then we come from eviol */
	echorg = 0;		/* Signals not found (yet) */

	while (top = extop(&eif_trace)) {
		if (top->ex_type == EN_ILVL && top->ex_lvl == (echlvl - 1)) {
			if (poped == 0) {			/* First one, nothing at this level */
				echorg = echval;		/* Current exception is original */
				echotag = echtg;		/* (implicitely raised from eviol) */
				break;
			}
			(void) exget(&eif_trace);	/* Move just above it */
			top = extop(&eif_trace);	/* Fetch record */
			echorg = top->ex_type;		/* Original exception code */
			echotag = extag(top);		/* Recompute exception tag */
			break;
		}
		expop(&eif_trace);		/* Level mark not found, continue */
		poped++;
	}

#ifdef MAY_PANIC
	/* We might not have found the record (because an out of memory condition
	 * was detected). Otherwise, code must be non-zero.
	 */
	
	if (!(echmem & MEM_FSTK) && echorg == 0)
		panic(botched);
	else if (echorg == 0) {
		echorg = EN_OMEM;				/* Default exception */
		echotag = (char *) 0;			/* No known tag */
	}
#else
	if (echorg == 0) {
		echorg = EN_OMEM;				/* Default exception */
		echotag = (char *) 0;			/* No known tag */
	}
#endif

#ifdef USE_STRUCT_COPY
	eif_trace = context;
#else
	bcopy(&context, &eif_trace, sizeof(struct xstack));
#endif
}

private char *extag(trace)
struct ex_vect *trace;		/* Faulty vector on trace stack */
{
	/* Recompute the exception tag associated with vector on stack. This burden
	 * is needed because of class EXCEPTION wich might ask the tag of the last
	 * exception any time--RAM.
	 */

	switch (trace->ex_type) {
	case EN_SIG:			/* Signal received */
		echtg = signame(trace->ex_sig);
		break;
	case EN_SYS:			/* Operating system error */
	case EN_IO:				/* I/O error */
		echtg = error_tag(trace->ex_errno);
		break;
	default:
		echtg = trace->ex_name;
	}
}

public void esfail()
{
	/* Produces immediate failure of the Eiffel system followed by an exception
	 * trace dump. No exit is performed. However, before returning we have to
	 * call the GC (a single mark and sweep will do) to ensure "dispose" is
	 * called on every dead objects (for instance to ensure all temporary
	 * files are removed and locks are cleared).
	 */
	
	/* We flush stdout now, to avoid unprinted data being printed after the
	 * stack trace. This is mainly indented for situations like stdout = tty
	 * or stdout and stderr redirected to the same file.
	 */
	fflush(stdout);

	/* Signals failure. If the out of memory flags are set, mention it */
	fputc('\n', stderr);
	fprintf(stderr, "%s: system execution failed.\n", ename);
	fprintf(stderr, "Following is the set of recorded exceptions");
	if (echmem & MEM_FSTK) {
		fprintf(stderr,
	".\nDue to a lack of memory, the sequence is incomplete near the end");
	}
	if (echmem & MEM_FULL) {
		if (echmem & MEM_FSTK) {
			fprintf(stderr,
	".\nMoreover, an 'out of memory' may have led to an untrustworthy stack");
		} else {
			fprintf(stderr,
	".\nHowever, an 'out of memory' occurred and might have spoilt the stack");
		}
	}
	if (echmem & MEM_PANIC) {
		fprintf(stderr,
".\nNB: The raised panic may have induced completely inconsistent information");
	}
	fprintf(stderr, ":\n\n");

	echmem |= MEM_PANIC;		/* Backtrack won't attempt any longjmp */
	(void) backtrack();			/* Unwind the whole stack */
	dump_trace_stack();			/* Print the stack */
}

#ifdef WORKBENCH
private void exception(how)
int how;		/* Implicit or explicit exception? */
{
	/* This is a debugger hook in workbench mode. If an exception is raised,
	 * either explicitely via eraise() or implicitely via eviol(),  then this
	 * this function is called.
	 * We pay attention to the "explicitness" of the exception, as the stack
	 * dumps within the debugger are not exactly performed in the same way, wrt
	 * the top record on both eif_stack and eif_trace (as eraise() explicitely
	 * pushes an exception record in eif_trace while eviol() relies on the
	 * backtracking process to do it).
	 */

	if (db_ign[echval])		/* Current exception to be ignored */
		return;				/* Do not stop execution */

	dbreak(how);			/* Stop execution */
}
#else
private void exception(how)
int how;		/* Implicit or explicit exception? */
{
	/* This is a no-operation call in final mode (no debugger). If an exception
	 * is raised, either explicitely via eraise() or implicitely via eviol(), 
	 * then this function is called.
	 */
}
#endif

public void panic(msg)
char *msg;
{
	/* In case of run-time panic, print the final message 'msg' and dumps
	 * an execution stack if possible. This exception cannot be trapped.
	 */

	struct ex_vect *trace;		/* To insert the panic in the stack */
	static int done = 0;		/* Avoid panic cascade */

	/* We flush stdout now, to avoid unprinted data being printed after the
	 * stack trace. This is mainly indented for situations like stdout = console
	 * or stdout and stderr redirected to the same file.
	 */
	fflush(stdout);

	/* Some verbose stuff. Make sure however there is only one panic raised.
	 * Others will cause an immediate termination with the exit status 2.
	 */
	if (done++) {
		fprintf(stderr, "\n%s: PANIC CASCADE: %s -- Giving up...\n",
			ename, msg);
		exit(2);
	} else
		fprintf(stderr, "\n%s: PANIC: %s ...\n", ename, msg);

	/* If we are already in panic mode, ouch... We've been printing our message
	 * on stderr, and something really weird must be happening, but there is
	 * not much we can do.
	 */
	if (echmem & MEM_PANIC)			/* Already recorded a panic? */
		return;

	echmem |= MEM_PANIC;			/* Signals we enter in panic mode */
	if (!(echmem & MEM_FSTK)) {
		trace = exget(&eif_trace);	/* Try saving on top of the stack */
		if (trace)
			trace->ex_type = EN_BYE;
	}
	echtg = msg;					/* Associated tag */
	esfail();						/* Raise system failure and stack dump */
	fputc('\n', stderr);			/* Skip one line */
	dump_core();					/* Before dumping a core */
	/* NOTREACHED */
}

public void fatal_error(msg)
char *msg;
{
	/* In case of run-time fatal error, print the final message 'msg' and dumps
	 * an execution stack if possible. This exception cannot be trapped.
	 */

	struct ex_vect *trace;		/* To insert the panic in the stack */
	static int done = 0;		/* Avoid fatal cascade */

	/* We flush stdout now, to avoid unprinted data being printed after the
	 * stack trace. This is mainly indented for situations like stdout = console
	 * or stdout and stderr redirected to the same file.
	 */
	fflush(stdout);

	/* Some verbose stuff. Make sure however there is only one fatal raised.
	 * Others will cause an immediate termination with the exit status 2.
	 */
	if (done++) {
		fprintf(stderr, "\n%s: FATAL CASCADE: %s -- Giving up...\n",
			ename, msg);
		exit(2);
	} else
		fprintf(stderr, "\n%s: FATAL: %s ...\n", ename, msg);

	/* If we are already in fatal mode, ouch... We've been printing our message
	 * on stderr, and something really weird must be happening, but there is
	 * not much we can do.
	 */
	if (echmem & MEM_FATAL)			/* Already recorded a fatal? */
		return;

	echmem |= MEM_FATAL;			/* Signals we enter in panic mode */
	if (!(echmem & MEM_FSTK)) {
		trace = exget(&eif_trace);	/* Try saving on top of the stack */
		if (trace)
			trace->ex_type = EN_FATAL;
	}
	echtg = msg;					/* Associated tag */
	esfail();						/* Raise system failure and stack dump */

	reclaim();						/* Reclaim all the objects */
	exit(1);						/* Abnormal termination */

	/* NOTREACHED */
}

private void dump_core()
{
	/* Dumps a core to generate debugging information. In case the SIGABRT
	 * signal would be caught or ignored, we first reset it to the default
	 * action. This may interfere with the user's request, but usually we come
	 * here from panic(), so the state of the program is not well defined,
	 * and thus continuing would not mean much.
	 */

	signal(ABORTSIG, SIG_DFL);	/* Make sure abort() will dump a core */

	/* Stdout has already been flushed */
	fprintf(stderr, "%s: dumping core to generate debugging information...\n",
		ename);
	if (-1 == abort()) {
		perror("Failed");
	}
	exit(1);					/* Bede Bede Bede, That's all Folks ! */
}

public void esdie(code)
int code;
{
	/* This routine provokes the termination of the current Eiffel program,
	 * collecting the objects (in case some dispose procedure have been
	 * attached to objects) and then exiting with the supplied exit code.
	 */

	reclaim();					/* Collect all currently alive objects */
	exit(code);					/* Return to OS and forward final status */

	/* NOTREACHED */
}

private struct ex_vect *find_call()
{
	/* The Eiffel exception trace stack was built upside-down. So we have to
	 * walk forward through the stack to find the enclosing call record (an
	 * EN_FAIL vector). The context of the stack is saved/restored.
	 * The function return the address of the enclosing call vector.
	 */

	register1 struct ex_vect *item;	/* Item we deal with */
	struct xstack saved;			/* Saved stack context */

#ifdef USE_STRUCT_COPY
	saved = eif_trace;				/* Save stack context */
#else
	bcopy(&eif_trace, &saved, sizeof(struct xstack));
#endif

	/* Reset the exception structure to its default state */
	except.rescued = 0;				/* Not rescued */
	except.retried = 0;				/* Nor retried */

	/* Start scanning the stack. Note that the current "top" (i.e. last item)
	 * is skipped. It should have been processed by the caller to make sure it
	 * is not the call we are looking for (in fact, it should never be so,
	 * unless the stack is untrustworthy due to an out of memory condition).
	 */

	while (item = exnext()) {		/* While not (found or end of stack) */

		if (
			item->ex_type == EN_FAIL ||		/* A routine failure (1st call) */
			item->ex_type == EN_RES ||		/* A retried routine entry */
			item->ex_type == EN_RESC		/* Exception in rescue clause */
		) {

			/* A record followed by a pseudo-vector "New level" means that
			 * an exception occurred in the rescue clause, so the routine
			 * has been "rescued". This failure will not be reported, but the
			 * previous exception (there must be one if no "out of memory"
			 * occurred) will have its effect set to "Rescue".
			 */

			except.rname = item->ex_rout;	/* Routine name */
			except.from = item->ex_orig;	/* Where it comes from */
			except.obj_id = item->ex_id;	/* Object's ID */
			if (item->ex_retry)				/* Function has been retried */
				except.retried = 1;			/* Resumption has been attempted */

			/* We want to signal an entry in a rescue clause even if it has not
			 * led to an exception. If the end of the rescue clause is reached,
			 * the ending of the rescue clause set the ex_rescue flag to 1.
			 */

			if (item->ex_rescue)
				except.rescued = 1;			/* Led to a (failed) rescue */
			break;

		} else if (item->ex_type == EN_PRE) {

			/* A precondition violated raises an exception in the caller.
			 * However, the precondition occurred in another routine, whose
			 * ID is held in the vector.
			 */
			
			except.rname = item->ex_where;	/* Where precondition was */
			except.from = item->ex_from;	/* Where it was written */
			except.obj_id = item->ex_oid;	/* Object's ID */
			break;
		}
	}
			
#ifdef DEBUG
	dump_vector("find_call: enclosing call is", item);
#endif

	/* If the routine name is a null pointer, then it is the top of the
	 * execution stack, as set up by main(). In that case. the name is set
	 * to "root" and the object is the root one. In case we failed early in
	 * the process (i.e. root_obj is a null pointer), use safe values.
	 */

	if (except.rname == (char *) 0) {		/* Was created by main() */
		if (root_obj != (char *) 0) {
			except.rname = "root's creation";
			except.from = Dtype(root_obj);
		} else {
			except.rname = "root's set-up";	/* Root object not created */
			except.from = -1;				/* Signals: no valid object */
		}
		except.obj_id = root_obj;			/* Null address if early */
		except.last = 1;					/* Must be the last record */
	}

#ifdef USE_STRUCT_COPY
	eif_trace = saved;				/* Restore saved stack context */
#else
	bcopy(&saved, &eif_trace, sizeof(struct xstack));
#endif
}

private void dump_trace_stack()
{
	/* Dump the Eiffel exception trace stack once a system failure has occurred.
	 * Due to the upside-down nature of this stack, we need to use the 'st_bot'
	 * field of the xstack structure.
	 */

	/* Initializes the eif_trace structure's field st_bot correctly. It is the
	 * current bottom of the stack, which appears to be the topmost exception
	 * to be printed by this dumping routine...
	 */
	eif_trace.st_bot = eif_trace.st_hd->sk_arena;	/* Very first item */
	eif_trace.st_cur = eif_trace.st_hd;				/* Is now where bottom is */

	/* Print header of history table */
	fprintf(stderr, "%s\n", failed);
	fprintf(stderr, "%-19.19s %-22.22s %-29.29s %-6.6s\n",
		"Class / Object", "Routine", "Nature of exception", "Effect");
	fprintf(stderr, "%s\n", failed);

	/* Print body of history table. A little look-ahead is necessary, in order
	 * to give meaningful routine names and effects (retried, rescued, failed).
	 */

	except.previous = 0;		/* Previous exception code */
	recursive_dump(0);			/* Recursive dump, starting at level 0 */
}

private void recursive_dump(level)
register1 int level;
{
	/* Prints the stack trace of a given level. Whenever a new level is reached,
	 * we call us recursively, hence the name of the routine. The exception
	 * structure is saved (on the C stack) before entering in the recursion.
	 * While the calling stack cannot be inconsistant (otherwise it's a panic),
	 * the exception stack may well be, in case we ran out of memory.
	 */

	struct ex_vect *trace;		/* Call on top of the stack */

	for (
		find_call(), trace = eif_trace.st_bot;
		trace != eif_trace.st_top;
		trace = eif_trace.st_bot
	) {
		except.code = trace->ex_type;	/* Record exception code */
		except.tag = (char *) 0;		/* No tag by default */
		switch (trace->ex_type) {
		case EN_ILVL:					/* Entering new level */
			/* The stack may end with such a beast, so detect this and return
			 * if we reached the last item in the stack.
			 */
			(void) exnext();			/* Skip pseudo-vector "New level" */
			if (exend())
				return;					/* Exit if at the end of the stack */
			fprintf(stderr, branch_enter, trace->ex_lvl);
			fprintf(stderr, "\n%s\n", failed);
			recursive_dump(level + 1);	/* Dump the new level */
			fprintf(stderr, branch_exit, level);
			fprintf(stderr, "\n%s\n", failed);
			find_call();				/* Restore global exception structure */
			break;
		case EN_OLVL:					/* Exiting a level */
			(void) exnext();			/* Skip pseudo-vector "Exit level" */
			return;						/* Recursion level decreases */
			/* NOTREACHED */
		case EN_RES:					/* Resumption attempt */
		case EN_FAIL:					/* Routine call */
		case EN_RESC:					/* Exception in rescue */
			print_top();				/* Print exception trace */
			find_call();				/* Look for new enclosing call */
			break;
		case EN_SIG:					/* Signal received */
			except.tag = signame(trace->ex_sig);
			print_top();
			break;
		case EN_SYS:					/* Operating system error */
		case EN_IO:						/* I/O error */
			except.tag = error_tag(trace->ex_errno);
			print_top();
			break;
		case EN_CINV:					/* Class invariant violated */
			except.obj_id = trace->ex_oid;	/* Do we need this? */
			/* Fall through */
		case EN_PRE:					/* Precondition violated */
			except.tag = trace->ex_name;
			print_top();
			find_call();				/* Restore correct object ID */
			break;
		case EN_BYE:
		case EN_FATAL:
			except.tag = echtg;			/* Tag for panic or fatal error */
			print_top();
			break;
		default:
			except.tag = trace->ex_name;
			print_top();
		}
	}
}

private void print_top()
{
	/* Prints the exception trace described by the top frame of the exception
	 * stack and the exception context built.
	 * The exception tag is limited to 26 characters, the class name to 19 and
	 * the routine name to 22 characters. These should be #defined--RAM, FIXME.
	 */

	char buf[25];				/* To pre-compute the (From orig) string */
	char code = except.code;	/* Exception's code */
	struct ex_vect *top;		/* Top of stack */

#ifdef DEBUG
	dump_vector("print_top: top of trace is", eif_trace.st_bot);
	dprintf(1)("print_top: code = %d (previous %d) %s%s%s\n",
		code, except.previous, except.retried ? "was retried" : "",
		(except.retried && except.rescued) ? " and " : "",
		except.rescued ? "was rescued" : "");
#endif

	/* Do not print anything if the retry flag is on and the previous exception
	 * was not not a routine failure nor a resumption attempt failed. Indeed,
	 * the exception that led to a retry has already been printed and we do
	 * not want to see two successive 'retry' lines.
	 * Similarily, a rescued routine fails, and is not 'rescued' at the end
	 * of the rescue clause.
	 */
	if (
		except.retried &&			/* Call has been retried */
		except.previous != 0 &&		/* Something has been already printed */
		except.previous != EN_FAIL && except.previous != EN_RES
	) {
		(void) exnext();		/* Remove the top */
		return;					/* We already printed the retry line */
	}

	except.previous = code;		/* Update previous exception code */

	if (except.tag)
		sprintf(buf, "%.28s:", except.tag);
	else
		buf[0] = '\0';

	if (except.from >= 0)
		fprintf(stderr, "%-19.19s %-22.22s %-29.29s\n",
			Class(except.obj_id), except.rname, buf);
	else
		fprintf(stderr, "%-19.19s %-22.22s %-29.29s\n",
			"RUN-TIME", except.rname, buf);

	/* There is no need to compute the origin of a routine if it is the same
	 * as the current class. To detect this, we do pointer comparaison to
	 * statically allocated strings (faster than a strcmp).
	 * As a matter of style, the macros 'Class', 'System' etc... are not
	 * all uppercased because there is no side effect, and they could be
	 * functions--RAM.
	 */

	if (except.from >= 0 && except.from != Dtype(except.obj_id))
		sprintf(buf, "(From %.15s)", Origin(except.from));
	else
		buf[0] = '\0';

	fprintf(stderr, "<%08X>          %-22.22s %-29.29s ",
		except.obj_id, buf, exception_string(code));
		
	/* Start panic effect when we reach the EN_BYE record */
	if (code == EN_BYE)
		echval = EN_BYE;

	/* Start fatal effect when we reach the EN_FATAL record */
	if (code == EN_FATAL)
		echval = EN_FATAL;

	(void) exnext();			/* Can safely be removed */

	/* Here is an informal discussion about the "Effect" keywords which may
	 * appear in the stack trace: "Retry" is the last exception that occurred
	 * before 'retry' was reached. Similarily, "Rescue" signals the last
	 * exception after entering in a rescue clause. "Pass" signals exceptions
	 * which are not directly followed by a call in the trace. In effect, they
	 * raise an exception somewhere but do not 'fail'. "Fail" appears everywhere
	 * else, unless it is the last exception, in which case we "Exit"--RAM.
	 */

	if (echval == EN_BYE) {		/* A run-time panic was raised */
		if (except.last)
			fprintf(stderr, "Bye\n%s\n", failed);	/* Good bye! */
		else
			fprintf(stderr, "Panic\n%s\n", failed);	/* Panic propagation */
		return;
	} else if (echval == EN_FATAL) {
		if (except.last)
			fprintf(stderr, "Bye\n%s\n", failed);	/* Good bye! */
		else
			fprintf(stderr, "Fatal\n%s\n", failed);	/* Fatal propagation */
		return;
	} else if (except.last) {						/* Last record => exit */
		fprintf(stderr, "Exit\n%s\n", failed);
		return;
	} else if (code == EN_FAIL || code == EN_RES) {
		if (except.retried)
			fprintf(stderr, "Retry\n%s\n", retried);
		else if (except.rescued)
			fprintf(stderr, "Rescue\n%s\n", failed);
		else
			fprintf(stderr, "Fail\n%s\n", failed);
		return;
	}

	/* We need some lookhead to exactely print retry or rescue once. We want
	 * to print a "retry" or "rescue" if and only if the next record in the
	 * stack (pointed at by 'top') is a retry or routine record.
	 */

	top = eif_trace.st_bot;		/* Look ahead */
	code = top->ex_type;

#ifdef DEBUG
	dump_vector("\nprint_top: followed by", top);
#endif

	if (code == EN_FAIL || code == EN_RES) {
		if (except.retried)
			fprintf(stderr, "Retry\n%s\n", retried);
		else
			fprintf(stderr, "Fail\n%s\n", failed);
	} else
		fprintf(stderr, "Pass\n%s\n", failed);
}

/* Stack handling routine. The following code has been cut/paste from the one
 * found in garcol.c and local.c as of this day. Hence the similarities and the
 * possible differences. What changes basically is that instead of storing
 * (char *) elements, we now store (struct ex_vect) ones.
 */

shared struct ex_vect *exget(stk)
register2 struct xstack *stk;
{
	/* Get a new execution vector at the top of the stack. If the chunk is
	 * full, we try to allocate a new chunk. If this fails, nothing is done,
	 * and a null pointer is returned to signal failure. Otherwise, the address
	 * of the new execution vector is returned.
	 */

	register1 struct ex_vect *top = stk->st_top;	/* Top of stack */

	if (top == (struct ex_vect *) 0)	{		/* No stack yet? */
		top = stack_allocate(stk, STACK_CHUNK);	/* Create one */
		if (top == (struct ex_vect *) 0) 		/* Could not create stack */
			return top;
	}

	if (stk->st_end == top) {
		/* The end of the current stack chunk has been reached. If there is
		 * a chunk allocated after the current one, use it, otherwise create
		 * a new one and insert it in the list.
		 */
		if (stk->st_cur == stk->st_tl) {	/* Reached last chunk */
			if (-1 == stack_extend(stk, STACK_CHUNK))
				return (struct ex_vect *) 0;
			top = stk->st_top;				/* New top */
		} else {
			register2 struct stxchunk *current;		/* New current chunk */

			/* Update the new stack context (main structure) */
			current = stk->st_cur = stk->st_cur->sk_next;
			top = stk->st_top = current->sk_arena;
			stk->st_end = current->sk_end;
		}
	}

	stk->st_top = ++top;	/* Points to next free location */

	return top - 1;			/* Address of new available execution vector */
}

private struct ex_vect *stack_allocate(stk, size)
register2 struct xstack *stk;		/* The stack */
register1 int size;					/* Initial size */
{
	/* The stack 'stk' is created, with size 'size'. Return the arena value */

	register3 struct ex_vect *arena;	/* Address for the arena */
	register4 struct stxchunk *chunk;	/* Address of the chunk */

	size *= sizeof(struct ex_vect);
	size += sizeof(*chunk);				/* Ensure arena is a correct multiple */
	chunk = (struct stxchunk *) cmalloc(size);
	if (chunk == (struct stxchunk *) 0)
		return (struct ex_vect *) 0;	/* Malloc failed for some reason */

	stk->st_hd = chunk;						/* New stack (head of list) */
	stk->st_tl = chunk;						/* One chunk for now */
	stk->st_cur = chunk;					/* Current chunk */
	arena = (struct ex_vect *) (chunk + 1);	/* Header of chunk */
	stk->st_top = arena;					/* Empty stack */
	chunk->sk_arena = arena;				/* Base address */
	stk->st_end = chunk->sk_end = (struct ex_vect *)
		((char *) chunk + size);		/* First free location beyond stack */
	chunk->sk_next = (struct stxchunk *) 0;
	chunk->sk_prev = (struct stxchunk *) 0;

	return arena;			/* Stack allocated */
}

private int stack_extend(stk, size)
register2 struct xstack *stk;		/* The stack */
register1 int size;					/* Size of new chunk to be added */
{
	/* The stack 'stk' is extended and the 'stk' structure updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */

	register3 struct ex_vect *arena;	/* Address for the arena */
	register4 struct stxchunk *chunk;	/* Address of the chunk */

	size *= sizeof(struct ex_vect);
	size += sizeof(*chunk);				/* Or arena might not be padded */
	chunk = (struct stxchunk *) cmalloc(size);
	if (chunk == (struct stxchunk *) 0) {
		chunk = (struct stxchunk *) uchunk();	/* Attempt with urgent mem */
		size = HEADER(chunk)->ov_size & B_SIZE;	/* Size of urgent chunks */
	}
	if (chunk == (struct stxchunk *) 0)
		return -1;		/* Malloc failed for some reason */

	arena = (struct ex_vect *) (chunk + 1);	/* Header of chunk */
	chunk->sk_next = (struct stxchunk *) 0;	/* Last chunk in list */
	chunk->sk_prev = stk->st_tl;			/* Preceded by the old tail */
	stk->st_tl->sk_next = chunk;			/* Maintain link w/previous */
	stk->st_tl = chunk;						/* New tail */
	chunk->sk_arena = arena;				/* Where items are stored */
	chunk->sk_end = (struct ex_vect *)
		((char *) chunk + size);			/* First item beyond chunk */
	stk->st_top = arena;					/* New top */
	stk->st_end = chunk->sk_end;			/* End of current chunk */
	stk->st_cur = chunk;					/* New current chunk */

	return 0;			/* Everything is ok */
}

private void stack_truncate(stk)
register1 struct xstack *stk;		/* The stack to be truncated */
{
	/* Free unused chunks in the stack. If the current chunk has at least
	 * MIN_FREE locations, then we may free all the chunks starting with the
	 * next one. Otherwise, we skip the next chunk and free the remainder.
	 */

	register2 struct ex_vect *top;	/* The current top of the stack */
	struct stxchunk *next;			/* Address of next chunk */

	top = stk->st_top;						/* The first free location */
	if (stk->st_end - top > MIN_FREE) {		/* Enough locations left */
		stk->st_tl = stk->st_cur;			/* Last chunk from now on */
		wipe_out(stk->st_cur->sk_next);		/* Free starting at next chunk */
	} else {								/* Current chunk is nearly full */
		next = stk->st_cur->sk_next;		/* We are followed by 'next' */
		if (next != (struct stxchunk *) 0) {/* There is indeed a next chunk */
			stk->st_tl = next;				/* New tail chunk */
			wipe_out(next->sk_next);		/* Skip it, wipe out remainder */
		}
	}
}

private void wipe_out(chunk)
register struct stxchunk *chunk;	/* First chunk to be freed */
{
	/* Free all the chunks after 'chunk' */

	register2 struct stxchunk *next;	/* Address of next chunk */

	if (chunk == (struct stxchunk *) 0)	/* No chunk */
		return;							/* Nothing to be done */

	chunk->sk_prev->sk_next = (struct stxchunk *) 0;	/* Previous is last */

	for (
		next = chunk->sk_next;
		chunk != (struct stxchunk *) 0;
		chunk = next, next = chunk ? chunk->sk_next : chunk
	)
		xfree((char *) chunk);
}

public void expop(stk)
register1 struct xstack *stk;		/* The stack */
{
	/* Removes one item from the Eiffel stack */
	
	register2 struct ex_vect *top = stk->st_top;	/* Top of the stack */
	register3 struct stxchunk *s;			/* To walk through stack chunks */
	register4 struct ex_vect *arena;		/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. This avoids pointer manipulation (walking along the stack)
	 * which may induce swapping, who knows?
	 */

	arena = stk->st_cur->sk_arena;
	if (--top >= arena) {			/* Hopefully, we remain in current chunk */
		stk->st_top = top;			/* Yes! Update top */
		return;						/* Done, we're lucky */
	}

	/* Unusual case: top pointed to the arena of next chunk */
	
	s= stk->st_cur = stk->st_cur->sk_prev;		/* Go one chunk back */

#ifdef MAY_PANIC
	if (s == (struct stxchunk *) 0)				/* Panic if none */
		panic("Eiffel stack underflow");
#endif

	top = stk->st_end = s->sk_end;				/* Set new end */
	stk->st_top = --top;						/* New top */

	/* There is not much overhead calling stack_truncate(), because this is
	 * only done when we are popping at a chunk edge. We have to make sure the
	 * program is running though, as popping done in debugging mode is only
	 * temporary--RAM.
	 */

#ifdef WORKBENCH
	if (d_cxt.pg_status == PG_RUN)	/* Program is running */
		stack_truncate(stk);		/* Remove unused chunks */
#else
	stack_truncate(stk);			/* Try removal of unused chunks */
#endif
}

shared struct ex_vect *extop(stk)
register1 struct xstack *stk;		/* The stack */
{
	/* Returns the value at the top of the Eiffel stack or a NULL pointer if
	 * stack is empty. I assume a value has already been pushed (i.e. the
	 * stack has been created).
	 */
	
	struct ex_vect *last_item;		/* Address of last item stored */
	struct stxchunk *prev;			/* Previous chunk in stack */

	last_item = stk->st_top - 1;
	if (last_item >= stk->st_cur->sk_arena)
		return last_item;
	
	/* It seems the current top of the stack (i.e. the next free location)
	 * is at the left edge of a chunk. Look for previous chunk then...
	 */
	prev = stk->st_cur->sk_prev;
	if (prev == (struct stxchunk *) 0)
		return (struct ex_vect *) 0;	/* Stack is empty */
	
	last_item = prev->sk_end - 1;		/* Last item of previous chunk */

	return last_item;
}

shared struct ex_vect *exnext()
{
	/* This function is only used when dumping the execution stack (i.e. after
	 * a system failure has occurred). As that stack has been built upside-down,
	 * the first items to be printed are those at the bottom of the stack.
	 * This function finds the next item to be printed (starting at the bottom),
	 * updating the xstack structure of eif_trace. It returns a null pointer
	 * in case of stack overflow.
	 * NB: The stack structure is physically destroyed, mangled from the bottom.
	 */
	
	register1 struct ex_vect *first_item;	/* First item pushed */

	/* If we already reached the end of the stack, return immediately */
	if (eif_trace.st_bot == eif_trace.st_top)
		return (struct ex_vect *) 0;		/* Reached the end of the stack */

	first_item = eif_trace.st_bot++;		/* Make a guess */
	if (first_item > eif_trace.st_end) {	/* Bad guess */
		eif_trace.st_cur =
			eif_trace.st_cur->sk_next;
		if (eif_trace.st_cur == (struct stxchunk *) 0)
			return (struct ex_vect *) 0;
		eif_trace.st_end = eif_trace.st_cur->sk_end;
		eif_trace.st_bot = eif_trace.st_cur->sk_arena;
		first_item = eif_trace.st_bot;
	}
	
	if (first_item == eif_trace.st_top)
		return (struct ex_vect *) 0;		/* Reached the end of the stack */
	
	return first_item;
}

private int exend()
{
	/* Returns true if the end of the Eiffel trace stack has been reached */

	register1 struct ex_vect *item;		/* Next item pushed */
	register2 struct stxchunk *next;	/* Next chunk */

	/* If we already reached the end of the stack, return immediately */
	if (eif_trace.st_bot == eif_trace.st_top)
		return 1;		/* Reached the end of the stack */

	item = eif_trace.st_bot + 1;		/* Make a guess */
	if (item > eif_trace.st_end) {		/* Bad guess */
		next = eif_trace.st_cur->sk_next;
		if (next == (struct stxchunk *) 0)
			return 1;
		item = next->sk_arena;
	}
	
	if (item == eif_trace.st_top)
		return 1;

	return 0;
}

/*
 * Translation functions. Giver a code or a signal number, return a pointer
 * to a static string giving a "human readable" description of the event.
 */

private char *exception_string(code)
int code;
{
	/* Returns a pointer to a static string describing the exception whose
	 * code is 'code'. All internal codes are positives one. Negative codes
	 * are for the user-defined exceptions.
	 */
	
	if (code < 0)							/* Raised by Eiffel call to raise */
		return "User-defined exception.";	/* Don't want to give code--RAM */
	else if (code < 1 || code > EN_NEX)		/* Ensure index is valid */
		return "Unknown exception.";		/* Should never happen */

	return ex_tag[code];		/* Name of exception whose code is 'code' */
}

#ifdef DEBUG
private void dump_vector(msg, vector)
char *msg;				/* Message to print before dumping */
struct ex_vect *vector;	/* The vector to be dumped */
{
	/* This routine is meant to be used for debugging purposes only */

	if (!(DEBUG & 1))
		return;
	
	printf("%s (at 0x%x):\n", msg, vector);
	if (vector == (struct ex_vect *) 0)
		return;
	printf("\tex_type = %d\n", vector->ex_type);
	printf("\tex_retry = %d\n", vector->ex_retry);
	printf("\tex_rescue = %d\n", vector->ex_rescue);
	printf("\texu_lvl = %d\n", vector->ex_lvl);
	printf("\texu_sig = %d\n", vector->ex_sig);
	printf("\texu_errno = %d\n", vector->ex_errno);
	switch (vector->ex_type) {
	case EX_CINV: case EN_CINV:
		printf("\texua_name = \"%s\"\n", vector->ex_name);
		printf("\texua_oid = %d\n", vector->ex_oid);
		break;
	case EX_PRE: case EN_PRE:
	case EX_POST: case EN_POST:
	case EX_LINV: case EN_LINV:
	case EX_VAR: case EN_VAR:
	case EX_CHECK: case EN_CHECK:
		printf("\texua_name = \"%s\"\n", vector->ex_name);
		printf("\texua_where = \"%s\"\n", vector->ex_where);
		printf("\texua_from = %d\n", vector->ex_from);
		printf("\texua_oid = %d\n", vector->ex_oid);
		break;
	case EX_CALL: case EN_FAIL:
	case EX_RESC: case EN_RESC:
	case EX_RETY: case EN_RES:
		printf("\texur_jbuf = 0x%x\n", vector->ex_jbuf);
		printf("\texur_id = 0x%x\n", vector->ex_id);
		printf("\texur_rout = \"%s\"\n", vector->ex_rout);
		printf("\texur_orig = %d\n", vector->ex_orig);
		break;
	}
}
#endif

/*
 * Eiffel interface
 */

public long eecode()
{
	/* Return the code of the first exception at this nesting level */

	return (long) echorg;	/* Original exception code */
}

public char *eetag()
{
	/* Return the tag of the first exception at this nesting level */

	if (echorg == 0)		/* No original exception */
		return (char *) 0;

	if (echotag != (char *) 0)
		return makestr(echotag, strlen(echotag)); /* Last exception tag */

	return (char *) 0;
}

public long ecode()
{
	return (long) echval;	/* Last exception code */
}

public char *etag()
{
	if (echval == 0)		/* No current exception */
		return (char *) 0;

	if (echtg != (char *) 0)
		return makestr(echtg, strlen(echtg)); /* Last exception tag */

	return (char *) 0;
}

#ifdef TEST

/* This section implements a set of tests for the exception mechanism.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

#undef TEST
#undef DEBUG
#undef Size
#undef References
#undef Dispose

#define Size(x)			40
#define References(x)	2
#define Dispose(x)		((void (*)()) 0)
#define stack_allocate	gc_stack_allocate
#define stack_extend	gc_stack_extend

#define DEBUG 0			/* So that we get debugging routines/tests */
#define lint			/* Avoid definition of rcsid */
#include "malloc.c"
#include "garcol.c"
#include "local.c"
#include "sig.c"
#include "timer.c"
#include "urgent.c"

private struct stack hec_stack;
private char *(**ecreate)();

#include "macros.h"

private int cc_for_speed = 1;	/* Optimized for speed */

/* Classes held in the pseudo-test system (these have to be statically allocated
 * strings as the dumping of the exception stack does address comparaison).
 */
char c0[] = "LONG_CLASS_NAME";
char c1[] = "FIRST";
char c2[] = "SECOND";
char c3[] = "THIRD";
char c4[] = "FOURTH";
char c5[] = "FIFTH";

/* Array used to fake a real system (with class names, routine names and
 * origins for each routine.
 */
private struct test test_system[] = {
	{ c0, "root", c0 },					/* 0 */
	{ c1, "first_routine", c1 },		/* 1 */
	{ c2, "second_routine", c1 },		/* 2 */
	{ c3, "third_routine", c2 },		/* 3 */
	{ c4, "fourth_routine", c3 },		/* 4 */
	{ c5, "fifth_routine", c4 },		/* 5 */
	{ c5, "called_by_invariant", c5 },	/* 6 */
	{ c4, "called_by_rescue", c4 },		/* 7 */
	{ c3, "called_by_check", c3 },		/* 8 */
	{ c2, "called_by_loop_var", c2 },	/* 9 */
};

/* Routines used to simulate the Eiffel system */
private void t_root();
private void t_first_routine();
private void t_second_routine();
private void t_third_routine();
private void t_fourth_routine();
/*
private void t_fifth_routine();
*/
private void t_called_by_check();
private Signal_t emergency();

public main()
{
	/* Tests for the exception mechanism */

	printf("> Starting tests for exception handling mechanism.\n");

	printf(">> Initializing signals.\n");
	initsig();
	printf(">> Installing t_fourth_routine as signal handler for #3.\n");
	esig[3] = t_fourth_routine;
	printf(">> Calling root routine.\n");
	t_root();
	exit(0);
}

private void t_root()
{
	RTEX; RTED;

	RTEA(0, 0, 0);
	RTEJ;
	printf(">>> In t_root (with rescue), calling t_first_routine.\n");
	t_first_routine();
	printf(">>> THIS SHOULD NEVER APPEAR.\n");
	exok();

rescue:
	printf(">>> In rescue of t_root.\n");
	trapsig(emergency);
	printf(">> Resumption is failing, dumping stack\n");
	esfail();
	printf("> End of tests.\n");
}

private void t_first_routine()
{
	RTEX;

	RTEA("first_routine", 1, 1);
	printf(">>> In t_first_routine (no rescue).\n");
	printf(">>> In t_first_routine, enter in precondition .\n");
	RTCT("Assertion_will_fail", EX_PRE);
	printf(">>> Precondition calls t_second_routine and fails.\n");
	t_second_routine();
	if (0)
		RTCK;
	else
		RTCF;
	printf(">>> Body of t_first_routine.\n");
	RTEE;
}

private void t_second_routine()
{
	RTEX; RTED;
	int time = 1;

	RTEA("second_routine", 2, 2);
	RTEJ;
	printf(">>> In t_second_routine (with rescue), %s time.\n",
		(time == 1) ? "first" : "second");
	RTCT("Number 1", EX_PRE);
	if (1)
		RTCK;
	else
		RTCF;
	printf(">>> Calling check routine.\n");
	RTCT("Check_will_fail", EX_CHECK);
	if (time == 1)
		printf(">>> Check fails (first time).\n");
	else
		printf(">>> Check fails (second time).\n");
	RTCF;
	printf(">>> THIS SHOULD NEVER APPEAR (2)\n");
	RTEE;

rescue:
	printf(">>> In rescue of t_second_routine.\n");
	RTEU;
	if (time == 1) {
		printf(">>> Retrying.\n");
		time++;
		RTER;
	}
	printf(">>> Calling t_third_routine.\n");
	t_third_routine();
	printf(">>> Rescue in t_second_routine ends without retry.\n");
	RTEF;
}

private void t_third_routine()
{
	RTEX;

	RTEA("third_routine", 3, 3);

	printf(">>> Body of t_third_routine.\n");
	printf(">>> In t_third_routine, enter in postcondition.\n");
	RTCT("Signal sent in postcond", EX_POST);
	printf(">>> Sending signal #3.\n");
	kill(getpid(), 3);
	RTCK;
	RTEE;
}

private void t_fourth_routine()
{
	RTEX;

	RTEA("fourth_routine", 4, 4);

	printf(">>> Body of t_fourth_routine.\n");
	printf(">>> In t_fourth_routine, enter in postcondition.\n");
	RTCT("Postcondition_will_fail", EX_POST);
	eraise("Ensure_it_fails", EN_LINV);
	RTCF;
	RTEE;
}

private Signal_t emergency(sig)
int sig;
{
	printf("Caught signal #%d (%s) -- Giving up...\n", sig, signame(sig));
	exit(2);
}

#endif
