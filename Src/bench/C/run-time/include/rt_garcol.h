/*

  ####     ##    #####    ####    ####   #               #    #
 #    #   #  #   #    #  #    #  #    #  #               #    #
 #       #    #  #    #  #       #    #  #               ######
 #  ###  ######  #####   #       #    #  #        ###    #    #
 #    #  #    #  #   #   #    #  #    #  #        ###    #    #
  ####   #    #  #    #   ####    ####   ######   ###    #    #

	Private declarations for garbage collector routines.
*/

#ifndef _rt_garcol_h_
#define _rt_garcol_h_

#include "eif_garcol.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef VXWORKS
#define STACK_CHUNK		400		/* Size of a stack chunk */
#else
#define STACK_CHUNK		1000	/* Size of a stack chunk */
#endif
#define MIN_FREE		100		/* Below that, chunk is nearly full */
#define TH_ALLOC		786432	/* Allocation threshold (768 K)*/
#define TH_ALLOC_MIN	8192	/* Minimal allocation threshold (8 K).*/
#define OBJ_MAX			1500	/* Maximum # of young objects in moved_set */
#define TO_MAX			7		/* Maximum number of allocable 'to' */
#define CHUNK_MIN		5		/* Minimum Eiffel chunk # to activate plsc() */
#define PLSC_PER		8		/* Period of plsc in acollect */
#define SPOILT_TBL		3		/* Size of spoilt chunks recording table */

/*
 * For aging -- edit with care.
 */
#define AGE_ONE		0x02000000		/* First birthday time */
#define AGE_OFFSET	25				/* Age starts at bit 25 and lasts 4 bits */

/*
 * Garbage collector's status.
 */
#define GC_GEN		0x01			/* Full GC with generation scavenging */
#define GC_PART		0x02			/* Full GC with partial scavenging */
#define GC_FAST		0x04			/* Fast GC (generation based) */
#define GC_STOP		0x08			/* Garbage collection is stopped */
#define GC_SIG		0x10			/* Entered in a signal handler */

/*
 * Generation scavenging's status.
 */
#define GS_STOP		0x00000008		/* Generation scavenging is stopped */
#define GS_SET		0x00000004		/* Generation scavenging to be set */
#define GS_ON		0x00000002		/* Generation scavenging is set */
#define GS_OFF		0x00000001		/* Generation scavenging is off */

#ifdef EIF_THREADS
extern EIF_MUTEX_TYPE *eif_gc_mutex;	/* GC mutex */
#endif

#ifdef ISE_GC
extern EIF_INTEGER clsc_per;			/* Period of full coalescing: 0 => never. */
extern struct gacinfo g_data;			/* Garbage collection status */
extern struct gacstat g_stat[GST_NBR];	/* Collection statistics */

/* Exported data-structure declarations */
extern struct stack memory_set;	/* Memory set stack.	*/
extern struct stack moved_set;	/* Describes the new generation */
extern int tenure;			/* Tenure value for next generation cycle */
extern long plsc_per;			/* Period of plsc() in acollect() */

/* To start timing or not for GC-profiling */
extern int gc_running;			/* Is the GC currently running */
extern double last_gc_time;		/* Time spent during the last run */
extern int gc_ran;				/* Has the GC been running */

/* Exported variables */
extern struct sc_zone ps_from;	/* Partial scavenging 'from' zone */
extern struct sc_zone ps_to;	/* Partial scavenging 'to' zone */
extern struct chunk *last_from;	/* Last 'from' chunk used by plsc() */
extern long th_alloc;			/* Allocation threshold (in bytes) */
extern int gc_monitor;			/* GC monitoring flag */

#ifdef EIF_THREADS
extern struct stack_list loc_stack_list;	/* List of all `loc_stack' allocated in each thread */
extern struct stack_list loc_set_list;		/* List of all `loc_set' allocated in each thread */
extern struct stack_list once_set_list;		/* List of all `once_set' allocated in each thread */
extern struct stack_list hec_stack_list;	/* List of all `hec_stack' allocted in each thread */
extern struct stack_list hec_saved_list;	/* List of all `hec_saved' allocted in each thread */
extern struct stack_list eif_stack_list;	/* List of all `eif_stack' allocted in each thread */
extern struct stack_list eif_trace_list;	/* List of all `eif_trace' allocted in each thread */
#ifdef WORKBENCH
extern struct stack_list opstack_list;	/* List of all `opstack' allocated in each thread */
#endif
#endif

extern char **st_alloc(register struct stack *stk, register int size);	/* Creates an empty stack */
extern  int st_extend(register struct stack *stk, register int size);	/* Extends a stack */
extern void st_truncate(register struct stack *stk);	/* Truncate stack if necessary */
extern void st_wipe_out(register struct stchunk *chunk);/* Remove unneeded chunk from stack */
extern void st_reset(register struct stack *stk);/* Clean stack */

#endif /* ISE_GC */

#ifdef __cplusplus
}
#endif

#endif
