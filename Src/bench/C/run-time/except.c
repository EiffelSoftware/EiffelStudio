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

#include "eif_portable.h"

#include <signal.h>
#include <stdio.h>
#include <string.h>
#include "eif_except.h"
#include "eif_local.h"
#include "eif_urgent.h"
#include "eif_sig.h"				/* For signal description */
#include "eif_macros.h"
#include "eif_debug.h"
#include "eif_err_msg.h"
#include "rt_main.h"
#include "rt_garcol.h"
#include "rt_threads.h"
#include "eif_error.h"
#include "eif_lmalloc.h"		/* for eif_free, eif_realloc */
#include "rt_assert.h"

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
#endif /* NOHOOK */
#endif /* WORKBENCH */

#include <stdlib.h>				/* For exit(), abort() */

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

#ifndef EIF_THREADS
/* Stack of current execution. On entrance, each routine pushes the address
 * of its own execution vector structure (held in the process's stack).
 * The exception trace records all the unresolved exceptions. For the case where
 * multiple exceptions occurred and we entered different rescue clauses, we
 * have to store the exception levels along with the unsolved exceptions.
 */
rt_public struct xstack eif_stack = {		/* Calling stack */
	(struct stxchunk *) 0,				/* st_hd */
	(struct stxchunk *) 0,				/* st_tl */
	(struct stxchunk *) 0,				/* st_cur */
	(struct ex_vect *) 0,				/* st_top */
	(struct ex_vect *) 0,				/* st_end */
	(struct ex_vect *) 0,				/* st_bot */
};
rt_public struct xstack eif_trace = {		/* Exception trace */
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
rt_public unsigned char ex_ign[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt */

/* Stack of current exception flags. This is used to control the assertion
 * checking (e.g. disable it when already in assertion checking).
 */
rt_public struct eif_exception exdata = {
	0,				/* ex_val */
	0,				/* ex_nomem */
	0,				/* ex_nsig */
	0,				/* ex_level */
	0,				/* ex_orig */
	(char *) 0,		/* ex_tag */
	(char *) 0,		/* ex_otag */
	(char *) 0,		/* ex_rt */
	(char *) 0,		/* ex_ort */
	0,				/* ex_class */
	0,				/* ex_oclass */
};

#ifdef WORKBENCH
/* Array of ignored exceptions, from the debugger's point of view. Normally
 * an exception stops the program to allow user inspection of the objects.
 */
rt_public unsigned char db_ign[EN_NEX];	/* Item set to 1 to ignore exception */
#endif

/* Structure used to store routine information during exception stack dumps
 * (gathered thanks to stack look-ahead).
 */
rt_private struct exprint eif_except;		/* Where exception has been raised */
#define EIF_EXCEPT_LOCK	
#define EIF_EXCEPT_UNLOCK 
#else	/* EIF_THREADS */
rt_private	EIF_MUTEX_TYPE *eif_except_lock = (EIF_MUTEX_TYPE *) 0;
#define EIF_EXCEPT_LOCK	\
	if (!eif_except_lock) \
		EIF_MUTEX_CREATE (eif_except_lock, "Couldn't create exception lock");\
	EIF_MUTEX_LOCK (eif_except_lock, "Couldn't lock exception lock");
#define EIF_EXCEPT_UNLOCK EIF_MUTEX_UNLOCK (eif_except_lock, "Couldn't unlock exception lock");


#endif /* EIF_THREADS */

/* Exception handling mechanism */
rt_public void enomem(void);			/* A critical "No more memory" exception */
rt_public struct ex_vect *exret(register1 struct ex_vect *rout_vect);	/* Retries execution of routine */
rt_public void exinv(register2 char *tag, register3 char *object);			/* Invariant record */
rt_public void exasrt(char *tag, int type);		/* Assertion record */
rt_public void eraise(char *tag, long num);		/* Raises an Eiffel exception */
rt_public void com_eraise(char *tag, long num);	/* Raises an EiffelCOM exception */
rt_public void eviol(void);			/* Signals assertion violation */
rt_public void exfail(void);			/* Signals: reached end of a rescue clause */
rt_public void eif_panic(char *msg);			/* Run-time raised panic */
rt_public void fatal_error(char *msg);			/* Run-time raised fatal errors */
rt_shared void xraise(int code);			/* Raises an exception with no tag */
rt_public struct ex_vect *exset(char *name, int origin, char *object);	/* Set execution stack on routine entrance */
rt_public struct ex_vect *new_exset(char *name, int origin, char *object, unsigned char loc_nb, unsigned char arg_nb, int bid);	/* Set execution stack on routine entrance */
#ifndef WORKBENCH
rt_public struct ex_vect *exft(void);	/* Entry in feature with rescue clause */
#endif

/* Exception recovery mechanism */
rt_public void exok(void);				/* Resumption has been successful */
rt_public void exclear(void);			/* Clears the exception stack */
rt_private jmp_buf *backtrack(void);		/* Backtrack in the calling stack */
rt_private void excur(void);			/* Current exception code in previous level */
rt_private void exorig(void);			/* Original exception code in previous level */
rt_private char *extag(struct ex_vect *trace);			/* Recompute exception tag */

#ifndef NOHOOK
rt_private void exception(int how);		/* Debugger hook */
#endif

#ifndef EIF_THREADS
rt_private int print_history_table = ~0;   /* Enable/disable printing of hist. table */ /* %%zmt added 'int' type */
#endif /* EIF_THREADS */

/* Eiffel interface */
rt_private char eedefined(long ex);		  /* Is exception code valid? */

/* Stack handling routines */
rt_public void expop(register1 struct xstack *stk);				/* Pops an execution vector off */
rt_private void stack_truncate(register1 struct xstack *stk);		/* Truncate stack if necessary */
rt_private void wipe_out(register struct stxchunk *chunk);			/* Remove unneeded chunk from stack */
rt_shared struct ex_vect *exget(register2 struct xstack *stk);		/* Get a new vector on stack */
rt_private int stack_extend(register2 struct xstack *stk, register1 int size);			/* Extends size of stack */
rt_private struct ex_vect *stack_allocate(register2 struct xstack *stk, register1 int size);	/* Creates an empty stack */
rt_shared struct ex_vect *extop(register1 struct xstack *stk);		/* Top of Eiffel stack */
rt_shared struct ex_vect *exnext(void);	/* Next item at bottom of trace stack */
rt_private int exend(void);				/* True if end of trace stack reached */

/* User-level dumps */
rt_public void esfail(void);				/* Eiffel system failure */
rt_private void dump_core(void);			/* Dumps a core for debugging infos */
rt_private char *exception_string(int code);	/* Name of an exception */
rt_private void dump_trace_stack(void);	/* Dumps the Eiffel trace stack to stderr */
rt_private void find_call(void);			/* Find enclosing call ID */
rt_private void recursive_dump(void (*append_trace)(char *), register1 int level);		/* Dump the stack at a given level */
rt_private void print_top(void (*append_trace)(char *));			/* Prints top value of the stack */
rt_private void dump_stack(void (*append_trace)(char *));			/* Dump the Eiffel trace stack */
rt_private void ds_stderr(char *line);			/* Wrapper to dump stack to stderr */
rt_private void ds_string(char *line);			/* Wrapper to dump stack to a string */
rt_public EIF_REFERENCE stack_trace_string(void);	/* Exception trace string */
rt_private void extend_trace_string(char *line);	/* Extend exception trace string */

#ifndef EIF_THREADS

rt_public SMART_STRING ex_string = {	/* Container of the exception trace */ /* %%zmt */
	NULL,	/* No area */
	0L,		/* No byte used yet */
	0L		/* Null length */
};

#endif /* EIF_THREADS */

/* Pre-defined exception tags (29 chars max please, otherwise truncated).
 * A final point is added at the end. Here is a 29 chars string template:
 *	"It is a 29 characters string."
 */
rt_private char *ex_tag[] = {
	(char *) 0,							/* Nothing */
	"Feature call on void target.",		/* EN_VOID */
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
	"CECIL cannot call melted code",	/* EN_DOL */
	"Runtime I/O error.",				/* EN_ISE_IO */
	"COM error."						/* EN_COM */
};

/* Converts a vector's type in the stack to an exception code, i.e. given a
 * vector in the stack, which exception has to be raised?
 */
rt_private unsigned char ex_tagc[] = {
	(unsigned char) EN_FAIL,		/* EX_CALL */
	(unsigned char) EN_PRE,			/* EX_PRE */
	(unsigned char) EN_POST,		/* EX_POST */
	(unsigned char) EN_CINV,		/* EX_CINV */
	(unsigned char) EN_RESC,		/* EX_RESC */
	(unsigned char) EN_RES,			/* EX_RETY */
	(unsigned char) EN_LINV,		/* EX_LINV */
	(unsigned char) EN_VAR,			/* EX_VAR */
	(unsigned char) EN_CHECK,		/* EX_CHECK */
	(unsigned char) EN_HDLR,		/* EX_HDLR */
	(unsigned char) EN_CINV,		/* EX_INVC */
	(unsigned char) EN_OSTK,		/* EX_OSTK */
};

/* Strings used as separator for Eiffel stack dumps */
rt_private char *retried =
"===============================================================================";
#ifdef EIF_THREADS
rt_private char *thr_enter =
"******************************** Thread exception *****************************";
rt_private char *thr_failed =
"*******************************************************************************";
#endif	/* EIF_THREADS */
rt_private char *failed =
"-------------------------------------------------------------------------------";
rt_private char *branch_enter =
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ entering level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
rt_private char *branch_exit =
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ back to level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";

/* Commonly used error messages */
#ifdef MAY_PANIC
rt_private char *botched = "Eiffel stack botched";
#endif
rt_private char *vanished = "main entry point vanished";

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

/* These are default values for tests */
#define Class(x)		test_system[(int) x].class
#define Origin(x)		test_system[(int) x].class
#undef Dtype
#define Dtype(x)		0
#else /* TEST */
#define Class(x)		System(Dtype(x)).cn_generator
#define Origin(x)		System(x).cn_generator
#endif

#ifdef DEBUG
rt_private void dump_vector(char *msg, struct ex_vect *vector);			/* Dump an execution vector on stdout */
#endif

#ifndef lint
rt_private char *rcsid = "$Id$";
#endif

/* Throughout the routines which maintain the execution stack, we must be *very*
 * careful about signals, which may occur between any two machine instruction
 * codes. Sections which manipulate the stack cannot be interrupted by signals,
 * and are enclosed between a pair of macros SIGBLOCK and SIGRESUME, which
 * respectively block the signals (from the run-time point's of view) and then
 * resume normal handling, eventually sending those signals which were caught
 * during the critical section.
 */

rt_public void enomem(void)
{
	/* Raises the "Out of memory" exception. Due to the special nature of this
	 * exception, we may not have been able to push everything we wanted on the
	 * Eiffel stack. So set a special flag to indicate that in case the stack
	 * is dumped. Note however that the calling stack is always consistent in
	 * the sense that the run-time can safely unwind the stack to get back to
	 * a previous call.
	 */
	EIF_GET_CONTEXT

	echmem |= MEM_FULL;		/* We dramatically ran out of memory */
	xraise(EN_OMEM);		/* The "Out of memory" stuff */
}

/* wrapper to the new function (for EIFFEL COM....) */
rt_public struct ex_vect *exset(char *name, int origin, char *object)
{
	return new_exset(name, origin, object, 0, 0, 0);
}

rt_public struct ex_vect *new_exset(char *name, int origin, char *object, unsigned char loc_nb, unsigned char arg_nb, int bid)
			/* The routine name */
			/* The origin of the routine */
			/* The object on which the routine is applied */
			/* The number of local variables (Result excluded) of the routine */
			/* The number of arguments of the routine */
			/* The body id of the routine */
{
	/* Sets the execution vector with the routine's parameters, so that we
	 * can produce an execution stack in case of routine failure. This brand new
	 * vector is then pushed on the Eiffel stack.
	 * This routine is normally called at the very top of each Eiffel routine;
	 * it returns the address of the exception vector or raises an exception.
	 */
	EIF_GET_CONTEXT
	register1 struct ex_vect *vector;	/* The exception vector */

	SIGBLOCK;				/* Critical section, protected against signals */

	/* Attempt to get a new vector for the current routine. If we can't, we
	 * have to raise an exception which will transfer control outside of the
	 * current routine anyway. The current call won't be mentionned in the stack
	 * trace. Logically, it is as if we had never entered in this routine.
	 */
	vector = exget(&eif_stack);	 /* Get brand new vector on the Eiffel stack */
	if (vector == (struct ex_vect *) 0)		/* No more memory */
		enomem();					/* Critical exception */

	vector->ex_type = EX_CALL;		/* Signals entry in a new routine */
	vector->ex_retry = 0;			/* Function not retried (yet!) */
	vector->ex_rescue = 0;			/* Function not rescued (yet!) */
	vector->ex_jbuf = NULL;		/* As far as we know, no rescue clause */
	vector->ex_rout = name;			/* Set the routine name */
	vector->ex_orig = origin;		/* And its origin (where it was written) */
	vector->ex_id = object;			/* The value of Current (Object ID) */
#ifdef WORKBENCH
	vector->ex_linenum = 0;			/* breakable line number */
	vector->ex_locnum = loc_nb;		/* number of local variables in the feature */
	vector->ex_argnum = arg_nb;		/* number of arguments the feature takes */
	vector->ex_bodyid = bid;		/* body id of the feature */
#endif
	SIGRESUME;			/* End of critical section, dispatch queued signals */
	return vector;		/* Execution vector of current Eiffel routine */
}

#ifndef WORKBENCH
rt_public struct ex_vect *exft(void)
{
	/* Get an execution vector, in final mode. We don't bother setting the
	 * feature name or the object ID as there is no stack dump in final mode.
	 */
	EIF_GET_CONTEXT
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

	memset (vector, 0, sizeof(struct ex_vect));	/* Make sure there is no garbage in the vector */

	/* Maybe there is no stack dump but there is some marking done or at least
	 * the marking is called even if no object is present on the stack
	 * In the long run, it will not be a problem but it's safer to initialize
	 * the entire structure anyway.Xavier
	 */

	vector->ex_type = EX_CALL;		/* Signals entry in a new routine */

	/* No need to set the other values as the bzero took care of everything */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	return vector;		/* Execution vector of current Eiffel routine */
}
#endif

rt_public struct ex_vect *exret(register1 struct ex_vect *rout_vect)
		/* Exec. vector of enclosing routine */
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
	EIF_GET_CONTEXT
	struct ex_vect *last_item;		/* Item at the top of the calling stack */

	last_item = extop(&eif_stack);		/* Make sure top is EX_RESC */

#ifdef MAY_PANIC
	if (last_item->ex_type != EX_RESC)
		eif_panic(botched);
#endif

	SIGBLOCK;				/* Critical section, protected against signals */

	/* Normally we should pop off this vector and get a new one, but it is so
	 * much simpler (and faster) to simply replace the top by the new vector.
	 * Copy the routine vector of the original routine, changing the type
	 * to EX_RETY to signal it has been retried. Note that the setjmp buffer
	 * address is kept.
	 */
	memcpy (last_item, rout_vect, sizeof(struct ex_vect));
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
		eif_panic(botched);
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
		eif_panic(botched);
	}
#else
	rout_vect->ex_retry = 1;		/* Function has been retried */
#endif

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	return last_item;	/* Execution vector for new routine invokation */
}

