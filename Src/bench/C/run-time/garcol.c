/*

  ####     ##    #####    ####    ####   #                ####
 #    #   #  #   #    #  #    #  #    #  #               #    #
 #       #    #  #    #  #       #    #  #               #
 #  ###  ######  #####   #       #    #  #        ###    #
 #    #  #    #  #   #   #    #  #    #  #        ###    #    #
  ####   #    #  #    #   ####    ####   ######   ###     ####

	Garbage collection routines.

	If this file is compiled with -DTEST, it will produce a standalone
	executable.
*/


#include "eif_portable.h"
#include "eif_project.h" /* for egc_prof_enabled */
#include "eif_eiffel.h"		/* For bcopy/memcpy */
#include "eif_globals.h"
#include "eif_misc.h"	
#include "eif_size.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "rt_types.h"
#include "rt_threads.h"
#include "eif_lmalloc.h"	/* for eif_free */
#include "eif_memory.h"
#if ! defined CUSTOM || defined NEED_TIMER_H
#include "eif_timer.h"
#endif
#include "eif_macros.h"
#include "eif_sig.h"
#include "eif_urgent.h"
#include "eif_search.h"
#include "eif_gen_conf.h"	/* For eif_gen_conf_cleanup () */
#include "eif_cecil.h"
#include "x2c.h"		/* For macro LNGPAD */
#ifdef VXWORKS
#include <string.h>
#endif

#include <stdio.h>		/* For stream flushing */

#include "rt_assert.h" 				/* For assertions checking. */
#ifdef EIF_REM_SET_OPTIMIZATION
#include "eif_special_table.h" 		/* For special table interface. */
#endif	/* EIF_REM_SET_OPTIMIZATION */
#if ! defined CUSTOM || defined NEED_OPTION_H
#include "eif_option.h"		/* For exitprf */
#endif
#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
#include "eif_object_id.h"	/* For the object id and separate stacks */
#endif
#include "eif_hector.h"
#include "rt_main.h"

#ifdef WORKBENCH
#include "eif_interp.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_ASSERTIONS
extern EIF_BOOLEAN has_object (struct stack *, EIF_REFERENCE); 
#endif

#ifdef EIF_WIN32
extern void eif_cleanup(void); /* %%ss added. In extra/win32/console/argcargv.c */
#endif

/* Select recursive marking is none is choosen */
#ifndef HYBRID_MARKING
#ifndef ITERATIVE_MARKING
#define RECURSIVE_MARKING
#endif
#endif

/* Make sure only one marking method is active */
#ifdef RECURSIVE_MARKING
#undef ITERATIVE_MARKING
#undef HYBRID_MARKING
#define MARK_SWITCH recursive_mark
#define GEN_SWITCH generation_mark
#endif

#ifdef HYBRID_MARKING
#undef RECURSIVE_MARKING
#undef ITERATIVE_MARKING
#define MARK_SWITCH hybrid_mark
#define GEN_SWITCH hybrid_gen_mark
#endif

#ifdef ITERATIVE_MARKING
#undef RECURSIVE_MARKING
#undef HYBRID_MARKING
#warning "Iterative marking"
#define MARK_SWITCH iterative_mark
#define GEN_SWITCH it_gen_mark
#if LNGSIZ == 4
#define LAST_REF 0x80000000
#else
#define LAST_REF 0x8000000000000000
#endif
#define fdprintf(n,p) \
	if ( \
			DEBUG & (n) && MARK_DEBUG & (p) \
	) printf
#ifndef EIF_THREADS
rt_private struct stack path_stack = {	/* Keeps track of explored nodes */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
rt_private struct stack parent_expanded_stack = {	/* Records expanded parents */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
#endif /* EIF_THREADS */
#endif	/* ITERATIVE_MARKING */

/*#define DEBUG 63 */				/* Debugging level */
/*#define MEMCHK		*/		/* Activate memory checking */
/*#define MEM_STAT		*/		/* Activate Eiffel memory monitoring */
/* Internal data structure used to monitor the activity of the garbage
 * collection process and help the auto-adaptative algorithm in its
 * decisions (heuristics).
 */
rt_shared struct gacinfo g_data = {			/* Global status */
	0L,			/* nb_full */
	0L,			/* nb_partial */
	0L,			/* mem_used */
	0,			/* gc_to */
	(char) 0,	/* status */
};
rt_shared struct gacstat g_stat[GST_NBR] = {	/* Run-time statistics */
	{
		0L,		/* mem_used */
		0L,		/* mem_collect */		 0L,		/* mem_avg */
		0L,		/* real_avg */			 0L,		/* real_time */
		0L,		/* real_iavg */			 0L,		/* real_itime */
		0.,		/* cpu_avg */			 0.,		/* sys_avg */
		0.,		/* cpu_iavg */			 0.,		/* sys_iavg */
		0.,		/* cpu_time */			 0.,		/* sys_time */
		0.,		/* cpu_itime */			 0.,		/* sys_itime */
	},
	{
		0L,		/* mem_used */
		0L,		/* mem_collect */		 0L,		/* mem_avg */
		0L,		/* real_avg */			 0L,		/* real_time */
		0L,		/* real_iavg */			 0L,		/* real_itime */
		0.,		/* cpu_avg */			 0.,		/* sys_avg */
		0.,		/* cpu_iavg */			 0.,		/* sys_iavg */
		0.,		/* cpu_time */			 0.,		/* sys_time */
		0.,		/* cpu_itime */			 0.,		/* sys_itime */
	}
};

/* The following structs are used as stack by the garbage collector.
 * The only public one is the stack for local variables. The others
 * are used internally. All these points to objects which may be moved by
 * the garbage collector or the memory management routines.
 */

#ifndef EIF_THREADS
rt_shared struct stack loc_stack = {			/* Local indirection stack */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
rt_public struct stack loc_set = {				/* Local variable stack */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
rt_public struct stack once_set = {			/* Once functions */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
#else
	/* Same as above except that GC keeps track of all thread specific stack to
	 * perform a GC cycle among all threads */
rt_public struct stack_list loc_stack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
rt_public struct stack_list loc_set_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
rt_public struct stack_list once_set_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
rt_public struct stack global_once_set = {			/* Once functions */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};

	/* Other containers needed by GC but are not specific to garcol */
	/* hector.c */
rt_public struct stack_list hec_stack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
rt_public struct stack_list hec_saved_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};

	/* except.c */
rt_public struct stack_list eif_stack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
rt_public struct stack_list eif_trace_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};

#ifdef WORKBENCH
rt_public struct stack_list opstack_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* threads_stack */
};
#endif

#endif

rt_private struct stack rem_set = {			/* Remembered set */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};

#ifdef EIF_REM_SET_OPTIMIZATION
rt_private struct special_table *special_rem_set = NULL;
			/* Remembered special table for special objects. */ 
#endif

rt_shared struct stack moved_set = {			/* Moved objects set */ 
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};

#ifdef EIF_MEMORY_OPTIMIZATION
	/********************************************************************
	 * Memory set: Record memory objects in the GS zone.		 		*
	 * It is traversed to call the 'dispose' routine when it is garbage.*
	 ********************************************************************/
rt_public struct stack memory_set = 
{
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,			/* st_top */
	(EIF_REFERENCE *) 0,			/* st_end */
};
#endif	/* EIF_MEMORY_OPTIMIZATION */

#ifdef EIF_THREADS
rt_public EIF_MUTEX_TYPE *eif_gc_mutex = NULL;	/* Mutex used to protect GC collection or allocation */
rt_public EIF_MUTEX_TYPE *eif_global_once_mutex = NULL;	/* Mutex used to protect insertion and computation of global onces. */
#endif

/* Array used to store the number of objects used, indexed by object's age.
 * This is used when computing the demographic feedback-mediated tenuring
 * threshold for the next step (generation collcetion). The size_table array
 * is used by the generation scavenging algorithm.
 */

rt_private uint32 age_table[TENURE_MAX];		/* Number of objects/age */ 
rt_private uint32 size_table[TENURE_MAX];		/* Amount of bytes/age */ 
rt_shared int tenure;				/* Maximum age for tenuring.
									 * Initialized in main.c	*/ 
											
rt_public long plsc_per;				/* Period of plsc in acollect
										 * Initialized in main.c. */
rt_public int gc_running = 0;			/* Is the GC running */ 
rt_public double last_gc_time = 0; 		/* The time spent on the last collect, 
										 * sweep or whatever the GC did */ 
rt_public int gc_ran = 0;				/* Has the GC been running */ 
rt_public EIF_INTEGER clsc_per;			/* Period of full coalescing: 0 => never. */

/* Spoilt chunks are put into a search table, to avoid taking them as 'from'
 * space more than once: for each spoilt chunk we find, we have to allocate a
 * new 'to' zone at the next partial scavenge.
 */

rt_private struct s_table *spoilt_tbl = (struct s_table *) 0;

/* Zones used for partial scavenging */
rt_shared struct sc_zone ps_from;		/* From zone */ 
rt_shared struct sc_zone ps_to;		/* To zone */ 
rt_shared struct chunk *last_from =
	(struct chunk *) 0;				/* Last 'from' used by partial scavenging */ 

rt_public long th_alloc;		/* Allocation threshold before calling GC.
								 * Initialized in main.c */
rt_public int gc_monitor = 0;		/* Disable GC time-monitoring by default */ 
rt_public EIF_REFERENCE root_obj = NULL;	
									/* Address of the 'root' object */ 

#ifdef DEBUG
rt_private int nb_items(register1 struct stack *);	
#endif
									/* Number of items held in a stack */
#ifdef EIF_REM_SET_OPTIMIZATION
rt_shared int is_in_rem_set (EIF_REFERENCE obj);	/* Is obj in rem_set? */
rt_shared int is_in_special_rem_set (EIF_REFERENCE obj);
									/* Is obj in special_rem_set? */

/* Automatic invokations of GC */
#endif	/* EIF_REM_SET_OPTIMIZATION */
rt_public int acollect(void);				/* Collection based on threshold */
rt_public int scollect(int (*gc_func) (void), int i);				/* Collect with statistics */

/* Stopping/restarting the GC */
rt_public void gc_stop(void);				/* Stop the garbage collector */
rt_public void gc_run(void);				/* Restart the garbage collector */

/* Mark and sweep */
rt_public void mksp(void);					/* The mark and sweep entry point */
rt_private int mark_and_sweep(void);		/* Mark and sweep algorithm */
rt_public void reclaim(void);				/* Reclaim all the objects */
rt_private void full_mark(EIF_CONTEXT_NOARG);			/* Marks all reachable objects */
rt_private void full_sweep(void);			/* Removes all un-marked objects */
rt_private void run_collector(void);		/* Wrapper for full collections */
rt_private void clean_up(void);			/* After collection, time to clean up */

/* Stack markers */
rt_private void mark_simple_stack(register5 struct stack *stk, register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register6 int move);	/* Marks a collector's stack */
rt_private void mark_stack(register5 struct stack *stk, register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register6 int move);			/* Marks a collector's stack */
#ifdef EIF_REM_SET_OPTIMIZATION
rt_private void mark_special_table (register struct special_table *spt, 
									register EIF_REFERENCE (*marker) (EIF_REFERENCE),
									register int move);
										/* Mark special table. */
#endif	/* EIF_REM_SET_OPTIMIZATION */
#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
rt_private void update_object_id_stack(void); /* Update the object id stack */
#endif
/* Storage compation reclaimer */
rt_public void plsc(void);					/* Storage compaction reclaimer entry */
rt_private int partial_scavenging(void);	/* The partial scavenging algorithm */
rt_private void run_plsc(void);			/* Run the partial scavenging algorithm */
rt_shared void urgent_plsc(EIF_REFERENCE *object);			/* Partial scavenge with given local root */
rt_private void init_plsc(void);			/* Initialize the scavenging process */
rt_private void clean_zones(void);			/* Clean up scavenge zones */
rt_private EIF_REFERENCE scavenge(register EIF_REFERENCE root, struct sc_zone *to);			/* Scavenge an object */
/*rt_private void clean_space();*/			/* Sweep forwarded objects */ /* %%ss undefine */
rt_private void full_update(void);			/* Update scavenge-related structures */
rt_private void split_to_block(void);		/* Keep only needed space in 'to' block */
rt_private int sweep_from_space(void);		/* Clean space after the scavenging */
rt_private int find_scavenge_spaces(void);	/* Find a pair of scavenging spaces */
rt_private struct chunk *find_std_chunk(register struct chunk *start);	/* Look for a standard-size chunk */
#if !(defined EIF_NO_SCAVENGING  || defined EIF_THREADS)
rt_private void find_to_space(struct sc_zone *to);		/* Find standard-size 'to' chunks */
#endif

/* Generation based collector */
rt_public int collect(void);				/* Generation based collector main entry */
rt_private int generational_collect(void);	/* The generational collection algorithm */
rt_public void eremb(EIF_REFERENCE obj);				/* Remember an old object */
rt_public void erembq(EIF_REFERENCE obj);				/* Quick version (no GC call) of eremb */
rt_public void special_erembq(EIF_REFERENCE obj, EIF_INTEGER offst);				
									/* Quick version (no GC call) of eremb 
									 * for special objects full of references.*/
#ifdef EIF_REM_SET_OPTIMIZATION
rt_public int special_rem_remove (EIF_REFERENCE obj);
			/* Remove `obj' in special_rem_set. */
rt_public int special_erembq_replace(EIF_REFERENCE old, EIF_REFERENCE val);
			/* Replace `old' by `val' in special_rem_set. */
rt_private int update_special_rem_set(void);	
					/* Update remembered set for special object full of references.*/
#endif	/* EIF_REM_SET_OPTIMIZATION */
#ifdef EIF_MEMORY_OPTIMIZATION
rt_private void update_memory_set (void);		/* Update memory set */
#endif	/* EIF_MEMORY_OPTIMIZATION */
rt_private void mark_new_generation(EIF_CONTEXT_NOARG);	/* The name says it all, I think--RAM */
rt_private EIF_REFERENCE mark_expanded(EIF_REFERENCE root, EIF_REFERENCE (*marker) (EIF_REFERENCE));		/* Marks expanded reference in stack */
rt_private void update_moved_set(void);	/* Update the moved set (young objects) */
rt_private void update_rem_set(void);		/* Update remembered set */
#ifdef EIF_ASSERTIONS
rt_private int refers_new_object_not_updated(register EIF_REFERENCE object);
#ifdef EIF_EXPENSIVE_ASSERTIONS
rt_private int	all_subreferences_processed (EIF_REFERENCE root);
#endif
#endif
rt_shared int refers_new_object(register EIF_REFERENCE object);		/* Does an object refers to young ones ? */
rt_private EIF_REFERENCE gscavenge(EIF_REFERENCE root);			/* Generation scavenging on an object */
rt_private void swap_gen_zones(void);		/* Exchange 'from' and 'to' zones */
rt_shared EIF_REFERENCE to_chunk(void);			/* Address of the chunk holding 'to' */

/* Dealing with dispose routine */
rt_shared void gfree(register union overhead *zone);				/* Free object, eventually call dispose */

/* Stack handling routines */
rt_shared int epush(register struct stack *stk, register EIF_REFERENCE value);				/* Push value on stack */
rt_shared EIF_REFERENCE *st_alloc(register struct stack *stk, register int size);		/* Creates an empty stack */
rt_shared void st_truncate(register struct stack *stk);		/* Truncate stack if necessary */
rt_shared void st_wipe_out(register struct stchunk *chunk);		/* Remove unneeded chunk from stack */
rt_shared int st_extend(register struct stack *stk, register int size);			/* Extends size of stack */

/* Marking algorithm */
#ifdef RECURSIVE_MARKING
rt_private EIF_REFERENCE recursive_mark(EIF_REFERENCE root);	/* Recursively mark reachable objects */
rt_private EIF_REFERENCE generation_mark(EIF_REFERENCE root);	/* A recursive mark with on-the-fly copy */
#endif

#ifdef HYBRID_MARKING
rt_private EIF_REFERENCE hybrid_mark(EIF_REFERENCE root);		/* Mark all reachable objects */
rt_private EIF_REFERENCE hybrid_gen_mark(EIF_REFERENCE root);	/* hybrid_mark with on-the-fly copy */
#endif

#ifdef ITERATIVE_MARKING
rt_private EIF_REFERENCE iterative_mark(EIF_REFERENCE root);	/* Iteratively mark reachable objects */
rt_private EIF_REFERENCE it_gen_mark(EIF_REFERENCE root);		/* Iterative mark with on-the-fly copy */
rt_private EIF_REFERENCE ntop(register1 struct stack *stk);	/* Returns the top element of a stack */
rt_private EIF_REFERENCE nget(register1 struct stack *stk);	/* Pops the top element of a stack */
#endif

rt_private void mark_ex_stack(register5 struct xstack *stk, register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register6 int move);		/* Marks the exception stacks */

#ifdef WORKBENCH
rt_private void mark_op_stack(struct opstack *stk, register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register5 int move);		/* Marks operational stack */

#ifdef CONCURRENT_EIFFEL
#define DISP(x,y) \
	(x == scount)?sep_obj_dispose(y):call_disp(x,y)
#else
#define DISP(x,y) call_disp(x,y)
#endif

#else
/* Does the exception stack need to be traversed to update references to
 * moving objects (i.e. set to False if no assertion and exception_trace(yes)
 * is not used in the Ace file
 */

#define DISP(x,y) ((void *(*)())Dispose(x))(y)

#endif

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	63		/* Highest debug level */
#endif
#endif

#ifdef DEBUG
#define NB_FULL		0
#define NB_PARTIAL	1

#define debug_ok(n)	( \
	(n) & DEBUG || \
	(g_data.nb_full == NB_FULL && fdone || g_data.nb_partial == NB_PARTIAL) \
	)
#define dprintf(n)	\
	if ( \
			DEBUG & (n) && debug_ok(n)\
	) printf 
#define flush			fflush(stdout);

static int fdone = 0;	/* Tracing flag to only get the last full collect */
#endif


/* Function(s) used only in DEBUG mode */
#ifdef DEBUG
#ifndef MEMCHK
#define memck(x)	;				/* No memory checking compiled */
#endif
#endif

#ifdef TEST
/* This is to make tests */
#undef References
#undef Size
#define References(type)	2				/* Number of references in object */
#define Size(type)			40				/* Size of the object */
#define Dispose(type)	((void (*)()) 0)	/* No dispose routine */
#endif

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/*
 * Automatic collection and statistics routines.
 */

rt_public int acollect(void)
{
	/* This is the main dispatcher for garbage collection. Calls are based on
	 * a threshold th_alloc. Statistics are gathered while performing
	 * collection. We run the collect() most of the time (for a generational
	 * mark and sweep and/or a generation scavenging) and a full collection
	 * once every 'plsc_per' (aka the period) calls.
	 * The function returns 0 if collection was done, -1 otherwise.
	 */
	static long nb_calls = 0;		/* Number of calls to function */
	static long eif_total = 0;		/* Total Eiffel memory allocated */
	int status;						/* Status returned by scollect() */
#ifdef EIF_CONDITIONAL_COLLECT
	int freemem;					/* Amount of free memory */
	int tau;						/* Mean allocation rate */
	int half_tau;					
	int allocated;					/* Memory used since last full collect */
#endif	/* EIF_CONDITIONAL_COLLECT */
	if (g_data.status & GC_STOP)
#ifdef DEBUG
	{
		dprintf(1)("acollect: Nothing has to be done because GC_STOP\n");
#endif
		return -1;					/* Garbage collection stopped */
#ifdef DEBUG
	}
#endif

#ifdef DEBUG
	dprintf(1)("acollect: automatic garbage collection with %s\n",
		nb_calls % plsc_per ? "generation collection" : "partial scavenging");
	flush;
#endif

	/* If the Eiffel memory free F is such that F > (.5 * P * T), where P is
	 * the period of full collections 'plsc_per' and T is the allocation
	 * threshold 'th_alloc', and F < (1.5 * P * T) then nothing is done. Thus
	 * we do collections only when a small amount of free memory is left or
	 * when a large amout is free (in the hope we'll be able to give some of
	 * this memory to the kernel).
	 * However, we have to counter balance this scheme with the extra amount of
	 * memory allocated since the last full collection. Whenever it is more
	 * than (P * T), we want to run a collection since some garbage might have
	 * been created.
	 */

#ifdef EIF_CONDITIONAL_COLLECT
	freemem = e_data.ml_total - e_data.ml_used - e_data.ml_over;
	tau = plsc_per * th_alloc;
	half_tau = tau >> 1;
	allocated = e_data.ml_total - eif_total;

	if (allocated < tau && freemem > half_tau && freemem < (tau + half_tau)) {

#ifdef DEBUG
		dprintf(1)("acollect: skipping call (%d bytes free)\n", freemem);
#endif
		return -1;	/* Do not perform collection */ /* %%ss -1 was 0 */
	}
#endif
	/* Every "plsc_per" collections, we ran a full collection.
	 * This period can be set by the user.
	 */

	if (plsc_per)						/* Can we run full collections?.*/
	{
		if (0 == nb_calls % plsc_per) {	/* Full collection required */
			plsc();
			status = 0;
			eif_total = e_data.ml_total;
		} else							/* Generation-base collector */
			status = collect();
	} else							/* Generation-base collector called, since
									 * there is no Full Collection. */
		status = collect();


	/* We may want to run periodically a full coalescing (Eiffel and C objects).
	 * Note that the user can also set his own period of full coalescing. 
	 */

	if (clsc_per && nb_calls)	/* Do not coalesce at the first collection. 
								 * It may corrupt the memory. */
	{
			if (0 == nb_calls % clsc_per)
				full_coalesc (ALL_T);
	}
#ifdef DEBUG
	dprintf(1)("acollect: returning status %d\n", status);
#endif

	nb_calls++;			/* Records the call */

	return status;		/* Collection done, forward status */
}

rt_public int scollect(int (*gc_func) (void), int i)
				 		/* The collection function to be called */
						/* Index in g_stat array where statistics are kept */
{
	/* Run a garbage collection cycle with statistics updating. We monitor
	 * both the time spent in the collection and the memory released,
	 * if any, as well as time between two collections...
	 * Return the status given by the collection function.
	 */

	static uint32 nb_stats[GST_NBR];	/* For average computation */
#ifndef FAST_RUNTIME
	static Timeval lastreal[GST_NBR];	/* Last real time of invocation */
	Timeval realtime, realtime2;		/* Real time stamps */
	double usertime, systime;			/* CPU stats before collection */
	double usertime2, systime2;			/* CPU usage after collection */
	static double lastuser[GST_NBR];	/* Last CPU time for last call */
	static double lastsys[GST_NBR];		/* Last kernel time for last call */
#endif
	long mem_used;						/* Current amount of memory used */
	int status;							/* Status reported by GC function */
	struct gacstat *gstat = &g_stat[i];	/* Address where stats are kept */
	int nbstat;							/* Current number of statistics */

	if (g_data.status & GC_STOP)
		return -1;						/* Garbage collection stopped */

	mem_used = m_data.ml_used + m_data.ml_over;		/* Count overhead */
	nbstat = ++nb_stats[i];							/* One more computation */

	/* Reset scavenging-related figures, since those will be updated by the
	 * scavenging routines when needed.
	 */

	g_data.mem_move = 0;				/* Memory subject to scavenging */
	g_data.mem_copied = 0;				/* Amount of that memory which moved */

#ifndef FAST_RUNTIME
	/* Get the current time before CPU time, because the accuracy of the
	 * real time clock is usually less important than the one used for CPU
	 * accounting.
	 */

	if (gc_monitor) {
		gettime(&realtime);					/* Get current time stamp */
		getcputime(&usertime, &systime);	/* Current CPU usage */
	}
#endif

#ifdef MEMCHK
#ifdef DEBUG
	dprintf(1)("scollect: before GC\n");
	memck(0);
#endif
#endif

	status = (gc_func)();				/* GC invocation */

#ifdef MEMCHK
#ifdef DEBUG
	dprintf(1)("scollect: after GC\n");
	memck(0);
#endif
#endif

#ifndef FAST_RUNTIME
	/* Get CPU time before real time, so that we have a more precise figure
	 * (gettime uses a system call)--RAM.
	 */

	if (gc_monitor) {
		getcputime(&usertime2, &systime2);	/* Current CPU usage */
		gettime(&realtime2);				/* Get current time stamp */
	}
#endif

	/* Now collect the statistics in the g_stat structure. The real time
	 * field will not be really significant if the time() system call is
	 * used (granularity is one second).
	 * Note that the memory collected can be negative, e.g. at the first
	 * partial scavenging where a scavenge zone is allocated.
	 */

	g_data.mem_used = m_data.ml_used + m_data.ml_over;	/* Total mem used */
	gstat->mem_used = g_data.mem_used;
	gstat->mem_collect = mem_used - g_data.mem_used;	/* Memory collected */
	gstat->mem_collect +=		/* Memory freed by scavenging (with overhead) */
		g_data.mem_copied - g_data.mem_move;
	gstat->mem_avg = ((gstat->mem_avg * (nbstat - 1)) +
		gstat->mem_collect) / nbstat;					/* Average mem freed */
#ifndef FAST_RUNTIME
	if (gc_monitor) {
		gstat->real_time = elapsed(&realtime, &realtime2);
		gstat->cpu_time = usertime2 - usertime;			/* CPU time (user) */
		gstat->sys_time = systime2 - systime;			/* CPU time (kernel) */
	} else {
		gstat->real_time = gstat->real_avg;		/* Adding the average */
		gstat->cpu_time = gstat->cpu_avg;		/* will not change the */
		gstat->sys_time = gstat->sys_avg;		/* computation done so far */
	}
	gstat->real_avg = ((gstat->real_avg * (nbstat - 1)) +
		gstat->real_time) / nbstat;						/* Average real time */
	gstat->cpu_avg = ((gstat->cpu_avg * (nbstat - 1)) +
		gstat->cpu_time) / nbstat;						/* Average user time */
	gstat->sys_avg = ((gstat->sys_avg * (nbstat - 1)) +
		gstat->sys_time) / nbstat;						/* Average sys time */


	/* If it is not the first time, update the statistics. First compute the
	 * time elapsed since last call, then update the average accordingly.
	 */

	if (lastuser[i] != 0) {
		if (gc_monitor) {
			gstat->cpu_itime = usertime - lastuser[i];
			gstat->sys_itime = systime - lastsys[i];
			gstat->real_itime = elapsed(&lastreal[i], &realtime);
		} else {
			gstat->cpu_itime = gstat->cpu_iavg;		/* Adding the average */
			gstat->sys_itime = gstat->sys_iavg;		/* does not change the */
			gstat->real_itime = gstat->real_iavg;	/* data we already have */
		}
		gstat->real_iavg = ((gstat->real_iavg * (nbstat - 2)) +
			gstat->real_itime) / (nbstat - 1);
		gstat->cpu_iavg = ((gstat->cpu_iavg * (nbstat - 2)) +
			gstat->cpu_itime) / (nbstat - 1);
		gstat->sys_iavg = ((gstat->sys_iavg * (nbstat - 2)) +
			gstat->sys_itime) / (nbstat - 1);
	}

	/* Record current times for next invokation */

	if (gc_monitor) {
		lastuser[i] = usertime2;		/* User time after last GC */
		lastsys[i] = systime2;			/* System time after last GC */
		memcpy (&lastreal[i], &realtime2, sizeof(Timeval));
	}
#endif /* ifndef FAST_RUNTIME */

#ifdef DEBUG
	dprintf(1)("scollect: statistics for %s\n",
		i == GST_PART ? "partial scavenging" : "generation collection");
	dprintf(1)("scollect: # of full collects: %ld\n", g_data.nb_full);
	dprintf(1)("scollect: # of partial collects: %ld\n", g_data.nb_partial);
	dprintf(1)("scollect: Total mem allocated: %ld bytes\n", m_data.ml_total);
	dprintf(1)("scollect: Total mem used: %ld bytes\n", m_data.ml_used);
	dprintf(1)("scollect: Total overhead: %ld bytes\n", m_data.ml_over);
	dprintf(1)("scollect: Collected: %ld bytes\n", gstat->mem_collect);
	dprintf(1)("scollect: (Scavenging collect: %ld bytes)\n",
		g_data.mem_copied - g_data.mem_move);
	if (gc_monitor) {
		dprintf(1)("scollect: Real time: %lfs\n", gstat->real_time / 100.);
		dprintf(1)("scollect: CPU time: %lfs\n", gstat->cpu_time);
		dprintf(1)("scollect: System time: %lfs\n", gstat->sys_time);
		dprintf(1)("scollect: Average real time: %lfs\n", gstat->real_avg / 100.);
		dprintf(1)("scollect: Average CPU time: %lf\n", gstat->cpu_avg);
		dprintf(1)("scollect: Average system time: %lf\n", gstat->sys_avg);
		dprintf(1)("scollect: Interval time: %lf\n", gstat->real_itime / 100.);
		dprintf(1)("scollect: Interval CPU time: %lf\n", gstat->cpu_itime);
		dprintf(1)("scollect: Interval sys time: %lf\n", gstat->sys_itime);
		dprintf(1)("scollect: Avg interval time: %lf\n", gstat->real_iavg / 100.);
		dprintf(1)("scollect: Avg interval CPU time: %lf\n", gstat->cpu_iavg);
		dprintf(1)("scollect: Avg interval sys time: %lf\n", gstat->sys_iavg);
	}
#endif

	return status;		/* Forward status report */
}

/*
 * Garbage collector stop/run
 */

rt_public void gc_stop(void)
{
	/* Stop the GC -- this should be used in case of emergency only, i.e.
	 * in an exception handler or in a time-critical routine.
	 * Note that when we are in an exception handler, requests to GC controls
	 * are silently ignored anyway (GC is turned off before executing the
	 * signal handler).
	 */

	if (!(g_data.status & GC_SIG))		/* If not in signal handler */
		g_data.status |= GC_STOP;		/* Stop GC */
}

rt_public void gc_run(void)
{
	/* Restart the GC -- the garbage collector should always run excepted in
	 * some critical operations, which should be rare. Anyway, after having
	 * stopped it, here is the way to wake it up. Note that no collection
	 * cycle is raised.
	 * As for gc_stop(), the request is ignored while in the exception handler.
	 * The garbage collector is turned off in that case to avoid the dangling
	 * reference problem--RAM.
	 */

	if (!(g_data.status & GC_SIG))		/* If not in signal handler */
		g_data.status &= ~GC_STOP;		/* Restart GC */
}

/*
 * Mark and sweep garbage collector.
 */

rt_public void mksp(void)
{
	/* The mark and sweep entry. The scollect routine is called in order to
	 * maintain statistics on every call.
	 */

	if (g_data.status & GC_STOP)
		return;						/* Garbage collection stopped */

	(void) scollect(mark_and_sweep, GST_PART);
}

rt_private int mark_and_sweep(void)
{
	/* Uses the mark and sweep algorithm to collect garbage in chunk
	 * space. This is a full-stop algorithm (i.e. non incremental).
	 * The roots for the mark phase are taken from 'root_obj', which is
	 * the address of the root object and 'loc_set', which holds
	 * all the local reference variables. I suppose no object is already
	 * marked at the beginning of the processing.
	 */
	EIF_GET_CONTEXT

	SIGBLOCK;			/* Block all signals during garbage collection */

	/* The idea of having a global status for the garbage collector arose
	 * this afternoon after lunch. Just to say it's not "clean", but it does
	 * avoid code duplication--RAM.
	 */
	g_data.status = (char) ((gen_scavenge & GS_ON) ? GC_GEN : 0);

	run_collector();		/* Call a wrapper to do the job */
	clean_up();				/* Restore signals, release core, etc... */

	return 0;
}

rt_private void clean_up(void)
{
	/* After a collection cycle, we may restore attempt to release some core,
	 * then dispatch signals which may have been stacked while in the GC process
	 * and finally stop blocking signals.
	 */
	EIF_GET_CONTEXT

	rel_core();				/* We may give some core back to the kernel */
	SIGRESUME;				/* Dispatch any signal which has been queued */
}

rt_public void reclaim(void)
{
	/* At the end of the process's lifetime, all the objects need to be
	 * reclaimed, so that all the "dispose" procedures are called to perform
	 * their clean-up job (such as removing locks or temporary files).
	 * As all the objects are unmarked, we simply call full_sweep.
	 * There is no need to explode the scavenge zone as objects held there
	 * are known not to have any dispose routine (cf emalloc).
	 */

	EIF_GET_CONTEXT

	struct chunk *c, *cn;

		/* Mark final collection */
	eif_is_in_final_collect = EIF_TRUE;

	if (gen_scavenge & GS_ON)		/* If generation scaveging was on */
		sc_stop();					/* Free 'to' and explode 'from' space */

#if ! defined CUSTOM || defined NEED_OPTION_H
	if (egc_prof_enabled)
		exitprf();			/* Store profile information */
#endif

	if (eif_no_reclaim || (g_data.status & GC_STOP))	/* Does user want no reclaim? */
		return;	
#ifdef RECLAIM_DEBUG
	fprintf(stderr, "reclaim: collecting all objects...\n");
#endif
		/* Call for the last time the GC through a `full_collect'. It enables
		 * the call to `dispose' routine of remaining objects which defines
		 * the dispose routine. */
	plsc ();

	/* Reset GC status otherwise full_sweep() might skip some memory blocks
	 * (those previously used as partial scavenging areas).
	 */
	g_data.status = (char) 0;
	
	full_sweep();				/* Reclaim ALL the objects in the system */

#ifdef EIF_REM_SET_OPTIMIZATION
	if (special_rem_set)
		spt_free (special_rem_set);	/* Free special_rem_set */
#endif
	eif_free (EIF_once_values); /* have been allocated with eif_malloc */
#ifdef EIF_THREADS 
	CHECK ("Root thread", eif_thr_is_root ());
#endif	/* EIF_THREADS */
	eif_free (starting_working_directory);
	eif_gen_conf_cleanup ();
#ifdef EIF_WIN32
	eif_cleanup(); 
#endif /* EIF_WIN32 */

	for (c = cklst.ck_head; c != (struct chunk *) 0; c = cn) {
		cn = c->ck_next;
#if !defined HAS_SMART_MMAP && !defined HAS_SBRK
		eif_free (c);	/* Previously allocated with eif_malloc. */
#else
		xfree ((EIF_REFERENCE) c);		/* Previously allocated with mmap or sbrk. */
#endif	/* !HAS_SMART_MMAP && !!HAS_SBRK */
	}
	cklst.ck_head = (struct chunk *) 0;

#ifdef EIF_WINDOWS 
	eif_free_dlls();
#endif


#ifdef LMALLOC_CHECK
	eif_lm_display ();
	eif_lm_free ();
#endif	/* LMALLOC_CHECK */

		/* Final collection terminated, unmark the flag */
	eif_is_in_final_collect = EIF_FALSE;
}

rt_private void run_collector(void)
{
	/* Run the mark and sweep collectors, assuming the state is already set.
	 * Provision is made for generation scavenging, as this zone cannot be
	 * collected excepted by using a scavenging algorithm (with no aging).
	 */

	g_data.nb_full++;	/* One more full collection */

#ifdef DEBUG
	fdone = g_data.nb_full == NB_FULL;
	dprintf(1)("run_collector: gen_scavenge: 0x%lx, status: 0x%lx\n",
		gen_scavenge, g_data.status);
	flush;
#endif

	/* If the root object address is void, only run a full sweep. At the end
	 * of the program (when the final disposal is run) or at the beginning
	 * (when allocating some memory in "optimized for memory" mode), the root
	 * object's address will be null and a mark phase does not really make
	 * sense--RAM.
	 */

	full_mark(MTC_NOARG);		/* Mark phase */
	full_update();		/* Update moved and remembered set (BEFORE sweep) */
	full_sweep();			/* Sweep phase */

	/* After a full collection (this routine is only called for a full mark
	 * and sweep or a partial scavenging), give generation scavenging a try
	 * again (in case it was stopped) by clearing the GS_STOP flag.
	 */

	if (gen_scavenge & GS_ON)		/* Generation scavenging is on */
		swap_gen_zones();			/* Swap generation zones */
	gen_scavenge &= ~GS_STOP;		/* Clear any stop flag */
	if (gen_scavenge == GS_OFF)		/* If generation scavenging is off */
		gen_scavenge = GS_SET;		/* Allow emalloc() to give another try */

	ufill();		/* Eventually refill our urgent memory stock */

#ifdef DEBUG
	fdone = 0;		/* Do not trace any further */
#endif
}

rt_private void full_mark(EIF_CONTEXT_NOARG)
{
	/* Mark phase -- Starting from the root object and the subsidiary
	 * roots in the local stack, we recursively mark all the reachable
	 * objects. At the beginning of this phase, it is assumed that no
	 * object is marked.
	 */
#ifdef EIF_THREADS
	int i;
#endif
	int moving = g_data.status & (GC_PART | GC_GEN);	/* Objects may move? */

	root_obj = MARK_SWITCH(root_obj);	/* Primary root */

#ifndef EIF_THREADS
	/* The regular Eiffel variables have their values stored directly within
	 * the loc_set stack. Those variables are the local roots for the garbage
	 * collection process.
	 */
	mark_stack(&loc_set, MARK_SWITCH, moving);

	/* The stack of local variables holds the addresses of variables
	 * in the process's stack which refers to the objects, hence the
	 * double indirection necessary to reach the objects.
	 */
	mark_stack(&loc_stack, MARK_SWITCH, moving);

	/* Once functions are old objects that are always alive in the system.
	 * They are all gathered in a stack and always belong to the old
	 * generation (thus they are allocated from the free-list). As with
	 * locals, a double indirection is necessary.
	 */
#if defined WORKBENCH
	mark_simple_stack(&once_set, MARK_SWITCH, moving);
#else
	mark_stack(&once_set, MARK_SWITCH, moving);
#endif

	/* The hector stacks record the objects which has been given to C and may
	 * have been kept by the C side. Those objects are alive, of course.
	 */
	mark_simple_stack(&hec_stack, MARK_SWITCH, moving);
	mark_simple_stack(&hec_saved, MARK_SWITCH, moving);

#ifdef WORKBENCH
	/* The operational stack of the interpreter holds some references which
	 * must be marked and/or updated.
	 */
	mark_op_stack(&op_stack, MARK_SWITCH, moving);

	/* The exception stacks are scanned. It is more to update the references on
	 * objects than to ensure these objects are indeed alive...
	 */
	mark_ex_stack(&eif_stack, MARK_SWITCH, moving);
	mark_ex_stack(&eif_trace, MARK_SWITCH, moving);

#else
	if (exception_stack_managed) {
		/* The exception stacks are scanned. It is more to update the references on
		 * objects than to ensure these objects are indeed alive...
		 */
		mark_ex_stack(&eif_stack, MARK_SWITCH, moving);
		mark_ex_stack(&eif_trace, MARK_SWITCH, moving);
	}
#endif
#else /* EIF_THREADS */
	for (i = 0; i < loc_set_list.count; i++)
		mark_stack(loc_set_list.threads.sstack[i], MARK_SWITCH, moving);

	for (i = 0; i < loc_stack_list.count; i++)
		mark_stack(loc_stack_list.threads.sstack[i], MARK_SWITCH, moving);

	mark_stack(&global_once_set, MARK_SWITCH, moving);

	for (i = 0; i < once_set_list.count; i++)
		mark_simple_stack(once_set_list.threads.sstack[i], MARK_SWITCH, moving);

	for (i = 0; i < hec_stack_list.count; i++)
		mark_simple_stack(hec_stack_list.threads.sstack[i], MARK_SWITCH, moving);
	for (i = 0; i < hec_saved_list.count; i++)
		mark_simple_stack(hec_saved_list.threads.sstack[i], MARK_SWITCH, moving);

#ifdef WORKBENCH
	for (i = 0; i < opstack_list.count; i++)
		mark_op_stack(opstack_list.threads.opstack[i], MARK_SWITCH, moving);
	for (i = 0; i < eif_stack_list.count; i++)
		mark_ex_stack(eif_stack_list.threads.xstack[i], MARK_SWITCH, moving);
	for (i = 0; i < eif_trace_list.count; i++)
		mark_ex_stack(eif_trace_list.threads.xstack[i], MARK_SWITCH, moving);

#else
	if (exception_stack_managed) {
		for (i = 0; i < eif_stack_list.count; i++)
			mark_ex_stack(eif_stack_list.threads.xstack[i], MARK_SWITCH, moving);
		for (i = 0; i < eif_trace_list.count; i++)
			mark_ex_stack(eif_trace_list.threads.xstack[i], MARK_SWITCH, moving);
	}
#endif

#endif /* EIF_THREADS */

#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
#ifdef CONCURRENT_EIFFEL
	/* The separate_object_id_set records object referenced by other processors */
	mark_simple_stack(&separate_object_id_set, MARK_SWITCH, moving);
#endif

	/* The object id stacks record the objects referenced by an identifier. Those objects
	 * are not necessarily alive. Thus only an update after a move is needed.
	 */
	if (moving) update_object_id_stack();
#endif
}
#ifdef EIF_REM_SET_OPTIMIZATION
rt_private void mark_special_table (register struct special_table *spt, register EIF_REFERENCE (*marker) (EIF_REFERENCE), register int move)
{
	/* 
	 * Mark the special table: The special table is an optmized rem_set
	 * table, which recorded the special objects, full of references and
	 * their indices to the new references that they references. This
	 * prevent from spending time in scanning the old sub-references.
	 * -- ET
	 */
 
	EIF_GET_CONTEXT

	EIF_REFERENCE	*container, ref;			/* Special object. */
	union overhead	*zone;				/* Special object malloc info zone. */
	EIF_INTEGER	ofst;				/* Index of item in special. */
	int		i;				/* Index. */


#ifndef NDEBUG
	int old_count;			/* For postcondition checking */
#endif	/* !NDEBUG */
	REQUIRE ("GC_FAST mode", g_data.status & GC_FAST);

	if (spt == (struct special_table *) 0)	/* Table not created yet. */
		return;

#ifndef NDEBUG
	old_count = spt->count;
#endif
	/* Initialization. */

	REQUIRE ("Not empty", spt->h_keys != (EIF_INTEGER *) 0);
	REQUIRE ("Not empty", spt->h_values != (EIF_REFERENCE *) 0);
	REQUIRE ("Special table coherent", spt->count <= spt->h_size);

#ifdef MARK_SPECIAL_TABLE_DEBUG
	printf ("MARK_SPECIAL_TABLE: count = %d\n", spt->count);
#endif /* MARK_SPECIAL_TABLE_DEBUG */


	for (i = 0; i < spt->count ; i++)
			/* It is very important to access directly to the `count' value 
			 * of the table,since it can increase during the following marking. 
			 * -- ET
		 	 */
	{
		ref = spt->h_values [i];
		CHECK ("ref_not_null", ref != (EIF_REFERENCE) 0);
		zone = HEADER (ref);

#ifdef MARK_SPECIAL_TABLE_DEBUG
	printf ("MARK_SPECIAL_TABLE: object %x\n", ref);
#endif	/* MARK_SPECIAL_TABLE_DEBUG */

		CHECK ("Full of references", zone->ov_flags & EO_REF);
		CHECK ("Special object", zone->ov_flags & EO_SPEC);
		CHECK ("Not forwarded", !(zone->ov_size & B_FWD));
		CHECK ("Not expanded", !(zone->ov_flags & EO_EXP));
		CHECK ("Not composite", !(zone->ov_flags & EO_COMP));
		CHECK ("Old object", zone->ov_flags & EO_OLD);
		CHECK ("Remembered object", zone->ov_flags & EO_REM);
		CHECK ("Eiffel object", !(zone->ov_flags & EO_C));
		

	/***************************************
	 * Marking of special remembered object*
	 ***************************************/

		if (!(zone->ov_flags & EO_MARK))
			/* The object has not been processed yet. 
			 * It must be referenced from an old object. */
		{
			zone->ov_flags |= EO_MARK;	/* Mark it. */	
			CHECK ("Object marked", HEADER (spt->h_values [i])->ov_flags & EO_MARK);
			CHECK ("Object marked", HEADER ((special_rem_set->h_values) [i])->ov_flags & EO_MARK);
		}
		
			
	/****************************************
	 * Marking of items. 					*
	 ****************************************/


		/* Initializations. */

		ofst = spt->h_keys [i];
		if (ofst == -1)
			continue;				/* No new reference, pass it. */
		container = (EIF_REFERENCE *) (ref + ofst * sizeof (EIF_REFERENCE));
		if (*container == (EIF_REFERENCE) 0)
			continue;				/* Skip Void elements. */


#ifdef MARK_SPECIAL_TABLE_DEBUG
/****************************** Debug. *************************************/
		iz = HEADER (*container);	/* Fetch malloc info zone for item. */

		printf("MARK_SPECIAL_TABLE: marking at 0x%x (type %d, %d bytes) %s %s %s %s %s %s %s, \n\t\t\twith item %x, offset %ld (type %d, %d bytes) %s age %ld, %s %s%s %s %s %s\n",
			spt->h_values [i],
			HEADER(
				zone->ov_size & B_FWD ? zone->ov_fwd : spt->h_values [i]
			)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE,
			zone->ov_size & B_FWD ? "forwarded" : "",
			zone->ov_flags & EO_REM ? "rem" : "",
			zone->ov_flags & EO_OLD ? "old" : "",
			zone->ov_flags & EO_MARK ? "marked" : "",
			zone->ov_flags & EO_REF ? "ref" : "",
			zone->ov_flags & EO_COMP ? "cmp" : "",
			zone->ov_flags & EO_SPEC ? "spec" : "",
			*container,
			spt->h_keys [i],
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_TYPE,
			iz->ov_size & B_SIZE,
			iz->ov_size & B_FWD ? "forwarded" : "",
			((HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_AGE) >> 24) / 2,
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_OLD ? "old " : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_REM ? "remembered" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_MARK ? "marked" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_REF ? "ref" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_COMP ? "comp" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : *container
			)->ov_flags & EO_SPEC ? "spec" : ""
		);
#endif	/* MARK_SPECIAL_TABLE_DEBUG */
/************************ End of debug. ********************************/
		


		/* Actual marking and update of items. */

		if (move) 	/* May Item move? */
		{
			if (
				(g_data.status & GC_FAST) &&
				(*container > sc_to.sc_arena) && 
				(*container <= sc_to.sc_end)
			)	
						/* Is it in the generational scavenge `to' zone? */
							
	 		{
						/* Then, it's a twin and it is already processed. */
			
#ifdef MARK_SPECIAL_TABLE_DEBUG
				printf ("MARK_SPECIAL_TABLE:Item %x is already processed!\n", *container);
#endif	/* MARK_SPECIAL_TABLE_DEBUG */

				CHECK ("Not forwarded twice", !(HEADER (*container)->ov_size & B_FWD));	
				CHECK ("Not marked and still in scavenge zone", !(HEADER (*container)->ov_flags & EO_MARK));	
				spt->h_keys [i] = -2;		/* Mark it as a twin, -2 by convention. */
				continue;			/* Next reference. */
			}
			else		/* Not a twin, then mark it. */
			{
				*container = marker (*container);
			}
		}
		else 				/* Then, Item does not move. */
		{
			(void) marker(*container);			/* Mark it. */
			CHECK ("Object marked", HEADER (*container)->ov_flags & EO_MARK);
		}

		CHECK ("Must be marked or not forwarded.",
				(HEADER (*container)->ov_flags & EO_MARK)
				|| !(HEADER (*container)->ov_size & B_FWD));
		CHECK ("Special cannot reference a special directly.",
			!(HEADER (*container)->ov_flags & EO_SPEC));
	}	/* for ... */

#ifndef NDEBUG
	ENSURE ("Table kept", spt == special_rem_set);	

		/* Special table must have grown or
		 * kept the same size during marking.*/
	ENSURE ("Has grown", old_count <= spt->count);

		/* `special_rem_set' must not move. */
	for (i = 0; i < spt->count; i ++)
	{
		ref = spt->h_values [i];
		ENSURE ("ref not null", ref != (EIF_REFERENCE) 0);
		ENSURE ("ref is in special_rem_set", ref == (special_rem_set->h_values) [i]);
		ENSURE ("ref is not forwarded", !(HEADER(ref)->ov_size & B_FWD));
		ENSURE ("ref is marked", HEADER (ref)->ov_flags & EO_MARK);
		ENSURE ("ref is special", HEADER (ref)->ov_flags & EO_SPEC);
		ENSURE ("ref is full of references", HEADER (ref)->ov_flags & EO_REF);
		if (spt->h_keys [i] >= 0) {
			ref = (EIF_REFERENCE) (ref + spt->h_keys [i] * sizeof (EIF_REFERENCE));
			ref = * (EIF_REFERENCE *) ref;
			if (ref)
				ENSURE ("*ref is not forwarded", !(HEADER (ref)->ov_size & B_FWD));	
#ifdef EIF_EXPENSIVE_ASSERTIONS
			ENSURE (all_subreferences_processed (special_rem_set->h_values [i]));	/* Checking coherence. */
#endif
		}
	}
	/*********************** End of postconditions. ****************/
#endif

}	/* mark_special_table () */

