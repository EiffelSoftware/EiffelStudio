/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Private declarations for garbage collector routines.
*/

#ifndef _rt_garcol_h_
#define _rt_garcol_h_

#include "eif_garcol.h"
#include "rt_constants.h"

#ifdef EIF_THREADS
#include "rt_threads.h"
#endif

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
#define PLSC_PER		20		/* Period of plsc in acollect */
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
#define GS_STOP		0x00000004		/* Generation scavenging is stopped */
#define GS_ON		0x00000002		/* Generation scavenging is on */
#define GS_OFF		0x00000001		/* Generation scavenging is off */

#ifdef WORKBENCH
#ifdef CONCURRENT_EIFFEL
#define DISP(x,y) \
	(x == scount)?sep_obj_dispose(y):call_disp(x,y)
#else
#define DISP(x,y) call_disp(x,y)
#endif

#else
#define DISP(x,y) ((void *(*)())Dispose(x))(y)
#endif

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_gc_mutex;	/* GC mutex */
extern EIF_LW_MUTEX_TYPE *eif_gc_set_mutex;	/* GC mutex */
extern EIF_LW_MUTEX_TYPE *eif_global_once_set_mutex;
#ifdef ISE_GC
extern EIF_LW_MUTEX_TYPE *eif_rt_g_data_mutex;
#endif
#endif

#ifdef ISE_GC
extern EIF_INTEGER clsc_per;			/* Period of full coalescing: 0 => never. */
extern struct gacinfo rt_g_data;			/* Garbage collection status */
extern struct gacstat rt_g_stat[GST_NBR];	/* Collection statistics */

/* Exported data-structure declarations */
extern struct stack memory_set;	/* Memory set stack.	*/
extern struct stack moved_set;	/* Describes the new generation */
extern int tenure;			/* Tenure value for next generation cycle */
extern long plsc_per;			/* Period of plsc() in acollect() */
extern long force_plsc;

/* To start timing or not for GC-profiling */
extern int gc_running;			/* Is the GC currently running */
extern double last_gc_time;		/* Time spent during the last run */
extern int gc_ran;				/* Has the GC been running */

/* Exported variables */
extern struct sc_zone ps_from;	/* Partial scavenging 'from' zone */
extern struct sc_zone ps_to;	/* Partial scavenging 'to' zone */
extern struct chunk *last_from;	/* Last 'from' chunk used by plsc() */
extern size_t th_alloc;			/* Allocation threshold (in bytes) */
extern int gc_monitor;			/* GC monitoring flag */

/* Overflow stack limit: number of recursive call we authorized
 * for each marking routine. As soon as we reach this number
 * we stop the recursion and proceed to marking by storing
 * objects that should be marked into `overflow_stack_set'
 * so that they will be marked later in an iterative algorithm.
 */
#define OVERFLOW_STACK_LIMIT 2000
extern uint32 overflow_stack_limit;


#ifdef EIF_THREADS
extern struct stack_list loc_stack_list;	/* List of all `loc_stack' allocated in each thread */
extern struct stack_list loc_set_list;		/* List of all `loc_set' allocated in each thread */
extern struct stack_list once_set_list;		/* List of all `once_set' allocated in each thread */
extern struct stack_list oms_set_list;		/* List of all `oms_set' allocated in each thread */
extern struct stack_list hec_stack_list;	/* List of all `hec_stack' allocted in each thread */
extern struct stack_list hec_saved_list;	/* List of all `hec_saved' allocted in each thread */
extern struct stack_list eif_stack_list;	/* List of all `eif_stack' allocted in each thread */
extern struct stack_list eif_trace_list;	/* List of all `eif_trace' allocted in each thread */
#ifdef WORKBENCH
extern struct stack_list opstack_list;	/* List of all `opstack' allocated in each thread */
#endif
#endif

extern int acollect(void);				/* Automatic garbage collection */
extern int scollect(int (*gc_func) (void), int i);				/* Collection with statistics */
extern void urgent_plsc(EIF_REFERENCE *object);			/* Partial scavenge with given local root */
extern void gfree(register union overhead *zone);	/* Garbage collector's free routine */

/* Status */
extern int is_in_rem_set (EIF_REFERENCE obj);	/* Is obj in rem-set? */
extern int refers_new_object(register EIF_REFERENCE object);		/* Does an object refers to young ones ? */
extern char *to_chunk(void);			/* Base address of partial 'to' chunk */
#endif /* ISE_GC */

RT_LNK int epush(register struct stack *stk, register void *value);	/* Push an addess on a run-time stack */

extern EIF_REFERENCE *st_alloc(register struct stack *stk, register int size);	/* Creates an empty stack */
extern  int st_extend(register struct stack *stk, register int size);	/* Extends a stack */
extern void st_truncate(register struct stack *stk);	/* Truncate stack if necessary */
extern void st_wipe_out(register struct stchunk *chunk);/* Remove unneeded chunk from stack */
extern void st_reset(register struct stack *stk);/* Clean stack */

/* Once manifest string manipulation:
 * 	ALLOC_OMS(a) allocates array to store string objects and assigns it to `a'
 * 	FREE_OMS(a) frees previously allocated array `a'
 */
#if defined(WORKBENCH) || defined(EIF_THREADS)
extern EIF_REFERENCE **alloc_oms ();
extern void free_oms (EIF_REFERENCE **oms_array);
#define ALLOC_OMS(a)	{a = alloc_oms ();}
#define FREE_OMS(a)	{free_oms (a); a = NULL;}
#else
#define ALLOC_OMS(a)
#define FREE_OMS(a)
#endif

#ifdef __cplusplus
}
#endif

#endif