rt_public void exinv(register2 char *tag, register3 char *object)
		/* Assertion tag */
		/* The object on which invariant is checked */
{
	/* Checking of the invariant 'tag' on 'object' */
	EIF_GET_CONTEXT
	register1 struct ex_vect *vector;		/* The execution vector */

	SIGBLOCK;			/* Critical section, protected against signals */

	vector = exget(&eif_stack);				/* Get an execution vector */
	if (vector == (struct ex_vect *) 0) {	/* No more memory */
		echmem |= MEM_FULL;					/* Exception stack incomplete */
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* May be ignored */
	}

	in_assertion = ~0;

	vector->ex_type = EX_CINV;		/* Class invariant checking */
	vector->ex_name = tag;			/* The associated assertion tag */
	vector->ex_oid = object;		/* The value of Current (object ID) */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

rt_public void exasrt(char *tag, int type)
					/* Assertion's tag */
					/* Type of assertion */
{
	/* Whenever an assertion is checked, an execution vector must be pushed on
	 * the Eiffel calling stack (eif_stack). In case of exception, this will
	 * help providing the exception trace.
	 * This routine records an assertion 'type' whose tag is 'tag'.
	 */
	EIF_GET_CONTEXT
	register1 struct ex_vect *vector;		/* The execution vector */

	SIGBLOCK;			/* Critical section, protected against signals */

	vector = exget(&eif_stack);				/* Get an execution vector */
	if (vector == (struct ex_vect *) 0) {	/* No more memory */
		echmem |= MEM_FULL;					/* Exception stack incomplete */
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* Exception may be ignored */
	}

	in_assertion = ~0;

	/* The ex_where field for EX_PRE is set only during backtracking */

	vector->ex_type = (unsigned char) type;	/* Assertion's type */
	vector->ex_name = tag;					/* Assertion's tag */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

/* The following function was originally designed to catch exceptions from the
 * interpreter, but is now widely used to provide a run-time catching of the
 * exceptions and perform some cleanup (e.g. in a retrieve operation).
 */

rt_public void excatch(jmp_buf *jmp)
		/* The jump buffer used to catch exception */
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
	EIF_GET_CONTEXT
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

rt_public void exhdlr(Signal_t (*handler)(int), int sig)
			/* The signal handler to be called */
			/* Caught signal */
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

	EIF_GET_CONTEXT
	struct ex_vect * volatile trace;		/* Top of Eiffel trace stack */
	jmp_buf exenv;							/* Environment saving for setjmp */
#ifdef ISE_GC
	char volatile gc_status;							/* Saved GC status */
#endif
	RTXD;									/* Save stack contexts */

	/* There is no need to protect against signals here, as this routine can
	 * only be called via the signal handler, which takes care of blocking
	 * them for us...
	 */

	if (echmem & MEM_FSTK)			/* Eiffel stack is full */
		enomem();					/* Critical exception */

#ifdef ISE_GC
	/* Before getting an execution vector, we must disable the GC. Indeed, we
	 * must guarantee the garbage collector will NEVER be called within the
	 * interruption or some dangling references may appear due to objects
	 * moves--RAM.
	 */
	gc_status = g_data.status;		/* Save GC current status */
	g_data.status |= GC_STOP;		/* Stop garbage collection anyway */
	g_data.status |= GC_SIG;		/* Signals entering in signal handler */
#endif

	trace = exget(&eif_trace);		/* Get a new execution vector */
	if (trace == (struct ex_vect *) 0) {	/* Can't have it */
		echmem |= MEM_FSTK;					/* Stack is full */
#ifdef ISE_GC
		g_data.status = gc_status;			/* Restore previous GC status */
#endif
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
#ifdef ISE_GC
		g_data.status = gc_status;			/* Restore previous GC status */
#endif
		xraise(EN_MEM);						/* Non-critical exception */
		return;								/* Which may be ignored */
	}

	trace->ex_type = EX_HDLR;		/* Enter in a signal handler */

	/* It is now time to call the handler after all those silly "stack"
	 * considerations. We put a setjmp to ensure we'll regain control should
	 * an exception occur, so that garbage collection may be enabled again.
	 */

	if (setjmp(exenv)) {				/* Returning from an exception */
		RTXSC;						/* Restore stack contexts */
#ifdef ISE_GC
		g_data.status = gc_status;	/* Restore previous GC status */
#endif
		xraise(EN_HDLR);			/* Raise exception in signal handler */
		return;						/* Exception ignored */
	}
	trace->ex_jbuf = &exenv;	/* Save setjmp buffer address */
	(handler)(sig);					/* LISPish call to signal handler :-) */
#ifdef ISE_GC
	g_data.status = gc_status;		/* Restore saved GC status */
#endif
	expop(&eif_trace);				/* Remove EN_ILVL record */
	expop(&eif_stack);				/* And EX_HDLR vector */
}

rt_public void exfail(void)
{
	/* The routine whose execution vector is 'exvect' has reached the end
	 * of its rescue clause. So it will fail. Set the ex_rescue flag in case
	 * we have to dump the exception trace and pops off the EX_RESC vector
	 * on eif_stack and the EN_ILVL record on top of eif_trace (pushed on
	 * entry in the rescue clause).
	 */
	EIF_GET_CONTEXT
	struct ex_vect *vector;			/* The stack vector entry at the top */
	unsigned char code;						/* Exception code */

	SIGBLOCK;			/* Critical section, protected against signals */

	expop(&eif_stack);	/* Remove EX_RESC vector */
	expop(&eif_trace);	/* As well as EN_ILVL */
	echlvl--;			/* Decrease by one level */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

	/* An assertion violation occurred, or the routine reached the end of its
	 * rescue clause with no 'retry'. Set the exception code matching the
	 * execution vector at the top of the stack and start backtracking, unless
	 * we have to ignore the exception.
	 */

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

	echval = code;		/* Keep track of the last exception code */
	echtg = vector->ex_name;			/* Record exception tag, if any */

	/* Maintain the notion of original exception at this level, despite any
	 * extra implicit raises, by recomputing the code each time. Due to the
	 * way exorig() works, we have to fake the entry in a new exception level
	 * prior to the call.
	 */
	echlvl++;			/* Have to fake a nesting level */
	exorig();			/* Recompute original exception code */
	echlvl--;			/* Restore nesting level */

#ifndef NOHOOK
	exception(PG_VIOL);		/* Debugger hook -- implicitely raised exception */
#endif
	ereturn();				/* Go back to last recorded rescue entry */

	/* NOTREACHED */
}

rt_public void exresc(register2 struct ex_vect *rout_vect)
{
	/* Signals entry in rescue clause. As we may enter a new exception level
	 * should an exception occur in the clause, push a "New level" on the
	 * Eiffel trace stack and signal we've been in the rescue of the current
	 * call (top of Eiffel trace stack).
	 */
	EIF_GET_CONTEXT
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
		eif_panic(botched);
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

	memcpy (trace, rout_vect, sizeof(struct ex_vect));
	trace->ex_type = EX_RESC;		/* Physical entry in rescue clause */
	trace->ex_rescue = 0;			/* Meaningless from now on */
	trace->ex_retry = 0;			/* So is this */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

rt_public void xraise(int code)
{
	/* Raises an Eiffel exception of the given code with no associated tag */

	eraise(NULL, (long) code);
}

rt_public void eraise(char *tag, long num)
	/* May be called from Eiffel, and INTEGER is long */
{
	/* Raises the exception whose number is 'num'. The execution code is set,
	 * then the stack is unwound up to the first non-null jum_buf pointer.
	 * The 'tag' is used to record the exception tag. This does not work for
	 * all the exceptions (e.g. it has no meaning for an operating system
	 * signal).
	 */
	EIF_GET_CONTEXT
	struct ex_vect	*trace = NULL;			/* The stack trace entry */
	struct ex_vect	*vector;		/* The stack trace entry */
	char 			*tg;
	EIF_REFERENCE obj = NULL;
	unsigned char	type;
#ifdef WORKBENCH
	int				line_number;	/* line number within feature */
#endif

	if (echmem & MEM_PANIC)		/* In panic mode, do nothing */
		return;

	if (echmem & MEM_FATAL)		/* In fatal error mode, panic! */
		eif_panic("exception in fatal mode");

	/* Excepted for EN_OMEM, check whether the user wants to ignore the
	 * exception or not. If so, return immediately.
	 */
	if (num != EN_OMEM && num < EN_NEX && ex_ign[num])
		return;			/* Exception is ignored */

	SIGBLOCK;			/* Critical section, protected against signals */
	echval = (unsigned char) num;		/* Set exception number */

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
			trace->ex_type = (unsigned char) num;		/* Exception code */
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

	vector = extop(&eif_stack);	 /* Vector at top of stack */
	if (vector == (struct ex_vect *) 0) {
		echrt = (char *) 0;	/* Null routine name */
		echclass = 0;		/* Null class name */
#ifdef WORKBENCH
		line_number = 0;	/* Invalid line number */
#endif
	} else {
		if (in_assertion) {
			tg = vector->ex_name;
			type = vector->ex_type;
			if (type == EX_CINV)
				obj = vector->ex_oid;
			expop(&eif_stack);
			vector = extop(&eif_stack);
			if (vector == (struct ex_vect *) 0) {   /* Stack is full now */
				echrt = (char *) 0;	/* Null routine name */
				echclass = 0;		/* Null class name */
#ifdef WORKBENCH
				line_number = 0;	/* Invalid line number */
#endif
			} else {
				echrt = vector->ex_rout;	/* Record routine name */
				echclass = vector->ex_orig; /* Record class name */
#ifdef WORKBENCH
				line_number = vector->ex_linenum; /* Record line number */
#endif
				vector = exget(&eif_stack);
				if (vector == (struct ex_vect *) 0) {   /* Stack is full now */
					echmem |= MEM_FULL;				 /* Signal it */
					if (num != EN_OMEM)				 /* If not already there */
						enomem();					   /* Raise an out of memory */
				} else {
					vector->ex_type = type;	 /* Restore type */
					vector->ex_name = tg;	   /* Restore tag */
					if (type == EX_CINV)
						vector->ex_oid = obj;   /* Restore object id if in invariant */
				}
			}
		} else {
			echrt = vector->ex_rout;	/* Record routine name */
			echclass = vector->ex_orig; /* Record class name */
#ifdef WORKBENCH
			line_number = vector->ex_linenum; /* Record line number */
#endif
		}
	}

	trace->ex_where = echrt;			/* Save routine in trace for exorig */
	trace->ex_from = echclass;			/* Save class in trace for exorig */
#ifdef WORKBENCH
	trace->ex_linenum = line_number;	/* Save line number in trace */
#endif

	/* Maintain the notion of original exception at this level, despite any
	 * extra explicit raises, by recomputing the code each time. Due to the
	 * way exorig() works, we have to fake the entry in a new exception level
	 * prior to the call.
	 */
	echlvl++;			/* Have to fake a nesting level */
	exorig();			/* Recompute original exception code */
	echlvl--;			/* Restore nesting level */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

#ifndef NOHOOK
	exception(PG_RAISE);	/* Debugger hook -- explicitly raised exception */
#endif
	ereturn();				/* Go back to last recorded rescue entry */

	/* NOTREACHED */
}

rt_public void com_eraise(char *tag, long num)
			/* May be called from Eiffel, and INTEGER is long */
{
	/* Raises the exception whose number is 'num'. The execution code is set,
	 * then the stack is unwound up to the first non-null jum_buf pointer.
	 * The 'tag' is used to record the exception tag. This does not work for
	 * all the exceptions (e.g. it has no meaning for an operating system
	 * signal).
	 */
	EIF_GET_CONTEXT
	struct ex_vect *trace = NULL;		/* The stack trace entry */
	struct ex_vect *vector;     /* The stack trace entry */
	char *tg;
	EIF_REFERENCE obj = NULL;
	unsigned char type;

	if (echmem & MEM_PANIC)		/* In panic mode, do nothing */
		return;

	if (echmem & MEM_FATAL)		/* In fatal error mode, panic! */
		eif_panic("exception in fatal mode");

	/* Excepted for EN_OMEM, check whether the user wants to ignore the
	 * exception or not. If so, return immediately.
	 */
	if (num != EN_OMEM && num < EN_NEX && ex_ign[num])
		return;			/* Exception is ignored */

	SIGBLOCK;			/* Critical section, protected against signals */
	echval = (unsigned char) num;		/* Set exception number */

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
			trace->ex_type = (unsigned char) num;		/* Exception code */
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

	vector = extop(&eif_stack);	 /* Vector at top of stack */
	if (vector == (struct ex_vect *) 0) {
		echrt = (char *) 0;	 /* Null routine name */
		echclass = 0;		  /* Null class name */
	} else {
		if (in_assertion) {
			tg = vector->ex_name;
			type = vector->ex_type;
			if (type == EX_CINV)
				obj = vector->ex_oid;
			expop(&eif_stack);
			vector = extop(&eif_stack);
			if (vector == (struct ex_vect *) 0) {   /* Stack is full now */
				echrt = (char *) 0;	 /* Null routine name */
				echclass = 0;		  /* Null class name */
			} else {
				echrt = vector->ex_rout;	/* Record routine name */
				echclass = vector->ex_orig; /* Record class name */
				vector = exget(&eif_stack);
				if (vector == (struct ex_vect *) 0) {   /* Stack is full now */
					echmem |= MEM_FULL;				 /* Signal it */
					if (num != EN_OMEM)				 /* If not already there */
						enomem();					   /* Raise an out of memory */
				} else {
					vector->ex_type = type;	 /* Restore type */
					vector->ex_name = tg;	   /* Restore tag */
					if (type == EX_CINV)
						vector->ex_oid = obj;   /* Restore object id if in invariant */
				}
			}
		} else {
			echrt = vector->ex_rout;	/* Record routine name */
			echclass = vector->ex_orig; /* Record class name */
		}
	}

	trace->ex_where = echrt;		/* Save routine in trace for exorig */
	trace->ex_from = echclass;			/* Save class in trace for exorig */

/* Maintain the notion of original exception at this level, despite any
	 * extra explicit raises, by recomputing the code each time. Due to the
	 * way exorig() works, we have to fake the entry in a new exception level
	 * prior to the call.
	 */
	echlvl++;			/* Have to fake a nesting level */
	exorig();			/* Recompute original exception code */
	echlvl--;			/* Restore nesting level */

	SIGRESUME;			/* End of critical section, dispatch queued signals */

#ifndef NOHOOK
	exception(PG_RAISE);	/* Debugger hook -- explicitly raised exception */
#endif
	ereturn();				/* Go back to last recorded rescue entry */

	/* NOTREACHED */
}

rt_public void eviol(void)
{
	/* An assertion violation occurred, or the routine reached the end of its
	 * rescue clause with no 'retry'. Set the exception code matching the
	 * execution vector at the top of the stack and start backtracking, unless
	 * we have to ignore the exception.
	 */
	EIF_GET_CONTEXT
	struct ex_vect *vector;			/* The stack vector entry at the top */
	unsigned char code;						/* Exception code */
	unsigned char type;				   /* Exception type */
	EIF_REFERENCE obj = NULL;				  /* Object */

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


	/* `eviol' will only be called after `exasrt'. Thus, only the tag
	 * and type will be saved temporarily whilst retrieving
	 * the routine and class name.
	 *
	 * Set up 'echtg' to be the tag of the current exception, if one can be
	 * computed, otherwise it is a null pointer. This will be used by the
	 * debugger in its stop notification request.
	 */

	SIGBLOCK;		   /* Critical section, protected against signals */

	echval = code;				/* Keep track of the last exception code */
	echtg = vector->ex_name;	/* Record exception tag, if any */
	type = vector->ex_type;	 /* Record exception type */
	if (type == EX_CINV)		/* if in invariant */
		obj = vector->ex_oid;   /*	  record object */

	expop(&eif_stack);		  /* Remove vector */

	vector = extop(&eif_stack); /* Execution vector at top of stack */
	if (vector == (struct ex_vect *) 0) {
		echrt = (char *) 0;	 /* Null routine name */
		echclass =  0;		  /* Null class name */
	} else {
		echrt = vector->ex_rout;	/* Record routine name */
		echclass = vector->ex_orig; /* Record class name */
	}

	vector = exget(&eif_stack);  /* Get brand new vector on the Eiffel stack */
	if (vector == (struct ex_vect *) 0) {   /* No more memory */
		echmem |= MEM_FULL;
		xraise(EN_MEM);
		return;							 /* Critical exception */
	}

	vector->ex_type = type;	 /* Restore type */
	vector->ex_name = echtg;	/* Restore tag */
	if (type == EX_CINV)
		vector->ex_oid = obj;   /* Restore object id if in invariant */

	/* Maintain the notion of original exception at this level, despite any
	 * extra implicit raises, by recomputing the code each time. Due to the
	 * way exorig() works, we have to fake the entry in a new exception level
	 * prior to the call.
	 */
	echlvl++;			/* Have to fake a nesting level */
	exorig();			/* Recompute original exception code */
	echlvl--;			/* Restore nesting level */

#ifndef NOHOOK
	exception(PG_VIOL);		/* Debugger hook -- implicitely raised exception */
#endif
	ereturn();				/* Go back to last recorded rescue entry */

	/* NOTREACHED */
}

rt_public void ereturn(void)
{
	/* Return to the first setjmp buffer stored in the exception stack. The
	 * bottom of the stack (created by the main routine) always has a valid
	 * return point anyway, but returning there causes the immediate system
	 * failure and the dumping of the exception stack held in eif_trace.
	 */
	EIF_GET_CONTEXT
	jmp_buf *rescue;					/* The rescue setjmp buffer */

	/* The backtracking operation is not a critical operation, so to speak.
	 * Nonetheless, I wish to protect its execution so as to avoid poblems
	 * should a signal occur right in the middle of the whole operation--RAM.
	 */

	SIGBLOCK;						/* Critical section */
	rescue = (jmp_buf *) backtrack();			/* Attempt rescue */
	SIGRESUME;						/* Dispatch queued signals */

	if (rescue != (jmp_buf *) 0)		/* %%zs was (char *) */
		longjmp(*rescue, echval);	/* Setjmp will return the exception code */

	eif_panic(vanished);				/* main() should have created a vector */
	/* NOTREACHED */
}

rt_private jmp_buf *backtrack(void)
{
	/* Assuming an exception has occurred, start the backtracking process in
	 * order to find a valid branching point (routine with a rescue clause). If
	 * none can be found, return a null pointer, otherwise return the address
	 * of the jmp_buf environment.
	 * There is no real concern for being really fast here, so I've chosen to
	 * rely on existing interface functions instead of hardwiring a loop--RAM.
	 */
	EIF_GET_CONTEXT
	register1 struct ex_vect *top;		/* Top of calling stack */
	struct ex_vect *trace = NULL;	/* The stack trace entry */

	while ((top = extop(&eif_stack))) {	/* While bottom not reached */

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
			memcpy (trace, top, sizeof(struct ex_vect));	/* Record exception */
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
				memcpy (top, trace, sizeof(struct ex_vect));	/* Shift record */
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
			echrt = top->ex_rout;	   /* Associated routine */
			echclass = top->ex_orig;	/* Associated class */
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
				eif_panic(botched);				/* There has to be a buffer */
#else
			if (!(echmem & MEM_SPEC))		/* Not in panic mode */
				return top->ex_jbuf;		/* Address of env buffer */
#endif
			break;

		case EX_PRE:	/* Precondition violation */
			/* An EX_CALL must follow on the stack (it cannot be an EX_RETY as
			 * preconditions are not rechecked when a retry occurs). Take it and
			 * initializes the ex_where field correctly. For a pre-condition,
			 * the exception is raised in the caller hence the caller must
			 * disappear from the stack...
			 */
			top = extop(&eif_stack);

			CHECK ("top vector not null", top);

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
			jmp_buf *jbuf = NULL;			/* Setjmp buffer from EX_OSTK */

			if (top->ex_type == EX_OSTK) {		/* Melted pre-condition */
				jbuf = top->ex_jbuf;			/* Save setjmp buffer */
				expop(&eif_stack);				/* Remove catching vector */
				top = extop(&eif_stack);		/* Update top */
			}
#endif

			CHECK ("precondition violated in call", top->ex_type == EX_CALL);
			trace->ex_where = top->ex_rout;	/* Save routine name */
			trace->ex_from = top->ex_orig;	/* Where it comes from */
			trace->ex_oid = top->ex_id;		/* And object ID */
			expop(&eif_stack);				/* Exception raised in caller */

#ifdef WORKBENCH
			/* In workbench mode, if we detected an EX_OSTK catching record,
			 * then the ex_jbuf entry in the trace vector is a non-null pointer.
			 */
			if (jbuf != NULL && !(echmem & MEM_SPEC))
				return jbuf;			/* Setjmp buffer from EX_OSTK */
		}
#endif
			break;

			/* FIXME: Manu 02/22/2001
			 * Before only EX_PRE was taken into account, not the other
			 * assertions types. I don't know the reason, but not taken
			 * the other into account will crash the runtime for some
			 * sequence of Eiffel code. See PR#2496.
			 */
		case EX_POST:	/* Postcondition violation */
		case EX_CINV:	/* Invariant (routine exit) violation */
		case EX_CHECK:	/* Check violation */
		case EX_INVC:	/* Invariant (routine entrance) violation */
		case EX_LINV:	/* Loop invariant violation */
		case EX_VAR:	/* Loop variant violation */
			top = extop(&eif_stack);

			CHECK ("top vector not null", top);

			trace->ex_where = top->ex_rout;	/* Save routine name */
			trace->ex_from = top->ex_orig;	/* Where it comes from */
			trace->ex_oid = top->ex_id;		/* And object ID */

	  		break;

		default:
			break;		/* No special processing needed */
		}

#ifdef DEBUG
		dump_vector("backtrack: top of eif_trace", trace);
#endif

	}

	return NULL;	/* No setjmp buffer found */
}