#endif	/* EIF_REM_SET_OPTIMIZATION */

rt_private void mark_simple_stack(register5 struct stack *stk, register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register6 int move)
									/* The stack which is to be marked */
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the specified stack, using the supplied marker to recursively
	 * mark the objects. The 'move' flag is a flag which tells us whether the
	 * objects are expected to more or not (to avoid useless writing
	 * indirections). Stack holds direct references to objects.
	 */
#ifdef DEBUG
	EIF_GET_CONTEXT
#endif

	register1 EIF_REFERENCE *object;		/* For looping over subsidiary roots */
	register2 int roots;			/* Number of roots in each chunk */
	register3 struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; EIF_REFERENCE *saved_object;
	dprintf(1)("mark_simple_stack: scanning %s stack for %s collector\n",
		stk == &loc_set ? "local" : (stk == &rem_set ? "remembered" : "other"),
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	if (stk->st_top == (EIF_REFERENCE *) 0)	/* Stack is not created yet */
		return;

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)					/* Before current pos? */
			roots = s->sk_end - object;			/* The whole chunk */
		else {
			roots = stk->st_top - object;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_simple_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_object = object;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif

		/* This is the actual marking! (hard to see in the middle of all those
		 * debug statement, so the only purpose of this comment is to catch
		 * the eye and spot the parsing code)--RAM.
		 */

		if (move) {
			for (; roots > 0; roots--, object++)
				*object = mark_expanded(*object, marker);
		} else {
			for (; roots > 0; roots--, object++)
				(void) mark_expanded(*object, marker);
		}
#ifdef DEBUG
		roots = saved_roots; object = saved_object;
		dprintf(2)("mark_simple_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif
	}
}

#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
rt_private void update_object_id_stack(void)
{
	/* Loop over the specified stack to update the objects after a move.
	 * Stack holds direct references to objects.
	 * No marking is done, just the update, i.e. the objects are not roots
	 * for the GC.
	 */

	register4 struct stack *stk = &object_id_stack;

	register1 EIF_REFERENCE *object;		/* For looping over subsidiary roots */
	register2 int roots;			/* Number of roots in each chunk */
	register3 struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; EIF_REFERENCE *saved_object;
	dprintf(1)("mark_object_id_stack\n");
	flush;
#endif

	if (stk->st_top == (EIF_REFERENCE *) 0)	/* Stack is not created yet */
		return;

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)					/* Before current pos? */
			roots = s->sk_end - object;			/* The whole chunk */
		else {
			roots = stk->st_top - object;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_object_id_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_object = object;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif

		for (; roots > 0; roots--, object++)
			{
			register char* root;
			register union overhead *zone;

			root = *object;
			if (root != (EIF_REFERENCE)0){
				zone = HEADER(root);
					/* If the object has moved, update the stack */
				if (zone->ov_size & B_FWD)
					*object = zone->ov_fwd;
				}
			}

#ifdef DEBUG
		roots = saved_roots; object = saved_object;
		dprintf(2)("mark_object_id_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *obj);
		}
		flush;
#endif
	}
}
#endif /* !CUSTOM || NEED_OBJECT_ID_H */

rt_private void mark_stack(register5 struct stack *stk, register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register6 int move)
									/* The stack which is to be marked */
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the specified stack, using the supplied marker to recursively
	 * mark the objects. The 'move' flag is a flag which tells us whether the
	 * objects are expected to move or not (to avoid useless writing
	 * indirections). Stack holds indirect references to objects.
	 */
#ifdef DEBUG
	EIF_GET_CONTEXT
#endif
	register1 EIF_REFERENCE *object;		/* For looping over subsidiary roots */
	register2 int roots;			/* Number of roots in each chunk */
	register3 struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; EIF_REFERENCE *saved_object;
	dprintf(1)("mark_stack: scanning %s stack for %s collector\n",
		stk == &loc_stack ? "local (indirect)" : "once",
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	if (stk->st_top == (EIF_REFERENCE *) 0)	/* Stack is not created yet */
		return;

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)					/* Before current pos? */
			roots = s->sk_end - object;			/* The whole chunk */
		else {
			roots = stk->st_top - object;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_object = object;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, *(EIF_REFERENCE *) *obj);
		}
		flush;
#endif

		if (move) {
			for (; roots > 0; roots--, object++)
				*(EIF_REFERENCE *) *object = mark_expanded(*(EIF_REFERENCE *) *object, marker);
		} else {
			for (; roots > 0; roots--, object++)
				(void) mark_expanded(*(EIF_REFERENCE *) *object, marker);
		}

#ifdef DEBUG
		roots = saved_roots; object = saved_object;
		dprintf(2)("mark_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; EIF_REFERENCE *obj = object;
			for (i = 0; i < roots; i++, obj++)
				printf("%d: 0x%lx\n", i, * (EIF_REFERENCE *) *obj);
		}
		flush;
#endif
	}
}

rt_private EIF_REFERENCE mark_expanded(EIF_REFERENCE root, EIF_REFERENCE (*marker) (EIF_REFERENCE))
		 				/* Expanded reference to be marked */
						/* The routine used to mark objects */
{
	/* The main invariant from the GC is: "expanded objects are only referenced
	 * once, therefore they are not marked and must be traversed only once".
	 * Here, the operational stack may reference expanded objects directly,
	 * hence jeopardizing the invariant. This routine will ask for a traversal
	 * of the enclosing object and then update the reference to the expanded
	 * should the enclosing object have moved.
	 */

	EIF_REFERENCE enclosing;	/* Address of the enclosing object */
	EIF_REFERENCE new;			/* New address of the enclosing object */
	long offset;		/* Offset of the expanded object within enclosing one */
	union overhead *zone;

	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

	zone = HEADER(root);			/* Malloc info zone */

	if (zone->ov_size & B_FWD)
		return zone->ov_fwd;		/* Already forwarded, i.e. traversed */

	if (!(zone->ov_flags & EO_EXP))
		return (marker)(root);		/* Mark non-expanded objects directly */

	offset = zone->ov_size & B_SIZE;
	enclosing = root - offset;

	new = (marker)(enclosing);		/* Traverse enclosing, save new location */
	if (new == enclosing)			/* Object did not move */
		return root;				/* Neither did the expanded object */

	return new + offset;			/* New address of the expanded object */
}

/* Start of workbench-specific marking functions */
#ifdef WORKBENCH
rt_private void mark_op_stack(struct opstack *stk, EIF_CONTEXT register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register5 int move)
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the operational stack (the one used by the interpreter) and
	 * mark all the references found.
	 */

	register1 struct item *last;	/* For looping over subsidiary roots */
	register2 int roots;			/* Number of roots in each chunk */
	register3 struct stochunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	int saved_roots; struct item *saved_last;
	dprintf(1)("mark_op_stack: scanning operational stack for %s collector\n",
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	/* There is no need to check for the existence of the operational stack:
	 * we know it has already been created.
	 */

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		last = s->sk_arena;						/* Start of stack */
		if (s != stk->st_cur)				/* Before current pos? */
			roots = s->sk_end - last;			/* The whole chunk */
		else {
			roots = stk->st_top - last;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}

#ifdef DEBUG
		dprintf(2)("mark_op_stack: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		saved_roots = roots; saved_last = last;
		if (DEBUG & 2 && debug_ok(2)) {
			int i; struct item *lst = last;
			for (i = 0; i < roots; i++, lst++) {
				switch (lst->type & SK_HEAD) {
				case SK_EXP:
					printf("\t%d: expanded 0x%lx\n", i, lst->it_ref);
					break;
				case SK_REF:
					printf("\t%d: 0x%lx\n", i, lst->it_ref);
					break;
				case SK_BOOL:
					printf("\t%d: bool %s\n", i,
						lst->it_char ? "true" : "false");
					break;
				case SK_CHAR:
					printf("\t%d: char %d\n", i, lst->it_char);
					break;
				case SK_WCHAR:
					printf("\t%d: wide char %lu\n", i, lst->it_wchar);
					break;
				case SK_INT8:
					printf("\t%d: int %ld\n", i, lst->it_int8);
					break;
				case SK_INT16:
					printf("\t%d: int %ld\n", i, lst->it_int16);
					break;
				case SK_INT32:
					printf("\t%d: int %ld\n", i, lst->it_int32);
					break;
				case SK_INT64:
					printf("\t%d: int %ld\n", i, lst->it_int64);
					break;
				case SK_FLOAT:
					printf("\t%d: float %f\n", i, lst->it_float);
					break;
				case SK_DOUBLE:
					printf("\t%d: double %lf\n", i, lst->it_double);
					break;
				case SK_BIT:
					printf("\t%d: BITS\n", i);
					break;
				case SK_POINTER:
					printf("\t%d: pointer 0x%lx\n", i, lst->it_ref);
					break;
				case SK_VOID:
					printf("\t%d: void\n", i);
					break;
				default:
					printf("\t%d: UNKNOWN TYPE 0x%lx\n", i, lst->type);
				}
			}
		}
		flush;
#endif

		if (move)
			for (; roots > 0; roots--, last++)		/* Objects may be moved */
				switch (last->type & SK_HEAD) {		/* Type in stack */
				case SK_REF:						/* Reference */
				case SK_EXP:
				case SK_BIT:
					last->it_ref = mark_expanded(last->it_ref, marker);
					break;
				}
		else
			for (; roots > 0; roots--, last++) 		/* Objects cannot move */
				switch (last->type & SK_HEAD) {		/* Type in stack */
				case SK_REF:						/* Reference */
				case SK_EXP:
				case SK_BIT:
					(void) mark_expanded(last->it_ref, marker);
					break;
				}

#ifdef DEBUG
		roots = saved_roots;
		last = saved_last;
		dprintf(2)("mark_op_stack: after GC: %d objects in %s chunk\n",
			roots, done ? "last" : "current");
		if (DEBUG & 2 && debug_ok(2)) {
			int i; struct item *lst = last;
			for (i = 0; i < roots; i++, lst++) {
				switch (lst->type & SK_HEAD) {
				case SK_EXP:
					printf("\t%d: expanded 0x%lx\n", i, lst->it_ref);
					break;
				case SK_REF:
					printf("\t%d: 0x%lx\n", i, lst->it_ref);
					break;
				case SK_BOOL:
					printf("\t%d: bool %s\n", i,
						lst->it_char ? "true" : "false");
					break;
				case SK_CHAR:
					printf("\t%d: char %d\n", i, lst->it_char);
					break;
				case SK_WCHAR:
					printf("\t%d: wide char %lu\n", i, lst->it_wchar);
					break;
				case SK_INT8:
					printf("\t%d: int %ld\n", i, lst->it_int8);
					break;
				case SK_INT16:
					printf("\t%d: int %ld\n", i, lst->it_int16);
					break;
				case SK_INT32:
					printf("\t%d: int %ld\n", i, lst->it_int32);
					break;
				case SK_INT64:
					printf("\t%d: int %ld\n", i, lst->it_int64);
					break;
				case SK_FLOAT:
					printf("\t%d: float %f\n", i, lst->it_float);
					break;
				case SK_DOUBLE:
					printf("\t%d: double %lf\n", i, lst->it_double);
					break;
				case SK_BIT:
					printf("\t%d: BITS\n", i);
					break;
				case SK_POINTER:
					printf("\t%d: pointer 0x%lx\n", i, lst->it_ref);
					break;
				case SK_VOID:
					printf("\t%d: void\n", i);
					break;
				default:
					printf("\t%d: UNKNOWN TYPE 0x%lx\n", i, lst->type);
				}
			}
		}
		flush;
#endif

	}
}
#endif
/* End of workbench-specific marking functions */

rt_private void mark_ex_stack(register5 struct xstack *stk, register4 EIF_REFERENCE (*marker) (EIF_REFERENCE), register6 int move)
							 		/* The stack which is to be marked */
									/* The routine used to mark objects */
				 					/* Are the objects expected to move? */
{
	/* Loop over the exception stacks (the one used by the exception handling
	 * mechanism) and update all the references found. Those references are
	 * alive, so the sole purpose of this traversal is to update the pointers
	 * when objects are moved around.
	 */

#ifdef DEBUG
	EIF_GET_CONTEXT
#endif

	register1 struct ex_vect *last;	/* For looping over subsidiary roots */
	register2 int roots;			/* Number of roots in each chunk */
	register3 struct stxchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */

#ifdef DEBUG
	dprintf(1)("mark_ex_stack: scanning exception %s stack for %s collector\n",
		stk == &eif_trace ? "trace" : "vector",
		marker == GEN_SWITCH ? "generation" : "traditional");
	flush;
#endif

	if (stk->st_top == (struct ex_vect *) 0)
		return;						/* Stack is not created yet */

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		last = s->sk_arena;					/* Start of stack */
		if (s != stk->st_cur)				/* Before current pos? */
			roots = s->sk_end - last;		/* The whole chunk */
		else {
			roots = stk->st_top - last;		/* Stop at the top */
			done = 1;						/* Reached end of stack */
		}
		if (move)
			for (; roots > 0; roots--, last++)
				switch (last->ex_type) {			/* Type in stack */
					/* The following are meaningful when printing the exception
					 * trace: the first set records the enclosing calls, the
					 * second records the failed preconditions (because in that
					 * case, the enclosing call does not appear in the printed
					 * stack).
					 */
					case EX_CALL: case EN_FAIL:
					case EX_RESC: case EN_RESC:
					case EX_RETY: case EN_RES:
						last->ex_id = mark_expanded(last->ex_id, marker);
						break;
					/* Do not inspect EX_PRE records. They do not carry any
					 * valid object ID, which is put in the EN_PRE vector by
					 * backtrack (the precondition failure raises exception in
					 * caller).
					 */
					case EN_PRE:
					case EX_CINV: case EN_CINV:
						last->ex_oid = mark_expanded(last->ex_oid, marker);
						break;
				}
		else
			for (; roots > 0; roots--, last++)
				switch (last->ex_type) {			/* Type in stack */
					/* The following are meaningful when printing the exception
					 * trace: the first set records the enclosing calls, the
					 * second records the failed preconditions (because in that
					 * case, the enclosing call does not appear in the printed
					 * stack).
					 */
					case EX_CALL: case EN_FAIL:
					case EX_RESC: case EN_RESC:
					case EX_RETY: case EN_RES:
						(void) mark_expanded(last->ex_id, marker);
						break;
					/* Do not inspect EX_PRE records. They do not carry any
					 * valid object ID, which is put in the EN_PRE vector by
					 * backtrack (the precondition failure raises exception in
					 * caller).
					 */
					case EN_PRE:
					case EX_CINV: case EN_CINV:
						(void) mark_expanded(last->ex_oid, marker);
						break;
				}
			
	}
}

#ifdef RECURSIVE_MARKING
rt_private EIF_REFERENCE recursive_mark(EIF_REFERENCE root)

{
	EIF_GET_CONTEXT
	/* Recursively mark all the objects referenced by the root object.
	 * I carefully avoided declaring things in registers, because as this
	 * is a recursive routine, the time we would otherwise spend in saving
	 * and backing up the registers to/from stack would be prohibitive--RAM.
	 * The function returns the address of the (possibly moved) object.
	 */

	union overhead *zone;		/* Malloc info zone fields */
	uint32 flags;				/* Eiffel flags */
	long offset;				/* Reference's offset */
	uint32 size;				/* Size of an item (for array of expanded) */
	EIF_REFERENCE *object;				/* Sub-objects scanned */

	/* If 'root' is a void reference, return immediately */
	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

	zone = HEADER(root);			/* Malloc info zone */
	flags = zone->ov_flags;			/* Fetch Eiffel flags */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(16)("recursive_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			root,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	} else {
		dprintf(16)("recursive_mark: 0x%lx %s%s%s(DT %d, %d bytes)\n",
			root,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
	flush;
#endif

	/* Deal with scavenging here, namely scavenge the reached object if it
	 * belongs to a 'from' space. Leave a forwarding pointer behind and mark
	 * the object as forwarded. Scavenging while marking avoids another pass
	 * for scavenging the 'from' zone and another entire pass to update the
	 * references, so it should be a big win--RAM. Note that scavenged objects
	 * are NOT marked: the fact that they have been forwarded is the mark.
	 * The expanded objects are never scavenged (only the object which holds
	 * them is).
	 */
	offset = (uint32) g_data.status;	/* Garbage collector's status */

	if (offset & (GC_PART | GC_GEN)) {

		/* If we enter here, then we are currently running a scavenging
		 * algorithm of some sort. Depending on the garbage collector's flag,
		 * we are able to see if the current object is in a 'from' zone (i.e.
		 * has to be scavenged). Note that the generation scavenging process
		 * does not usually call this routine (tenuring can fail, and we are
		 * in a process that is not allowed to fail). Here, the new generation
		 * is simply scavenged, with no tenuring.
		 * Detecting whether an object is in the scavenge zone or not is easy
		 * and fast: all the objects in the scavenge zone have their B_BUSY
		 * flag reset.
		 */

		size = zone->ov_size;
		if (size & B_FWD)				/* Can't be true if expanded */
			return zone->ov_fwd;		/* So it has been already processed */

		/* Even though the object could be in the scavenging "from" zone, it
		 * might be a C one, i.e. it cannot move and would be marked with
		 * EO_MARK by the scavenging process. Hence the test here.
		 */

		if (flags & (EO_MARK | EO_C))	/* Already marked or C object */
			return root;				/* Object processed and did not move */

		if (
			(offset & GC_GEN) && !(size & B_BUSY)
		) {
			root = scavenge(root, &sc_to);	/* Simple scavenging */
			zone = HEADER(root);			/* Update zone */
			flags = zone->ov_flags;			/* And Eiffel flags */
			goto marked;					/* I hate those--necessary here */
		} else if (
			(offset & GC_PART) &&
			(root > ps_from.sc_arena && root <= ps_from.sc_end)
		) {
			root = scavenge(root, &ps_to);	/* Partial scavenge */
			zone = HEADER(root);			/* Update zone */
			flags = zone->ov_flags;			/* And Eiffel flags */
			goto marked;					/* Forwarding goto--not so bad */
		}

	}

	/* This part of code, until the 'marked' label is executed only when the
	 * object does not belong any scavenging space, or no scavenging is to
	 * ever be done.
	 */

	/* If current object is already marked, it has been (or is)
	 * studied. So return immediately. Idem if object is a C one.
	 */
	if (flags & (EO_MARK | EO_C))
		return root;

	/* Expanded objects have no 'ov_size' field. Instead, they have a
	 * pointer to the object which holds them. This is needed by the
	 * scavenging process, so that we can update the internal references
	 * to the expanded in the scavenged object.
	 * It's useless to mark an expanded, because it has only one reference
	 * on itself, in the object which holds it.
	 */
	if (!(flags & EO_EXP)) {		/* Object is not expanded */
		flags |= EO_MARK;			/* Mark it now, to avoid loops */
		zone->ov_flags = flags;
	}

marked:		/* I need this goto label to avoid code duplication */

	/* Now explore all the references of the current object.
	 * For each object of type 'type', References(type) gives the number
	 * of references in the objects. The references are placed at the
	 * beginning of the data space by the Eiffel compiler. Expanded
	 * objects have a reference to them, so no special treatment is
	 * required. Special objects full of references are also explored.
	 */

	if (flags & EO_SPEC) {				/* Special object */

		/* Special objects may have no references (e.g. an array of
		 * integer or a string), so we have to skip those.
		 */
		if (!(flags & EO_REF))
			return root;				/* Skip if no references */

		/* At the end of the special data zone, there are two long integers
		 * which give informations to the run-time about the content of the
		 * zone: the first is the 'count', i.e. the number of items, and the
		 * second is the size of each item (for expandeds, the overhead of the
		 * header is not taken into account).
		 */
		size = zone->ov_size & B_SIZE;		/* Fetch size of block */
		size -= LNGPAD_2;					/* Go backward to 'count' */
		offset = *(long *) (root + size);	/* Get the count (# of items) */

		/* Treat arrays of expanded object here, because we have a special
		 * way of looping over the array (we must take the size of each item
		 * into account). Code below is somewhat duplicated with the normal
		 * code for regular objects or arrays of references, but this is because
		 * we have to increment our pointers by size and I do not want to
		 * to slow down the normal loop--RAM.
		 */
		 if (flags & EO_COMP) {
			size = *(long *) (root + size + sizeof(long));	/* Item's size */
			if (g_data.status & (GC_PART | GC_GEN)) {	/* Moving objects */
				object = (EIF_REFERENCE *) (root + OVERHEAD);	/* First expanded */
				for (; offset > 0; offset--) {			/* Loop over array */
					*object = recursive_mark(*object);	
					object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
				}
			} else {									/* Object can't move */
				object = (EIF_REFERENCE *) (root + OVERHEAD);	/* First expanded */
				for (; offset > 0; offset--) {			/* Loop over array */
					(void) recursive_mark(*object);	
					object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
				}
			}
			return root;	/* Address of possibly moved array of expanded */
		}

	} else
		offset = References(Deif_bid(flags));	/* Number of references */

#ifdef DEBUG
	dprintf(16)("recursive_mark: %d references for 0x%lx\n", offset, root);
	if (DEBUG & 16 && debug_ok(16)) {
		int i;
		for (i = 0; i < offset; i++)
			printf("\t0x%lx\n", *((EIF_REFERENCE *) root + i));
	}
	flush;
#endif

	/* Mark all objects under root, updating the references if scavenging */

	if (g_data.status & (GC_PART | GC_GEN))
		for (object = (EIF_REFERENCE *) root; offset > 0; offset--, object++)
			*object = recursive_mark(*object);
	else
		for (object = (EIF_REFERENCE *) root; offset > 0; offset--)
			(void) recursive_mark(*object++);

	return root;	/* Address of possibly moved object */
}
#endif /* RECURSIVE_MARKING */

#ifdef HYBRID_MARKING
rt_private EIF_REFERENCE hybrid_mark(EIF_REFERENCE root)

{
	/* Mark all the objects referenced by the root object. This is almost the
	 * same routine as recursive_mark() with one major change: the tail
	 * recursion has been removed. All the attributes of an object are 
	 * recursively marked, except the last one. This brings a noticeable
	 * improvement with structures like LINKED_LIST.
	 */
	union overhead *zone;		/* Malloc info zone fields */
	uint32 flags;				/* Eiffel flags */
	long offset;				/* Reference's offset */
	uint32 size;				/* Size of an item (for array of expanded) */
	EIF_REFERENCE *object;				/* Sub-objects scanned */
	EIF_REFERENCE current;				/* Object currently inspected */
	EIF_REFERENCE *prev;				/* Holder of current (for update) */
	long count;					/* Number of references */

	/* If 'root' is a void reference, return immediately. This is redundant
	 * with the beginning of the loop, but this case occurs quite often.
	 */
	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

	/* Initialize the variables for the loop */
	current = root;
	prev = (EIF_REFERENCE *) 0;

	do {
		if (current == (EIF_REFERENCE) 0)		/* No further exploration */
			goto done;					/* Exit the procedure */

		zone = HEADER(current);			/* Malloc info zone */
		flags = zone->ov_flags;			/* Fetch Eiffel flags */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(16)("hybrid_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			current,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	} else {
		dprintf(16)("hybrid_mark: 0x%lx %s%s%s(DT %d, %d bytes)\n",
			current,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
	flush;
#endif

		/* Deal with scavenging here, namely scavenge the reached object if it
		 * belongs to a 'from' space. Leave a forwarding pointer behind and mark
		 * the object as forwarded. Scavenging while marking avoids another pass
		 * for scavenging the 'from' zone and another entire pass to update the
		 * references, so it should be a big win--RAM. Note that scavenged
		 * objects are NOT marked: the fact that they have been forwarded is the
		 * mark. The expanded objects are never scavenged (only the object which
		 * holds them is).
		 */
		offset = (uint32) g_data.status;		/* Garbage collector's status */

		if (offset & (GC_PART | GC_GEN)) {

			/* If we enter here, then we are currently running a scavenging
			 * algorithm of some sort. Depending on the garbage collector's
			 * flag, we are able to see if the current object is in a 'from'
			 * zone (i.e. has to be scavenged). Note that the generation
			 * scavenging process does not usually call this routine (tenuring
			 * can fail, and we are in a process that is not allowed to fail).
			 * Here, the new generation is simply scavenged, with no tenuring.
			 * Detecting whether an object is in the scavenge zone or not is
			 * easy and fast: all the objects in the scavenge zone have their
			 * B_BUSY flag reset.
			 */

			size = zone->ov_size;
			if (size & B_FWD) {			/* Can't be true if expanded */
				if(prev)				/* Update the referencing address */
					*prev = zone->ov_fwd;
				goto done;				/* So it has been already processed */
			}

			if (flags & (EO_MARK | EO_C))	/* Already marked or C object */
				goto done;				/* Object processed and did not move */

			if (offset & GC_GEN && !(size & B_BUSY)) {
				current = scavenge(current, &sc_to);	/* Simple scavenging */
				zone = HEADER(current);					/* Update zone */
				flags = zone->ov_flags;					/* And Eiffel flags */
				if (prev)					/* Update referencing pointer */
					*prev = current;
				goto marked;
			} else
				if (offset & GC_PART &&
				current > ps_from.sc_arena && current <= ps_from.sc_end) {
					current = scavenge(current, &ps_to);/* Partial scavenge */
					zone = HEADER(current);				/* Update zone */
					flags = zone->ov_flags;				/* And Eiffel flags */
					if (prev)
						*prev = current;	/* Update referencing pointer */
					goto marked;
				}
		}

		/* This part of code, until the 'marked' label is executed only when the
		 * object does not belong any scavenging space, or no scavenging is to
		 * ever be done.
		 */

		/* If current object is already marked, it has been (or is)
		 * studied. So return immediately. Idem if object is a C one.
		 */
		if (flags & (EO_MARK | EO_C))
			goto done;


		/* Expanded objects have no 'ov_size' field. Instead, they have a
		 * pointer to the object which holds them. This is needed by the
		 * scavenging process, so that we can update the internal references
		 * to the expanded in the scavenged object.
		 * It's useless to mark an expanded, because it has only one reference
		 * on itself, in the object which holds it.
		 */
		if (!(flags & EO_EXP)) {
			flags |= EO_MARK;
			zone->ov_flags = flags;
		}

marked: /* Goto label needed to avoid code duplication */

		/* Now explore all the references of the current object.
		 * For each object of type 'type', References(type) gives the number
		 * of references in the objects. The references are placed at the
		 * beginning of the data space by the Eiffel compiler. Expanded
		 * objects have a reference to them, so no special treatment is
		 * required. Special objects full of references are also explored.
		 */

		if (flags & EO_SPEC) {

			/* Special objects may have no references (e.g. an array of
			 * integer or a string), so we have to skip those.
			 */

			if (!(flags & EO_REF)) /* If object moved, reference updated */
				goto done;

			/* At the end of the special data zone, there are two long integers
			 * which give informations to the run-time about the content of the
			 * zone: the first is the 'count', i.e. the number of items, and the
			 * second is the size of each item (for expandeds, the overhead of
			 * the header is not taken into account).
			 */
			size = zone->ov_size & B_SIZE;			/* Fetch size of block */
			size -= LNGPAD_2;						/* Go backward to 'count' */
			count = offset = *(long *) (current + size);	/* Get # of items */

			/* Treat arrays of expanded object here, because we have a special
			 * way of looping over the array (we must take the size of each item
			 * into account). Code below is somewhat duplicated with the normal
			 * code for regular objects or arrays of references, but this is
			 * because we have to increment our pointers by size and I do not
			 * want to to slow down the normal loop--RAM.
			 */
			if (flags & EO_COMP) {
				size = *(long *) (current + size + sizeof(long));	/* Item's size */
				if (g_data.status & (GC_PART | GC_GEN)) {	/* Moving objects */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						*object = hybrid_mark(*object);
						object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
					}
				} else {								/* Object can't move */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						(void) hybrid_mark(*object);
						object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
					}
				}
				/* Keep iterating if and only if the current object has at
				 * least one attribute.
				 */
				if (count >= 1) {
					prev = object;
					current = *object;
					continue;
				} else
					goto done;		/* End of iteration; exit procedure */
			}

		} else
			count = offset = References(Deif_bid(flags));	/* # items */

#ifdef DEBUG
	dprintf(16)("hybrid_mark: %d references for 0x%lx\n", offset, current);
	if (DEBUG & 16 && debug_ok(16)) {
		int i;
		for (i = 0; i < offset; i++)
			printf("\t0x%lx\n", *((EIF_REFERENCE *) current + i));
	}
	flush;
#endif

		/* Mark all objects under root, updating the references if scavenging */

		if (g_data.status & (GC_PART | GC_GEN))
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--, object++)
				*object = hybrid_mark(*object);
		else
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--)
				(void) hybrid_mark(*object++);

		if (count >= 1) {
			prev = object;
			current = *object;
		} else
			goto done;

	} while(current);

done:
	/* Return the [new] address of the root object */
	zone = HEADER(root);
	return ((zone->ov_size & B_FWD) ? zone->ov_fwd : root);
}
#endif /* HYBRID_MARKING */