rt_public void exok(void)
{
	/* Signals that the call recorded at the top of the stack has finished
	 * normally (eventually via resumption). Pop off the values on the
	 * execution stack until the first EX_CALL structure. Also pop off values
	 * from the exception trace stack (those matching our level).
	 * It's not our concern to deal with the local variable stack. This routine
	 * is called only before returning from a routine with a rescue clause.
	 */
	EIF_GET_CONTEXT
	register1 struct ex_vect *top;		/* Top of calling stack */
	register2 struct stxchunk *start;	/* First chunk in trace stack */
	register3 int type;					/* Type of execution vector */

	/* If 'echval' is set to zero, then no exception occurred, so return
	 * immediately after poping the current element.
	 * Otherwise, pop off the stack until we reach an execution
	 * vector, which will be popped off by the normal ending of the routine.
	 * (The generated C code does not optimize the call to exok() by first
	 * testing the value of 'echval', nor does the interpreter hence the test
	 * here--RAM).
	 */

	if (echval == 0) {
		expop(&(eif_stack));		/* remove current call from `eif_stack' */
		return;						/* No exception occurred */
	}

	SIGBLOCK;			/* Critical section, protected against signals */

	while ((top = extop(&eif_stack))) {	/* Find last enclosing call */
		type = top->ex_type;			/* Type of the current vector */
		if (type == EX_CALL || type == EX_RESC || type == EX_RETY) {
			expop(&eif_stack);			/* remove current call from `eif_stack' */
			break;						/* We found a calling record */
		}
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
		while ((top = extop(&eif_trace))) {
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


/* Clears the exception stack */
rt_public void exclear(void)
{
	EIF_GET_CONTEXT

	/* If 'echval' is set to zero, then no exception occurred, so return
	 * immediately. Otherwise, pop off the stack until we reach an execution
	 * vector, which will be popped off by the normal ending of the routine.
	 * (The generated C code does not optimize the call to exok() by first
	 * testing the value of 'echval', nor does the interpreter hence the test
	 * here--RAM).
	 */

	if (echval == 0) return; /* No exception occurred */

	SIGBLOCK;			/* Critical section, protected against signals */

	/* Now deal with the trace stack. If the exception level is 0, we can reset
	 * the whole stack. Otherwise, we have to unwind it until we find the
	 * "New level" pseudo-vector.
	 */

	while (extop(&eif_trace))
	  expop(&eif_trace);	/* Will panic if we underflow */

	echval = 0;			/* No more pending exception */
	echmem = 0;			/* We have recovered from this out of mem */
	echorg = 0;			/* No more original exception */

	SIGRESUME;			/* End of critical section, dispatch queued signals */
}

rt_private void excur(void)
{
	/* Compute the value of the current exception which was pushed on the
	 * exception trace stack, at the previous execution level. The run-time
	 * maintains this notion of 'current exception' (the last one which was
	 * raised) and it is normally carried by 'echval'. Also reset 'echtg' to be
	 * the current exception tag.
	 */
	EIF_GET_CONTEXT
	struct xstack context;		/* Saved stack context */
	struct ex_vect *top;		/* Walk through stack */

#ifdef MAY_PANIC
	if (echlvl < 1)				/* There has to be at least one nesting level */
		eif_panic(botched);
#endif

	memcpy (&context, &eif_trace, sizeof(struct xstack));

	/* The current top at this point is an EN_ILVL record, so the last exception
	 * which occurred at the previous level is just the one below.
	 */

	expop(&eif_trace);			/* This removes the EN_ILVL record */
	top = exget(&eif_trace);	/* Last exception at previous level */
	echval = top->ex_type;		/* Current exception code */
	echtg = extag(top);			/* Recompute exception tag */

	memcpy (&eif_trace, &context, sizeof(struct xstack));
}

rt_private void exorig(void)
{
	/* Compute the value of the original exception which started to fill in
	 * the exception trace stack, at the previous execution level. The run-time
	 * maintains this notion of 'original exception' (the one which started it
	 * all) and it is normally carried by 'echorg'. Also reset 'echotag' to be
	 * the original exception tag.
	 */

	EIF_GET_CONTEXT
	struct xstack context;		/* Saved stack context */
	struct ex_vect *top;		/* Walk through stack */
	int poped;					/* Number of vectors already poped */

#ifdef MAY_PANIC
	if (echlvl < 1)				/* There has to be at least one nesting level */
		eif_panic(botched);
#endif

	/* If there is only one nesting level, then the exception which started it
	 * all is at the bottom of the stack, since we enter a new level each time
	 * we execute a rescue clause.
	 */

	if (echlvl == 1) {				/* Only one level -> bottom of stack */
		if (eif_trace.st_hd == (struct stxchunk *) 0) {		/* No stack yet */
			echorg = echval;				/* Original is current exception */
			echotag = echtg;				/* As well as original tag */
			echort = echrt;				 /* As well as original routine */
			echoclass = echclass;		   /* As well as original class */
			return;
		}
		top = eif_trace.st_hd->sk_arena;	/* This is the bottom */
		if (top == eif_trace.st_top) {		/* Empty stack (yes, can happen) */
			echorg = echval;				/* Original is current exception */
			echotag = echtg;				/* As well as original tag */
			echort = echrt;				 /* As well as original routine */
			echoclass = echclass;		   /* As well as original class */
		} else {
			echorg = top->ex_type;			/* Get original exception code */
			echotag = extag(top);			/* And recompute tag */
			echort = echrt;				 /* As well as original routine */
			echoclass = echclass;		   /* As well as original class */
		}
		return;
	}

	/* We are in level 'echlvl' and the exception which started it all is the
	 * one just above the EX_ILVL record at level 'echlvl - 1' (i.e. the
	 * previous nesting level).
	 */

	memcpy (&context, &eif_trace, sizeof(struct xstack));

	poped = 0;		/* If top is the EN_ILVL vector, then we come from eviol */
	echorg = 0;		/* Signals not found (yet) */

	while ((top = extop(&eif_trace))) {
		if (top->ex_type == EN_ILVL && top->ex_lvl == (echlvl - 1)) {
			if (poped == 0) {			/* First one, nothing at this level */
				echorg = echval;		/* Current exception is original */
				echotag = echtg;		/* (implicitely raised from eviol) */
				echort = echrt;		 /* As well as original routine */
				echoclass = echclass;   /* As well as original class */
				break;
			}
			(void) exget(&eif_trace);	/* Move just above it */
			top = extop(&eif_trace);	/* Fetch record */
			echorg = top->ex_type;		/* Original exception code */
			echotag = extag(top);		/* Recompute exception tag */
			echort = echrt;		 	/* As well as original routine */
			echoclass = echclass;   	/* As well as original class */
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
		eif_panic(botched);
	else if (echorg == 0) {
		echorg = EN_OMEM;				/* Default exception */
		echotag = (char *) 0;			/* No known tag */
		echort = (char *) 0;			/* No known routine */
		echoclass = 0;				  /* No known class */
	}
#else
	if (echorg == 0) {
		echorg = EN_OMEM;				/* Default exception */
		echotag = (char *) 0;			/* No known tag */
		echort = (char *) 0;			/* No known routine */
		echoclass = 0;				  /* No known class */
	}
#endif

	memcpy (&eif_trace, &context, sizeof(struct xstack));
}

rt_private char *extag(struct ex_vect *trace)
		/* Faulty vector on trace stack */
{
	/* Recompute the exception tag associated with vector on stack. This burden
	 * is needed because of class EXCEPTION wich might ask the tag of the last
	 * exception any time--RAM.
	 */
	EIF_GET_CONTEXT

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

	echrt = trace->ex_where;	/* Associated routine */
	echclass = trace->ex_from;	  /* Associated class */

	return echtg;
}

rt_public void esfail(void)
{
	/* Produces immediate failure of the Eiffel system followed by an exception
	 * trace dump. No exit is performed. However, before returning we have to
	 * call the GC (a single mark and sweep will do) to ensure "dispose" is
	 * called on every dead objects (for instance to ensure all temporary
	 * files are removed and locks are cleared).
	 */
	EIF_GET_CONTEXT

	/* We flush stdout now, to avoid unprinted data being printed after the
	 * stack trace. This is mainly indented for situations like stdout = tty
	 * or stdout and stderr redirected to the same file.
	 */
	fflush(stdout);

	/* Display exception stack only if print_history_table is true */
	if (!print_history_table)
		return;

	/* Signals failure. If the out of memory flags are set, mention it */
	EIF_EXCEPT_LOCK
	print_err_msg(stderr, "\n%s: system execution failed.\n", ename);
	print_err_msg(stderr, "Following is the set of recorded exceptions");
	if (echmem & MEM_FSTK) {
		print_err_msg(stderr,".\nDue to a lack of memory, the sequence is incomplete near the end");
	}
	if (echmem & MEM_FULL) {
		if (echmem & MEM_FSTK) {
			print_err_msg(stderr,".\nMoreover, an 'out of memory' may have led to an untrustworthy stack");
		} else {
			print_err_msg(stderr,".\nHowever, an 'out of memory' occurred and might have spoilt the stack");
		}
	}
	if (echmem & MEM_PANIC) {
		print_err_msg(stderr,".\nNB: The raised panic may have induced completely inconsistent information");
	}
	print_err_msg(stderr, ":\n\n");

	echmem |= MEM_PANIC;		/* Backtrack won't attempt any longjmp */
	(void) backtrack();			/* Unwind the whole stack */
	dump_trace_stack();			/* Print the stack */
	EIF_EXCEPT_UNLOCK
#ifdef EIF_WIN32
	eif_console_cleanup(EIF_TRUE);
#endif
}

#ifdef WORKBENCH
#ifndef NOHOOK
rt_private void exception(int how)
		/* Implicit or explicit exception? */
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
	EIF_GET_CONTEXT

	if (db_ign[echval])		/* Current exception to be ignored */
		return;				/* Do not stop execution */

	if (!debug_mode)
		return;

	if (echval == EN_FAIL || echval == EN_OSTK)
		return;
	dbreak(how);			/* Stop execution */
}
#endif
#else
rt_private void exception(int how) {}
#endif

rt_public void eif_panic(char *msg)
{
	/* In case of run-time panic, print the final message 'msg' and dumps
	 * an execution stack if possible. This exception cannot be trapped.
	 */
	EIF_GET_CONTEXT
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
	switch (done) {
		case 0:
			done = 1;
			print_err_msg(stderr, "\n%s: PANIC: %s ...\n", ename, msg);
			break;
		case 1:
			done = 2;
			print_err_msg(stderr, "\n%s: PANIC CASCADE: %s -- Giving up...\n", ename, msg);
			reclaim ();
			exit (2);
			break;
		default:
			print_err_msg(stderr, "\n%s: FINAL PANIC: Cannot reclaim Eiffel objects -- Giving up...\n", ename);
			exit (2);
			break;
	}

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
	print_err_msg(stderr, "\n");	/* Skip one line */
	dump_core();					/* Before dumping a core */
	/* NOTREACHED */
}

rt_public void fatal_error(char *msg)
{
	/* In case of run-time fatal error, print the final message 'msg' and dumps
	 * an execution stack if possible. This exception cannot be trapped.
	 */
	EIF_GET_CONTEXT
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
	switch (done) {
		case 0:
			done = 1;
			print_err_msg(stderr, "\n%s: PANIC: %s ...\n", ename, msg);
			break;
		case 1:
			done = 2;
			print_err_msg(stderr, "\n%s: PANIC CASCADE: %s -- Giving up...\n", ename, msg);
			reclaim ();
			exit (2);
			break;
		default:
			print_err_msg(stderr, "\n%s: FINAL PANIC: Cannot reclaim Eiffel objects -- Giving up...\n", ename);
			exit (2);
			break;
	}

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
	echrt = (char *) 0;			 /* No routine name */
	echclass = 0;				   /* No current class */
	esfail();						/* Raise system failure and stack dump */

	reclaim();						/* Reclaim all the objects */
	exit(1);						/* Abnormal termination */

	/* NOTREACHED */
}

rt_private void dump_core(void)
{
	/* Dumps a core to generate debugging information. In case the SIGABRT
	 * signal would be caught or ignored, we first reset it to the default
	 * action. This may interfere with the user's request, but usually we come
	 * here from panic(), so the state of the program is not well defined,
	 * and thus continuing would not mean much.
	 */

	signal(ABORTSIG, SIG_DFL);	/* Make sure abort() will dump a core */

	/* Stdout has already been flushed */
	print_err_msg(stderr, "%s: dumping core to generate debugging information...\n",
		ename);
	reclaim();
	abort();

	exit(1);					/* Bede Bede Bede, That's all Folks ! */
}

rt_public void esdie(int code)
{
	/* This routine provokes the termination of the current Eiffel program,
	 * collecting the objects (in case some dispose procedure have been
	 * attached to objects) and then exiting with the supplied exit code.
	 */

	reclaim();					/* Collect all currently alive objects */
#ifdef EIF_WIN32
	ExitProcess (code);			/* Return to OS and forward final status */
#else
	exit(code);					/* Return to OS and forward final status */
#endif

	/* NOTREACHED */
}

rt_private void find_call(void)
{
	/* The Eiffel exception trace stack was built upside-down. So we have to
	 * walk forward through the stack to find the enclosing call record (an
	 * EN_FAIL vector). The context of the stack is saved/restored.
	 * The function return the address of the enclosing call vector.
	 */
	EIF_GET_CONTEXT
	register1 struct ex_vect *item;	/* Item we deal with */
	struct xstack saved;			/* Saved stack context */

	memcpy (&saved, &eif_trace, sizeof(struct xstack));

	/* Reset the exception structure to its default state */
	eif_except.rescued = 0;				/* Not rescued */
	eif_except.retried = 0;				/* Nor retried */

	/* Start scanning the stack. Note that the current "top" (i.e. last item)
	 * is skipped. It should have been processed by the caller to make sure it
	 * is not the call we are looking for (in fact, it should never be so,
	 * unless the stack is untrustworthy due to an out of memory condition).
	 */

	while ((item = exnext())) {		/* While not (found or end of stack) */

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

			eif_except.rname = item->ex_rout;	/* Routine name */
			eif_except.from = item->ex_orig;	/* Where it comes from */
			eif_except.obj_id = item->ex_id;	/* Object's ID */
			if (item->ex_retry)				/* Function has been retried */
				eif_except.retried = 1;			/* Resumption has been attempted */

			/* We want to signal an entry in a rescue clause even if it has not
			 * led to an exception. If the end of the rescue clause is reached,
			 * the ending of the rescue clause set the ex_rescue flag to 1.
			 */

			if (item->ex_rescue)
				eif_except.rescued = 1;			/* Led to a (failed) rescue */
			break;

		} else if (item->ex_type == EN_PRE) {

			/* A precondition violated raises an exception in the caller.
			 * However, the precondition occurred in another routine, whose
			 * ID is held in the vector.
			 */

			eif_except.rname = item->ex_where;	/* Where precondition was */
			eif_except.from = item->ex_from;	/* Where it was written */
			eif_except.obj_id = item->ex_oid;	/* Object's ID */
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

	if (eif_except.rname == (char *) 0) {		/* Was created by main() */
		if (root_obj != (char *) 0) {
			eif_except.rname = "root's creation";
			eif_except.from = Dtype(root_obj);
		} else {
			eif_except.rname = "root's set-up";	/* Root object not created */
			eif_except.from = -1;				/* Signals: no valid object */
		}
		eif_except.obj_id = root_obj;			/* Null address if early */
		eif_except.last = 1;					/* Must be the last record */
	}

	memcpy (&eif_trace, &saved, sizeof(struct xstack));
}

rt_private void ds_stderr (char *line)
{
	/* Print the string 'line' to the standard output */

	print_err_msg(stderr, "%s", line);
}

rt_private void ds_string(char *line)
{
	/* Wrapper to dump the exception stack to the string ex_string */

	extend_trace_string(line);
}

rt_private void extend_trace_string(char *line)
{
	/* Appends the string line to the exception string. Memory reallocation is
	 * performed if necessary.
	 */
	EIF_GET_CONTEXT

	if ((ex_string.size - ex_string.used) > (long) strlen(line)) {
		strcpy (ex_string.area + ex_string.used, line);
		ex_string.used += strlen(line);
	} else {
		ex_string.size += strlen(line) + BUFSIZ;
#ifdef DEBUG
		printf ("extend_trace_string: Going to do a realloc...\n");
#endif
		ex_string.area = (char *) eif_realloc(ex_string.area, ex_string.size);
		if(ex_string.area) {
			strcpy (ex_string.area + ex_string.used, line);
			ex_string.used += strlen(line);
		} else
			enomem();
	}
}

rt_public EIF_REFERENCE stack_trace_string (void)
{
    /* Initialize the SMART_STRING structure supposed to receive the exception
     * stack, dump the exception stack into it and return an Eiffel string.
     */
	EIF_GET_CONTEXT

    /* Clean the area from a previous call. */
    if (ex_string.area)
        eif_free(ex_string.area);

    /* Prepare the structure for a new trace */
    ex_string.area = NULL;
    ex_string.used = 0L;
    ex_string.size = 0L;

    /* Dump the exception stack into this structure by using the
     * wrapper ds_string().
     */
    dump_stack(ds_string);

    /* Return the string to Eiffel */
    return (EIF_REFERENCE) RTMS(ex_string.area);
}

rt_private void dump_trace_stack(void)
{
	/* Wrapper to dump the exception stack to stderr */

	dump_stack(ds_stderr);
}

rt_private void dump_stack(void (*append_trace)(char *))
{
	EIF_GET_CONTEXT
	char buffer[256];
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
	eif_trace.st_end = eif_trace.st_cur->sk_end;

	/* Print header of history table */
	
#ifdef EIF_THREADS
	/* At first, if we are in the MT mode, print the thread id */
	sprintf(buffer, "%s\n", thr_enter);
	append_trace(buffer);
	
	if (!(eif_thr_is_root()))
		sprintf (buffer,"%-19.19s %-22.22s 0x%lx %s\n", "In thread", 
				"Child thread", (unsigned long) eif_thr_context->tid, "(thread id)");
	else
		sprintf (buffer,"%-19.19s %-22.22s 0x%lx %s\n", "In thread", 
				"Root thread", (unsigned long) 0, "(thread id)");
		
	append_trace(buffer);
	sprintf(buffer, "%s\n", thr_failed);
	append_trace(buffer);

#endif 	/* EIF_THREADS */

	sprintf(buffer, "%s\n", failed);
	append_trace(buffer);
	sprintf(buffer, "%-19.19s %-22.22s %-29.29s %-6.6s\n",
			"Class / Object", "Routine", "Nature of exception", "Effect");
	append_trace(buffer);
	sprintf(buffer, "%s\n", failed);
	append_trace(buffer);

	/* Print body of history table. A little look-ahead is necessary, in order
	 * to give meaningful routine names and effects (retried, rescued, failed).
	 */

	eif_except.previous = 0;		/* Previous exception code */
	recursive_dump(append_trace, 0);	/* Recursive dump, starting at level 0 */
}

rt_private void recursive_dump(void (*append_trace)(char *), register1 int level)
{
	/* Prints the stack trace of a given level. Whenever a new level is reached,
	 * we call us recursively, hence the name of the routine. The exception
	 * structure is saved (on the C stack) before entering in the recursion.
	 * While the calling stack cannot be inconsistant (otherwise it's a panic),
	 * the exception stack may well be, in case we ran out of memory.
	 */
	EIF_GET_CONTEXT
	struct ex_vect *trace;		/* Call on top of the stack */
	char buffer[256];

	for (
		find_call(), trace = eif_trace.st_bot;
		trace != eif_trace.st_top;
		trace = eif_trace.st_bot
	) {
		eif_except.code = trace->ex_type;	/* Record exception code */
		eif_except.tag = (char *) 0;		/* No tag by default */
		switch (trace->ex_type) {
		case EN_ILVL:					/* Entering new level */
			/* The stack may end with such a beast, so detect this and return
			 * if we reached the last item in the stack.
			 */
			(void) exnext();			/* Skip pseudo-vector "New level" */
			if (exend())
				return;					/* Exit if at the end of the stack */
			sprintf(buffer, branch_enter, trace->ex_lvl);
			append_trace(buffer);
			sprintf(buffer, "\n%s\n", failed);
			append_trace(buffer);
			recursive_dump(append_trace, level + 1);	/* Dump the new level */
			sprintf(buffer, branch_exit, level);
			append_trace(buffer);
			sprintf(buffer, "\n%s\n", failed);
			append_trace(buffer);
			find_call();				/* Restore global exception structure */
			break;
		case EN_OLVL:					/* Exiting a level */
			(void) exnext();	/* Skip pseudo-vector "Exit level" */
			return;						/* Recursion level decreases */
			/* NOTREACHED */
		case EN_RES:					/* Resumption attempt */
		case EN_FAIL:					/* Routine call */
		case EN_RESC:					/* Exception in rescue */
			print_top(append_trace);				/* Print exception trace */
			find_call();				/* Look for new enclosing call */
			break;
		case EN_SIG:					/* Signal received */
			eif_except.tag = signame(trace->ex_sig);
			print_top(append_trace);
			break;
		case EN_SYS:					/* Operating system error */
		case EN_IO:						/* I/O error */
			eif_except.tag = error_tag(trace->ex_errno);
			print_top(append_trace);
			break;
		case EN_CINV:					/* Class invariant violated */
			eif_except.obj_id = trace->ex_oid;	/* Do we need this? */
			/* Fall through */
		case EN_PRE:					/* Precondition violated */
			eif_except.tag = trace->ex_name;
			print_top(append_trace);
			find_call();				/* Restore correct object ID */
			break;
		case EN_BYE:
		case EN_FATAL:
			eif_except.tag = echtg;			/* Tag for panic or fatal error */
			print_top(append_trace);
			break;
		default:
			eif_except.tag = trace->ex_name;
			print_top(append_trace);
		}
	}
}

rt_private void print_top(void (*append_trace)(char *))
{
	/* Prints the exception trace described by the top frame of the exception
	 * stack and the exception context built.
	 * The exception tag is limited to 26 characters, the class name to 19 and
	 * the routine name to 22 characters. These should be #defined--RAM, FIXME.
	 */
	EIF_GET_CONTEXT
	char			buf[32];				/* To pre-compute the (From orig) string */
	char			buffer[256];
	char			rout_name_buffer[256];	/* To add line number at end of routine name */
#ifdef WORKBENCH
	int				line_number;
#endif
	char			code = eif_except.code;	/* Exception's code */
	struct ex_vect	*top;					/* Top of stack */

#ifdef DEBUG
	dump_vector("print_top: top of trace is", eif_trace.st_bot);
	dprintf(1)("print_top: code = %d (previous %d) %s%s%s\n",
		code, eif_except.previous, eif_except.retried ? "was retried" : "",
		(eif_except.retried && eif_except.rescued) ? " and " : "",
		eif_except.rescued ? "was rescued" : "");
#endif

	/* Do not print anything if the retry flag is on and the previous exception
	 * was not not a routine failure nor a resumption attempt failed. Indeed,
	 * the exception that led to a retry has already been printed and we do
	 * not want to see two successive 'retry' lines.
	 * Similarily, a rescued routine fails, and is not 'rescued' at the end
	 * of the rescue clause.
	 */
	if (
		eif_except.retried &&			/* Call has been retried */
		eif_except.previous != 0 &&		/* Something has been already printed */
		eif_except.previous != EN_FAIL && eif_except.previous != EN_RES
	) {
		(void) exnext();		/* Remove the top */
		return;			/* We already printed the retry line */
	}

	eif_except.previous = code;		/* Update previous exception code */

	/* get the line number, it's situated in the next satck element (the current bottom */
	/* element gives only the reason of crashes                                         */
#ifdef WORKBENCH
	line_number = (eif_trace.st_bot)->ex_linenum;

	/* create the 'routine_name@line_number' string */
	if (line_number>0)
		/* the line number seems valid, so we are going to print it */
		sprintf(rout_name_buffer, "%s @%d", eif_except.rname, line_number);
	else
		/* the line number is not valid, so we are forgetting it */
#endif
		sprintf(rout_name_buffer, "%s", eif_except.rname);

	if (eif_except.tag)
		sprintf(buf, "%.28s:", eif_except.tag);
	else
		buf[0] = '\0';

	if (eif_except.from >= 0) {
		if (eif_except.obj_id) {
			int obj_dtype = Dtype(eif_except.obj_id);

			if (obj_dtype>=0 && obj_dtype < scount) {
				sprintf(buffer, "%-19.19s %-22.22s %-29.29s\n",	
						Class(eif_except.obj_id), rout_name_buffer, buf);
				append_trace(buffer);
			} else {
				sprintf(buffer, "%-19.19s %-22.22s %-29.29s\n",	
						"Invalid object", rout_name_buffer, buf);
				append_trace(buffer);
			}
		} else {
			sprintf(buffer, "%-19.19s %-22.22s %-29.29s\n",	
					"Invalid object", rout_name_buffer, buf);
			append_trace(buffer);
		}
	} else {
		sprintf(buffer, "%-19.19s %-22.22s %-29.29s\n",
			"RUN-TIME", rout_name_buffer, buf);
		append_trace(buffer);
	}

	/* There is no need to compute the origin of a routine if it is the same
	 * as the current class. To detect this, we do pointer comparaison to
	 * statically allocated strings (faster than a strcmp).
	 * As a matter of style, the macros 'Class', 'System' etc... are not
	 * all uppercased because there is no side effect, and they could be
	 * functions--RAM.
	 */

	buf[0] = '\0';

	if (eif_except.from >= 0) {
		if (eif_except.obj_id) {
			if (eif_except.from != (int)Dtype(eif_except.obj_id))
				sprintf(buf, "         (From %.15s)", Origin(eif_except.from));
		} else
			sprintf(buf, "         (From %.15s)", Origin(eif_except.from));
	}

	sprintf(buffer, "<%08lX> %-31.31s %-29.29s ", 
			(unsigned long) eif_except.obj_id, buf, exception_string(code));
	append_trace(buffer);

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
		if (eif_except.last) {
			sprintf(buffer, "Bye\n%s\n", failed);	/* Good bye! */
			append_trace(buffer);
		} else {
			sprintf(buffer, "Panic\n%s\n", failed);	/* Panic propagation */
			append_trace(buffer);
		}
		return;
	} else if (echval == EN_FATAL) {
		if (eif_except.last) {
			sprintf(buffer, "Bye\n%s\n", failed);	/* Good bye! */
			append_trace(buffer);
		} else {
			sprintf(buffer, "Fatal\n%s\n", failed);	/* Fatal propagation */
			append_trace(buffer);
		}
		return;
	} else if (eif_except.last) {						/* Last record => exit */
		sprintf(buffer, "Exit\n%s\n", failed);
		append_trace(buffer);
		return;
	} else if (code == EN_FAIL || code == EN_RES) {
		if (eif_except.retried) {
			sprintf(buffer, "Retry\n%s\n", retried);
			append_trace(buffer);
		} else
			if (eif_except.rescued) {
				sprintf(buffer, "Rescue\n%s\n", failed);
				append_trace(buffer);
			} else {
				sprintf(buffer, "Fail\n%s\n", failed);
				append_trace(buffer);
			}

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
		if (eif_except.retried) {
			sprintf(buffer, "Retry\n%s\n", retried);
			append_trace(buffer);
		} else {
			sprintf(buffer, "Fail\n%s\n", failed);
			append_trace(buffer);
		}
	} else {
		sprintf(buffer, "Pass\n%s\n", failed);
		append_trace(buffer);
	}
}

/* Stack handling routine. The following code has been cut/paste from the one
 * found in garcol.c and local.c as of this day. Hence the similarities and the
 * possible differences. What changes basically is that instead of storing
 * (char *) elements, we now store (struct ex_vect) ones.
 */

rt_shared struct ex_vect *exget(register2 struct xstack *stk)
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

rt_private struct ex_vect *stack_allocate(register2 struct xstack *stk, register1 int size)
		/* The stack */
		/* Initial size */
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

rt_private int stack_extend(register2 struct xstack *stk, register1 int size)
			/* The stack */
			/* Size of new chunk to be added */
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
		if (chunk != (struct stxchunk *) 0)
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

rt_private void stack_truncate(register1 struct xstack *stk)
		/* The stack to be truncated */
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

rt_private void wipe_out(register struct stxchunk *chunk)
		/* First chunk to be freed */
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

rt_public void expop(register1 struct xstack *stk)
		/* The stack */
{
	/* Removes one item from the Eiffel stack */
#ifdef WORKBENCH
	EIF_GET_CONTEXT
#endif

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
		eif_panic("Eiffel stack underflow");
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

rt_shared struct ex_vect *extop(register1 struct xstack *stk)
		/* The stack */
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

rt_shared struct ex_vect *exnext(void)
{
	/* This function is only used when dumping the execution stack (i.e. after
	 * a system failure has occurred). As that stack has been built upside-down,
	 * the first items to be printed are those at the bottom of the stack.
	 * This function finds the next item to be printed (starting at the bottom),
	 * updating the xstack structure of eif_trace. It returns a null pointer
	 * in case of stack overflow.
	 * NB: The stack structure is physically destroyed, mangled from the bottom.
	 */
	EIF_GET_CONTEXT
	register1 struct ex_vect *first_item;	/* First item pushed */

	/* If we already reached the end of the stack, return immediately */
	if (eif_trace.st_bot == eif_trace.st_top)
		return (struct ex_vect *) 0;		/* Reached the end of the stack */

	first_item = eif_trace.st_bot++;

	if  (eif_trace.st_bot == eif_trace.st_top)
			/* We don't need to check if we reached the end of the chunk */
			/* because the end of the stack is forseen */
		return first_item;

	if (eif_trace.st_bot >= eif_trace.st_cur->sk_end) {
			/* We reached the end of the current chunk. Set the bottom */
			/* pointer to the beginning of the next chunk for the next */
			/* call. (This next chunk exists because we didn't reach */
			/* the top of the stack yet.) */
		eif_trace.st_cur = eif_trace.st_cur->sk_next;
		eif_trace.st_end = eif_trace.st_cur->sk_end;
		eif_trace.st_bot = eif_trace.st_cur->sk_arena;
	}

	return first_item;
}

rt_private int exend(void)
{
	/* Returns true if the end of the Eiffel trace stack has been reached */
	EIF_GET_CONTEXT

	/* If we already reached the end of the stack, return immediately */
	if (eif_trace.st_bot == eif_trace.st_top)
		return 1;		/* Reached the end of the stack */

	return 0;
}

/*
 * Translation functions. Giver a code or a signal number, return a pointer
 * to a static string giving a "human readable" description of the event.
 */

rt_private char *exception_string(int code)
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
rt_private void dump_vector(char *msg, struct ex_vect *vector)
				/* Message to print before dumping */
				/* The vector to be dumped */
{
	/* This routine is meant to be used for debugging purposes only */

	if (!(DEBUG & 1))
		return;
		
	printf("%s (at 0x%lx):\n", msg, vector);
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
		printf("\texur_jbuf = 0x%lx\n", vector->ex_jbuf);
		printf("\texur_id = 0x%lx\n", vector->ex_id);
		printf("\texur_rout = \"%s\"\n", vector->ex_rout);
		printf("\texur_orig = %d\n", vector->ex_orig);
		break;
	}
}
#endif

/*
 * Eiffel interface
 */

rt_public long eeocode(void)	/* %%zmt never called in C dir. */
{
	EIF_GET_CONTEXT
	/* Return the code of the first exception at this nesting level */

	return (long) echorg;	/* Original exception code */
}

rt_public char *eeotag(void)	/* %%zmt never called in C dir. */
{
	EIF_GET_CONTEXT
	/* Return the tag of the first exception at this nesting level */

	if (echorg == 0)		/* No original exception */
		return (char *) 0;

	if (echotag != (char *) 0)
		return makestr(echotag, strlen(echotag)); /* Last exception tag */

	return (char *) 0;
}

rt_public char *eeorout(void)	/* %%zmt never called in C dir. */
{
	/* Return the routine of the first exception at this nesting level */
	EIF_GET_CONTEXT

	if (echorg == 0)		/* No original exception */
		return (char *) 0;

	if (echort != (char *) 0)
		return makestr(echort, strlen(echort)); /* Last exception tag */

	return (char *) 0;
}

rt_public char *eeoclass(void)	/* %%zmt never called in C dir. */
{
	/* Return the class of the first exception at this nesting level */
	EIF_GET_CONTEXT
	char *cl_name;

	if (echorg == 0)		/* No original exception */
		return (char *) 0;

	if (echoclass != 0) {
		cl_name = Origin(echoclass);
		return makestr(cl_name, strlen(cl_name)); /* Last exception tag */
	}

	return (char *) 0;
}

rt_public long eelcode(void)	/* %%zmt never called in C dir. */
{
	EIF_GET_CONTEXT
	return (long) echval;	/* Last exception code */
}

rt_public char *eeltag(void)	/* %%zmt never called in C dir. */
{
	EIF_GET_CONTEXT

	if (echval == 0)		/* No current exception */
		return (char *) 0;

	if (echtg != (char *) 0)
		return makestr(echtg, strlen(echtg)); /* Last exception tag */

	return (char *) 0;
}

rt_public char *eelrout(void)	/* %%zmt never called in C dir. */
{
	/* Return the routine of the last exception */
	EIF_GET_CONTEXT

	if (echval == 0)		/* No current exception */
		return (char *) 0;

	if (echrt != (char *) 0)
		return makestr(echrt, strlen(echrt)); /* Last exception tag */

	return (char *) 0;
}

rt_public char *eelclass(void)	/* %%zmt never called in C dir. */
{
	/* Return the class of the last exception */
	EIF_GET_CONTEXT
	char *cl_name;

	if (echval == 0)		/* No current exception */
		return (char *) 0;

	if (echclass != 0) {
		cl_name = Origin(echclass);
		return makestr(cl_name, strlen(cl_name)); /* Last exception tag */
	}

	return (char *) 0;
}

rt_public void eetrace(char b)	/* %%zmt never called in C dir. */
{
	/* Enable/diable printing of the history table */
	EIF_GET_CONTEXT

	if (b == (char) 1)
		print_history_table = ~0;
	else
		print_history_table = 0;
}

rt_public EIF_REFERENCE eename(long ex)
{
	/* Return the english description for exeception `ex' */

	char *e_string;

	if (eedefined(ex) == (char) 1){
		e_string = exception_string(ex);
		return makestr(e_string, strlen(e_string));
	}
	return (0); /* to avoid a warning */
}

rt_public void eecatch(long ex)
{
	EIF_GET_CONTEXT
	/* Catch exception `ex' */

	if (eedefined(ex) == (char) 1){
		ex_ign[ex] = 0;
		if (ex == EN_FLOAT)
			(void) signal(SIGFPE, exfpe);
	}
}

rt_public void eeignore(long ex)
{
	EIF_GET_CONTEXT

	/* Ignore exception `ex' */
	if (eedefined(ex) == (char) 1){
		ex_ign[ex] = 1;
		if (ex == EN_FLOAT)
			(void) signal(SIGFPE, SIG_IGN);
	}
}

rt_private char eedefined(long ex)
{
	/* Is exception `ex' defined? */

	return (char) ((ex > 0 && ex <= EN_NEX)? 1 : 0);
}

/*---------------------------------------------*/
/*											 */
/* The  following is used by Concurrent Eiffel */
/*											 */
/*---------------------------------------------*/
#ifdef CONCURRENT_EIFFEL
rt_private void cur_print_top(void);		/* Prints top value of the stack for Concurrency*/

/* Strings used as separator for Eiffel stack dumps */
rt_private char *cur_retried =
"\n===============================================================================";
rt_private char *cur_failed =
"\n-------------------------------------------------------------------------------";
rt_private char *cur_branch_enter =
"\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ entering level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
rt_private char *cur_branch_exit =
"\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ back to level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";

void get_call_stack(void) {
	char buf[200];
	if (echmem & MEM_FSTK) {
		extend_string(&_concur_call_stack, "\nDue to a lack of memory, the sequence is incomplete near the end");
	}
	if (echmem & MEM_FULL) {
		if (echmem & MEM_FSTK) {
			extend_string(&_concur_call_stack, "\nMoreover, an 'out of memory' may have led to an untrustworthy stack");
		} else {
			extend_string(&_concur_call_stack, ".\nHowever, an 'out of memory' occurred and might have spoilt the stack");
		}
	}
	if (echmem & MEM_PANIC) {
		extend_string(&_concur_call_stack, "\nNB: The raised panic may have induced completely inconsistent information");
	}
	echmem |= MEM_PANIC;
	(void) backtrack();

	/* Dump the Eiffel exception trace stack once a system failure has occurred .
	 * Due to the upside-down nature of this stack, we need to use the 'st_bot'
	 * field of the xstack structure.
	 */

	/* Initializes the eif_trace structure's field st_bot correctly. It is the
	 * current bottom of the stack, which appears to be the topmost exception
	 * to be printed by this dumping routine...
	 */
	eif_trace.st_bot = eif_trace.st_hd->sk_arena;   /* Very first item */
   eif_trace.st_cur = eif_trace.st_hd;			 /* Is now where bottom is */
	eif_trace.st_end = eif_trace.st_cur->sk_end;

	/* Print header of history table */
	extend_string(&_concur_call_stack, cur_failed);
	sprintf(buf, "\n%-19.19s %-22.22s %-29.29s %-6.6s",
		"Class / Object", "Routine", "Nature of exception", "Effect");
	extend_string(&_concur_call_stack, buf);

	extend_string(&_concur_call_stack, cur_failed);

	/* Print body of history table. A little look-ahead is necessary, in order
	 * to give meaningful routine names and effects (retried, rescued, cur_failed).
	 */

	eif_except.previous = 0;		/* Previous exception code */
	cur_recursive_dump(0);		  /* Recursive dump, starting at level 0 */

}

cur_recursive_dump(register1 int level)
{
	char buf[200];
	/* Prints the stack trace of a given level. Whenever a new level is reached ,
	 * we call us recursively, hence the name of the routine. The exception
	 * structure is saved (on the C stack) before entering in the recursion.
	 * While the calling stack cannot be inconsistant (otherwise it's a panic),
	 * the exception stack may well be, in case we ran out of memory.
	 */

	struct ex_vect *trace;	  /* Call on top of the stack */

	for (
		find_call(), trace = eif_trace.st_bot;
		trace != eif_trace.st_top;
		trace = eif_trace.st_bot
	) {
		eif_except.code = trace->ex_type;   /* Record exception code */
		eif_except.tag = (char *) 0;		/* No tag by default */

		switch (trace->ex_type) {
		case EN_ILVL:				   /* Entering new level */
			/* The stack may end with such a beast, so detect this and return
			 * if we reached the last item in the stack.
			 */
			(void) exnext();			/* Skip pseudo-vector "New level" */
			if (exend())
				return;				 /* Exit if at the end of the stack */
			sprintf(buf, cur_branch_enter, trace->ex_lvl);
			extend_string(&_concur_call_stack, buf);
			extend_string(&_concur_call_stack, cur_failed);
			recursive_dump(level + 1);  /* Dump the new level */
			sprintf(buf, cur_branch_exit, level);
			extend_string(&_concur_call_stack, buf);
			extend_string(&_concur_call_stack, cur_failed);
			find_call();				/* Restore global exception structure */
			break;
		case EN_OLVL:				   /* Exiting a level */
			(void) exnext();			/* Skip pseudo-vector "Exit level" */
			return;					 /* Recursion level decreases */
			/* NOTREACHED */
		case EN_RES:					/* Resumption attempt */
		case EN_FAIL:				   /* Routine call */
		case EN_RESC:				   /* Exception in rescue */
			cur_print_top();				/* Print exception trace */
			find_call();				/* Look for new enclosing call */
			break;
		case EN_SIG:					/* Signal received */
			eif_except.tag = signame(trace->ex_sig);
			cur_print_top();
			break;
		case EN_SYS:					/* Operating system error */
		case EN_IO:					 /* I/O error */
			eif_except.tag = error_tag(trace->ex_errno);
			cur_print_top();
			break;
		case EN_CINV:				   /* Class invariant violated */
			eif_except.obj_id = trace->ex_oid;  /* Do we need this? */
			/* Fall through */
		case EN_PRE:					/* Precondition violated */
			eif_except.tag = trace->ex_name;
			cur_print_top();
			find_call();				/* Restore correct object ID */
			break;
		case EN_BYE:
		case EN_FATAL:
			eif_except.tag = echtg;		 /* Tag for panic or fatal error */
			cur_print_top();
			break;
		default:
			eif_except.tag = trace->ex_name;
			cur_print_top();
		}
	}
}

rt_private void cur_print_top(void)
{
	/* Prints the exception trace described by the top frame of the exception
	 * stack and the exception context built.
	 * The exception tag is limited to 26 characters, the class name to 19 and
	 * the routine name to 22 characters. These should be #defined--RAM, FIXME.
	 */

	char cur_buf[200];
	char rout_name_buffer[256];		/* To add line number at end of routine name */
#ifdef WORKBENCH
	int line_number;
#endif
	char code = eif_except.code;	/* Exception's code */
	struct ex_vect *top;			/* Top of stack */

	/* Do not print anything if the retry flag is on and the previous exception
	 * was not not a routine failure nor a resumption attempt cur_failed. Indeed,
	 * the exception that led to a retry has already been printed and we do
	 * not want to see two successive 'retry' lines.
	 * Similarily, a rescued routine fails, and is not 'rescued' at the end
	 * of the rescue clause.
	 */
	if (
		eif_except.retried &&		   /* Call has been retried */
		eif_except.previous != 0 &&	 /* Something has been already printed */
		eif_except.previous != EN_FAIL && eif_except.previous != EN_RES
	) {
		(void) exnext();	/* Remove the top */
		return;		/* We already printed the retry line */
	}

	eif_except.previous = code;	 /* Update previous exception code */
#ifdef WORKBENCH
	line_number = (eif_trace.st_bot)->ex_linenum;
#endif

#ifdef WORKBENCH
	/* create the 'routine_name@line_number' string */
	if (line_number>0)
		/* the line number seems valid, so we are going to print it */
		sprintf(rout_name_buffer, "%s @%d", eif_except.rname, line_number);
	else
		/* the line number is not valid, so we are forgetting it */
#endif
		sprintf(rout_name_buffer, "%s", eif_except.rname);

	if (eif_except.tag)
		sprintf(buf, "%.28s:", eif_except.tag);
	else
		buf[0] = '\0';

	if (eif_except.from >= 0)
		if (eif_except.obj_id) {
			int obj_dtype = Dtype(eif_except.obj_id);

			if (obj_dtype>=0 && obj_dtype < scount) {
				sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
					  Class(eif_except.obj_id), rout_name_buffer, buf);
				extend_string(&_concur_call_stack, cur_buf);
			}
			else {
				sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
						"Invalid object", rout_name_buffer, buf);
				extend_string(&_concur_call_stack, cur_buf);
			}
		}
		else {
			sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
					"Invalid object", rout_name_buffer, buf);
			extend_string(&_concur_call_stack, cur_buf);
		}
	else {
		sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
			   "RUN-TIME", rout_name_buffer, buf);
		extend_string(&_concur_call_stack, cur_buf);
	}

	/* There is no need to compute the origin of a routine if it is the same
	 * as the current class. To detect this, we do pointer comparaison to
	 * statically allocated strings (faster than a strcmp).
	 * As a matter of style, the macros 'Class', 'System' etc... are not
	 * all uppercased because there is no side effect, and they could be
	 * functions--RAM.
	 */

	buf[0] = '\0';

	if (eif_except.from >= 0)
		if (eif_except.obj_id) {
			if (eif_except.from != Dtype(eif_except.obj_id))
				sprintf(buf, "(From %.15s)", Origin(eif_except.from));
		} else
			sprintf(buf, "(From %.15s)", Origin(eif_except.from));

	sprintf(cur_buf, "\n<%08X>		  %-22.22s %-29.29s ",
		eif_except.obj_id, buf, exception_string(code));
	extend_string(&_concur_call_stack, cur_buf);

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

	if (echval == EN_BYE) {	 /* A run-time panic was raised */
		if (eif_except.last)
			extend_string(&_concur_call_stack, cur_failed); /* Good bye! */
		else {
			sprintf(cur_buf, "Panic%s", cur_failed);   /* Panic propagation */
			extend_string(&_concur_call_stack, cur_buf);
		}
		return;
	} else if (echval == EN_FATAL) {
		if (eif_except.last) {
			sprintf(cur_buf, "Bye%s", cur_failed); /* Good bye! */
			extend_string(&_concur_call_stack, cur_buf);
		}
		else {
			sprintf(cur_buf, "Fatal%s", cur_failed);   /* Fatal propagation */
			extend_string(&_concur_call_stack, cur_buf);
		}
		return;
	} else if (eif_except.last) {					   /* Last record => exit */
		sprintf(cur_buf, "Exit%s", cur_failed);
		extend_string(&_concur_call_stack, cur_buf);
		return;
	} else if (code == EN_FAIL || code == EN_RES) {
		if (eif_except.retried) {
			sprintf(cur_buf, "Retry%s", cur_retried);
			extend_string(&_concur_call_stack, cur_buf);
		}
		else if (eif_except.rescued) {
			sprintf(cur_buf, "Rescue%s", cur_failed);
			extend_string(&_concur_call_stack, cur_buf);
		}
		else {
			sprintf(cur_buf, "Fail%s", cur_failed);
			extend_string(&_concur_call_stack, cur_buf);
		}
		return;
	}

	/* We need some lookhead to exactely print retry or rescue once. We want
	 * to print a "retry" or "rescue" if and only if the next record in the
	 * stack (pointed at by 'top') is a retry or routine record.
	 */

	top = eif_trace.st_bot;	 /* Look ahead */
	code = top->ex_type;


	if (code == EN_FAIL || code == EN_RES) {
		if (eif_except.retried) {
			sprintf(cur_buf, "Retry%s", cur_retried);
			extend_string(&_concur_call_stack, cur_buf);
		}
		else {
			sprintf(cur_buf, "Fail%s", cur_failed);
			extend_string(&_concur_call_stack, cur_buf);
		}
	} else {
		sprintf(cur_buf, "Pass%s", cur_failed);
		extend_string(&_concur_call_stack, cur_buf);
	}
}

#endif