#ifdef ITERATIVE_MARKING
rt_private EIF_REFERENCE iterative_mark(EIF_REFERENCE root)
{
	/* Mark all the objects referenced by the root object. Recursion
	 * is carefully avoided even if highly appropriate (might cause
	 * C call stack overflow).
	 * For a detailed description of the algorithm, refer to ...
	 */

	EIF_GET_CONTEXT
	register1 union overhead *zone;	/* Malloc info zone fields */
	register2 uint32 flags;			/* Eiffel flags */
	long offset;					/* Reference's offset */
	register3 uint32 size;			/* Size of an item (for array of expanded) */
	EIF_REFERENCE *object;					/* Sub-objects scanned */

	register4 EIF_REFERENCE parent = (EIF_REFERENCE) 0;	/* Parent of the current object */
	register5 EIF_REFERENCE child;			/* Child to be inspected */
	register6 EIF_REFERENCE node;			/* Node currently inspected */
	register7 long position;		/* Child is the position-th attribute of Node */
	long s_top;						/* Value on top of path_stack */

#ifdef DEBUG
	long loop_call = 0;
#endif

	/* Initialize the stack with LAST_REF. The algorithm stops when this
	 * element is on top of the stack.
	 */
	epush(&path_stack, (EIF_REFERENCE) LAST_REF);

	/* root is kept until the end because we have to return its possibly
	 * new address.
	 */
	node = root;

	do {

#ifdef DEBUG
	loop_call++;
#endif
		/* Step 0
		 * This part of code is executed for all the references the algorithm
		 * inspects.
		 */

		/* If the current object is void, there's nothing to explore.
		 * Skip it.
		 */
		if (!node)
			goto not_explorable;

		zone = HEADER(node);		/* Malloc info zone */
		flags = zone->ov_flags;		/* Fetch Eiffel flags */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(128)("iterative_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			node,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	} else {
		fdprintf(128,1)("iterative_mark: step 0, 0x%lx %s%s%s(DT %d, %d bytes)\n",
			node,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
	flush;
#endif

		/* Deal with scavenging here, namely scavenge the reached object if it
		 * belongs to a 'from' space. Leave a forwarding pointer behind and mark
		 * the object as forwarded. Scavenging while marking avoids another pass
		 * for scavenging the 'from' zone and another entire pass to update the
		 * references, so it should be a big win--RAM. Note that scavenged
		 * objects are NOT marked: the fact that they have been forwarded is the
		 * mark. The expanded objects are never scavenged (only the object which
		 * holds them is).
		 */
		offset = (uint32) g_data.status;	/* Garbage collector's status */

		if (offset & (GC_PART | GC_GEN)) {

			/* If we enter here, then we are currently running a scavenging
			 * algorithm of some sort. Depending on the garbage collector's
			 * flag, we are able to see if the current object is in a 'from'
			 * zone (i.e. has to be scavenged). Note that the generation
			 * scavenging process does not usually call this routine (tenuring
			 * can fail, and we are in a process that is not allowed to fail).
			 * Here, the new generation is simply scavenged, with no tenuring.
			 * Detecting whether an object is in the scavenge zone or not is
			 * easy and fast: all the objects in the scavenge zone have their
			 * B_BUSY flag reset.
			 */

			size = zone->ov_size;
			if (size & B_FWD) {			/* Can't be true if expanded */
				node = zone->ov_fwd;	/* So it has been already processed */
				goto not_explorable;	/* Nothing to inspect, skip step 1 */
			}

			if (flags & (EO_MARK | EO_C))	/* Already marked or C object */
				goto not_explorable;		/* Skip step 1 */

			if (offset & GC_GEN && !(size & B_BUSY)) {
				node = scavenge(node, &sc_to);	/* Simple scavenging */
				zone = HEADER(node);			/* Update zone */
				flags = zone->ov_flags;			/* And Eiffel flags */
				goto marked;					/* Skip further testing */
			} else if (offset & GC_PART && node > ps_from.sc_arena && node <= ps_from.sc_end) {
				node = scavenge(node, &ps_to);	/* Partial scavenge */
				zone = HEADER(node);			/* Update zone */
				flags = zone->ov_flags;			/* And Eiffel flags */
				goto marked;					/* Skip further testing */
			}
		}

		/* This part of code, until the 'marked' label is executed only when the
		 * object does not belong any scavenging space, or no scavenging is to
		 * ever be done.
		 */

		/* If current object is already marked, it has been (or is)
		 * studied. So skip it. Idem if object is a C one.
		 */
		if (flags & (EO_MARK | EO_C))
			goto not_explorable;

		/* Expanded objects have no 'ov_size' field. Instead, they have a
		 * pointer to the object which holds them. This is needed by the
		 * scavenging process, so that we can update the internal references
		 * to the expanded in the scavenged object.
		 * It's useless to mark an expanded, because it has only one reference
		 * on itself, in the object which holds it.
		 */
		if (!(flags & EO_EXP)) {		/* Object is not expanded */
			flags |= EO_MARK;			/* Mark it now, to avoid loops */
			zone->ov_flags = flags;
		}

marked:

		/* Now explore all the references of the current object.
		 * For each object of type 'type', References(type) gives the number
		 * of references in the objects. The references are placed at the
		 * beginning of the data space by the Eiffel compiler. Expanded
		 * objects have a reference to them, so no special treatment is
		 * required. Special objects full of references are also explored.
		 */

		if (flags & EO_SPEC) {

			/* Special objects may have no references (e.g. an array of
			 * integer or a string), so we have to skip those.
			 */
			if (!(flags & EO_REF))
				goto not_explorable;

			/* At the end of the special data zone, there are two long integers
			 * which give informations to the run-time about the content of the
			 * zone: the first is the 'count', i.e. the number of items, and the
			 * second is the size of each item (for expandeds, the overhead of
			 * the header is not taken into account).
			 */
			size = zone->ov_size & B_SIZE;		/* Fetch size of block */
			size -= LNGPAD_2;					/* Go backward to 'count' */
			offset = *(long *) (node + size);	/* Get the count (# of items) */
		} else
			offset = References(Deif_bid(flags));	/* # of references */


		/* Step 1
		 * if the current object has reference(s), inspect the first one.
		 */

#ifdef DEBUG
	fdprintf(128,1)("iterative_mark: step 1, node = %lx, parent = %lx\n",
				node,parent);
	fdprintf(128,1)("iterative_mark: step 1, following 1/%d \n",offset);
#endif

		if (offset) {
			/* If this is the only reference, mark the value pushed on the
			 * stack consequently.
			 */
			if (offset == 1L)
				epush (&path_stack, (EIF_REFERENCE) (1L | LAST_REF));
			else
				epush (&path_stack, (EIF_REFERENCE) 1L);

			/* The current node has references. Get the first one */
			/* Array of expanded */
			if ((flags & EO_SPEC) && (flags & EO_COMP)) {
				child = (EIF_REFERENCE) (node + OVERHEAD);		/* First expanded */

				/* For arrays of expanded, there's no field for the reference
				 * so we have to store the address of the father in a stack
				 * that will be used for all the fathers of arrays of expanded
				 * (it means this stack should stay small).
				 */
				epush (&parent_expanded_stack, parent);
			} else {
				child = * (EIF_REFERENCE *) node;
				* (EIF_REFERENCE *) node = parent;
			}
			parent = node;
			node = child;
			continue;
		}

not_explorable:

		/* Step 2
		 * At this point, we have reached a node that hasn't any reference
		 * or all the references of which have been inspected. Go back to
		 * the parent as long as we can.
		 */

#ifdef DEBUG
	fdprintf(128,1)("iterative_mark: step 2, node = %lx, parent = %lx\n",
				node,parent);
	fdprintf(128,1)("iterative_mark: top(path_stack) = %lx\n",
				ntop(&path_stack));
#endif

		s_top = (long) ntop(&path_stack);

		while ((s_top & LAST_REF) && (s_top & ~LAST_REF)) {
			position = (long) nget (&path_stack);
			position &= ~LAST_REF;
			child = node;
			node = parent;
			/* If this current new object is an array of expanded, its father
			 * is in the parent_expanded_stack stack, not in one if its
			 * attributes
			 */
			flags = HEADER(node)->ov_flags;
			if ((flags & EO_SPEC) && (flags & EO_COMP))
				parent = nget (&parent_expanded_stack);
			else {
				/* The address of the parent must be in the last reference
				 * and at this point, position must hold the number of
				 * attributes of the current node.
				 */
				object = (EIF_REFERENCE *) node;
				object += position - 1;
				parent = *object;
				*object = child;
#ifdef DEBUG
	fdprintf(128,1)("iterative_mark: step 2, up one level, node = %lx, "
				"parent = %lx, child = %lx\n",node,parent,child);
#endif
			}
			s_top = (long) ntop(&path_stack);
		}

		/* Step 3
		 * If the parent of the current node exists, it has some unexplored
		 * references. Go back to the parent.
		 */

#ifdef DEBUG
	fdprintf(128,1)("iterative_mark: step 3, node = %lx, parent = %lx\n",
				node,parent);
#endif

		if (parent) {
			position = (long) nget (&path_stack) + 1;
			child = node;
			node = parent;
			flags = HEADER(node)->ov_flags;
			if (flags & EO_SPEC) {
				zone = HEADER(node);
				size = zone->ov_size & B_SIZE;
				size -= LNGPAD_2;
				offset = *(long *) (node + size);
			} else
				offset = References(Deif_bid(flags));

			if (position == offset)
				epush (&path_stack, (EIF_REFERENCE) (position | LAST_REF));
			else
				epush (&path_stack, (EIF_REFERENCE) position);

			if ((flags & EO_SPEC) && (flags & EO_COMP)) {
				size = *(long *) (node + size + sizeof(long));
				child = (EIF_REFERENCE) (node + OVERHEAD + (position - 1) * (size + OVERHEAD));
			} else {
				object = (EIF_REFERENCE *) node;
				object += position - 2;
				parent = *object;
				*object = child;
				object++;
				child = *object;
				*object = parent;
			}

#ifdef DEBUG
	fdprintf(128,1)("iterative_mark: step 3, up one level, node = %lx, "
					"parent = %lx, child = %lx\n",node,parent,child);
	fdprintf(128,1)("iterative_mark: step 3, node = %lx, parent = %lx\n",
					node,parent);
	fdprintf(128,1)("iterative_mark: step 3, following %d/%d reference\n",
					position, offset);
#endif

			parent = node;
			node = child;
		}

	} while (ntop(&path_stack) != (EIF_REFERENCE) LAST_REF);

	(void) nget (&path_stack);

	/* Check if `root' has moved and return the eventually new address */
	zone = HEADER(root);
	flags = zone->ov_flags;
	size = zone->ov_size;

#ifdef DEBUG
	fdprintf(128,2)("iterative_mark called with 0x%lx, %ld iteration(s)\n",root,loop_call);
#endif

	if (size & B_FWD)
		return zone->ov_fwd;
	else
		return root;
}

EIF_REFERENCE nget(register1 struct stack *stk)
{
	/* Pop the top item of *stk */
	EIF_GET_CONTEXT
	register1 EIF_REFERENCE *top = stk->st_top;		/* The top of the stack */
	register3 EIF_REFERENCE *arena;					/* Base address of current chunk */
	register4 struct stchunk *s;

	if (top == (EIF_REFERENCE *) 0) {		/* No stack yet? */
#ifdef DEBUG
	fdprintf(128,4)("nget: no stack yet, returning 0\n");
#endif
		return (EIF_REFERENCE) 0;				/* Return null pointer */
	}

	arena = stk->st_cur->sk_arena;
	top--;
	if (top >= arena) {				/* Still in the same chunk ? */
		stk->st_top = top;			/* Yes! Update top */
#ifdef DEBUG
	fdprintf(128,4)("nget: returning 0x%lx\n",*top);
#endif
		return *top;
	}

	/* We are just at the beginning of a new chunk. Go back to the previous
	 * chunk if any.
	 */

	SIGBLOCK;			/* Entering critical section */

	s = stk->st_cur->sk_prev;
	if (s) {
		stk->st_cur = s;
		top = s->sk_end;		/* sk_end points to the first element beyond the chunk */
		top--;
		stk->st_top = top;
		stk->st_end = s->sk_end;
	}

	SIGRESUME;			/* Leaving critical section */

	if (s) {
#ifdef DEBUG
	fdprintf(128,4)("nget: returning 0x%lx\n",*top);
#endif
		return *top;
	} else {
#ifdef DEBUG
	fdprintf(128,4)("nget: returning 0\n");
#endif
		return (EIF_REFERENCE) 0;
	}
}

EIF_REFERENCE ntop (register1 struct stack *stk)
{
	/* Return the top item of *stk */
	register1 EIF_REFERENCE *top = stk->st_top;		/* The top of the stack */
	register2 EIF_REFERENCE *arena;					/* Base address of current chunk */
	register3 struct stchunk *s;

	if (top == (EIF_REFERENCE *) 0)		/* No stack yet? */
			return (EIF_REFERENCE) 0;		/* Return null pointer */

	arena = stk->st_cur->sk_arena;
	top--;
	if (top >= arena)			/* Still in the same chunk ? */
		return *top;

	s = stk->st_cur->sk_prev;
	if (s) {
		top = s->sk_end;	/* sk_end points to the first element beyond the
 chunk */
		top--;
		return (*top);
	} else {
		fprintf (stderr,"ntop: stack corrupted!\n");
		return (EIF_REFERENCE) 0;
	}
}
#endif /* ITERATIVE_MARKING */


rt_private void full_sweep(void)
{
	/* Sweep phase -- All the reachable objects have been marked, so
	 * all we have to do is scan all the objects and look for garbage.
	 * The remaining objects are unmarked. If partial scavenging is on,
	 * the 'from' and 'to' spaces are left untouched (the objects in the
	 * 'to' space are unmarked but alive...).
	 */
	register1 union overhead *zone;		/* Malloc info zone */
	register2 uint32 size;				/* Object's size in bytes */
	register3 EIF_REFERENCE end;				/* First address beyond chunk */
	register4 uint32 flags;				/* Eiffel flags */
	register5 struct chunk *chunk;		/* Current chunk */
	register6 EIF_REFERENCE arena;				/* Arena in chunk */

	/* We start the sweeping at the end of the memory, and we walk
	 * backawrds along the chunk list. That way, the freed objects
	 * are inserted at the beginning of the free list (which is kept
	 * in increasing order). If I did it the other way round, then
	 * the first freed objects would be inserted at the beginning but
	 * the last one would take much more time to get inserted, not to
	 * mention all the paging problems that could be involved--RAM.
	 */

	for (chunk = cklst.ck_tail; chunk; chunk = chunk->ck_prev) {

		arena = (EIF_REFERENCE) (chunk + 1);

		/* Skip the scavenge zones, if they exist and we are in a partial
		 * scavenge: (objects there have to go back to the free list only if
		 * the chunk is not completely free, i.e. if it has C blocks in it).
		 * The 'to' zone is full of 'alive' objects, but they are unmarked...
		 * There is no special consideration for generation scavenging,
		 * because the blocks which hold these zone are C ones. Note that this
		 * test works only because we use standard chunks--RAM.
		 *
		 * In non-partial scavenging mode, then only the 'to' has to be skipped:
		 * the scavenge zone are unused in this mode, but 'to' contains a bunch
		 * of objects which should be dead (it was surely a 'from' during the
		 * last scavenging cycle).
		 */

		if (g_data.status & GC_PART) {			/* In partial scavenge */
			if (arena == ps_from.sc_arena || arena == ps_to.sc_arena)
				continue;					/* Skip scavenge zones */
		} else if (arena == ps_to.sc_arena)
			continue;						/* Skip 'to' zone */

		end = (EIF_REFERENCE) arena + chunk->ck_length;	/* Chunk's tail */

		/* Objects are not chained together, so the only way to walk
		 * through them is to use the size field of each block. C blocks
		 * have to be skipped. The main disadvantage of this mechanism is
		 * that it involves swapping, but this is the price to pay to have
		 * only an 8 bytes header--RAM.
		 */

		for (
			zone = (union overhead *) arena;
			(EIF_REFERENCE) zone < end;
			zone = (union overhead *) (((EIF_REFERENCE) zone) + size + OVERHEAD)
		) {
			size = zone->ov_size;			/* Size and flags */

			if (!(size & B_BUSY)) {
				/* Object belongs to the free list (not busy).
				 */
				size &= B_SIZE;				/* Keep only pure size */
				continue;					/* Skip block */
			}


			if (size & B_C) {
				/* Object is a C one.
				 * However, any Eiffel object (i.e. any object not bearing
				 * the EO_C mark) is marked during the marking phase and has
				 * to be unmarked now. It is not freed however, since it is
				 * marked B_C and hence is under user control. Moreover, we
				 * would not be able to remove the reference from hector.
				 */
				size &= B_SIZE;				/* Keep only pure size */
				zone->ov_flags &= ~EO_MARK;	/* Unconditionally unmark it */
				continue;					/* Skip block */
			}

			size &= B_SIZE;					/* Remove block flags */
			flags = zone->ov_flags;			/* Fetch Eiffel flags */

			if (flags & EO_MARK) { 					/* Object is marked */
				zone->ov_flags = flags & ~EO_MARK;	/* Unmark it */
				continue;							/* And skip it */
			}

			/* Expanded objects are within normal objects and therefore
			 * cannot be explicitely removed. I assume it is impossible
			 * to reference an expanded object directly (via another object
			 * reference)--RAM.
			 */

			gfree(zone);		/* Object is freed */
#ifdef FULL_SWEEP_DEBUG
		printf("FULL_SWEEP: Removing 0x%x (type %d, %d bytes) %s %s %s %s %s %s %s, age %ld\n",
			(union overhead *) zone + 1,
			HEADER( (union overhead *) zone + 1 )->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE,
			((union overhead *) zone + 1),
			zone->ov_size & B_FWD ? "forwarded" : "",
			zone->ov_flags & EO_MARK ? "marked" : "",
			zone->ov_flags & EO_REF ? "ref" : "",
			zone->ov_flags & EO_COMP ? "cmp" : "",
			zone->ov_flags & EO_SPEC ? "spec" : "",
			zone->ov_flags & EO_NEW ? "new" : "",
			zone->ov_flags & EO_OLD ? "old" : "",
			((zone->ov_flags & EO_AGE) >> 24) / 2);
		

#endif	/* FULL_SWEEP_DEBUG */
		}
	}

	/* The Hector stack has to be traversed to call `dispose' on protected objects 
	 * Standard dispose traversal checks for Eiffel objects, frozen obj are 
	 * marked as C obj thus ignored. The other stacks are referencing "moving" 
	 * objects so there's no problem */
}

rt_private void full_update(void)
{
	/* After a mark and sweep, eventually mixed with scavenging, the data
	 * structures which are used to describe the generations have to be
	 * updated, in case the references changed or some objects died.
	 * An object is considered to be alive iff it carries the EO_MARK bit
	 * or if it has been forwarded. The references are updated in that case.
	 * The routines rely on the garbage collector's status flag to do the
	 * proper job.
	 */

	update_moved_set();
	update_rem_set();		/* Must be done after moved set (for GC_FAST) */
#ifdef EIF_REM_SET_OPTIMIZATION 
	(void) update_special_rem_set ();		
#endif	/* EIF_REM_SET_OPTIMIZATION */
#ifdef EIF_MEMORY_OPTIMIZATION
	update_memory_set ();
#endif	/* EIF_MEMORY_OPTIMIZATION */
}

/*
 * Mixed strategy garbage collector (mark and sweep plus scavenging).
 * This can also be qualified as a storage compaction garbage collector.
 */

rt_public void plsc(void)
{
	/* The partial scavenging entry point, which is monitored for statistics
	 * updating (available to the user via MEMORY).
	 */

	if (g_data.status & GC_STOP)
		return;				/* Garbage collection stopped */

	(void) scollect(partial_scavenging, GST_PART);
}

rt_private int partial_scavenging(void)
{
	/* Partial Scavenging -- Implementation of the INRIA algorithm
	 * Lang-Dupont 1987. The idea is to do a full mark and sweep for
	 * most of the memory, the 'from' space excepted. This space is
	 * scavenged to the 'to' space, thus doing storage compaction.
	 * Note that for efficiency reasons and for the memory update to
	 * work correctly, 'from' MUST be the address of the first block
	 * of a memory chunk (because this zone is skipped by doing pointer
	 * comparaisons).
	 */
	EIF_GET_CONTEXT

	SIGBLOCK;				/* Block all signals during garbage collection */
	init_plsc();			/* Initialize scavenging (find 'to' space) */
	run_plsc();				/* Normal sequence */

	return 0;
}

rt_private void run_plsc(void)
{
	/* This routine actually invokes the partial scavenging and takes care of
	 * restoring signals at the end and dispatching signals if necessary.
	 */

	run_collector();		/* Call a wrapper to do the job */
	clean_zones();			/* Clean up 'from' and 'to' scavenge zonse */
	clean_up();				/* Dispatch signals, release core, etc... */
}

rt_shared void urgent_plsc(EIF_REFERENCE *object)
{
	/* Perform an urgent partial scavenging, taking 'object' as a pointer
	 * to the address of a variable holding a reference to an Eiffel object
	 * which must be part of the local roots for the collector.
	 */

	EIF_GET_CONTEXT
	if (g_data.status & GC_STOP)
		return;							/* Garbage collection stopped */

	SIGBLOCK;				/* Block all signals during garbage collection */
	init_plsc();			/* Initialize scavenging (find 'to' space) */

	/* This object needs to be taken care of, because it might be dead from
	 * the GC's point of view although we know that it is not... As its location
	 * may change, we use an indirection to reach it.
	 */
	*object = MARK_SWITCH(*object);	/* Ensure object is alive */

	run_plsc();				/* Normal sequence */
}

rt_private void clean_zones(void)
{
	/* This routine is called after a partial scavenging has been done.
	 * Run over the 'from' field, coalescing all the Eiffel block we find
	 * there. If we reach a C block, then the entire zone is polluted and the
	 * free blocks are returned to the free list. Otherwise, the whole chunk
	 * is kept for the next partial scavenge (this should be the case all the
	 * time, but some C blocks may pollute the zones if we are low in memory).
	 */

#ifdef DEBUG
	dprintf(1)("clean_zones: entering function..\n");
#endif


	if (!(g_data.status & GC_PART))
		return;				/* A simple mark and sweep was done */

	/* Compute the amount of copied bytes and the size of the scavenging zone
	 * we were dealing with. This is used by scollect to update its statistics
	 * about the memory collected (since when scavenging is done, some memory
	 * is collected without having the free-list disturbed, thus making the
	 * malloc statistics inaccurate in this respect)--RAM.
	 */

	g_data.mem_copied += ps_from.sc_size;	/* Bytes subject to copying */
	g_data.mem_move += ps_to.sc_top - ps_to.sc_arena;

	split_to_block();		/* Put final free block back to the free list */

	if (0 == sweep_from_space()) {	/* Clean up 'from' space */

#ifdef DEBUG
		dprintf(1)("clean_zones: 'from' zone is completely empty\n");
		flush;
#endif

		/* For malloc, set the B_LAST bit to indicate that the block held
		 * in the space is the last one in the chunk (remember, we use
		 * standard chunks only).
		 */
		((union overhead *) ps_from.sc_arena)->ov_size |= B_LAST;

		/* The whole 'from' space is now free. If the 'to' space holds at least
		 * one object, then this will become the new 'to' space. Otherwise, we
		 * keep the same 'to' space and the 'from' space is put back to the
		 * free list.
		 */

		if (ps_to.sc_arena == ps_to.sc_top) {

#ifdef DEBUG
			dprintf(1)("clean_zones: 'from' zone freed (%d bytes)\n",
				((union overhead *) ps_from.sc_arena)->ov_size & B_SIZE);
			flush;
#endif

			/* The 'to' space is empty -- Free the 'from' space but keep the
			 * to zone for next scavenge (it's so hard to find). Before
			 * freeing the scavenge zone, do not forget to set the B_BUSY
			 * flag for xfree. The number of 'to' zones allocated is also
			 * decreased by one, since its allocation is compensated by the
			 * release of the from space (well, sort of).
			 */

			((union overhead *) ps_from.sc_arena)->ov_size |= B_BUSY;
			xfreechunk(ps_from.sc_arena + OVERHEAD);	/* One big bloc */
			memset (&ps_from, 0, sizeof(struct sc_zone));	/* Was freed */
			g_data.gc_to--;

		} else {

			/* The 'to' space holds at least one object (normal case). The
			 * 'from' space is completely empty and will be the next 'to' space
			 * in the next partial scavenging.
			 */

			memcpy (&ps_to, &ps_from, sizeof(struct sc_zone));
			ps_to.sc_flgs = ((union overhead *) ps_from.sc_arena)->ov_size;

#ifdef DEBUG
			dprintf(1)("clean_zones: 'from' zone kept for next 'to'\n");
			flush;
#endif
		}
		return;
	}

	/* Chunk is spoilt. Add it in the search table, so that we do not try to
	 * scavenge this space again.
	 */

	if (spoilt_tbl == (struct s_table *) 0)
		spoilt_tbl = s_create(SPOILT_TBL);

	if (spoilt_tbl != (struct s_table *) 0)
		(void) s_put(spoilt_tbl, ps_from.sc_arena);

	/* The whole 'from' space is not free, but the 'to' space may well be if
	 * by chance all the Eiffel objects in 'from' where garbage. The 'to' space
	 * is hence kept for next scavenge unless there is something.
	 */
	if (ps_to.sc_arena == ps_to.sc_top)		/* To space is empty */
		return;

	ps_to.sc_arena = (EIF_REFERENCE) 0;		/* Signals: no valid 'to' space */
}

rt_private void init_plsc(void)
{
	/* Set a correct status for the garbage collector, so that the recursive
	 * mark process knows about what we are doing. If we are unable to get
	 * a valid 'to' zone for the scavenge, a simple mark and sweep will be done.
	 */

	if (0 == find_scavenge_spaces())
		g_data.status = (char) ((gen_scavenge & GS_ON) ? GC_PART | GC_GEN : GC_PART);
	else
		g_data.status = (char) ((gen_scavenge & GS_ON) ? GC_GEN : 0);

	/* If partial scavenging was not activated, make sure no scavenge space is
	 * recorded at all, to avoid problems with malloc and core releasing.
	 */

	if (!(g_data.status & GC_PART)) {
		ps_from.sc_arena = (EIF_REFERENCE) 0;		/* Will restart from end */
		if (ps_to.sc_arena != (EIF_REFERENCE) 0) {	/* One chunk was kept in reserve */
			/* Somehow, it is important to make sure the one big block in the
			 * empty 'from' space is marked as busy, otherwise we will get
			 * into trouble when we try to put it back into the free list.
			 */
			((union overhead *) ps_to.sc_arena)->ov_size |= B_BUSY;
			xfreechunk(ps_to.sc_arena + OVERHEAD);
			ps_to.sc_arena = (EIF_REFERENCE) 0;	/* No to zone yet */
		}
	}
}

rt_private void split_to_block(void)
{
	/* The 'to' space may well not be full, and the free part at the end has
	 * to be returned to the free list.
	 *
	 * I do not want to interfere with the malloc package more than necessary,
	 * (I mean, at the implementation level), so I'm calling the low levels
	 * procedures of malloc to do the dirty job for me.
	 *
	 * For the rare but possible case where everything in the 'from' space was
	 * garbage, the 'to' space is empty, we do nothing, leaving the block in
	 * its original state. The block will then be kept for the next scavenging,
	 * only the 'from' space will change.
	 */
	union overhead *base;	/* Base address */
	uint32 size;			/* Amount of bytes used (malloc point's of view) */
	uint32 old_size;		/* To save the old size for the leading object */

	base = (union overhead *) ps_to.sc_arena;
	size = ps_to.sc_top - (EIF_REFERENCE) base;	/* Plus overhead for first block */

	if (size != 0) {		/* Some objects were scavengend */

		/* I'm faking a big block which will hold all the scavenged object,
		 * so that split_block() will be fooled and correctly split the block
		 * after the last scavenged object--RAM. In fact, I'm restoring the
		 * state the space was in when it was selected for a scavenge.
		 * The malloc flags attached to the 'to' zone are restored. The two
		 * which matters are B_LAST and B_CTYPE (needed by split_block).
		 */

		old_size = base->ov_size;			/* Save size of 1st block */
		base->ov_size = ps_to.sc_flgs;		/* Malloc flags for whole space */
		(void) split_block(base, size - OVERHEAD);
		base->ov_size = old_size;			/* Restore 1st block integrity */

#ifdef DEBUG
		dprintf(1)("split_to_block: new 'to' is now %d bytes [0x%lx, 0x%lx[\n",
			size, base, ps_to.sc_top);
		dprintf(1)("split_to_block: released %d bytes (starting at 0x%lx)\n",
			ps_to.sc_end - ps_to.sc_top, (EIF_REFERENCE) base + size);
		flush;
#endif

		/* Update accounting information: the split_block() routine only update
		 * the overhead usage, because it assumes the block it is splitting is
		 * still "used", so the split only appears to add overhead. This is not
		 * the case here. We also free some memory which was accounted as used.
		 */

		size = ps_to.sc_end - ps_to.sc_top;		/* Memory unused (freed) */

		m_data.ml_used -= size;
		if (ps_to.sc_flgs & B_CTYPE)
			c_data.ml_used -= size;
		else {
			e_data.ml_used -= size;
#ifdef MEM_STAT
		printf ("Eiffel: %ld used (-%ld), %ld total (split_to_block)\n",
			e_data.ml_used, size, e_data.ml_total);
#endif
		}

		return;
	}

#ifdef DEBUG
	dprintf(1)("split_to_block: no object was scavenged ('to' empty)\n");
	flush;
#endif
}

rt_private int sweep_from_space(void)
{
	/* After a scavenging, the 'ps_from' zone has to be cleaned up. If by
	 * chance the whole zone is free, it will be kept for the next 'to' zone,
	 * unless that one is also empty in which case the 'from' space will be
	 * returned to the free list anyway. If only one C block remains, then
	 * every block is freed, after having been coalesced.
	 * Note that the coalescing has to be done manually. I would prefer to use
	 * the coalesc() routine in the malloc package, but it assumes that the
	 * coalesced block belongs to the free list, which is not true here.
	 * The function returns 0 if the whole space is free, -1 otherwise.
	 * When this function produces a big free block (i.e. when it returns 0),
	 * that block should carry the B_LAST bit. Currently, it is added by the
	 * caller because there is no reason this should be true if we did not use
	 * standard chunks.
	 */
	register1 union overhead *zone;		/* Currently inspected block */
	register2 union overhead *next;		/* Address of next block */
	register3 uint32 flags;				/* Malloc flags and size infos */
	register4 EIF_REFERENCE end;				/* First address beyond from space */
	register5 uint32 dtype;				/* Dynamic type of object */
	EIF_REFERENCE base;							/* First address of 'from' space */
	int size;							/* Size of current object */
	char gc_status;						/* Saved GC status */

	base = ps_from.sc_arena;
	zone = (union overhead *) base;		/* Start of from space */
	end = ps_from.sc_end;				/* End of zone */
	flags = zone->ov_size;				/* Malloc information flags */

#ifdef DEBUG
	dprintf(1)("sweep_from_space: chunk from 0x%lx to 0x%lx (excluded)\n",
		base, end);
	flush;
#endif

	for (;;) {

		/* Loop until we reach an Eiffel block */
		for (
			next = (union overhead *)
				(((EIF_REFERENCE) zone) + (flags & B_SIZE) + OVERHEAD);
			flags & B_C;
			next = (union overhead *)
				(((EIF_REFERENCE) zone) + (flags & B_SIZE) + OVERHEAD)
		) {

#ifdef DEBUG
			dprintf(8)("sweep_from_space: found a %d bytes C block at 0x%lx\n",
				zone->ov_size & B_SIZE, zone + 1);
			flush;
#endif

			/* Make sure object is unmarked (could be a frozen Eiffel object).
			 * The C objects do not use the EO_MARK bit so there is no need
			 * for tests.
			 */
			
			zone->ov_flags &= ~EO_MARK;	/* Unconditionally unmark object */
			zone = next;				/* Advance to next object */
			if ((EIF_REFERENCE) zone >= end)	/* This zone block was the last one */
				break;
			flags = zone->ov_size;		/* Update flags for loop tests */
		}

		/* Either we reached an Eiffel block, a free block or the end of the
		 * 'from' space. I could have tested for the B_LAST bit to check for
		 * one big free block at the head instead of comparing zone and base.
		 * Never mind, this would have added a test whereas the one here is
		 * mandatory--RAM.
		 */

		if ((EIF_REFERENCE) zone >= end)		/* Seems we reached the end of space */
			return -1;					/* 'from' holds at least one C block */
	
#ifdef DEBUG
		dprintf(8)(
		"sweep_from_space: %sfound a %s %s%s%sblock (%d bytes) at 0x%lx\n",
			(EIF_REFERENCE) zone == base ? "" : "(spoilt) ",
			zone->ov_size & B_LAST ? "last" : "normal",
			zone->ov_size & B_BUSY ? "" : "free ",
			zone->ov_size & B_FWD ? "" : "dead ",
			zone->ov_size & B_C ? "BUG " : "",
			zone->ov_size & B_SIZE,
			zone + 1);
		flush;
#endif

		/* Every free block has to be extracted from the free list for
		 * coalescing to occur safely. Non-free blocks which are dead
		 * have to be "dispose"ed properly. Memory accounting has to be
		 * performed diligently, but, halas (!), this simply undoes the work
		 * done during the allocation. And all that overhead will be there for
		 * nothing if the space is spoilt and has to be freed.
		 */

		size = flags & B_SIZE;		/* Pre-compute that guy */

		if (flags & B_BUSY) {		/* We reached a busy block */

			/* Update statistics: every block we extract from the free list and
			 * every dead object we find here is still "used" in the sense that
			 * it is part of a scavenge zone which is still allocated in memory.
			 */

			if (!(flags & B_FWD)) {	/* Non-forwarded block is dead */
				dtype = Deif_bid(zone->ov_flags);		/* Dispose ptr */
				if (Disp_rout(dtype)) {					/* Exists ? */
					gc_status = g_data.status;			/* Save GC current status */
					g_data.status |= GC_STOP;			/* Stop GC */
					DISP(dtype, (EIF_REFERENCE) (zone + 1));	/* Call it */
					g_data.status = gc_status;			/* Restart GC */
				}
				CHECK ("Cannot be in object ID stack",
					!has_object (&object_id_stack, (EIF_REFERENCE) zone + 1));
			}
		} else {
			lxtract(zone);			/* Extract it from free list */
			m_data.ml_used += size;	/* Memory accounting */
			if (flags & B_CTYPE)	/* Bloc is in a C chunk */
				c_data.ml_used += size;
			else								
				e_data.ml_used += size;
		}

		/* Whenever we reach a "first" block which will be the first one in the
		 * coalesced block, we MUST make sure it is marked B_BUSY. In the event
		 * the whole coalesced block would be freed (e.g. when we reach a C
		 * block), xfree() would be called and that would be a no-op if no
		 * B_BUSY mark was carried. Of course, the 'flags' variable, which is
		 * carrying the original version of the malloc flags is left
		 * undisturbed.
		 */

		zone->ov_size |= B_BUSY;	/* Or free would not do anything */

		/* Loop over the Eiffel/free blocks and merge them into one (as
		 * described in the 'zone' header). Stop at the end of the space or
		 * when a C block is reached.
		 */
		for (
			/* empty */;
			!(flags & B_C) && (EIF_REFERENCE) next < end;
			next = (union overhead *)
				(((EIF_REFERENCE) next) + size + OVERHEAD)
		) {
			flags = next->ov_size;			/* Fetch flags for next loop */

#ifdef DEBUG
			dprintf(8)(
			"sweep_from_space: followed by a %s %s%sblock (%d bytes) at 0x%lx\n",
				next->ov_size & B_LAST ? "last" : "normal",
				next->ov_size & B_BUSY ? "" : "free ",
				next->ov_size & B_C ? "C " : next->ov_size & B_FWD ? "":"dead ",
				next->ov_size & B_SIZE,
				next + 1);
			flush;
#endif

			if (flags & B_C)		/* Current block followed by a C one */
				break;				/* Coalescing has to stop here */

			/* Any coalesced free block must be removed from the free list,
			 * otherwise, if the coalesced block is finally freed because
			 * the space is spoilt, the block will be listed twice in the list,
			 * once in the original entry and once as being part of a bigger
			 * block. Gulp!
			 * Other non-forwarded blocks are dead and dispose is called if
			 * necessary.
			 */

			size = flags & B_SIZE;		/* Pre-compute that guy */

			if (flags & B_BUSY) {		/* We reached a busy block */

				/* I don't expect any overflow which could corrupt the flags.
				 * The updating of the overhead is only done when the object
				 * was dead, otherwise its overhead has been transferred to
				 * the other scavenging zone (we are talking about partial
				 * scavenging here, so there is no tenuring involved)--RAM.
				 */

				if (!(flags & B_FWD)) {	/* Non-forwarded block is dead */
					dtype = Deif_bid(next->ov_flags);	/* Dispose ptr */
					if (Disp_rout(dtype)) {				/* Exists ? */
						gc_status = g_data.status;		/* Save GC current status */
						g_data.status |= GC_STOP;		/* Stop GC */
						DISP(dtype,(EIF_REFERENCE) (next + 1));/* Call it */
						g_data.status = gc_status;		/* Restore previous GC status */
					}
					CHECK ("Cannot be in object ID stack",
						!has_object (&object_id_stack, (EIF_REFERENCE) next + 1));

					m_data.ml_over -= OVERHEAD;		/* Memory accounting */
					m_data.ml_used += OVERHEAD;		/* Overhead is used */
					if (flags & B_CTYPE) {
						c_data.ml_over -= OVERHEAD;	/* Overhead is decreasing */
						c_data.ml_used += OVERHEAD;
					} else {
						e_data.ml_over -= OVERHEAD;	/* Block in Eiffel chunk */
						e_data.ml_used += OVERHEAD;
#ifdef MEM_STAT
		printf ("Eiffel: %ld used (+%ld), %ld total (sweep_from_space)\n",
			e_data.ml_used, OVERHEAD, e_data.ml_total);
#endif
					}
				}
			} else {
				lxtract(next);					/* Remove it from free list */
				m_data.ml_over -= OVERHEAD;		/* Memory accounting */
				m_data.ml_used += OVERHEAD + size;
				if (flags & B_CTYPE) {			/* Bloc is in a C chunk */
					c_data.ml_over -= OVERHEAD;	/* Overhead is decreasing */
					c_data.ml_used += OVERHEAD + size;
				} else {
					e_data.ml_over -= OVERHEAD;	/* Block in Eiffel chunk */
					e_data.ml_used += OVERHEAD + size;
#ifdef MEM_STAT
		printf ("Eiffel: %ld used (+%ld), %ld total (sweep_from_space)\n",
			e_data.ml_used, OVERHEAD + size, e_data.ml_total);
#endif
				}
			}

			zone->ov_size += size + OVERHEAD;	/* Do coalescing */

#ifdef DEBUG
			dprintf(8)("sweep_from_space: coalesced %s block is now %d bytes\n",
				zone->ov_flags & B_BUSY ? "busy" : "free",
				zone->ov_size & B_SIZE);
			flush;
#endif
		}

		/* Either we reached a C block or the end of the 'from' space. In case
		 * we have a last block to free within a spoilt zone, we have to set
		 * the B_LAST bit, in case we coalesced on the fly.
		 */

		if ((EIF_REFERENCE) next >= end) {		/* We reached the end */

#ifdef DEBUG
			if ((EIF_REFERENCE) zone != base)
				dprintf(8)("sweep_from_space: freed %d bytes (zone spoilt)\n",
					zone->ov_size & B_SIZE);
			flush;
#endif

			if ((EIF_REFERENCE) zone == base)		/* The whole space is free */
				return 0;					/* 'from' may become next 'to' */
			else {							/* At least one C block */
				zone->ov_size |= B_LAST;	/* Ensure malloc sees it as last */
				xfree((EIF_REFERENCE) (zone + 1));	/* Back to free list */
				return -1;					/* Space is spoilt */
			}
		}

#ifdef DEBUG
		dprintf(8)("sweep_from_space: giving %d bytes to free list\n",
			zone->ov_size & B_SIZE);
		flush;
#endif

		/* We must have reached a C block, which means we can free the block.
		 * Free the coalesced block we have so far, starting at zone and reset
		 * the coalescing base to the next object. We will then enter the first
		 * loop which walks other the C blocks, and this loop will unmark the
		 * current object.
		 * This routine is a mess and needs rewriting--RAM.
		 */

		xfree((EIF_REFERENCE) (zone + 1));		/* Put block back to free list */
		zone = next;					/* Reset coalescing base */
	}
	/* NOTREACHED */
}

rt_private int find_scavenge_spaces(void)
{
	/* Look for a 'from' and a 'to' space for partial scavenging. Usually, the
	 * Eiffel memory is viewed as a cyclic memory, where the old 'from' becomes
	 * the 'to' space and the next 'from' will be the chunk following the new
	 * 'to' (i.e the old 'from') until 'to' is near the break, at which point
	 * it is given back to the kernel.
	 * Note that only the standard chunks (i.e. those whose size is CHUNK) are
	 * taken into account by the scavenging process, for reasons that are too
	 * disgusting to be revealed here--RAM.
	 * The function returns 0 if all is ok, -1 otherwise.
	 */
#if defined EIF_NO_SCAVENGING || defined EIF_THREADS
	/* In MT mode, we do not want the object out of the scavenge zone 
	 * to move. */
	return -1;
#else	/* EIF_NO_SCAVENGING */
	EIF_GET_CONTEXT
	int from_size;					/* Size of selected 'from' space */
	EIF_REFERENCE to_space;					/* Location of the 'to' space */

#ifdef DEBUG
	dprintf(1)("find_scavenge_spaces: last from was 0x%lx\n", last_from);
	flush;
#endif

	/* Whenever a scavenge zone is released via rel_core() from malloc, or at
	 * the beginning of the program, the ps_from and ps_to structure are filled
	 * in with zeros, which means their sc_arena field is a null pointer.
	 */

	if (ps_from.sc_arena == (EIF_REFERENCE) 0)		/* From zone was freed */
		last_from = (struct chunk *) 0;		/* Restart from the end */

	if (last_from == (struct chunk *) 0) 	/* Reached the end of the list */
		last_from = find_std_chunk(cklst.eck_tail);			/* Restart */
	else {
		last_from = find_std_chunk(last_from->ck_lprev);	/* Advance */
		if (last_from == (struct chunk *) 0)				/* None valid ? */
			last_from = find_std_chunk(cklst.eck_tail);		/* Restart */
	}
	
#ifdef DEBUG
	dprintf(1)("find_scavenge_spaces: from space is now 0x%lx\n", last_from);
	flush;
#endif

	if (last_from == (struct chunk *) 0) 	/* There are no standard chunks */
		return -1;

	/* Water-mark is unused by the partial scavenging algorithm */
	from_size = last_from->ck_length;				/* Record length */
	ps_from.sc_size = from_size;					/* Subject to copying */
	ps_from.sc_arena = (EIF_REFERENCE) (last_from + 1);	/* Overwrites first header */
	ps_from.sc_end = ps_from.sc_arena + from_size;	/* First location beyond */
	ps_from.sc_top = ps_from.sc_arena;				/* Empty for now */

	if (ps_to.sc_arena != (EIF_REFERENCE) 0) {

#ifdef DEBUG
		dprintf(1)("find_scavenge_spaces: from [0x%lx, 0x%lx] to [0x%lx, 0x%lx]\n",
			ps_from.sc_arena, ps_from.sc_end - 1,
			ps_to.sc_arena, ps_to.sc_end - 1);
#endif

		return 0;			/* We already have a 'to' space */
	}

	find_to_space(&ps_to);	/* Try to find a 'to' space by coalescing */
	if (ps_to.sc_arena)		/* It worked */
		return 0;			/* We got our 'to' space */

	/* We cannot indefinitely ask for malloced chunks, as the size of the
	 * process may increase each time we do so... Therefore, we count each
	 * time we do so and are allowed at most TO_MAX allocations. Passed this
	 * limit, there cannot be any partial scavenging, at least for this cycle.
	 * Note that when core is released to the kernel, the count of malloc'ed
	 * 'to' zones decreases accordingly.
	 */

	if (g_data.gc_to >= TO_MAX || e_data.ml_chunk < CHUNK_MIN)
		return -1;						/* Cannot allocate a 'to' space */

	/* Find a 'to' space.
	 * We ask for more core, I repeat: we ask for more core. If this fails, then no
	 * scavenging will be done. This is why it is so important to be able to
	 * always have a 'to' handy for the next scavenge (i.e. no C blocks in the
	 * 'from' space).
	 * It's necessary to have the 'to' space in the Eiffel space, so I call a
	 * somewhat low-level malloc routine.
	 *
	 * The get_to_from_core replaces the previous call to gmalloc which used
	 * to get a to_space anywhere in the free list. But we want a standard
	 * empty chunk and if we arrive here, the only way to get a free chunk
	 * is to get it from the kernel. It does not happen so often. Usually
	 * it happens the first time partial scavenging is called.
	 * Fixes random-string-blank-panic and random-array-alloc-loop.
	 * -- Fabrice.
	 */

	to_space = get_to_from_core(from_size - OVERHEAD);	/* Allocation from free list */
	if ((EIF_REFERENCE) 0 == to_space)
		return -1;			/* Unable to find a 'to' space */
	
	/* The 'to' space will see its header overwritten, which is basically why
	 * we have to save the flags associated with the arena. When it's time to
	 * split the 'to' block, we can always fake the original block by saving the
	 * size header (which belongs to the first scavenged object), restoring the
	 * original, doing the split and finally restoring the saved header.
	 */

	g_data.gc_to++;								/* Count 'to' zone allocation */
	ps_to.sc_arena = to_space - OVERHEAD;		/* Overwrite the header */
	ps_to.sc_flgs = HEADER(to_space)->ov_size;	/* Save flags */
	ps_to.sc_size = from_size;					/* Used for statistics */
	ps_to.sc_end = ps_to.sc_arena + from_size;	/* First free location beyond */
	ps_to.sc_top = ps_to.sc_arena;				/* Is empty */

#ifdef DEBUG
	dprintf(1)("find_scavenge_spaces: malloc'ed a to space at 0x%lx (#%d)\n",
		ps_to.sc_arena, g_data.gc_to);
	dprintf(1)("find_scavenge_spaces: from [0x%lx, 0x%lx] to [0x%lx, 0x%lx]\n",
		ps_from.sc_arena, ps_from.sc_end - 1,
		ps_to.sc_arena, ps_to.sc_end - 1);
	flush;
#endif

	return 0;		/* Ok, we got a 'to' space */
#endif	/* EIF_NO_SCAVENGING */
}

rt_private struct chunk *find_std_chunk(register struct chunk *start)
{
	/* Find a standard chunk (i.e. one whose size is CHUNK), starting at the
	 * chunk 'start'. Return the pointer to the one found, or a null pointer
	 * if none was found in the Eiffel list.
	 */

	register2 int std_size = eif_chunk_size - sizeof(struct chunk);

	for (/* empty */; start != (struct chunk *) 0; start = start->ck_lprev) {

#ifdef DEBUG
		dprintf(4)("find_std_chunk: chunk 0x%lx is %d (std is %d)\n",
			start, start->ck_length, std_size);
		flush;
#endif

		if (start->ck_length != std_size)		/* Not a standard chunk */
			continue;

		/* If there is a spoilt table, make sure the chunk is not recoded there,
		 * since we do not want to deal with those spoilt chunks more than once.
		 */
		if (spoilt_tbl != (struct s_table *) 0)
			if (EIF_SEARCH_FOUND == s_search(spoilt_tbl, (EIF_REFERENCE) (start + 1)))
				continue;

		/* Skip the active 'to' space, if any: we must not have 'from' and
		 * 'to' at the same location, otherwise it's a 4 days bug--RAM.
		 */
		if (ps_to.sc_arena != (EIF_REFERENCE) (start + 1))	/* Used ? */
			return start;							/* No, it's ok */
	}

	return (struct chunk *) 0;		/* No standard size chunk found */
}

#if !(defined EIF_NO_SCAVENGING  || defined EIF_THREADS)
rt_private void find_to_space(struct sc_zone *to)
					/* The zone structure we want to fill in */
{
	/* Look for a suitable space which could be used by partial scanvenging
	 * as a 'to' zone. We are starting by looking at the end of the memory,
	 * and we walk back, focusing only on standard chunks. If the leading block
	 * in the chunk is free but not equal to the whole chunk, we even attempt
	 * block coalescing.
	 */
	register1 int std_size = eif_chunk_size - sizeof(struct chunk);
	register2 struct chunk *cur;	/* Current chunk we are considering */
	register3 uint32 flags = 0;		/* Malloc info flags */
	register4 EIF_REFERENCE arena = (EIF_REFERENCE) 0;	/* Where chunk's arena starts */

	for (cur = cklst.eck_tail; cur != (struct chunk *) 0; cur = cur->ck_lprev) {
		if (cur->ck_length != std_size)		/* Not a standard sized chunk */
			continue;						/* Skip it */
		arena = (EIF_REFERENCE) cur + sizeof(struct chunk);
		if (arena == ps_from.sc_arena)
			continue;						/* Skip scanvenging from space */
		flags = ((union overhead *) arena)->ov_size;
		if (flags & B_BUSY)					/* Leading block allocated */
			continue;						/* Chunk not completely free */
		if (!(flags & B_LAST))				/* Looks like a fragmented chunk */
			if (0 == chunk_coalesc(cur))	/* Coalescing was useless */
				continue;					/* Skip this chunk */
		flags = ((union overhead *) arena)->ov_size;
		if (flags & B_LAST)					/* One big happy free block */
			break;
	}

	if (cur == (struct chunk *) 0)		/* Did not find any suitable chunk */
		return;
	CHECK ("Flags must be initialized", flags != 0);
	CHECK ("Arena must be initialized", arena != (EIF_REFERENCE) 0);

	/* Initialize scavenging zone. Note that the arena of the zone starts at
	 * the header of the first block, but we save the malloc flags so that we
	 * can restore the block later when it is time to put it back to the free
	 * list world.
	 */

	to->sc_top = to->sc_arena = arena;
	to->sc_flgs = flags;
	to->sc_end = to->sc_arena + (flags & B_SIZE) + OVERHEAD;

	/* This zone is now used for scavening, so it must be removed from the free
	 * list so that further mallocs do not attempt to use this space (when
	 * tenuring, for instance). Also the block is used from the statistics
	 * point of view.
	 */

	lxtract((union overhead *) arena);	/* Extract block from free list */

	m_data.ml_used += (flags & B_SIZE) + OVERHEAD;
	if (flags & B_CTYPE)
		c_data.ml_used += (flags & B_SIZE) + OVERHEAD;
	else
		e_data.ml_used += (flags & B_SIZE) + OVERHEAD;

#ifdef DEBUG
	dprintf(1)("find_to_space: coalesced a to space at 0x%lx (#%d)\n",
		ps_to.sc_arena, g_data.gc_to);
	dprintf(1)("find_to_space: from [0x%lx, 0x%lx] to [0x%lx, 0x%lx]\n",
		ps_from.sc_arena, ps_from.sc_end - 1,
		ps_to.sc_arena, ps_to.sc_end - 1);
	flush;
#endif
}
#endif

rt_shared EIF_REFERENCE to_chunk(void)
{
	/* Return the address of the 'to' chunk used by partial scavenging. The
	 * structure 'ps_to' is private but malloc needs the address when it
	 * attempts to release some core. The address returned is the first one
	 * which will be used, i.e. the start of the header block.
	 */

	if (ps_to.sc_arena == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

	return ps_to.sc_arena;
}

rt_private EIF_REFERENCE scavenge(register EIF_REFERENCE root, struct sc_zone *to)
{
	/* The object pointed to by 'root' is to be scavenged in the 'to' space,
	 * provided it is not an expanded object (otherwise, it has already been
	 * scavenged as part of the object that holds it). The function returns the
	 * pointer to the new object's location, in the 'to' space.
	 */
	register2 union overhead *zone;	/* Malloc info header */
	int length;						/* Length of scavenged object */

	REQUIRE ("Algorithm moves objects",
			g_data.status & (GC_GEN | GC_PART) || g_data.status & GC_FAST);

	zone = HEADER(root);

	/* Expanded objects are held in one object, and a pseudo-reference field
	 * in the father object points to them. However, the scavenging process
	 * does not update this reference. Instead, the expanded header knows how to
	 * reach the header of the father object. If scavenging is on, we reach the
	 * expanded once the father has been scavenged, and we get the new address
	 * by following the forwarding pointer left behind. Nearly a kludge.
	 * Let A be the address of the original object (zone below) and A' (new) the
	 * address of the scavenged object (given by following the forwarding
	 * pointer left) and P the pointed expanded object in the original (root).
	 * Then the address of the scavenged expanded is A'+(P-A).
	 */
	if (zone->ov_flags & EO_EXP) {
			/* Compute original object's address (before scavenge) */
		EIF_REFERENCE exp;					/* Expanded data space */
		EIF_REFERENCE new;					/* New object's address */
		zone = (union overhead *) ((EIF_REFERENCE) zone - (zone->ov_size & B_SIZE));
		if (!(zone->ov_size & B_FWD))
			return root;
		new = zone->ov_fwd;			/* Data space of the scavenged object */
		exp = new + (root - (EIF_REFERENCE) (zone + 1));	/* New data space */
		return exp;					/* This is the new location of expaded */
	}

	CHECK ("Not in Generation Scavenge TO zone",
		!((g_data.status & GC_GEN) &&
		(root > sc_to.sc_arena) && 
		(root <= sc_to.sc_end))
	);				
	CHECK ("Not in Partial Scavenge TO zone.",
		!((g_data.status & GC_PART) &&
		(root > ps_to.sc_arena) && 
		(root <= ps_to.sc_end))
	);

	/* If an Eiffel object holds the B_C mark (we know it's an Eiffel object
	 * because it is referenced by an Eiffel object), then simply ignore it.
	 * It is important to mark the object though, because it might be a frozen
	 * object part of the remembered set, and it will be removed if it is not
	 * marked. Besides, we need to cut recursion to prevent loops.
	 */
	if (zone->ov_size & B_C) {
		if (!(zone->ov_flags & EO_C))	/* Not a C object */
			zone->ov_flags |= EO_MARK;	/* Mark it */
		return root;					/* Leave object where it is */
	}

	root = to->sc_top;						/* New location in 'to' space */
	length = (zone->ov_size & B_SIZE) + OVERHEAD;
	to->sc_top += length;					/* Update free-location pointer */
	memcpy (root, zone, length);			/* The scavenge process itself */
	zone->ov_fwd = root + OVERHEAD;			/* Leave forwarding pointer */
#ifdef EIF_NO_SCAVENGING
	eif_panic ("Scavenging is not disabled");
#endif	/* EIF_NO_SCAVENGING */
	zone->ov_size |= B_FWD;					/* Mark object as forwarded */

	/* If we reached the end of the scavenge space, then the B_LAST flag
	 * must be already set on the new object (size of from and to spaces are
	 * identical). Otherwise, it has to be reset. Of course, this does not make
	 * sense when scavenging in a generational zone...
	 */

	if (to != &sc_to) {						/* Not in generation scavenging */
		if (to->sc_top == to->sc_end)		/* At end of space? */
			((union overhead *) root)->ov_size |= B_LAST;
		else
			((union overhead *) root)->ov_size &= ~B_LAST;
	}

#ifdef MAY_PANIC
	if (to->sc_top > to->sc_end) {			/* Uh-oh! Zone has overflowed */
		if (to == &sc_to)					/* Identify culprit */
			eif_panic("generation zone overflow");
		else
			eif_panic("scavenge zone overflow");
	}
#endif

#ifdef DEBUG
	dprintf(2)(
		"scavenge: %sobject %lx moved to %lx (%d bytes) for %s scavenging\n",
		to == &sc_to ? "" : (zone->ov_size & B_BUSY ? "" : "FREE? "),
		zone + 1, zone->ov_fwd, length - OVERHEAD,
		to == &sc_to ? "generation" : "partial");
	flush;
#endif

	return root + OVERHEAD;			/* New object's location */
}

/* Generation-based collector. This is a non incremental fast collector, which
 * is derived from Ungar's papers (ACM 1984 and OOPSLA'88). Provision is made
 * for both generation collection and generation scavenging.
 */

rt_public int collect(void)
{
	/* The generational collector entry point, with statistics updating. The
	 * time spent in the algorithm is monitored by scollect and accessible
	 * to the user via MEMORY primitives.
	 */

	int result;
	result = scollect(generational_collect, GST_GEN);
	return result;
}

rt_private int generational_collect(void)
{
	/* Generation collector -- The new generation is completely collected
	 * and survival objects are tenured (i.e. promoted to the old generation).
	 * The routine returns 0 if collection performed normally, -1 if GC is
	 * stopped or generation scavenging was stopped for some reason.
	 */

	EIF_GET_CONTEXT
	register1 int age;			/* Computed tenure age */
	register2 int overused;		/* Amount of data over watermark */
	EIF_REFERENCE watermark;			/* Watermark in generation zone */

	if (g_data.status & GC_STOP)
		return -1;				/* Garbage collection stopped */

	SIGBLOCK;					/* Block signals during garbage collection */
	g_data.status = GC_FAST;	/* Fast generation collection */
	g_data.nb_partial++;		/* One more partial collection */

#ifdef DEBUG
	dprintf(1)("collect: tenure age is %d for this cycle\n", tenure);
	flush;
#endif

	mark_new_generation(MTC_NOARG);		/* Mark all new reachable objects */
	full_update();				/* Sweep the youngest generation */
	if (gen_scavenge & GS_ON)
		swap_gen_zones();		/* Swap generation scavenging spaces */

	/* Compute the tenure for the next pass. If generation scavenging is on,
	 * we use Ungar's feedback technique on the size_table array, otherwise
	 * the age_table array is used.
	 */

	tenure = eif_tenure_max;

	if ((gen_scavenge & GS_ON) && (!(gen_scavenge & GS_STOP))) {

		/* Generation scavenging is on and has not been stopped. If less than
		 * the watermark is used, set tenure to eif_tenure_max, 
		 * to avoid tenuring for the next cycle. Otherwise, set it so 
		 * that we tenure at least
		 * 'overused' bytes next cycle. GS_FLOATMARK is set to 40% of the
		 * scavenge zone size and lets us get some free space to let other
		 * young objects die, hopefully.
		 * When compiled for speed however, we do not want to spend our time
		 * copying objects back and forth too many times. So in this case,
		 * we test for the watermark minus GS_FLOATMARK to maintain at least
		 * that space free. This should limit collection racing when objects
		 * are allocated at a high rate, at the price of more memory usage,
		 * since this will incur some tenuring.
		 */
		
		watermark = cc_for_speed ? sc_from.sc_mark - GS_FLOATMARK : sc_from.sc_mark;

		if (sc_from.sc_top >= watermark) {
			overused = sc_from.sc_top - sc_from.sc_mark + GS_FLOATMARK;
			for (age = eif_tenure_max - 1; age >= 0; age--) {
				overused -= size_table[age];	/* Amount tenured at 'age' */
				if (overused <= 0)
					break;
			}
			tenure = age;		/* Tenure threshold for next cycle */
		}
	}

	/* Deal with the objects in the chunk space. Our aim is to limit the number
	 * of young objects to OBJ_MAX, so that we do not spend a considerable time
	 * walking through the moved set and the remembered set.
	 */
	
	overused = 0;
	for (age = 0; age < eif_tenure_max; age++)
		overused += age_table[age];

#ifdef DEBUG
	dprintf(1)("collect: %d objects in moved set\n", overused);
	dprintf(1)("collect: scavenged %d bytes (%d bytes free in zone)\n",
		sc_from.sc_top - sc_from.sc_arena, sc_from.sc_end - sc_from.sc_top);
#endif

	if (overused > OBJ_MAX) {
		overused -= OBJ_MAX;				/* Amount of spurious objects */
		for (age = eif_tenure_max - 1; age >= 0; age--) {
			overused -= age_table[age];		/* Amount tenured at 'age' */
			if (overused <= 0)
				break;
		}
		tenure = tenure < age ? tenure : age;	/* Tenure for next cycle */
	}

	/* We have computed the tenure based on the current state, but at the next
	 * cycle, the objects will be one generation older, so we have to increase
	 * the tenure limit by one, in not at eif_tenure_max - 1 or above.
	 */

	if (tenure < eif_tenure_max - 1)
		tenure++;

#ifdef DEBUG
	dprintf(1)("collect: tenure fixed to %d for next cycle\n", tenure);
	flush;
#endif

	SIGRESUME;			/* Restore signal handling and dispatch queued ones */

	return (gen_scavenge & GS_STOP) ? -1 : 0;	/* Signals error if stopped */
}

rt_private void mark_new_generation(EIF_CONTEXT_NOARG)
{
	/* Genration mark phase -- All the young objects which are reachable
	 * from the remembered set are alive. Old objects have reached immortality,
	 * not less--RAM. We must not forgive new objects that are referenced only
	 * via new objects. The new generation is described by the moved set.
	 * I am aware of the code duplication, but this is a trade for speed over
	 * run-time size and maintainability--RAM.
	 */
#ifdef EIF_THREADS
	int i;
#endif
	register1 int age;					/* Object's age */
	int moving = gen_scavenge & GS_ON;	/* May objects be moved? */

	/* First, reset the age tables, so that we can recompute the tenure
	 * threshold for the next pass (feedback).
	 */
	for (age = 0; age < eif_tenure_max; age++)
		size_table[age] = age_table[age] = (uint32) 0;

	/* First deal with the root object. If it is not old, then mark it */
	if (!(HEADER(root_obj)->ov_flags & EO_OLD))
		root_obj = GEN_SWITCH(root_obj);

#ifndef EIF_THREADS
	/* The regular Eiffel variables have their values stored directly within
	 * the loc_set stack. Those variables are the local roots for the garbage
	 * collection process.
	 */
	mark_stack(&loc_set, GEN_SWITCH, moving);

	/* Then deal with remembered set, which records the addresses of all the
	 * old objects pointing to new ones.
	 */
	mark_simple_stack(&rem_set, GEN_SWITCH, moving);

	/* The stack of local variables holds the addresses of variables
	 * in the process's stack which refers to the objects, hence the
	 * double indirection necessary to reach the objects.
	 */
	mark_stack(&loc_stack, GEN_SWITCH, moving);

	/* Once functions are old objects that are always alive in the system.
	 * They are all gathered in a stack and always belong to the old
	 * generation (thus they are allocated from the free-list). As with
	 * locals, a double indirection is necessary.
	 */
#if defined WORKBENCH
	mark_simple_stack(&once_set, GEN_SWITCH, moving);
#else
	mark_stack(&once_set, GEN_SWITCH, moving);
#endif

	/* The hector stacks record the objects which has been given to C and may
	 * have been kept by the C side. Those objects are alive, of course.
	 */
	mark_simple_stack(&hec_stack, GEN_SWITCH, moving);
	mark_simple_stack(&hec_saved, GEN_SWITCH, moving);

#ifdef WORKBENCH
	/* The operational stack of the interpreter holds some references which
	 * must be marked and/or updated.
	 */
	mark_op_stack(&op_stack, GEN_SWITCH, moving);

	/* The exception stacks are scanned. It is more to update the references on
	 * objects than to ensure these objects are indeed alive...
	 */
	mark_ex_stack(&eif_stack, GEN_SWITCH, moving);
	mark_ex_stack(&eif_trace, GEN_SWITCH, moving);
#else
	if (exception_stack_managed) {
		/* The exception stacks are scanned. It is more to update the references on
		 * objects than to ensure these objects are indeed alive...
		 */
		mark_ex_stack(&eif_stack, GEN_SWITCH, moving);
		mark_ex_stack(&eif_trace, GEN_SWITCH, moving);
	}
#endif
#else /* EIF_THREADS */
	for (i = 0; i < loc_set_list.count; i++)
		mark_stack(loc_set_list.threads.sstack[i], GEN_SWITCH, moving);

	mark_simple_stack(&rem_set, GEN_SWITCH, moving);

	for (i = 0; i < loc_stack_list.count; i++)
		mark_stack(loc_stack_list.threads.sstack[i], GEN_SWITCH, moving);

	mark_stack(&global_once_set, GEN_SWITCH, moving);

	for (i = 0; i < once_set_list.count; i++)
		mark_simple_stack(once_set_list.threads.sstack[i], GEN_SWITCH, moving);

	for (i = 0; i < hec_stack_list.count; i++)
		mark_simple_stack(hec_stack_list.threads.sstack[i], GEN_SWITCH, moving);
	for (i = 0; i < hec_saved_list.count; i++)
		mark_simple_stack(hec_saved_list.threads.sstack[i], GEN_SWITCH, moving);

#ifdef WORKBENCH
	for (i = 0; i < opstack_list.count; i++)
		mark_op_stack(opstack_list.threads.opstack[i], GEN_SWITCH, moving);
	for (i = 0; i < eif_stack_list.count; i++)
		mark_ex_stack(eif_stack_list.threads.xstack[i], GEN_SWITCH, moving);
	for (i = 0; i < eif_trace_list.count; i++)
		mark_ex_stack(eif_trace_list.threads.xstack[i], GEN_SWITCH, moving);

#else
	if (exception_stack_managed) {
		for (i = 0; i < eif_stack_list.count; i++)
			mark_ex_stack(eif_stack_list.threads.xstack[i], GEN_SWITCH, moving);
		for (i = 0; i < eif_trace_list.count; i++)
			mark_ex_stack(eif_trace_list.threads.xstack[i], GEN_SWITCH, moving);
	}
#endif

#endif /* EIF_THREADS */

#ifdef EIF_REM_SET_OPTIMIZATION 
	/* Finally, deal with special remembered objects set, which records 
	 * the old special objects, full of reference pointing to new ones. 
	 * (FIXME only hybrid_gen_mark support it.)
	 */

	mark_special_table(special_rem_set, GEN_SWITCH, moving);
#endif	/* EIF_REM_SET_OPTIMIZATION */

#if ! defined CUSTOM || defined NEED_OBJECT_ID_H
#ifdef CONCURRENT_EIFFEL
	/* The separate_object_id_set records object referenced by other processors */
	mark_simple_stack(&separate_object_id_set, GEN_SWITCH, moving);
#endif

	/* The object id stacks record the objects referenced by an identifier. Those objects
	 * are not necessarily alive. Thus only an update after a move is needed.
	 */
	if (moving) update_object_id_stack();
#endif
}

#ifdef RECURSIVE_MARKING
rt_private EIF_REFERENCE generation_mark(EIF_REFERENCE root)
{
	EIF_GET_CONTEXT
	/* This function is the same as recursive_mark() but slightly different :-).
	 * Hmm..., I know this is a bad comment and a bad practice, but, for once,
	 * it has to be done--RAM. In effect, I want to reduce the overhead on the
	 * recursive_mark() routine. This is why I wrote a different one for the
	 * generation-based collection.
	 * The function returns the address of the (possibly moved) object.
	 */

	union overhead *zone;		/* Malloc info zone fields */
	uint32 flags;				/* Eiffel flags */
	long offset;				/* Reference's offset */
	uint32 size;				/* Size of items (for array of expanded) */
	EIF_REFERENCE *object;				/* Sub-objects scanned */

	/* If 'root' is a void reference, return immediately */
	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

	zone = HEADER(root);			/* Malloc info zone */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(16)("generation_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			root,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	} else {
		dprintf(16)("generation_mark: 0x%lx %s%s%s%s(DT %d, %d bytes)\n",
			root,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_NEW ? "new " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
	flush;
#endif

	/* If we reach a marked object or a forwarded object, return immediately:
	 * the object has been already processed. Otherwise, an old object which
	 * is not remembered is not processed, as it can't reference any new
	 * objects. Old remembered objects are marked when they are processed,
	 * otherwise it would be possible to process it twice (once via a reference
	 * from another object and once because it's in the remembered list).
	 */

	if (zone->ov_size & B_FWD)		/* Object was forwarded (scavenged) */
		return zone->ov_fwd;		/* Return its new location */

	flags = zone->ov_flags;			/* Fetch Eiffel flags */
	if (flags & (EO_MARK | EO_C))	/* Object has been already processed? */
		return root;				/* Finished--object did not move */

	if (flags & EO_OLD) {			/* Old object unmarked */
		if (flags & EO_REM)			/* But remembered--mark it as processed */
			zone->ov_flags =
				flags | EO_MARK;	/* Flags not in sync, but it's ok */
		else						/* Old object is not remembered */
			return root;			/* Skip it--object did not move */
	}

	/* If we reach an expanded object, then we already dealt with the object
	 * which holds it. If this object has been forwarded, we need to update
	 * the reference field. Of course object with EO_OLD set are ignored.
	 * It's easy to know whether a normal object has to be scavenged or marked.
	 * The new objects outside the scavenge zone carry the EO_NEW mark.
	 */
	if (!(flags & EO_OLD) || (flags & EO_EXP)) {
		root = gscavenge(root);			/* Generation scavenging */
		zone = HEADER(root);			/* Update zone */
		flags = zone->ov_flags;			/* And Eiffel flags */
	}

	/*
	 * It's useless to mark an expanded, because it has only one reference
	 * on itself, in the object which holds it. Scavengend objects need not
	 * any mark either, as the forwarding mark tells that they are alive.
	 */
	if (!(flags & EO_EXP) && (flags & EO_NEW)) {
		flags |= EO_MARK;			/* Mark it now, to avoid loops */
		zone->ov_flags = flags;
	}

	/* Now explore all the references of the current object.
	 * For each object of type 'type', Reference[type] gives the number
	 * of references in the objects. The references are placed at the
	 * beginning of the data space by the Eiffel compiler. Expanded
	 * objects have a reference to them, so no special treatment is
	 * required. Special objects full of references are also explored.
	 */

	if (flags & EO_SPEC) {				/* Special object */

		/* Special objects may have no references (e.g. an array of
		 * integer or a string), so we have to skip those.
		 */
		if (!(flags & EO_REF))
			return root;				/* Skip if no references */

		/* At the end of the special data zone, there are two long integers
		 * which give informations to the run-time about the content of the
		 * zone: the first is the 'count', i.e. the number of items, and the
		 * second is the size of each item (for expandeds, the overhead of the
		 * header is not taken into account).
		 */
		size = zone->ov_size & B_SIZE;		/* Fetch size of block */
		size -= LNGPAD_2;					/* Go backward to 'count' */
		offset = *(long *) (root + size);	/* Get the count (# of items) */

		/* Treat arrays of expanded object here, because we have a special
		 * way of looping over the array (we must take the size of each item
		 * into account).
		 */

		 if (flags & EO_COMP) {
			size = *(long *) (root + size + sizeof(long));	/* Item's size */
			if (gen_scavenge & GS_ON) {					/* Moving objects */
				object = (EIF_REFERENCE *) (root + OVERHEAD);	/* First expanded */
				for (; offset > 0; offset--) {			/* Loop over array */
					*object = generation_mark(*object);	
					object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
				}
			} else {									/* Object can't move */
				object = (EIF_REFERENCE *) (root + OVERHEAD);	/* First expanded */
				for (; offset > 0; offset--) {			/* Loop over array */
					(void) generation_mark(*object);	
					object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
				}
			}
			return root;	/* Address of possibly moved array of expanded */
		}

	} else
		offset = References(Deif_bid(flags));	/* Number of references */

#ifdef DEBUG
	dprintf(16)("generation_mark: %d references for 0x%lx\n", offset, root);
	if (DEBUG & 16 && debug_ok(16)) {
		int i;
		for (i = 0; i < offset; i++)
			printf("\t0x%lx\n", *((EIF_REFERENCE *) root + i));
	}
	flush;
#endif

	/* Mark all objects under root, updating the references if scavenging */

	if (gen_scavenge & GS_ON) {
		for (object = (EIF_REFERENCE *) root; offset > 0; offset--, object++)
			*object = generation_mark(*object);
	} else {
		for (object = (EIF_REFERENCE *) root; offset > 0; offset--)
			(void) generation_mark(*object++);
	}

	return root;	/* Address of possibly moved object */
}
#endif /* RECURSIVE_MARKING */

#ifdef HYBRID_MARKING
rt_private EIF_REFERENCE hybrid_gen_mark(EIF_REFERENCE root)

{
	/* This function is the half-recursive half-iterative version of
	 * generation_mark(). Instead of recursively marking all the attributes
	 * of an object, the (n-1) first attributes are marked by a recursive call
	 * to hybrid_gen_mark() while the last one is treated in the main loop
	 * (suppression of tail recursion).
	 */
	union overhead *zone;		/* Malloc info zone fields */
	uint32 flags;				/* Eiffel flags */
	long offset;				/* Reference's offset */
	uint32 size;				/* Size of items (for array of expanded) */
	EIF_REFERENCE *object;				/* Sub-objects scanned */
	EIF_REFERENCE current;				/* Object currently inspected */
	EIF_REFERENCE *prev;				/* Holder of current (for update) */
	long count;					/* Number of references */

	/* If 'root' is a void reference, return immediately. This is redundant
	 * with the beginning of the loop, but this case occurs quite often.
	 */
	if (root == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

	/* Initialize the variables for the loop */
	current = root;
	prev = (EIF_REFERENCE *) 0;

	do {
		if (current == (EIF_REFERENCE) 0)		/* No further exploration */
			goto done;					/* Exit the procedure */

		zone = HEADER(current);			/* Malloc info zone */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(16)("hybrid_gen_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			current,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	 } else {
		dprintf(16)("hybrid_gen_mark: 0x%lx %s%s%s%s(DT %d, %d bytes)\n",
			current,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_NEW ? "new " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
	flush;
#endif

		/* If we reach a marked object or a forwarded object, return
		 * immediately: the object has been already processed. Otherwise, an old
		 * object which is not remembered is not processed, as it can't
		 * reference any new objects. Old remembered objects are marked when
		 * they are processed, otherwise it would be possible to process it
		 * twice (once via a reference from another object and once because it's
		 * in the remembered list).
		 */

		if (zone->ov_size & B_FWD) {	/* Object was forwarded (scavenged) */
			if(prev)
				*prev = zone->ov_fwd;	/* Update with its new location */
			goto done;					/* Exit the procedure */
		}

		flags = zone->ov_flags;			/* Fetch Eiffel flags */
		if (flags & (EO_MARK | EO_C))	/* Object has been already processed? */
			goto done;					/* Exit the procedure */

		if (flags & EO_OLD) {			/* Old object unmarked */
			if (flags & EO_REM)		/* But remembered--mark it as processed */
			{
				zone->ov_flags = flags | EO_MARK;
#ifdef EIF_REM_SET_OPTIMIZATION
				if ((flags & EO_SPEC) && (flags & EO_REF))	
									/* Is Object special and full of refs? */
				{
					CHECK ("Is in special rem set", is_in_spt (special_rem_set, current));
					goto done;			
						/* Skip it. it will be processed later in 
						 * "mark_special_rem_set()". 
						 * This is actually the purpose of the special_rem_set:
						 * to avoid to mark recursively all the reference in a 
						 * special rememembered old object, but only those 
						 * which are `young'. */
				}

#endif	/* EIF_REM_SET_OPTIMIZATION */
			}
			else						/* Old object is not remembered */
				goto done;				/* Skip it--object did not move */
		}

		/* If we reach an expanded object, then we already dealt with the object
		 * which holds it. If this object has been forwarded, we need to update
		 * the reference field. Of course object with EO_OLD set are ignored.
		 * It's easy to know whether a normal object has to be scavenged or
		 * marked. The new objects outside the scavenge zone carry the EO_NEW
		 * mark.
		 */
		if (!(flags & EO_OLD) || (flags & EO_EXP)) {
			current = gscavenge(current);	/* Generation scavenging */
			zone = HEADER(current);			/* Update zone */
			flags = zone->ov_flags;			/* And Eiffel flags */
			if (prev)						/* Update referencing pointer */
				*prev = current;
#ifdef EIF_REM_SET_OPTIMIZATION
			if ((flags & (EO_SPEC | EO_REM | EO_REF | EO_OLD)) == (EO_REM | EO_SPEC | EO_REF | EO_OLD))
				/* It has been tenured and may be in the special remembered set. 
				 * Skip it-- Only the new references will be processed in 
				 * "mark_special_table()". */
			{
				CHECK ("Is old", flags & EO_OLD);
				CHECK ("Is marked", flags & EO_MARK);
				CHECK ("Is in special rem set", is_in_spt (special_rem_set, current));
				goto done;	/* Skip it. */
			}
#endif	/* EIF_REM_SET_OPTIMIZATION */
		}

		/* It's useless to mark an expanded, because it has only one reference
		 * on itself, in the object which holds it. Scavengend objects need not
		 * any mark either, as the forwarding mark tells that they are alive.
		 */
		if (!(flags & EO_EXP) && (flags & EO_NEW)) {
			flags |= EO_MARK;
			zone->ov_flags = flags;
		}

		/* Now explore all the references of the current object.
		 * For each object of type 'type', Reference[type] gives the number
		 * of references in the objects. The references are placed at the
		 * beginning of the data space by the Eiffel compiler. Expanded
		 * objects have a reference to them, so no special treatment is
		 * required. Special objects full of references are also explored.
		 */
		if (flags & EO_SPEC) {				/* Special object */

			/* Special objects may have no references (e.g. an array of
			 * integer or a string), so we have to skip those.
			 */
			if (!(flags & EO_REF))
				goto done;				/* Skip if no references */

			/* At the end of the special data zone, there are two long integers
			 * which give informations to the run-time about the content of the
			 * zone: the first is the 'count', i.e. the number of items, and the
			 * second is the size of each item (for expandeds, the overhead of
			 * the header is not taken into account).
			 */
			size = zone->ov_size & B_SIZE;		/* Fetch size of block */
			size -= LNGPAD_2;					/* Go backward to 'count' */
			count = offset = *(long *) (current + size);	/* Get # items */

			/* Treat arrays of expanded object here, because we have a special
			 * way of looping over the array (we must take the size of each item
			 * into account).
			 */

			if (flags & EO_COMP) {
				size = *(long *) (current + size + sizeof(long));	/* Item's size */
				if (gen_scavenge & GS_ON) {					/* Moving objects */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						*object = hybrid_gen_mark(*object);
						object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
					}
				} else {							/* Object can't move */
					object = (EIF_REFERENCE *) (current + OVERHEAD);/* First expanded */
					for (; offset > 1; offset--) {		/* Loop over array */
						(void) hybrid_gen_mark(*object);
						object = (EIF_REFERENCE *) ((EIF_REFERENCE) object + size);
					}
				}
				/* Keep iterating if and only if the current object has at
				 * least one attribute.
				 */
				if (count >= 1) {
					prev = object;
					current = *object;
					continue;
				} else
					goto done;		/* End of iteration; exit procedure */
			}
		} else
			count = offset = References(Deif_bid(flags)); /* # of references */

#ifdef DEBUG
	dprintf(16)("hybrid_gen_mark: %d references for 0x%lx\n", offset, current);
	if (DEBUG & 16 && debug_ok(16)) {
		int i;
		for (i = 0; i < offset; i++)
			printf("\t0x%lx\n", *((EIF_REFERENCE *) current + i));
	}
	flush;
#endif

		/* Mark all objects under root, updating the references if scavenging */

		if (gen_scavenge & GS_ON) {
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--, object++)
				*object = hybrid_gen_mark(*object);
		} else {
			for (object = (EIF_REFERENCE *) current; offset > 1; offset--)
				(void) hybrid_gen_mark(*object++);
		}

		if (count >= 1) {
			prev = object;
			current = *object;
		} else
			goto done;

	} while(current);

done:
	/* Return the [new] address of the root object */
	zone = HEADER(root);
	return ((zone->ov_size & B_FWD) ? zone->ov_fwd : root);
}
#endif /* HYBRID_MARKING */

#ifdef ITERATIVE_MARKING
rt_private EIF_REFERENCE it_gen_mark(EIF_REFERENCE root)
{
	EIF_GET_CONTEXT
	register1 union overhead *zone;	/* Malloc info zone fields */
	register2 uint32 flags;			/* Eiffel flags */
	long offset;					/* Reference's offset */
	register3 uint32 size;			/* Size of an item (for array of expanded) */
	EIF_REFERENCE *object;					/* Sub-objects scanned */

	register4 EIF_REFERENCE parent = (EIF_REFERENCE) 0;	/* Parent of the current object */
	register5 EIF_REFERENCE child;			/* Child to be inspected */
	register6 EIF_REFERENCE node;			/* Node currently inspected */
	register7 long position;		/* Child is the position-th attribute of Node */
	long s_top;						/* Value on top of path_stack */

#ifdef DEBUG
	long loop_call = 0;
#endif

	/* Initialize the stack with LAST_REF. The algorithm stops when this
	 * element is on top of the stack.
	 */
	epush(&path_stack, (EIF_REFERENCE) LAST_REF);

	/* root is kept until the end because we have to return its possibly
	 * new address.
	 */
	node = root;

	do {

#ifdef DEBUG
	loop_call++;
#endif
		/* Step 0
		 * This part of code is executed for all the references the algorithm
		 * inspects.
		 */

		/* If the current object is void, there's nothing to explore.
		 * Skip it.
		 */
		if (!node)
			goto not_explorable;

		zone = HEADER(node);			/* Malloc info zone */

#ifdef DEBUG
	if (zone->ov_size & B_FWD) {
		dprintf(16)("it_gen_mark: 0x%lx fwd to 0x%lx (DT %d, %d bytes)\n",
			root,
			zone->ov_fwd,
			HEADER(zone->ov_fwd)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	} else {
		dprintf(16)("it_gen_mark: 0x%lx %s%s%s%s(DT %d, %d bytes)\n",
			root,
			zone->ov_flags & EO_MARK ? "marked " : "",
			zone->ov_flags & EO_OLD ? "old " : "",
			zone->ov_flags & EO_NEW ? "new " : "",
			zone->ov_flags & EO_REM ? "remembered " : "",
			zone->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE);
	}
#endif

		/* If we reach a marked object or a forwarded object, return
		 * immediately: the object has been already processed. Otherwise, an old
		 * object which is not remembered is not processed, as it can't
		 * reference any new objects. Old remembered objects are marked when
		 * they are processed, otherwise it would be possible to process it
		 * twice (once via a reference from another object and once because it's
		 * in the remembered list).
		 */
		if (zone->ov_size & B_FWD) {	/* Object was forwarded (scavenged) */
			node = zone->ov_fwd;		/* Update node with the new location */
			goto not_explorable;		/* Nothing to inspect, skip step 1 */
		}

		flags = zone->ov_flags;			/* Fetch Eiffel flags */
		if (flags & (EO_MARK | EO_C))	/* Object has been already processed? */
			goto not_explorable;		/* Skip step 1 */

		if (flags & EO_OLD) {			/* Old object unmarked */
			if (flags & EO_REM)			/* But remembered--mark it as processed */
				zone->ov_flags = flags | EO_MARK;
			else
				goto not_explorable;
		}

		/* If we reach an expanded object, then we already dealt with the object
	 	 * which holds it. If this object has been forwarded, we need to update
	 	 * the reference field. Of course object with EO_OLD set are ignored.
	 	 * It's easy to know whether a normal object has to be scavenged or
		 * marked. The new objects outside the scavenge zone carry the EO_NEW
		 * mark.
		 */

		if (!(flags & EO_OLD) || (flags & EO_EXP)) {
			node = gscavenge(node);		/* Generation scavenging */
			zone = HEADER(node);		/* Update zone */
			flags = zone->ov_flags;		/* And Eiffel flags */
		}

		/* It's useless to mark an expanded, because it has only one reference
		 * on itself, in the object which holds it. Scavengend objects need not
	 	 * any mark either, as the forwarding mark tells that they are alive.
	 	 */
		if (!(flags & EO_EXP) && (flags & EO_NEW)) {
			flags |= EO_MARK;			/* Mark it now, to avoid loops */
			zone->ov_flags = flags;
		}

		/* Now explore all the references of the current object.
		 * For each object of type 'type', Reference[type] gives the number
		 * of references in the objects. The references are placed at the
		 * beginning of the data space by the Eiffel compiler. Expanded
		 * objects have a reference to them, so no special treatment is
		 * required. Special objects full of references are also explored.
		 */

		if (flags & EO_SPEC) {			/* Special object */

			/* Special objects may have no references (e.g. an array of
			 * integer or a string), so we have to skip those.
			 */
			if (!(flags & EO_REF))
				goto not_explorable;

			/* At the end of the special data zone, there are two long integers
			 * which give informations to the run-time about the content of the
			 * zone: the first is the 'count', i.e. the number of items, and the
			 * second is the size of each item (for expandeds, the overhead of
			 * the header is not taken into account).
			 */
			size = zone->ov_size & B_SIZE;		/* Fetch size of block */
			size -= LNGPAD_2;					/* Go backward to 'count' */
			offset = *(long *) (node + size);	/* Get the count (# of items) */
		} else
			offset = References(Deif_bid(flags));	/* # of references */

		/* Step 1
		 * if the current object has reference(s), inspect the first one.
		 */

#ifdef DEBUG
	fdprintf(128,1)("it_gen_mark: step 1, node = %lx, parent = %lx\n",
					node,parent);
	fdprintf(128,1)("it_gen_mark: step 1, following 1/%d \n",offset);
#endif

		if (offset) {
			/* If this is the only reference, mark the value pushed on the
			 * stack consequently.
			 */
			if (offset == 1L)
				epush (&path_stack, (EIF_REFERENCE) (1L | LAST_REF));
			else
				epush (&path_stack, (EIF_REFERENCE) 1L);

			/* The current node has references. Get the first one */
			/* Array of expanded */
			if ((flags & EO_SPEC) && (flags & EO_COMP)) {
				child = (EIF_REFERENCE) (node + OVERHEAD);		/* First expanded */

				/* For arrays of expanded, there's no field for the reference
				 * so we have to store the address of the father in a stack
				 * that will be used for all the fathers of arrays of expanded
				 * (it means this stack should stay small).
				 */
				epush (&parent_expanded_stack, parent);
			} else {
				child = * (EIF_REFERENCE *) node;
				* (EIF_REFERENCE *) node = parent;
			}
			parent = node;
			node = child;
			continue;
		}

not_explorable:

		/* Step 2
		 * At this point, we have reached a node that hasn't any reference
		 * or all the references of which have been inspected. Go back to
		 * the parent as long as we can.
		 */

#ifdef DEBUG
	fdprintf(128,1)("it_gen_mark: step 2, node = %lx, parent = %lx\n",
					node,parent);
	fdprintf(128,1)("it_gen_mark: top(path_stack) = %lx\n",
					ntop(&path_stack));
#endif

		s_top = (long) ntop(&path_stack);

		while ((s_top & LAST_REF) && (s_top & ~LAST_REF)) {
			position = (long) nget (&path_stack);
			position &= ~LAST_REF;
			child = node;
			node = parent;
			/* If this current new object is an array of expanded, its father
			 * is in the parent_expanded_stack stack, not in one if its
			 * attributes
			 */
			flags = HEADER(node)->ov_flags;
			if ((flags & EO_SPEC) && (flags & EO_COMP))
				parent = nget (&parent_expanded_stack);
			else {
				/* The address of the parent must be in the last reference
				 * and at this point, position must hold the number of
				 * attributes of the current node.
				 */
				object = (EIF_REFERENCE *) node;
				object += position - 1;
				parent = *object;
				*object = child;

#ifdef DEBUG
	fdprintf(128,1)("it_gen_mark: step 2, up one level, node = %lx, "
					"parent = %lx, child = %lx\n",node,parent,child);
#endif
			}
			s_top = (long) ntop(&path_stack);
		}

		/* Step 3
		 * If the parent of the current node exists, it has some unexplored
		 * references. Go back to the parent.
		 */

#ifdef DEBUG
	fdprintf(128,1)("it_gen_mark: step 3, node = %lx, parent = %lx\n",
					node,parent);
#endif

		if (parent) {
			position = (long) nget (&path_stack) + 1;
			child = node;
			node = parent;
			flags = HEADER(node)->ov_flags;
			if (flags & EO_SPEC) {
				zone = HEADER(node);
				size = zone->ov_size & B_SIZE;
				size -= LNGPAD_2;
				offset = *(long *) (node + size);
			} else
				offset = References(Deif_bid(flags));

			if (position == offset)
				epush (&path_stack, (EIF_REFERENCE) (position | LAST_REF));
			else
				epush (&path_stack, (EIF_REFERENCE) position);

			if ((flags & EO_SPEC) && (flags & EO_COMP)) {
				size = *(long *) (node + size + sizeof(long));
				child = (EIF_REFERENCE) (node + OVERHEAD + (position - 1) * (size + OVERHEAD));
			} else {
				object = (EIF_REFERENCE *) node;
				object += position - 2;
				parent = *object;
				*object = child;
				object++;
				child = *object;
				*object = parent;
			}

#ifdef DEBUG
	fdprintf(128,1)("it_gen_mark: step 3, up one level, node = %lx, "
					"parent = %lx, child = %lx\n",node,parent,child);
	fdprintf(128,1)("it_gen_mark: step 3, node = %lx, parent = %lx\n",
					node,parent);
	fdprintf(128,1)("it_gen_mark: step 3, following %d/%d reference\n",
					position, offset);
#endif

			parent = node;
			node = child;
		}

	} while (ntop(&path_stack) != (EIF_REFERENCE) LAST_REF);

	(void) nget (&path_stack);

	/* Check if `root' has moved and return the eventually new address */
	zone = HEADER(root);
	flags = zone->ov_flags;
	size = zone->ov_size;

#ifdef DEBUG
	fdprintf(128,2)("it_gen_mark called with 0x%lx, %ld iteration(s)\n",root,
					loop_call);
#endif

	if (size & B_FWD)
		return zone->ov_fwd;
	else
		return root;
}
#endif /* ITERATIVE_MARKING */

rt_private EIF_REFERENCE gscavenge(EIF_REFERENCE root)
{
	/* Generation scavenging of 'root', with tenuring done on the fly. The
	 * address of the new object (scavenged or tenured) is returned.
	 * Whenever tenuring fails, the flag GS_STOP is set which means that
	 * scavenging is to be done without tenuring.
	 */
	register1 union overhead *zone;		/* Malloc header zone */
	register2 int age;				/* Object's age */
	register3 uint32 flags;				/* Eiffel flags */
	EIF_REFERENCE new;							/* Address of new object (tenured) */ 
	int size;							/* Size of scavenged object */
	int ret;							/* status returned by "epush" or 
										 * "eif_promote_special" */

	zone = HEADER(root);				/* Info header */
	flags = zone->ov_flags;				/* Eiffel flags */

	if (gen_scavenge & GS_STOP)			/* Generation scavenging was stopped */
		if (!(flags & EO_NEW))			/* Object inside scavenge zone */
			return scavenge(root, &sc_to);	/* Simple scavenging */
		
	if (flags & EO_EXP) {				/* Expanded object */
		if (!(flags & EO_NEW))			/* Object inside scavenge zone */
			return scavenge(root, &sc_to);	/* Update reference pointer */
		else
			return root;				/* Do nothing for expanded objects */
	}

	if (zone->ov_size & B_C)	/* Eiffel object not under GC control */
		return root;			/* Leave it alone */

	/* Get the age of the object, update it and fill in the age table.
	 * Tenure when necessary (i.e. when age is greater than 'tenure_age',
	 * overflow is taken into account but this relies on the fact that
	 * the age is not stored in the leftmost bits, to leave room for the
	 * overflow bit--RAM). Note that when tenure is set to eif_tenure_max,
	 * no object can ever be tenured.
	 */

	age = flags & EO_AGE;			/* Fetch object's age */
	age += AGE_ONE;					/* Make a wish, it's your birthday */

	if (age >= (tenure << AGE_OFFSET)) {	/* Object is to be tenured */

		if (flags & EO_NEW) {			/* Object outside scavenge zone */

			/* Object is becomming old, so maybe it has to be remembered. Add
			 * it to the remembered set for later perusal. If the object cannot
			 * be remembered, it remains in the new generation.
			 */

#ifdef EIF_REM_SET_OPTIMIZATION
			if ((flags & EO_SPEC) && (flags & EO_REF))
				/* We need to push it into the special_rem_set
				 * So we scan the young object reference that
				 * it contains.
				 */
			{
#ifdef GSCAVENGE_DEBUG
				printf ("GSCAVENGE: Pushing %x in a special remembered table\n", root);
#endif	/* GSCAVENGE_DEBUG */
				ret = eif_promote_special (root);
			}
			else	/* Not a special object full of reference*/
				ret = epush (&rem_set, root);

#else	/* EIF_REM_SET_OPTIMIZATION */
			ret = epush (&rem_set, root);
#endif	/* EIF_REM_SET_OPTIMIZATION */
			if (-1 != ret) {	/* We could record it */

				/* Mark the object as being old, but do not remove the EO_MARK
				 * mark. See comment about GC_FAST in update_moved_set()--RAM.
				 */

				flags &= ~EO_NEW;			/* No longer new */
				flags |= EO_OLD | EO_REM | EO_MARK;	/* See below for EO_MARK */
				zone->ov_flags = flags;		/* Store updated flags */

#ifdef DEBUG
				dprintf(4)("gscavenge: tenured 0x%lx at age %d (%d bytes)\n",
					root, age >> AGE_OFFSET, zone->ov_size & B_SIZE);
				flush;
#endif

				return root;				/* Object did not move */
			}

		} else {					/* Object is inside scavenge zone */

			/* Try tenuring after having marked the object as old. We get the size
			 * from the object to perform the copy.
			 * Addition: now it can be a special object if the EIF_GSZ_ALLOC_OPTIMIZATION
			 * has been enabled, because we try to allocate them in the GSZ
			 * as much as possible (70% speed improvement on the eiffel compiler).
			 */

#ifndef EIF_GSZ_ALLOC_OPTIMIZATION
			CHECK ("Not a special", !(HEADER (root)->ov_flags & EO_SPEC));
#endif
			size = zone->ov_size & B_SIZE;		/* Size without header */

			new = gmalloc(size);				/* Try in Eiffel chunks first */
			if ((EIF_REFERENCE) 0 == new) {			/* Out of memory */
				gen_scavenge |= GS_STOP;		/* Stop generation scavenging */
				return scavenge(root, &sc_to);	/* Simple scavenge */
			}

			/* Object is promoted, so add it to the remebered set for later
			 * perusal (the set will be scanned and eventually some items will
			 * be removed--object does not reference any young ones any more).
			 */

#ifdef EIF_REM_SET_OPTIMIZATION
			if ((flags & EO_SPEC) && (flags & EO_REF)) {
				/* We need to push it into the special_rem_set
				 * So we scan the young object reference that
				 * it contains.
				 */
				memcpy (new, root, size);	/* Copy content of area to enable the
											call to `eif_promote_special' */
				HEADER(new)->ov_flags = flags | EO_OLD;	/* Copy flags for new object */
				ret = eif_promote_special (new);
			} else	/* Not a special object full of reference*/
				ret = epush (&rem_set, new);
#else
			ret = epush (&rem_set, new);
#endif
			if (ret == -1) {	/* Cannot record it */
				gen_scavenge |= GS_STOP;		/* Mark failure */
				xfree(new);						/* Back where we found it */
				return scavenge(root, &sc_to);	/* Simple scavenge */
			}

			/* Copy the object to its new location, then update the header: the
			 * object is now an old one. Leave a forwarding pointer behind us.
			 * The data part of the object is copied as-is, but references on
			 * expanded will be correctly updated by the recursive process.
			 * The address of the new object has been inserted in the remembered
			 * set, so we must not remove the collector's mark otherwise it
			 * would be considered dead by update_rem_set()--RAM.
			 */

			flags |= EO_OLD | EO_REM | EO_MARK;	/* See below for EO_MARK */

			/* It is imperative to mark the object we've just tenured, so that
			 * we do not process it twice!! The tenured object will be processed
			 * as we return from this routine, but generation_mark has already
			 * dealt with EO_MARK, so it is our responsability... This was a bug
			 * I spent three days tracking--RAM.
			 */
#ifdef EIF_REM_SET_OPTIMIZATION
				/* It is a special full of reference the copy has already
				 * been done */
			if (!((flags & EO_SPEC) && (flags & EO_REF))) 
#endif
				memcpy (new, root, size);		/* Copy data part */

#ifdef EIF_NO_SCAVENGING
			eif_panic ("Generation Scavenging is not disabled");
#endif	/* EIF_NO_SCAVENGING */
			zone->ov_size |= B_FWD;		/* Mark object as forwarded */
			zone->ov_fwd = new;			/* Leave forwarding pointer */
			zone = HEADER(new);			/* New info zone */
			zone->ov_flags = flags;		/* Copy flags for new object */
			zone->ov_size &= ~B_C;		/* Object is an Eiffel one */

#ifdef DEBUG
			dprintf(4)("gscavenge: tenured 0x%lx to 0x%lx at age %d (%d bytes)\n",
				root, new, age >> AGE_OFFSET, size);
			flush;
#endif

			return new;		/* Done */
		}
	}

	/* Object is to be kept in the new generation */

#ifdef DEBUG
	dprintf(4)("gscavenge: keeping %s0x%lx at age %d (%d bytes)\n",
		flags & EO_NEW ? "new " : "",
		root, age >> AGE_OFFSET, zone->ov_size & B_SIZE);
	flush;
#endif

	age |= flags & (~EO_AGE);			/* New Eiffel flags */
	zone->ov_flags = age & (~EO_MARK);	/* Age merged, object unmarked */
	age = (age & EO_AGE) >> AGE_OFFSET;	/* Scalar value of age */
	if (flags & EO_NEW) {				/* Object allocated from free list */
		age_table[age]++;				/* One more object for this age */
		return root;					/* Object not moved */
	} else {							/* Object is in the scavenge zone */
		size_table[age] += (zone->ov_size & B_SIZE) + OVERHEAD;
		return scavenge(root, &sc_to);	/* Move object */
	}
	/* NOTREACHED */
}

rt_private void update_moved_set(void)
{
	/* Update the moved set. This routine is called to throw away from the moved
	 * set all the dead objects.
	 * Generation collection has its own treatment for that, as we need to
	 * eventually collect the dead objects. If partial collection has been done
	 * we may need to update some references.
	 * Note that I could free the dead objects here, but I chose to wait for
	 * the general sweep process because of the swapping problems--RAM. Only
	 * the generation-based collectors have their free here, for the objects
	 * outside the scavenge zone (those in the moved set, precisely).
	 */

	register1 EIF_REFERENCE *obj;			/* Pointer to objects held in a stack */
	register2 int i;				/* Number of items in stack chunk */
	register3 union overhead *zone;	/* Referenced object's header */
	register4 struct stchunk *s;	/* To walk through each stack's chunk */
	register5 uint32 flags;			/* Used only if GC_FAST */
	struct stack new_stack;			/* The new stack built from the old one */
	int done = 0;					/* Top of stack not reached yet */

	memcpy (&new_stack, &moved_set, sizeof(struct stack));
	s = new_stack.st_cur = moved_set.st_hd;		/* New empty stack */
	if (s) {
		new_stack.st_top = s->sk_arena;			/* Lowest possible top */
		new_stack.st_end = s->sk_end;			/* End of first chunk */
	}

#ifdef DEBUG
	dprintf(1)("update_moved_set: %d objects to be studied\n",
		nb_items(&moved_set));
	flush;
#endif

	/* If generation collection is active, a marked object is kept in the
	 * moved set if and only if it has not been promoted (in which case the
	 * EO_NEW bit has been cleared). In that case, the object is unmarked.
	 * Otherwise, if object has been promoted, it is not kept, but we
	 * unmark it only if it has not been remembered (because after the update
	 * of the moved set, we're going to update the remembered set and any
	 * alive object must still be marked).
	 */

	if (g_data.status & GC_PART) {			/* Partial collection */
		for (s = moved_set.st_hd; s && !done; s = s->sk_next) {
			obj = s->sk_arena;					/* Start of stack */
			if (s != moved_set.st_cur)			/* Top is before after 's' */
				i = s->sk_end - obj;			/* Look at the whole chunk */
			else {
				i = moved_set.st_top - obj;		/* Stop at the top */
				done = 1;						/* Reached end of stack */
			}
			for (; i > 0; i--, obj++) {			/* Stack viewed as an array */
				zone = HEADER(*obj);			/* Referenced object */
				if (zone->ov_size & B_FWD) {		/* Object forwarded? */
					zone = HEADER(zone->ov_fwd);	/* Look at fwd object */
					if (zone->ov_flags & EO_NEW)	/* It's a new one */
						epush(&new_stack, (EIF_REFERENCE)(zone+1));	/* Update reference */
				} else if (EO_MOVED == (zone->ov_flags & EO_MOVED))
					epush(&new_stack, (EIF_REFERENCE)(zone+1));	/* Remain as is */
			}
		}
	} else if (g_data.status & GC_FAST) {	/* Generation collection */
		for (s = moved_set.st_hd; s && !done; s = s->sk_next) {
			obj = s->sk_arena;					/* Start of stack */
			if (s != moved_set.st_cur)			/* Top is before after 's' */
				i = s->sk_end - obj;			/* Look at the whole chunk */
			else {
				i = moved_set.st_top - obj;		/* Stop at the top */
				done = 1;						/* Reached end of stack */
			}
			for (; i > 0; i--, obj++) {			/* Stack viewed as an array */
				zone = HEADER(*obj);			/* Referenced object */
				flags = zone->ov_flags;			/* Get Eiffel flags */
				if (flags & EO_MARK) {			/* Object is alive? */
					if (flags & EO_NEW) {				/* Not tenrured */
						epush(&new_stack, (EIF_REFERENCE)(zone+1));		/* Remains "as is" */
						zone->ov_flags &= ~EO_MARK;		/* Unmark object */
					} else if (!(flags & EO_REM))		/* Not remembered */
						zone->ov_flags &= ~EO_MARK;		/* Unmark object */
				} else if (!(zone->ov_size & B_C) && (zone->ov_size & B_BUSY))
					gfree(zone);				/* Free if under GC control */
			}
		}
	} else {								/* Mark and sweep */
		for (s = moved_set.st_hd; s && !done; s = s->sk_next) {
			obj = s->sk_arena;					/* Start of stack */
			if (s != moved_set.st_cur)			/* Top is before after 's' */
				i = s->sk_end - obj;			/* Look at the whole chunk */
			else {
				i = moved_set.st_top - obj;		/* Stop at the top */
				done = 1;						/* Reached end of stack */
			}
			for (; i > 0; i--, obj++) {			/* Stack viewed as an array */
				zone = HEADER(*obj);			/* Referenced object */
				if (EO_MOVED == (zone->ov_flags & EO_MOVED))
					epush(&new_stack,(EIF_REFERENCE)(zone+1));	/* Remains "as is" */
			}
		}
	}

#ifdef DEBUG
	dprintf(1)("update_moved_set: %d objects remaining\n",
		nb_items(&new_stack));
	flush;
#endif

	memcpy (&moved_set, &new_stack, sizeof(struct stack));

	/* As for the remembered set (see comment in update_rem_set), we release the
	 * spurious chunks used by the moved set stack.
	 */

	st_truncate(&moved_set);
}

rt_private void update_rem_set(void)
{
	/* Update the remembered set. This is an iterative process: for each item,
	 * we look for references to new objects. If there are none, the object is
	 * removed from the set. This "in place" updating cannot lead to a stack
	 * overflow.
	 * This routine checks that the object is alive only when doing a full
	 * collection. Otherwise, the objects in the remembered set are old ones,
	 * which means they are not affected by generation collections.
	 */

	EIF_REFERENCE *object;					/* Current inspected object */
	int n;							/* Number of objects to be dealt with */
	struct stack new_stack;			/* The new stack built from the old one */
	register1 EIF_REFERENCE current;		/* Address of inspected object */
	register2 char moving;			/* May GC move objects around? */
	register3 union overhead *zone;	/* Malloc info zone */
	register4 struct stchunk *s;	/* To walk through each stack's chunk */
	int done = 0;					/* Top of stack not reached yet */
	int generational;				/* Are we in a generational cycle? */

	memcpy (&new_stack, &rem_set, sizeof(struct stack));
	s = new_stack.st_cur = rem_set.st_hd;		/* New empty stack */
	if (s) {
		new_stack.st_top = s->sk_arena;			/* Lowest possible top */
		new_stack.st_end = s->sk_end;			/* End of first chunk */
	}

	moving = g_data.status;				/* Garbage collector's state */
	generational = moving & GC_FAST;	/* Is this a collect() cycle? */
	moving &= GC_PART | GC_GEN;			/* Current algorithm moves objects? */

#ifdef DEBUG
	dprintf(1)("update_rem_set: %d objects to be studied\n",
		nb_items(&rem_set));
	flush;
#endif

	for (s = rem_set.st_hd; s && !done; s = s->sk_next) {
		object = s->sk_arena;				/* Start of stack */
		if (s != rem_set.st_cur)			/* Top is before after 's' */
			n = s->sk_end - object;			/* Look at the whole chunk */
		else {
			n = rem_set.st_top - object;	/* Stop at the top */
			done = 1;						/* Reached end of stack */
		}

		for (; n > 0; n--, object++) {
			current = *object;				/* Save that for later perusal */
			zone = HEADER(current);			/* Object's header */

#ifdef DEBUG
			dprintf(4)("update_rem_set: at 0x%lx (type %d, %d bytes) %s%s\n",
				current,
				HEADER(
					zone->ov_size & B_FWD ? zone->ov_fwd : current
				)->ov_flags & EO_TYPE,
				zone->ov_size & B_SIZE,
				zone->ov_size & B_FWD ? "forwarded" : "",
				zone->ov_flags & EO_MARK ? "marked" : ""
			);
			flush;
#endif

			/* When objects are moving, we need to focus on both the B_FWD
			 * mark (which is an indication that the object is alive) and the
			 * EO_MARK which is the traditional alive mark. Dead objects are
			 * simply removed from the remembered set.
			 */

			if (moving) {					/* Object may move? */
				if (zone->ov_size & B_FWD)	/* Object was forwarded */
					current = zone->ov_fwd;	/* Follow forwarding pointer */
				else if (!(zone->ov_flags & EO_MARK))	/* Object is dead */
					continue;				/* Remove it from remembered set */
			} else if (!(zone->ov_flags & EO_MARK))	/* Object cannot move */
				continue;					/* It's dead -- remove it */

			/* In a generational cycle, we need to explicitely unmark all the
			 * alive objects, whether we keep them in the remembered set or
			 * not. Why? Because when we tenure those objects, we mark them
			 * and also set the EO_OLD and EO_REM bit. If we do not unmark them
			 * and those are once functions, then we will never scan the inside
			 * of those objects. In other cycles, the unmarking will be done
			 * by the full sweep operation.
			 */

			if (generational)
				HEADER(current)->ov_flags &= ~EO_MARK;	/* Unmark object */

			/* The objects referred by the current object could have been
			 * tenured, so we need to recheck whether it has its place in the
			 * remembered set.
			 */

			if (refers_new_object(current))	/* Object deserves remembering? */
				epush(&new_stack, current);	/* Save it for posterity */
			else
				HEADER(current)->ov_flags &= ~EO_REM;	/* Not remembered */

#ifdef DEBUG
			dprintf(4)("update_rem_set: %s object %lx (type %d, %d bytes) %s\n",
				HEADER(current)->ov_flags & EO_OLD ? "old" :
					HEADER(current)->ov_flags & EO_NEW ? "new" : "gen",
				current, HEADER(current)->ov_flags & EO_TYPE,
				HEADER(current)->ov_size & B_SIZE,
				HEADER(current)->ov_flags & EO_REM ? "remembered":"forgotten");
			flush;
#endif

		}
	}

#ifdef DEBUG
	dprintf(1)("update_rem_set: %d objects remaining\n",
		nb_items(&new_stack));
	flush;
#endif

	/* Objects remembered have been pushed on stack "new_stack". Now reset the
	 * remembered set correctly by making "rem_set" refer to the new stack.
	 */

	memcpy (&rem_set, &new_stack, sizeof(struct stack));

	/* Usually, the remembered set shrinks after a collection. The unused chunks
	 * in the stack are freed. Yet, we'll have to call malloc() again to extend
	 * the stack, but this raises the chances of being able to shrink the
	 * process size--RAM.
	 */
	
	st_truncate(&rem_set);
}

#ifdef EIF_MEMORY_OPTIMIZATION
rt_private void update_memory_set ()
	/* Traverse the memory_set which contains all the objects, which have a
	 * dispose routine. It calls the dispose routine
	 * on the objects thar are garbage.
	 * To be compared with "update_rem_set ()". 
	 * -- ET
	 */
{
	EIF_GET_CONTEXT					/* In MT-mode, for memory_set.	*/

	EIF_REFERENCE *object;					/* Current inspected object */
	int n;							/* Number of objects to be dealt with */
	struct stack new_stack;			/* The new stack built from the old one */
	register1 EIF_REFERENCE current;		/* Address of inspected object */
	register3 union overhead *zone;	/* Malloc info zone */
	register4 struct stchunk *s;	/* To walk through each stack's chunk */
	int saved_in_assertion;			/* Saved assertion level.	*/
	char gc_status;					/* Saved GC status.	*/
	int dtype;						/* Dynamic type of Current object.	*/
	int done = 0;					/* Top of stack not reached yet */

	REQUIRE ("GC is not stopped", !(g_data.status & GC_STOP));

	memcpy (&new_stack, &memory_set, sizeof(struct stack));
	s = new_stack.st_cur = memory_set.st_hd;		/* New empty stack */
	if (s) {
		new_stack.st_top = s->sk_arena;				/* Lowest possible top */
		new_stack.st_end = s->sk_end;				/* End of first chunk */
	}

#ifdef DEBUG_UPDATE_MEMORY_SET
	printf("update_memory_set: %d objects to be studied\n",
		nb_items(&memory_set));
#endif

	/* Traverse stack.	*/
	for (s = memory_set.st_hd; s && !done; s = s->sk_next) 
	{
		object = s->sk_arena;				/* Start of stack */
		if (s != memory_set.st_cur)			/* Top is before after 's' */
			n = s->sk_end - object;			/* Look at the whole chunk */
		else 
		{
			n = memory_set.st_top - object;	/* Stop at the top */
			done = 1;						/* Reached end of stack */
		}

		for (; n > 0; n--, object++) 
		{
			current = *object;				/* Save that for later perusal */
			zone = HEADER(current);			/* Object's header */

#ifdef DEBUG_UPDATE_MEMORY_SET
			printf("update_memory_set: at 0x%lx (type %d, %d bytes) %s\n",
				current,
				HEADER(
					zone->ov_size & B_FWD ? zone->ov_fwd : current
				)->ov_flags & EO_TYPE,
				zone->ov_size & B_SIZE,
				zone->ov_size & B_FWD ? "forwarded" : "dead"
			);
#endif	/* DEBUG_UPDATE_MEMORY_SET	*/

			/* We need to call the dispose routine on the objects that
			 * not alive any longer. 
			 * If the object holds the B_FWD flag, it has survived the 
			 * generational collection and we just need to update the proper
			 * entry in the stack. Otherwise it is garbage: we must call the 
			 * dispose routine on it and remove it from the stack. 
			 */

			CHECK ("Objects not in GSZ", !(zone->ov_size & (EO_OLD | EO_NEW | EO_MARK | EO_SPEC)));	

			if (zone->ov_size & B_FWD)	/* Object survived GS collection. */
			{
				current = zone->ov_fwd;		/* Update entry. */

				CHECK ("Has dispose routine", Disp_rout (Dtype (HEADER (current) + 1)));
				CHECK ("Not forwarded twice", !(HEADER (current)->ov_size & B_FWD));

				if (!(HEADER (current)->ov_flags & (EO_OLD | EO_NEW)))
										/* Forwarded object is still in GSZ. */
					epush(&new_stack, current);		/* Save it in the stack. */
			}
			else 									/* Object is dead. */
			{										/* Call dispose routine.*/
				dtype = Deif_bid(zone->ov_flags);	/* Need it for dispose.	*/ 

				CHECK ("Has with dispose routine", Disp_rout (dtype));

				gc_status = g_data.status;			/* Save GC status. */
				g_data.status |= GC_STOP;			/* Stop GC. */

				/* We should disable invariants but not postconditions 
				 * (see `dispose' from IDENTIFIED).
 				 */
				saved_in_assertion = in_assertion;	/* Save in_assertion. */
				in_assertion = ~0;			/* Turn off assertion checking. */
				DISP(dtype,(EIF_REFERENCE) (zone + 1));	/* Call 'dispose'. */
				in_assertion = saved_in_assertion;	/* Set in_assertion back. */
				g_data.status = gc_status;		/* Restore previous GC status.*/
				CHECK ("Cannot be in object ID stack",
					!has_object (&object_id_stack, (EIF_REFERENCE) zone + 1));
			}

#ifdef DEBUG_UPDATE_MEMORY_SET
			printf("update_memory_set: object %lx (type %d, %d bytes) %s\n",
				current, HEADER(current)->ov_flags & EO_TYPE,
				HEADER(current)->ov_size & B_SIZE,
				HEADER(current)->ov_size & B_FWD ? "updated":"disposed");
#endif	/* DEBUG_UPDATE_MEMORY_SET	*/

		}	/* for ... */
	}	/* for ... */

#ifdef DEBUG_UPDATE_MEMORY_SET
	printf("update_memory_set: %d objects remaining\n",
		nb_items(&new_stack));
#endif	/* DEBUG_UPDATE_MEMORY_SET	*/

	/* Memory objects have been pushed on stack "new_stack". Now reset the
	 * the memory set correctly by making "memory_set" refer to the new stack.
	 */

	memcpy (&memory_set, &new_stack, sizeof(struct stack));

	/* Usually, the memory set shrinks after a collection. The unused chunks
	 * in the stack are freed. 
	 */
	
	st_truncate(&memory_set);

}	/* update_memory_set() */	
#endif	/* EIF_MEMORY_OPTIMIZATION */

#ifdef EIF_REM_SET_OPTIMIZATION
rt_private int update_special_rem_set(void)
{
	/* Update the special remembered set. This is an iterative process: we check
	 * only for the item that is new. 
	 * During partial collections, this routine update the refernces, which
	 * are remembered in the "special_rem_set", removing twin, void, and old
	 * references.
	 * This routine checks that the object is alive only when doing a full
	 * collection. 
	 */

	EIF_GET_CONTEXT

	EIF_REFERENCE			object;	/* Current inspected remembered object */
	EIF_REFERENCE			item;		/* Current inspected item. */
	struct special_table 	*new_table;
									/* The new table built from the old one */
	register2 char 			moving;		/* May GC move objects around? */
	union overhead 			*zone;		/* Malloc info zone of current object.*/
	union overhead 			*izone;		/* Malloc info zone of current item. */
	int 					generational;/* Are we in a generational cycle? */
	int						hsize;
	int						count;			
	int						i;			/* Index for loop. */
	EIF_INTEGER_32			*hkeys;		/* Index of remembered items table. */
	char 					**hvalues;	/* Special old object pointers table. */
	long 					offset;		/* Index of item. */

	/* Initializations. */

#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
	printf ("In update_special_rem_set () : special_rem_set %x\n", special_rem_set);
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */

	if (!special_rem_set)			 	/* No special_rem_set . */
		return 0;
		
	
	count = special_rem_set->count;		
							/* Fetch number of special remembered objects. */
	if (count == 0) 					/* No object in special_rem_set . */
		return 0;						/* Pass it. */


	/* Initializations. */
	hsize = special_rem_set->h_size;	/* Fetch fields of "special_rem_set". */
	hkeys = special_rem_set->h_keys;
	hvalues = special_rem_set->h_values;	 
	moving = g_data.status;				/* Garbage collector's status */
	generational = moving & GC_FAST;	/* Is this a collect() cycle? */
	moving &= GC_PART | GC_GEN ;		/* Is this a Full collection,
										 which moves objects?	*/

	new_table = (struct special_table *) eif_malloc (sizeof (struct special_table));
	if (new_table == (struct special_table *) 0)	
		enomem();	/* Could not allocate struct. */


		/* Initializations of "new_table". 
		 * In "old_values" are the table of the non processed special
		 * remembered objects. We must do it to unmark them when exiting the
		 * the procedure. */

	new_table->count = 0;
	new_table->h_size = special_rem_set->h_size;
	new_table->old_values = special_rem_set->h_values;
	new_table->old_count = special_rem_set->count;
	new_table->h_values = special_rem_set->old_values;
	new_table->h_keys = special_rem_set->h_keys;

#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
	printf ("Status %d, Generational = %d, Moving = %d\n", g_data.status,generational, moving);
	printf("update_special_rem_set: %d objects to be studied in %s collection\n",
		special_rem_set->count, generational? "generational" : "full");
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */


#ifdef EIF_ASSERTION
	/************************ Checks. *********************************/
	CHECK ("Table is coherent", count <= hsize);
	{
		int32	old_count = count;		/* For postcondittions. */
	for (i = 0 ; i < count ; i++)
	{
		union overhead 	*zone = HEADER (hvalues [i]);
									/* Current special's Malloc info zone. */
		uint32 flags;	
									/* Fetch curennt special Eiffel flags. */
		if (zone->ov_size & B_FWD)		/* Is object forwarded? */
			zone = HEADER (zone->ov_fwd);	/* Update Malloc info zone. */
		flags = zone->ov_flags;			/* fetch Eiffel flags. */

		CHECK ("Not composite", !(flags & EO_COMP));
		CHECK ("Not C", !(flags & EO_C));
		CHECK ("Remembered", flags & EO_REM);
		CHECK ("Not expanded", !(flags & EO_EXP));
		CHECK ("Old", flags & EO_OLD);
		CHECK ("Full of references", flags & EO_REF);
		CHECK ("Special", flags & EO_SPEC);
		if (generational)
		{
			CHECK ("Not forwarded", !(zone->ov_size & B_FWD));
			CHECK ("Marked", zone->ov_flags & EO_MARK);
		}
		
	}
	/************************ End of checks. *********************************/
#endif /* !NDEBUG */

	/* First, we remove the EO_REM flags from all the special object inside the 
	 * table. Later on, we will process this flag with `| EO_REM' if it really 
	 * has to be remembered or `| ~EO_REM' if it does not references a young 
	 * item any longer. This way, if at least one remembered reference has to
	 * be remembered the enclosing special will remain remembered. This is 
	 * necessary since a special remembered objects can be recorded several 
	 * times in the "special-rem_set".
	 */


	for (i = 0 ; i < count; i++)
	{
		union overhead *tzone = HEADER (hvalues [i]);	/* Fetch zone. */
		if (tzone->ov_size & B_FWD)	{ /* Is object forwarded? */
				tzone = HEADER (tzone->ov_fwd);	
					/* Update zone, but not object, We must keep
					 *the B_FWD flag to check if object is alive later on. */
		}
		tzone->ov_flags &= ~EO_REM;	/* Remove remembered flag. */
		CHECK ("Flag EO_REM is unset", !(tzone->ov_flags & EO_REM));	
	}


	/* We check whether the special object references any new objects. 
	 * We scan only the references recorded in the table. 
	 */

	for (i = 0; i < count ; i++)
	{
		/* Initializations. */
		object 	= hvalues [i];			/* Current remembered object. */
		if (object == (EIF_REFERENCE) 0)		/* Is special void? */
			continue;					/* Skip it. */
		zone = HEADER (object);			/* Current special's Malloc info zone. */
		

#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
	/******************************* Debug.	*********************************/

		{
		int32 ofst = hkeys [i];
		if (ofst >= 0)
		{
		EIF_REFERENCE itm;
		union overhead *iz;
		itm = *(EIF_REFERENCE *) (object + ofst * REFSIZ);
		if (itm != (EIF_REFERENCE) 0)
		{
		iz = HEADER (itm);

		printf("update_special_rem_set: at 0x%x (type %d, %d bytes) %s%s %s %s %s, \n\t\t\twith item %x, offset %ld (type %d, %d bytes) %s age %ld, %s %s%s %s %s %s\n",
			object,
			HEADER(
				zone->ov_size & B_FWD ? zone->ov_fwd : object
			)->ov_flags & EO_TYPE,
			zone->ov_size & B_SIZE,
			zone->ov_size & B_FWD ? "forwarded" : "",
			zone->ov_flags & EO_MARK ? "marked" : "",
			zone->ov_flags & EO_REF ? "ref" : "",
			zone->ov_flags & EO_COMP ? "cmp" : "",
			zone->ov_flags & EO_SPEC ? "spec" : "",
			itm,
			ofst,
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_TYPE,
			iz->ov_size & B_SIZE,
			iz->ov_size & B_FWD ? "forwarded" : "",
			((HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_AGE) >> 24) / 2,
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_OLD ? "old " : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_REM ? "remembered" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_MARK ? "marked" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_REF ? "ref" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_COMP ? "comp" : "",
			HEADER (
				iz->ov_size & B_FWD ? iz->ov_fwd : itm
			)->ov_flags & EO_SPEC ? "spec" : ""
		);
		}
		}
		}
	/*************************** End of debug. *****************************/
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */



		/* When objects are moving, we need to focus on both the B_FWD
		 * mark (which is an indication that the object is alive) and the
		 * EO_MARK which is the traditional alive mark. Dead objects are
		 * simply removed from the special remembered set.
		 */


		if (moving)						/* May object move? */
		{
			if (zone->ov_size & B_FWD)	/* Object was forwarded. */
			{

#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
				printf ("UPDATE_SPECIAL_REM_SET_DEBUG: Object was forwarded.\n");
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */

				hvalues [i] = zone->ov_fwd;	/* Update object now. */
				object = hvalues [i];
				zone = HEADER (object);
				CHECK ("Object forwarded", !(zone->ov_size & B_FWD));
			}
			else if (!(zone->ov_flags & EO_MARK))	/* Object is dead */
#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
				printf ("UPDATE_SPECIAL_REM_SET:Remembered object %x is dead and kicked out.\n", object);
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */
				continue;			/* Remove it from special remembered table. */
		} 
		else if (!(zone->ov_flags & EO_MARK))	/* Object cannot move */
		{

#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
			printf ("UPDATE_SPECIAL_REM_SET:Remembered object %x is dead and kicked out.\n", object);
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */

			continue;	/* Skip it. */
		}	/* if ... */
		
 
		/* The objects referred by the hvalues [i] could have been
		 * tenured, so we need to recheck whether it has its place in the
		 * special remembered set.
		 * We deal only with the subreferences recorded in the table. 
		 */
		
		CHECK ("Object not forwarded anymore", !(HEADER (object)->ov_size & B_FWD));

		/* Initializations for item. */
		offset 	= hkeys [i];

		if (offset == -1) /* No subreference to check. */
			continue;						/* Remove it. */
		if (offset == -2)		 	/* Twin, by convention.*/
		{


#ifndef NDEBUG
#ifdef EIF_EXPENSIVE_ASSERTIONS
			/* Must be present in hvalues. */

			{
				int j;
				int present = 0;
				int twin = 0;
				for (j = 0; j < count; j++)
				{
					if (hvalues [j] == hvalues [i])
					{
						present = 1;	
						if (hkeys [j] == hkeys [i])
						{
							twin = 1;
							break;
						}
					}	
				}
				CHECK ("present", present == 1);
				CHECK ("twin", twin == 1);
			}
#endif	/* EIF_EXPENSIVE_ASSERTIONS */
#endif	/* !NDEBUG */		

			continue;				/* Skip twins. */
		}	/* if ... */

		item 	= *(EIF_REFERENCE *) (object + offset * sizeof (EIF_REFERENCE));		
									/* Fetch current item . */
		izone 	= HEADER (item);	/* Malloc info zone of item. */
		if (item == (EIF_REFERENCE) 0)
			continue;				/* Skip Void item. */


#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
		printf("update_special_rem_set: Item at 0x%x (type %d, %d bytes) %s%s\n",
			item,
			HEADER(
				izone->ov_size & B_FWD ? izone->ov_fwd : item
			)->ov_flags & EO_TYPE,
			izone->ov_size & B_SIZE,
			izone->ov_size & B_FWD ? "forwarded" : "",
			izone->ov_flags & EO_MARK ? "marked" : ""
			
		);
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */

		CHECK ("Must be updated", !(HEADER (item)->ov_size & B_FWD));


		/* Look for the new item only. */

		if (!(izone->ov_flags & EO_OLD))		/* Is Item still young? */
		{
				/* Copy it into the new table. */
			zone->ov_flags |= EO_REM ;	/* Still remember it. */
			if (-1 == spt_put (new_table, offset, object))
					/* Insertion failed. */
				eif_panic ("New special rem_set cannot be bigger."); 
		}
#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
		else	/* Then , it is old. */
				/* Remove entry by ommitting it, reset the EO_REM flag. */
		{

			printf ("Removing reference special-offset = (%x, %ld (=item %x))\n", object, offset, item);

		}
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */
			
	}	/* for ... */
	
	/* In a generational cycle, we need to explicitely unmark all the
	 * alive objects, whether we keep them in the special remembered set or
	 * not. Why? Because when we tenure those objects, we mark them
	 * and also set the EO_OLD and EO_REM bit. If we do not unmark them
	 * and those are once functions, then we will never scan the inside
	 * of those objects. In other cycles, the unmarking will be done
	 * by the full sweep operation.
	 */

	if (generational)				/* Is this a generational collection? */
	{
		for (i = 0; i < new_table->old_count; i ++)
		{
			CHECK ("Object did not move during generational collect",
				!(HEADER(new_table->old_values [i])->ov_size & B_FWD));	

				/* Unmark object */
			HEADER (new_table->old_values [i])->ov_flags &=~EO_MARK;

			CHECK ("Unmarked", !(HEADER (new_table->old_values [i])->ov_flags & EO_MARK));	
		}
	}

				
	/* Update "special_rem_set". */
	special_rem_set->h_values = new_table->h_values;
	special_rem_set->h_keys = new_table->h_keys;
	special_rem_set->old_values = new_table->old_values;
	special_rem_set->count = new_table->count;
	special_rem_set->old_count = new_table->old_count;

#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
	printf("Out of update_special_rem_set: %s object %lx (type %d, %d bytes) %s\n",
		HEADER(object)->ov_flags & EO_OLD ? "old" :
		HEADER(object)->ov_flags & EO_NEW ? "new" : "gen",
		object, HEADER(object)->ov_flags & EO_TYPE,
		HEADER(object)->ov_size & B_SIZE,
		HEADER(object)->ov_flags & EO_REM ? "remembered":"forgotten");
	printf("update_special_rem_set: %ld references remaining\n",
		special_rem_set->count);
	printf ("UPDATE_REM_SET: %ld couples kicked out\n", old_count - special_rem_set->count);
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */

	CHECK ("consistent count", special_rem_set->count == new_table->count );	
	CHECK ("consistence size", special_rem_set->h_size == new_table->h_size );	
	CHECK ("consistence content", special_rem_set->h_values == new_table->h_values);	
	CHECK ("consistent keys", special_rem_set->h_keys == new_table->h_keys);	
	CHECK ("less items than before", special_rem_set->count <= old_count);

	eif_free (new_table);

#ifndef NDEBUG
	 /**************************** Postconditions *********************/

	for (i = 0; i < special_rem_set->count ; i++)			/* All still remembered.	*/
	{
		
		uint32 flags = HEADER (special_rem_set->h_values [i])->ov_flags;
								/* Fetch object flags. */

#ifdef UPDATE_SPECIAL_REM_SET_DEBUG
		printf ("UPDATE_SPECIAL_REM_SET: Checking coherence of special %x\n", special_rem_set->h_values [i]);
#endif	/* UPDATE_SPECIAL_REM_SET_DEBUG */

#ifdef EIF_EXPENSIVE_ASSERTIONS
		ENSURE ("Refers new object", refers_new_object (special_rem_set->h_values [i]));
#endif	/* EIF_EXPENSIVE_ASSERTIONS */

		ENSURE ("Remembered", flags & EO_REM);
		ENSURE ("Updated", !(HEADER (special_rem_set->h_values [i])->ov_size & B_FWD));	
		ENSURE ("Not expanded", !(flags & EO_EXP));
		ENSURE ("Old", flags & EO_OLD);	
		ENSURE ("Full of references", flags & EO_REF);
		ENSURE ("Special", flags & EO_SPEC);
		if (generational)
			ENSURE ("Not marked", !(flags & EO_MARK));
	}
	}	/* (bracket open in Preconditions.) */
	 /******************** End of Postconditions *****************************/
#endif 	/* !NDEBUG */

	return 0;						/* Always returns 0. */

}	/* update_special_rem_set () */
#endif	/* EIF_REM_SET_OPTIMIZATION */


#ifdef EIF_REM_SET_OPTIMIZATION 
rt_shared int eif_promote_special (register EIF_REFERENCE object)
	/* Promote a special object full of reference. This function
	 * scan all the subreferences of "object" so that only the
	 * young references will be processed during a partial
	 * collection.	-- ET
	 * Return value:
	 *	-2: no young references found, but object put in special
	 * 		table with index -1.
	 *	-1: Error, could not push it into special_table, not implemented yey.
	 * 	+1: Young references found, and recorded in special table.
	 */
{

	register uint32 	flags;			/* Eiffel flags */
	register int 		refs;			/* Number of references */
	
	register char 		*item;			/* Address of referred object */
	register uint32 	size;			/* Size in bytes of an item */
	register char		*ptr;				
	union overhead 		*zone;			/* Malloc info zone of "object"'s item. */		
	int 				ret = -2;		/* Returned status. */
	int 				i;				/* Index of loop. */

	EIF_GET_CONTEXT
#ifdef EIF_PROMOTE_SPECIAL_DEBUG
	printf ("EIF_PROMOTE_SPECIAL: promoting special %x\n", object);
#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	

	REQUIRE ("object not null", object != (EIF_REFERENCE) 0);
	REQUIRE ("object is special", HEADER (object)->ov_flags & EO_SPEC);
	REQUIRE ("object is full of references", HEADER (object)->ov_flags & EO_REF);
	REQUIRE ("object is not forwarded", !(HEADER (object)->ov_size & B_FWD));	

	/* Initializations. */

	flags = HEADER(object)->ov_flags;			/* Fetch Eiffel flags */
	size = (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2;
	refs = *(EIF_INTEGER *) (object + size);


	/* Loop over the referenced objects to check 
	 * if there is a new one. 
	 */

	ptr = object;							/* Temproray pointer. */
	for (i = 0; i < refs ; i++, ptr += REFSIZ) 
	{
	#ifdef EIF_PROMOTE_SPECIAL_DEBUG
		printf ("EIF_PROMOTE_SPECIAL: Scanning subref #%d amongthe %d references in %x\n", i, refs, object);
	#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	
		item = *(EIF_REFERENCE *) ptr;				/* Fetch item in special object. */
		if (item == (EIF_REFERENCE) 0)
		{
	#ifdef EIF_PROMOTE_SPECIAL_DEBUG
		printf ("EIF_PROMOTE_SPECIAL: Item at %d : 0x%x was void\n", i, item);
	#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	
			continue;						/* Skip void references.*/
		}
		zone = HEADER (item);				/* Item's malloc info zone. */
		flags = zone->ov_flags;				/* Item's Eiffel flags. */

		if (zone->ov_size & B_FWD)			/* Item is already forwarded? */
		{

#ifdef EIF_PROMOTE_SPECIAL_DEBUG
	printf ("EIF_PROMOTE_SPECIAL: item %x at %d was forwarded\n", item, i);
#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	
			
			/* An item was forwarded before the enclosing special 
			 * has been promoted. 
			 * Thus, we must update now the reference if it is an old object, 
			 * since it will not be updated at the end of the collection 
			 * in "update_special_rem_set ()". -- ET
			 */

			item = zone->ov_fwd;						/* Update. */
			flags = HEADER (item)->ov_flags;			/* Fetch new flags. */
			CHECK ("Not forwarded twice", !(HEADER (item)->ov_size & B_FWD));
			if (!(flags & EO_OLD))						/* Is item young? */
			{
				ret = 1;					/* We found a new reference. */
#ifdef EIF_PROMOTE_SPECIAL_DEBUG
	printf ("EIF_PROMOTE_SPECIAL: remembering object %x with offset %d without update\n", object, i);
#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	
				special_erembq (object, i);	/* Remember the reference. */
			}
			else	/* Then, it is old */
			{
				/* This reference will not be processed, 
				 * we must update it now. This function may be called 
				 * from the GC. */

#ifdef EIF_PROMOTE_SPECIAL_DEBUG
	printf ("EIF_PROMOTE_SPECIAL: updating new location of forwarded %x at %d without remembering it\n", item, i);
#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	
				*(EIF_REFERENCE *) (object + REFSIZ * i) = item;	/* Update. */
			}

			continue;									/* Process next item. */
		}
			
		CHECK ("Not forwarded", !(HEADER (item)->ov_size & B_FWD));
		if (!(flags & EO_OLD))							/* Is item young? */
		{
			ret = 1;								/* We found a new reference. */

#ifdef EIF_PROMOTE_SPECIAL_DEBUG
	printf ("EIF_PROMOTE_SPECIAL: inserting item in special rem set %x with index %d\n", item, i);
#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	
			CHECK ("Object valid", (*(EIF_REFERENCE *) (object + REFSIZ * i)) == (EIF_REFERENCE) item);
			special_erembq (object, i);		/* Remember young reference. */
		}
			
	}	/* for ... */

	if (ret == -2)							/* No young reference found. */
	{
#ifdef EIF_EXPENSIVE_ASSERTIONS
		CHECK ("Not refers new object", !(refers_new_object (object)));	
#endif	/* EIF_EXPENSIVE_ASSERTIONS */
#ifdef EIF_PROMOTE_SPECIAL_DEBUG
		printf ("EIF_PROMOTE_SPECIAL: no item to be inserted");
#endif	/* EIF_PROMOTE_SPECIAL_DEBUG */	

			/* Remember the object, even with no new reference, 
			 * only for unmarking it in "update_special_table ()". 
			 */

		special_erembq (object, -1);		
	}

	ENSURE ("Object is still special", HEADER (object)->ov_flags & EO_SPEC);
	ENSURE ("Object is still full of references", HEADER (object)->ov_flags & EO_REF);
#ifdef EIF_EXPENSIVE_ASSERTIONS
	ENSURE ("Has been pushed", is_in_spt (special_rem_set, object));
#endif

	/*********************** End of Postconditions. ************************/

	return ret;		/* Object does not reference any new object */

}	/* eif_promote_special () */
#endif	/* EIF_REM_SET_OPTIMIZATION */

#ifdef EIF_EXPENSIVE_ASSERTIONS
rt_private int all_subreferences_processed (EIF_REFERENCE root)
	/* Check that all the subreferences under root (root included)
	 * have been processed by some marking. Check is done at the first
	 * level only.
	 */
{
	union overhead 	*zone;		/* Malloc info zone of root. */
	union overhead 	*szone;		/* Malloc info zone of subreference. */
	int 			refs; 		/* Number of references in root. */
	int				i;
	char			*subref;	/* Subreference in root. */


	if (root == (EIF_REFERENCE) 0)
		return 1;

	zone = HEADER (root);
	
	if (zone->ov_size & B_FWD)
		return 0;	/* Not updated. */

	CHECK ("Not forwarded", !(HEADER (root)->ov_size & B_FWD));
	CHECK ("Special", HEADER (root)->ov_flags & EO_SPEC);
	CHECK ("Full of references", HEADER (root)->ov_flags & EO_REF);

	if ((zone->ov_flags & (EO_OLD | EO_REM)) == EO_OLD)
	{
		CHECK ("Not in spec rem set", !(refers_new_object (root)));
		return 1;
	}
	
	refs = *(long *) (root + ((HEADER (root)->ov_size & B_SIZE) - LNGPAD_2));

	for (i = 0; i < refs; i++)
	{
		subref = *(EIF_REFERENCE *) (root + i * REFSIZ); 
		szone = HEADER (subref);
		if (!subref)			/* Is reference Void? */
			continue;			/* Skip it - Next reference. */
		if (szone->ov_size & B_FWD)
		{
			return 0;	/* Not updated. */
		}
		if (szone->ov_flags & EO_MARK)
			continue;	/* Ok, next one. */
		if (szone->ov_flags & EO_OLD)
			continue;	/* Do not explore. */
		if ((g_data.status & GC_FAST) &&
			((subref > sc_to.sc_arena) && subref <= sc_to.sc_end)) 
				/* In TO zone. */
			continue;	/* Ok, next. */
		
		if ((g_data.status & GC_PART)) {
				/* Is this a partial scavenging. */
			if 	((subref > ps_to.sc_arena) && (subref <= ps_to.sc_end))
					/* In TO zone. */
				continue;	/* Ok, next. */
			if ((subref > ps_from.sc_arena && subref <= ps_from.sc_end))
					/* Still in FROM zone. */
				return 0;		/* Object not updated. */
		}
		return 0;
	}	

	return 1;	/* Passed successfully. */	
}	/* all_subreferences_processed () */
#endif


#ifdef EIF_EXPANSIVE_ASSERTIONS
rt_private int refers_new_object_not_updated(register EIF_REFERENCE object)
{
	/* Does 'object' directly refers to a new object? Stop as soon as the
	 * answer is known. Return a boolean value stating the result. 
	 * This routine can deal with non updated sub-objects. 
	 */

	register2 uint32 flags;			/* Eiffel flags */
	register3 int refs;				/* Number of references */
	register4 EIF_REFERENCE root;			/* Address of referred object */
	register5 uint32 size;			/* Size in bytes of an item */

	REQUIRE ("Special rememvered set valid", object);
	REQUIRE ("Special", HEADER (object)->ov_flags & EO_SPEC);
	REQUIRE ("Full of references", HEADER (object)->ov_flags & EO_REF);

	flags = HEADER(object)->ov_flags;	/* Fetch Eiffel flags */
	size = (HEADER(object)->ov_size & B_SIZE) - LNGPAD(2);
	refs = *(long *) (object + size);

	for (; refs != 0; refs--, object += REFSIZ) {
		root = *(EIF_REFERENCE *) object;			/* Get reference */
		if (root == (EIF_REFERENCE) 0)
			continue;						/* Skip void references */
		if (HEADER (root)->ov_size & B_FWD)
			flags = HEADER(HEADER (root)->ov_fwd)->ov_flags;/* Update flags. */
		else
			flags = HEADER(root)->ov_flags;
		if (!(flags & EO_OLD))
			return 1;						/* Object references a young one */
	}

	return 0;		/* Object does not reference any new object */
}
#endif	/* !NDEBUG */

rt_shared int refers_new_object(register EIF_REFERENCE object)
{
	/* Does 'object' directly refers to a new object? Stop as soon as the
	 * answer is known. Return a boolean value stating the result. This
	 * routine is recursively called to deal with expanded objects. However,
	 * there are few of them, so I chose to delcare locals in registers--RAM.
	 */

	register2 uint32 flags;			/* Eiffel flags */
	register3 int refs;				/* Number of references */
	register4 EIF_REFERENCE root;			/* Address of referred object */
	register5 uint32 size;			/* Size in bytes of an item */

#ifdef MAY_PANIC
	/* If 'object' is a void reference, panic immediately */
	if (object == (EIF_REFERENCE) 0)
		eif_panic("remembered set botched");
#endif

	size = REFSIZ;
	flags = HEADER(object)->ov_flags;	/* Fetch Eiffel flags */
	if (flags & EO_SPEC) {				/* Special object */
		if (!(flags & EO_REF))			/* (see recursive_mark() for details) */
			return 0;					/* No references at all */
		size = (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2;
		refs = *(long *) (object + size);
		if (flags & EO_COMP)			/* Composite object = has expandeds */
			size = *(long *) (object + size + LNGSIZ) + OVERHEAD;
		else
			size = REFSIZ;		/* Usual item size */
	} else
		refs = References(Deif_bid(flags));	/* Number of references */

	/* Loop over the referenced objects to see if there is a new one. If the
	 * reference is on an expanded object, recursively explore that object.
	 * No infinite loop is to be feared, as expanded object can only have ONE
	 * reference from the object within which they are held.
	 * When checking for new object, I check for not EO_OLD, because the new
	 * objects in the scavenge zone do not carry the EO_NEW mark.
	 */
	for (; refs != 0; refs--, object += size) {
		root = *(EIF_REFERENCE *) object;			/* Get reference */
		if (root == (EIF_REFERENCE) 0)
			continue;						/* Skip void references */
		flags = HEADER(root)->ov_flags;
		if (flags & EO_EXP)	{				/* Expanded object, grrr... */
			if (refers_new_object(root))
				return 1;					/* Object references a young one */
		} else if (!(flags & EO_OLD))
			return 1;						/* Object references a young one */
	}

	return 0;		/* Object does not reference any new object */
}

rt_private void swap_gen_zones(void)
{
	/* After a generation scavenging, swap the 'from' and 'to' zones. There is
	 * no need to loop over the old 'from' and dispose dead objects: no objects
	 * with a dispose procedure are allowed to be allocated there.
	 */

	struct sc_zone temp;				/* For swapping */

	/* Before swapping, we have to compute the amount of bytes we copied and
	 * the size of the original scavenging zone so that we can update the
	 * statistics accordingly. Unfortunately, those figures are counting the
	 * overhead associated with the objects--RAM.
	 */

	g_data.mem_copied += sc_from.sc_top - sc_from.sc_arena;	/* Initial */
	g_data.mem_move += sc_to.sc_top - sc_to.sc_arena;		/* Moved */

	memcpy (&temp, &sc_from, sizeof(struct sc_zone));
	memcpy (&sc_from, &sc_to, sizeof(struct sc_zone));
	memcpy (&sc_to, &temp, sizeof(struct sc_zone));

	sc_to.sc_top = sc_to.sc_arena;	/* Make sure 'to' is empty */
}

rt_public void eremb(EIF_REFERENCE obj)
{
	/* Remembers the object 'obj' by pushing it in the remembered set.
	 * It is up to the caller to ensure that 'obj' is not already remembered
	 * by testing the EO_REM bit in the header. In affectations, it is
	 * normally done by the RTAR macro.
	 */

	if (-1 == epush(&rem_set, obj)) {		/* Low on memory */
		urgent_plsc(&obj);					/* Compacting garbage collection */
		if (-1 == epush(&rem_set, obj))		/* Still low on memory */
			enomem(MTC_NOARG);						/* Critical exception */
	}

#ifdef DEBUG
	dprintf(4)("eremb: remembering object %lx (type %d, %d bytes) at age %d\n",
		obj,
		HEADER(obj)->ov_flags & EO_TYPE,
		HEADER(obj)->ov_size & B_SIZE,
		(HEADER(obj)->ov_flags & EO_AGE) >> AGE_OFFSET);
	flush;
#endif

	/* If we come here, the object was successfully pushed in the stack */
	
	HEADER(obj)->ov_flags |= EO_REM;	/* Mark it as remembered */
}

rt_public void erembq(EIF_REFERENCE obj)
{
	/* Quick version of eremb(), but without any call to the GC. This is
	 * provided for special objects (we don't want to ask for GC hooks
	 * on every 'put' operation).
	 */

	if (-1 == epush(&rem_set, obj))		/* Cannot record object */
		enomem(MTC_NOARG);						/* Critical exception */

	HEADER(obj)->ov_flags |= EO_REM;	/* Mark object as remembered */
}

#ifdef EIF_REM_SET_OPTIMIZATION
rt_public int special_rem_remove (EIF_REFERENCE obj)
{
	/* Remove `obj' in special_rem_set. */
	EIF_GET_CONTEXT
	return spt_replace (special_rem_set, obj, (EIF_REFERENCE) 0);
}	/* special_rem_remove () */

rt_public int special_erembq_replace(EIF_REFERENCE old, EIF_REFERENCE val)
{
	/* Replace `old' by `val' in special_rem_set. */
	EIF_GET_CONTEXT
	return spt_replace (special_rem_set, old, val);
}	/* special_erembq_replace () */

rt_public void 	special_erembq (EIF_REFERENCE obj, EIF_INTEGER offst)
{
	/*
	 * Special version of erembq() for special objects full of references
	 */

	EIF_GET_CONTEXT
	
#ifdef SPECIAL_EREMBQ_DEBUG
	printf ("Remembering special object %x, with offset %d\n", obj, offst);
#endif	/* SPECIAL_EREMBQ_DEBUG */

	REQUIRE ("Special", HEADER (obj)->ov_flags & EO_SPEC);
	REQUIRE ("Full of references", HEADER (obj)->ov_flags & EO_REF);	

	if (special_rem_set == (struct special_table *)	0)
			/* Initialize it. */
	{
		special_rem_set = (struct special_table *) eif_malloc (sizeof (struct special_table));
		if (special_rem_set == (struct special_table *) 0)
			enomem();

		if (-1 == spt_create (special_rem_set, EIF_SPT_SZ))
			eif_panic ("Could not create special remembered special table");
		else
			/* Fill it with zero. */
			spt_zero (special_rem_set);
	}

	CHECK ("special_rem_set created", special_rem_set != (struct special_table *) 0);	

	/* Push the old object in it with corresponding offset as a key. *
	 * With resizing of the special-table when needed.			 */

	spt_force (special_rem_set, offst, obj);
	
	HEADER(obj)->ov_flags |= EO_REM;	/* Mark object as remembered. */
	
	ENSURE ("Should be remembered", HEADER(obj)->ov_flags & EO_REM);
}	/* special_erembq () */
#else
	
rt_public void 	special_erembq (EIF_REFERENCE obj, EIF_INTEGER offst)
{
	/* Remember it in the remembered set. In the case we do not any
	 * remembrance optimization, we redirect this function to the usual
	 * remembrance process without changing the generated C-code (i.e
	 * RTAS_OPT). There is only a slight overhead in RTAS_OPT compared
	 * with the usual RTAS. -- ET*/

	erembq (obj);
}


#endif	/* EIF_REM_SET_OPTIMIZATION */

/*
 * Freeing objects: each class has a chance to redefine the 'dispose' routine
 * which will be called whenever the object is released under GC control.
 * Of course the dispose MUST NOT do anything fancy: the collection cycle is
 * done so all the pointers are safe, but the object is meant to be destroyed,
 * so its address cannot be kept to be put in a free-list for instance. To
 * minimize problems, the garbage collector is stopped before invoking the
 * 'dispose' routine--RAM.
 */

rt_shared void gfree(register union overhead *zone)
							/* Pointer on malloc info zone */
{
	/* The entry Dispose(type) holds a pointer to the dispose function to
	 * be called when freeing an entity of dynamic type 'type'. A void entry
	 * means nothing has to be done. Of course, the object is physically
	 * freed AFTER dispose has been called...
	 */

	EIF_GET_CONTEXT
	char gc_status;					/* Saved GC status */
	int saved_in_assertion;		/* Saved in_assertion value */
	register2 uint32 dtype;			/* Dynamic type of object */

/*

	* Object freed ?
	* Yes, then return -- NEED TO CHECK WITH
	* RAM - DINOV
	* Does not seem necessary to me - FRED

	if (!(zone->ov_size & B_BUSY))
		return;					
*/
							
	if (!(zone->ov_size & B_FWD)) {	/* If object has not been forwarded
									then call the dispose routine */
		dtype = Deif_bid(zone->ov_flags);
		if (Disp_rout(dtype)) { 
			gc_status = g_data.status;			/* Save GC status */
			g_data.status |= GC_STOP;			/* Stop GC */
			saved_in_assertion = in_assertion;	/* Save in_assertion */
			in_assertion = ~0;					/* Turn off assertion checking */
			DISP(dtype,(EIF_REFERENCE) (zone + 1));	/* Call 'dispose' */
			in_assertion = saved_in_assertion;	/* Set in_assertion back */
			g_data.status = gc_status;			/* Restore previous GC status */
		}
	}

	CHECK ("Cannot be in object ID stack",
		!has_object (&object_id_stack, (EIF_REFERENCE) zone + 1));

#ifdef DEBUG
	dprintf(8)("gfree: freeing object 0x%lx, DT = %d\n",
		zone + 1, dtype);
	flush;
#endif

	xfree((EIF_REFERENCE) (zone + 1));		/* Put object back to free-list */
}

/* Once functions need to be kept in a dedicated stack, so that they are
 * always kept alive. Before returning, a once function needs to call the
 * following to properly record itself.
 */

rt_public EIF_REFERENCE onceset(void)
{
	/* Record result of once functions onto the once_set stack, so that the
	 * run-time may update the address should the result be moved around by
	 * the garbage collector (we are storing the address of a C static variable.
	 */

	EIF_GET_CONTEXT
#ifdef DEBUG
	dprintf(32)("onceset");
	flush;
#endif
	
	if (-1 == epush(&once_set, (EIF_REFERENCE) 0 ))
		eraise("once function recording", EN_MEM);

	return (EIF_REFERENCE) (once_set.st_top - 1);
}

rt_public void new_onceset(EIF_REFERENCE address)
{
	/* Record result of once functions onto the once_set stack, so that the
	 * run-time may update the address should the result be moved around by
	 * the garbage collector (we are storing the address of a C static variable.
	 */

	EIF_GET_CONTEXT
	if (-1 == epush(&once_set, (EIF_REFERENCE) address))
		eraise("once function recording", EN_MEM);
}

#ifdef EIF_THREADS
rt_public void globalonceset(EIF_REFERENCE address)
{
	/* Record result of once functions onto the global global_once_set stack, so that the
	 * run-time may update the address should the result be moved around by
	 * the garbage collector (we are storing the address of a C static variable.
	 */

	if (-1 == epush(&global_once_set, address))
		eraise("once function recording", EN_MEM);
}
#endif

/*
 * Stack handling routines. Each of these require the address of the
 * associated stack structure as a parameter. This avoids code duplication
 * at the cost of an additional parameter--RAM.
 * A stack is a collection of some small chunks, linked together. The main
 * structure 'stack' describes the whole data structure completely.
 */

rt_shared int epush(register struct stack *stk, register EIF_REFERENCE value)
									/* The stack */
									/* Value to be pushed */
{
	/* Push 'value' on top of the given stack 'stk'. If the stack is
	 * full, we try to allocate a new chunk. If this fails, nothing is done,
	 * and -1 is returned to signal failure. Otherwise 0 is returned.
	 */
	EIF_GET_CONTEXT
	register3 EIF_REFERENCE *top = stk->st_top;		/* Current top of stack */

	if (top == (EIF_REFERENCE *) 0)	{					/* No stack yet? */
		top = st_alloc(stk, STACK_CHUNK);		/* Create one */
		if (top == (EIF_REFERENCE *) 0)
			return -1;				/* Could not create stack */
	}

#ifdef DEBUG
	dprintf(32)("epush: value 0x%lx on stack 0x%lx\n", value, stk);
	flush;
#endif

	if (stk->st_end == top) {
		/* The end of the current stack chunk has been reached. If there is
		 * a chunk allocated after the current one, use it, otherwise create
		 * a new one and insert it in the list.
		 */
		SIGBLOCK;							/* Critical section */
		if (stk->st_cur == stk->st_tl) {	/* Reached last chunk */
			if (-1 == st_extend(stk, STACK_CHUNK))
				return -1;			/* Could not extend stack */
			top = stk->st_top;		/* New top */
		} else {
			register4 struct stchunk *current;		/* New current chunk */

			/* Update the new stack context (main structure) */
			current = stk->st_cur = stk->st_cur->sk_next;
			top = stk->st_top = current->sk_arena;
			stk->st_end = current->sk_end;
		}
		SIGRESUME;		/* End of critical section */
	}

	*top++ = value;			/* Push value on top of the stack */
	stk->st_top = top;		/* Points to next free location */

	return 0;		/* Value was successfully pushed on the stack */
}

rt_shared EIF_REFERENCE *st_alloc(register struct stack *stk, register int size)
									/* The stack */
				 					/* Initial size */
{
	/* The stack 'stk' is created, with size 'size'. Return the arena value */
	EIF_GET_CONTEXT
	register3 EIF_REFERENCE *arena;				/* Address for the arena */
	register4 struct stchunk *chunk;	/* Address of the chunk */

	chunk = (struct stchunk *) xmalloc(size * REFSIZ, C_T, GC_OFF);
	if (chunk == (struct stchunk *) 0)
		return (EIF_REFERENCE *) 0;		/* Malloc failed for some reason */

	SIGBLOCK;							/* Critical section */
	stk->st_hd = chunk;					/* New stack (head of list) */
	stk->st_tl = chunk;					/* One chunk for now */
	stk->st_cur = chunk;				/* Current chunk */
	arena = (EIF_REFERENCE *) (chunk + 1);		/* Header of chunk */
	stk->st_top = arena;				/* Empty stack */
	chunk->sk_arena = arena;			/* Base address */
	stk->st_end = chunk->sk_end =
		(EIF_REFERENCE *) chunk + size;			/* First free location beyond stack */
	chunk->sk_next = (struct stchunk *) 0;
	chunk->sk_prev = (struct stchunk *) 0;
	SIGRESUME;							/* End of critical section */

	return arena;			/* Stack allocated */
}

rt_shared int st_extend(register struct stack *stk, register int size)
									/* The stack */
				 					/* Size of new chunk to be added */
{
	/* The stack 'stk' is extended and the 'stk' structure updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 */
	EIF_GET_CONTEXT
	register3 EIF_REFERENCE *arena;				/* Address for the arena */
	register4 struct stchunk *chunk;	/* Address of the chunk */

	chunk = (struct stchunk *) xmalloc(size * REFSIZ, C_T, GC_OFF);
	if (chunk == (struct stchunk *) 0)
		return -1;		/* Malloc failed for some reason */

	SIGBLOCK;								/* Critical section */
	arena = (EIF_REFERENCE *) (chunk + 1);			/* Header of chunk */
	chunk->sk_next = (struct stchunk *) 0;	/* Last chunk in list */
	chunk->sk_prev = stk->st_tl;			/* Preceded by the old tail */
	stk->st_tl->sk_next = chunk;			/* Maintain link w/previous */
	stk->st_tl = chunk;						/* New tail */
	chunk->sk_arena = arena;				/* Where items are stored */
	chunk->sk_end = (EIF_REFERENCE *) chunk + size;	/* First item beyond chunk */
	stk->st_top = arena;					/* New top */
	stk->st_end = chunk->sk_end;			/* End of current chunk */
	stk->st_cur = chunk;					/* New current chunk */
	SIGRESUME;								/* End of critical section */

	return 0;			/* Everything is ok */
}

rt_shared void st_truncate(register struct stack *stk)
									/* The stack to be truncated */
{
	/* Free unused chunks in the stack. If the current chunk has at least
	 * MIN_FREE locations, then we may free all the chunks starting with the
	 * next one. Otherwise, we skip the next chunk and free the remainder.
	 */

	register2 EIF_REFERENCE *top;			/* The current top of the stack */
	struct stchunk *next;			/* Address of next chunk */

	top = stk->st_top;						/* The first free location */
	if (top == (EIF_REFERENCE *) 0)					/* Not allocated yet */
		return;

	if (stk->st_end - top > MIN_FREE) {		/* Enough locations left */
		stk->st_tl = stk->st_cur;			/* Last chunk from now on */
		st_wipe_out(stk->st_cur->sk_next);	/* Free starting at next chunk */
	} else {								/* Current chunk is nearly full */
		next = stk->st_cur->sk_next;		/* We are followed by 'next' */
		if (next != (struct stchunk *) 0) {	/* There is indeed a next chunk */
			stk->st_tl = next;				/* New tail chunk */
			st_wipe_out(next->sk_next);		/* Skip it, wipe out remainder */
		}
	}
}

rt_shared void st_wipe_out(register struct stchunk *chunk)
							 		/* First chunk to be freed */
{
	/* Free all the chunks after 'chunk' */

	register2 struct stchunk *next;		/* Address of next chunk */

	if (chunk == (struct stchunk *) 0)	/* No chunk */
		return;							/* Nothing to be done */

	chunk->sk_prev->sk_next = (struct stchunk *) 0;	/* Nothing after previous */

	for (
		next = chunk->sk_next;
		chunk != (struct stchunk *) 0;
		chunk = next, next = chunk ? chunk->sk_next : chunk
	)
		xfree((EIF_REFERENCE) chunk);
}

rt_public void st_reset(register1 struct stack *stk)
		/* The stack */
{
	/* Reset the stack 'stk' to its minimal state and disgard all its
	 * contents. Walking through the list of chunks, we free them and
	 * clear the 'stk' structure.
	 */

	register2 struct stchunk *k;	/* To walk through the list */
	register3 struct stchunk *n;	/* Save next before freeing chunk */

	for (k = stk->st_hd; k; k = n) {
		n = k->sk_next;		/* This is not necessary given current xfree() */
		xfree((EIF_REFERENCE) k);	/* But how do I know implementation won't change? */
	}

	memset (stk, 0, sizeof(struct stack));
}

#ifdef EIF_REM_SET_OPTIMIZATION
rt_shared int is_in_special_rem_set (EIF_REFERENCE obj)
{
	EIF_GET_CONTEXT
	int ret;
	ret = is_in_spt (special_rem_set, obj);
	return ret;
}
#endif	/* EIF_REM_SET_OPTIMIZATION */

rt_shared int is_in_rem_set (EIF_REFERENCE obj)
{
	register2 struct stchunk	*s;			/* To walk through the list */
	register3 int				n = 0;		/* Number of items */
	register4 int 				done = 0;	/* Top of stack not reached yet */
	char 						**object;
	
	for (s = rem_set.st_hd; s && !done; s = s->sk_next) 
	{
		object = s->sk_arena;				/* Start of stack */
		if (s != rem_set.st_cur)			/* Top is before after 's' */
			n = s->sk_end - object;			/* Look at the whole chunk */
		else {
			n = rem_set.st_top - object;	/* Stop at the top */
			done = 1;						/* Reached end of stack */
		}

		for (; n > 0; n--, object++) 
		{
			if (*object == obj)
				return 1;
			continue;
		}
	}
	return 0;
}

#ifdef DEBUG
rt_private int nb_items(register1 struct stack *stk)
		/* The stack */
{
	/* Gives the number of items held in the stack */

	register2 struct stchunk *s;	/* To walk through the list */
	register3 int n = 0;			/* Number of items */
	register4 int done = 0;			/* Top of stack not reached yet */

	for (s = stk->st_hd; s && !done; s = s->sk_next) {
		if (s != stk->st_cur)
			n += s->sk_end - s->sk_arena;		/* The whole chunk */
		else {
			n += stk->st_top - s->sk_arena;		/* Stop at the top */
			done = 1;							/* Reached end of stack */
		}
	}

	return n;		/* Number of objects held in stack */
}
#endif	/* !NDEBUG */

#ifdef TEST

/* This section implements a set of tests for the garbage collector.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

#undef TEST
#undef DEBUG
#define lint					/* Avoid definition of rcsid */
#include "malloc.c"
#include "timer.c"


rt_private void run_tests(void);		/* Run all the garbage collector's tests */
rt_private void scavenge_trace(void);	/* Statistics on the scavenge space */
rt_private void run_gc(void);			/* Run garbage collector with statistics */

rt_public main(void)
{
	/* Tests for the garbage collector */

	printf("> Starting tests for the garbage collector\n");
	printf("> Package has been optimized for %s\n",
		cc_for_speed ? "speed" : "memory");
	run_tests();

	/* Generation scavenging is going to be turned off. The garbage collector
	 * can only run correctly if the remembered set is reset.
	 */
	st_reset(&rem_set);
	st_reset(&moved_set);

	printf("> Switching optimizations\n");
	cc_for_speed = 1 - cc_for_speed;
	printf("> Package is now optimized for %s\n",
		cc_for_speed ? "speed" : "memory");
	run_tests();
	printf("> End of tests\n");
	exit(0);
}

rt_private void run_tests(void)
{
	/* Run all garbage collector's tests */

	int i;
	EIF_REFERENCE p;

	/* Test generation-based collectors */

	printf(">> Testing generation collection\n");
	scavenge_trace();
	printf(">> Allocating 15 objects (void references, all remembered)\n");
	for (i = 0; i < 15; i++)
		epush(&rem_set, emalloc(0));
	scavenge_trace();
	printf(">> Collecting...\n");
	(void) collect();
	scavenge_trace();
	printf(">> Scavenge again (everything is to be collected)\n");
	(void) collect();
	scavenge_trace();
	printf(">> Allocating 15 objects (self references, all remembered)\n");
	for (i = 0; i < 15; i++) {
		epush(&rem_set, (p = emalloc(0)));
		*(EIF_REFERENCE *) p = p;			/* Double reference on itself */
		*((EIF_REFERENCE *) p + 1) = p;
	}
	printf(">> Collecting...\n");
	(void) collect();
	scavenge_trace();
	printf(">> Scavenge again (nothing is to be collected)\n");
	(void) collect();
	scavenge_trace();

	printf(">> Taking one object for root\n");
	root_obj = p;
	printf(">> Partial scavenge...\n");
	run_gc();
	scavenge_trace();

	printf(">> Releasing the root object\n");
	root_obj = 0;
	printf(">> Partial scavenge... (collects one garbage object)\n");
	run_gc();
	scavenge_trace();
}

rt_private void scavenge_trace(void)
{
	printf(">>> Scavenging flags: ");
	printf("%s%s%s%s\n",
		gen_scavenge & GS_OFF ? "GS_OFF " : "",
		gen_scavenge & GS_ON ? "GS_ON " : "",
		gen_scavenge & GS_SET ? "GS_SET " : "",
		gen_scavenge & GS_STOP ? "GS_STOP " : "");
	printf(">>> Bytes used in from: %d\n", sc_from.sc_top - sc_from.sc_arena);
	printf(">>> Objects remebered: %d\n", nb_items(&rem_set));
	printf(">>> Moved set: %d\n", nb_items(&moved_set));
}

rt_private void run_gc(void)
{
	scollect(mark_and_sweep, GST_PART);
	printf(">>> GC status:\n");
	printf(">>>> # of full collects    : %ld\n", g_data.nb_full);
	printf(">>>> # of partial collects : %ld\n", g_data.nb_partial);
	printf(">>>> Amount of memory freed: %ld\n", g_stat->mem_collect);
	printf(">>>> Total time used       : %lfs\n", g_stat->real_time / 100.);
	printf(">>>> Total time used (avg) : %lfs\n", g_stat->real_avg / 100.);
	printf(">>>> CPU time used         : %lfs\n", g_stat->cpu_time);
	printf(">>>> CPU time used (avg)   : %lfs\n", g_stat->cpu_avg);
	printf(">>>> System time used      : %lfs\n", g_stat->sys_time);
	printf(">>>> System time used (avg): %lfs\n", g_stat->sys_avg);
}

/* Functions not provided here */
rt_public void eraise(char *tag, int val)
{
	printf("Exception: %s (code %d)\n", tag, val);
	exit(1);
}

rt_public void enomem(void)
{
	eraise("Out of memory", 0);
}

rt_public void eif_panic(char *s)
{
	printf("PANIC: %s\n", s);
	exit(1);
}

#endif

#ifdef __cplusplus
}
# endif
