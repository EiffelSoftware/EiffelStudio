/*

 ######    #    ######
 #         #    #
 #####     #    #####
 #         #    #
 #         #    #
 ######    #    #      #######

  ####   #        ####   #####     ##    #        ####          #    #
 #    #  #       #    #  #    #   #  #   #       #              #    #
 #       #       #    #  #####   #    #  #        ####          ######
 #  ###  #       #    #  #    #  ######  #            #   ###   #    #
 #    #  #       #    #  #    #  #    #  #       #    #   ###   #    #
  ####   ######   ####   #####   #    #  ######   ####    ###   #    #
	Global variables handling.

*/

#ifndef _eif_globals_h_
#define _eif_globals_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"
#include "eif_constants.h"
#include "eif_types.h"
#include "eif_threads.h"
#include "eif_main.h"

#define GTCX		EIF_GET_CONTEXT
#define EDCX		EIF_END_GET_CONTEXT

#ifdef EIF_THREADS

/****************************************
 *                                      *
 *    Reentrant run-time definitions    *
 *                                      *
 ****************************************/


#define MTC_NOARG			/* eif_globals */
#define MTC					/* MTC_NOARG, */
#define EIF_CONTEXT_NOARG	void /* eif_global_context_t	*MTC_NOARG */
#define EIF_CONTEXT			/* EIF_CONTEXT_NOARG, */
#define EIF_STATIC_OPT

	/*
	 * Definition of the macros EIF_GET_CONTEXT and EIF_END_GET_CONTEXT
	 *
	 * EIF_GET_CONTEXT used to contain an opening curly brace `{'. It is
	 * now changed in order not to need it anymore: it is part of the local
	 * variables declarations.
	 * EIF_END_GET_CONTEXT is now empty
	 */

#define EIF_END_GET_CONTEXT

#if defined EIF_POSIX_THREADS	/* POSIX Threads */
#if !defined EIF_NONPOSIX_TSD
#define EIF_GET_CONTEXT \
	eif_global_context_t *eif_globals = pthread_getspecific (eif_global_key);
#else /* EIF_NONPOSIX_TSD */
#define EIF_GET_CONTEXT \
	eif_global_context_t *eif_globals; \
	int ctxt_return = pthread_getspecific(eif_global_key,(void **)&eif_globals);
#endif /* EIF_NONPOSIX_TSD */

#elif defined VXWORKS			/* VxWorks Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t *eif_globals = eif_global_key;

#elif defined EIF_WIN32			/* Windows Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t *eif_globals = \
		(eif_global_context_t *) TlsGetValue (eif_global_key);

#elif defined SOLARIS_THREADS	/* Solaris Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t *eif_globals; \
	int ctxt_return = thr_getspecific (eif_global_key, (void **)&eif_globals);

#else
	Platform not supported for multithreading, check that you are using
	the correct EIFFEL flags
#endif


typedef struct tag_eif_globals		/* Structure containing all global variables to the run-time */
{
		/* cecil.c */
	unsigned char ign_invisible_cx;	/* Raise exception when class not visible? */

#ifdef WORKBENCH
		/* debug.c */
	struct dbstack db_stack_cx;		/* Debugging stack. */
	struct id_list once_list_cx;		/* Debugging once_list */
	struct dbinfo d_data_cx;			/* Global debugger information */
	struct pgcontext d_cxt_cx;			/* Main program context */
#endif

		/* eif_threads.c */
	start_routine_ctxt_t *eif_thr_context_cx;

		/* except.c */
	struct xstack eif_stack_cx;		/* Calling stack (rt_public) */
	struct xstack eif_trace_cx;		/* Unsolved exception trace */
	struct eif_exception exdata_cx;		/* Exception handling global flags */
	unsigned char ex_ign_cx[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */
	struct exprint eif_except_cx;		/* Where exception has been raised */
	int print_history_table_cx;		/* Enable/disable printing of hist. table */
	SMART_STRING ex_string_cx;			/* Container of the exception trace */

		/* garcol.c */
	struct gacinfo g_data_cx;			/* Global status */
	struct gacstat g_stat_cx[GST_NBR];	/* Run-time statistics */
	struct stack loc_stack_cx;			/* Local indirection stack */
	struct stack loc_set_cx;			/* Local variable stack */
	struct stack rem_set_cx;			/* Remembered set */
	struct stack moved_set_cx;			/* Moved objects set */
	struct stack once_set_cx;		/* Once functions */
	uint32 age_table_cx[TENURE_MAX];	/* Number of objects/age */
	uint32 size_table_cx[TENURE_MAX];	/* Amount of bytes/age */
	uint32 tenure_cx;					/* Hector needs to see that */
	long plsc_per_cx;					/* Period of plsc in acollect */
	int gc_running_cx;					/* Is the GC running */
	double last_gc_time_cx;			/* The time spent on the last collect, sweep or whatever the GC did */
	int gc_ran_cx;						/* Has the GC been running */
	struct s_table *spoilt_tbl_cx;
	struct sc_zone ps_from_cx;			/* From zone */
	struct sc_zone ps_to_cx;			/* To zone */
	struct chunk *last_from_cx;		/* Last 'from' used by partial scavenging */
	long th_alloc_cx;					/* Allocation threshold before calling GC */
	int gc_monitor_cx;					/* Disable GC time-monitoring by default */
	char *root_obj_cx;					/* Address of the 'root' object */

		/* hector.c */
	struct stack hec_stack_cx;			/* Indirection table "hectori stack" for references passed to C*/
	struct stack hec_saved_cx;			/* Indirection table "hector saved" */
	struct stack free_stack_cx;		/* Entries free in hector */

		/* interp.c */
	struct opstack op_stack_cx;		/* Operational stack */
	char *IC_cx;						/* Interpreter Counter (like PC on a CPU) */
	struct item **iregs_cx;			/* Interpreter registers */
	int iregsz_cx;						/* Size of 'iregs' array (bytes) */
	int argnum_cx;						/* Number of arguments */
	int locnum_cx;						/* Number of locals */
	unsigned long tagval_cx;			/* Records number of interpreter's call */
	char *inv_mark_table_cx;			/* Marking table to avoid checking the same invariant several times */

		/* malloc.c */
	struct emallinfo m_data_cx;		/* general information about the memory */
	struct emallinfo c_data_cx;		/* Informations on C memory */
	struct emallinfo e_data_cx;		/* Informations on Eiffel memory */
	struct ck_list cklst_cx;			/* Record head and tail of the chunk list */
	union overhead *c_hlist_cx[NBLOCKS];	/* H list for C blocks */
	union overhead *e_hlist_cx[NBLOCKS];	/* H list for Eiffel blocks */
	union overhead *c_buffer_cx[NBLOCKS];	/* Buffer cache for C list */
	union overhead *e_buffer_cx[NBLOCKS];	/* Buffer cache for Eiffel list */
	struct sc_zone sc_from_cx;				/* Scavenging 'from' zone */
	struct sc_zone sc_to_cx;				/* Scavenging 'to' zone */
	uint32 gen_scavenge_cx;				/* Generation scavenging to be set */
	long eiffel_usage_cx;					/* Monitor Eiffel memory usage */
	uint32 *type_use_cx;					/* Object usage table by dynamic type */
	uint32 c_mem_cx;						/* C memory used (bytes) */
	int chunk_size_cx;					/* Size of memory chunks (bytes) */
	int scavenge_size_cx;				/* Size of scavenge zones (bytes) */
	int max_mem_cx;					/* Maximum memory that can be allocated */

		/* memory.c */
	int m_largest_cx;						/* Size of largest coalesced block */
	struct emallinfo mem_stats_cx;			/* Memory usage.*/
	struct gacstat gc_stats_cx;			/* GC statistics.*/
	long gc_count_cx;						/* GC statistics.*/

		/* out.c */
	char buffero_cx[TAG_SIZE];	/* Buffer for printing an object in a string */ /* %%ss renamed */
	char *tagged_out_cx;		/* String where the tagged out is written */
	int tagged_max_cx;			/* Actual maximum size of `tagged_out' */
	int tagged_len_cx;			/* Actual length of `tagged_out' */

		/* pattern.c */
	uint32 eif_delta_cx[ASIZE];	/* Records shifting deltas */
	uint32 **darray_cx;		/* Pointer to array recording shifting tables */

		/* plug.c */
	int nstcall_cx;			/* Nested call global variable: signals a nested call and
							 * trigger an invariant check in generated C routines  */
	char *inv_mark_tablep_cx;	/* Marking table to avoid checking the same invariant several times */


		/* sig.c */
	char sig_ign_cx[NSIG];		/* Is signal ignored by default? */
	char osig_ign_cx[NSIG];	/* Original signal default (1 = ignored) */
	int esigblk_cx;			/* By default, signals are not blocked */
	struct s_stack sig_stk_cx;	/* Initialized by initsig() */

		/* main.c */
	char **EIF_once_values_cx;	/* Once values for a thread */
    int in_assertion_cx ;    /* Is an assertion evaluated? */

#ifdef WORKBENCH
		/* except.c */
	unsigned char db_ign_cx[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */
#endif

#ifdef ITERATIVE_MARKING
		/* garcol.c */
	struct stack path_stack_cx;				/* Keeps track of explored nodes */
	struct stack parent_expanded_stack_cx;		/* Records expanded parents */
#endif

#if defined __VMS || defined EIF_OS2 || defined SYMANTEC_CPP
#else
		/* garcol.c and retrieve.c */
	int r_fides_cx;					/* File descriptor used for retrieving */
	int s_fides_cx;					/* File descriptor used for storing */
#endif

	/* Thread management variables */
	int n_children_cx;					/* Number or child threads */
	EIF_THR_TYPE *last_child_cx;		/* Task id of the last created thread */
	EIF_MUTEX_TYPE *children_mutex_cx;	/* Mutex for join, join_all */
	thr_list_t *unfreeze_list;		/* List of threads to unfreeze */
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *children_cond_cx;	/* Condition variable for join, join_all */
#endif

} eif_global_context_t;

	/* cecil.c */
#define eif_ignore_invisible (eif_globals->ign_invisible_cx)

	/* debug.c */
#define db_stack		(eif_globals->db_stack_cx)		/* rt_shared */
#define once_list		(eif_globals->once_list_cx)		/* rt_shared */
#define d_data			(eif_globals->d_data_cx)		/* rt_shared */
#define d_cxt			(eif_globals->d_cxt_cx)		/* rt_shared */

	/* eif_threads.c */
#define eif_thr_context	(eif_globals->eif_thr_context_cx)	/* rt_public */

	/* except.c */
/* Exported data structures (used by the generated C code) */
#define eif_stack		(eif_globals->eif_stack_cx)	/* rt_public */
#define eif_trace		(eif_globals->eif_trace_cx)	/* rt_public */
#define ex_ign			(eif_globals->ex_ign_cx)	/* rt_public */
#define exdata			(eif_globals->exdata_cx)	/* rt_public */
#define eif_except		(eif_globals->eif_except_cx)	/* rt_private */
#define print_history_table (eif_globals->print_history_table_cx)   /* rt_private */
#define ex_string		(eif_globals->ex_string_cx)	/* rt_public */
#ifdef WORKBENCH
#define db_ign			(eif_globals->db_ign_cx)	/* rt_public */
#endif

	/* garcol.c */
#ifdef ITERATIVE_MARKING
#define path_stack		(eif_globals->path_stack_cx)	/* rt_private */
#define parent_expanded_stack (eif_globals->parent_expanded_stack_cx)	/* rt_private */
#endif
#define g_data			(eif_globals->g_data_cx)		/* rt_shared */
#define g_stat			(eif_globals->g_stat_cx)		/* rt_shared */
#define loc_stack		(eif_globals->loc_stack_cx)	/* rt_shared */
#define loc_set			(eif_globals->loc_set_cx)		/* rt_public */
#define rem_set			(eif_globals->rem_set_cx)		/* rt_private */
#define moved_set		(eif_globals->moved_set_cx)	/* rt_shared */
#define once_set		(eif_globals->once_set_cx)	/* rt_public */
#define age_table		(eif_globals->age_table_cx)	/* rt_private */
#define size_table		(eif_globals->size_table_cx)	/* rt_private */
#define tenure			(eif_globals->tenure_cx)		/* rt_shared */
#define plsc_per		(eif_globals->plsc_per_cx)		/* rt_public */
#define gc_running		(eif_globals->gc_running_cx)	/* rt_public */
#define last_gc_time	(eif_globals->last_gc_time_cx)	/* rt_public */
#define gc_ran			(eif_globals->gc_ran_cx)		/* rt_public */
#define spoilt_tbl		(eif_globals->spoilt_tbl_cx)	/* rt_private */
#define ps_from			(eif_globals->ps_from_cx)		/* rt_shared */
#define ps_to			(eif_globals->ps_to_cx)		/* rt_shared */
#define last_from		(eif_globals->last_from_cx)	/* rt_shared */
#define th_alloc		(eif_globals->th_alloc_cx)		/* rt_public */
#define gc_monitor		(eif_globals->gc_monitor_cx)	/* rt_public */
#define root_obj		(eif_globals->root_obj_cx)		/* rt_public */

	/* hector.c */
#define hec_stack		(eif_globals->hec_stack_cx)	/* rt_public */
#define hec_saved		(eif_globals->hec_saved_cx)	/* rt_public */
#define free_stack		(eif_globals->free_stack_cx)	/* rt_private */

	/* interp.c */
#define op_stack		(eif_globals->op_stack_cx)		/* rt_shared */
#define IC				(eif_globals->IC_cx)			/* rt_public */
#define iregs			(eif_globals->iregs_cx)		/* rt_private */
#define iregsz			(eif_globals->iregsz_cx)		/* rt_private */
#define argnum			(eif_globals->argnum_cx)		/* rt_private */
#define locnum			(eif_globals->locnum_cx)		/* rt_private */
#define tagval			(eif_globals->tagval_cx)		/* rt_private */
#define inv_mark_table	(eif_globals->inv_mark_table_cx)	/* rt_private */

	/* malloc.c */
#define m_data			(eif_globals->m_data_cx)		/* rt_shared */
#define c_data			(eif_globals->c_data_cx)		/* rt_shared */
#define e_data			(eif_globals->e_data_cx)		/* rt_shared */
#define cklst			(eif_globals->cklst_cx)		/* rt_shared */
#define c_hlist			(eif_globals->c_hlist_cx)		/* rt_private */
#define e_hlist			(eif_globals->e_hlist_cx)		/* rt_private */
#define c_buffer		(eif_globals->c_buffer_cx)		/* rt_private */
#define e_buffer		(eif_globals->e_buffer_cx)		/* rt_private */
#define sc_from			(eif_globals->sc_from_cx)		/* rt_shared */
#define sc_to			(eif_globals->sc_to_cx)		/* rt_shared */
#define gen_scavenge	(eif_globals->gen_scavenge_cx)	/* rt_shared */
#define eiffel_usage	(eif_globals->eiffel_usage_cx)	/* rt_public */
#define type_use		(eif_globals->type_use_cx)		/* rt_private */
#define c_mem			(eif_globals->c_mem_cx)		/* rt_private */
#define eif_chunk_size	(eif_globals->chunk_size_cx)	/* rt_shared? */
#define eif_scavenge_size (eif_globals->scavenge_size_cx)	/* rt_shared? */
#define eif_max_mem		(eif_globals->max_mem_cx)

	/* memory.c */
#define m_largest		(eif_globals->m_largest_cx)	/* rt_private */
#define mem_stats		(eif_globals->mem_stats_cx)	/* rt_private */
#define gc_stats		(eif_globals->gc_stats_cx)		/* rt_private */
#define gc_count		(eif_globals->gc_count_cx)		/* rt_private */

	/* out.c */
#define buffero			(eif_globals->buffero_cx)		/* rt_private */
#define tagged_out		(eif_globals->tagged_out_cx)	/* rt_private */
#define tagged_max		(eif_globals->tagged_max_cx)	/* rt_private */
#define tagged_len		(eif_globals->tagged_len_cx)	/* rt_private */

	/* pattern.c */
#define eif_delta		(eif_globals->eif_delta_cx)		/* rt_private */
#define darray			(eif_globals->darray_cx)		/* rt_private */

	/* plug.c */
#define nstcall			(eif_globals->nstcall_cx)			/* rt_public */
#define inv_mark_tablep	(eif_globals->inv_mark_tablep_cx)	/* rt_private */

	/* sig.c */
#define sig_ign			(eif_globals->sig_ign_cx)		/* rt_public */
#define osig_ign		(eif_globals->osig_ign_cx)		/* rt_public */
#define esigblk			(eif_globals->esigblk_cx)		/* rt_shared */
#define sig_stk			(eif_globals->sig_stk_cx)		/* rt_shared */

	/* main.c */
#define EIF_once_values	(eif_globals->EIF_once_values_cx)	/* rt_public */
#define in_assertion	(eif_globals->in_assertion_cx)	/* rt_public */

	/* store.c and retrieve.c */
#if defined __VMS || defined EIF_OS2 || defined SYMANTEC_CPP
#else
#define r_fides			(eif_globals->r_fides_cx)		/* rt_private */
#define s_fides			(eif_globals->s_fides_cx)		/* rt_private */
#endif

	/* special */
#define n_children		(eif_globals->n_children_cx)
#define eif_children_mutex (eif_globals->children_mutex_cx)
#define eif_children_cond (eif_globals->children_cond_cx)
#define last_child		(eif_globals->last_child_cx)

extern EIF_TSD_TYPE eif_global_key;

#else

/******************************************
 *                                        *
 *    Traditional run-time definitions    *
 *                                        *
 ******************************************/


#define MTC_NOARG
#define MTC
#define EIF_CONTEXT_NOARG void
#define EIF_CONTEXT
#define EIF_STATIC_OPT static

#define EIF_GET_CONTEXT
#define EIF_END_GET_CONTEXT


#ifdef WORKBENCH
	/* debug.c */
/* Debugging data structures */
extern struct dbstack db_stack;	/* Calling context stack */
extern struct id_list once_list;	/* Calling context once_list */
extern struct dbinfo d_data;	/* Global debugger information */
extern struct pgcontext d_cxt;	/* Program context */
#endif


	/* except.h */
/* Exported data structures (used by the generated C code) */
RT_LNK struct xstack eif_stack;	/* Stack of all the Eiffel calls */
extern struct xstack eif_trace;	/* Unsolved exception trace */
RT_LNK struct eif_exception exdata;	/* Exception handling global flags */


	/* garcol.h */
extern struct gacinfo g_data;			/* Garbage collection status */
extern struct gacstat g_stat[GST_NBR];	/* Collection statistics */
/* Exported data-structure declarations */
RT_LNK struct stack loc_stack;			/* Local indirection stack */
RT_LNK struct stack loc_set;	/* Local variable stack */
extern struct stack moved_set;	/* Describes the new generation */
extern struct stack once_set;	/* Once functions */
extern uint32 tenure;			/* Tenure value for next generation cycle */
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
RT_LNK char *root_obj;			/* Address of the 'root' object */

	/* hector.c */
RT_LNK struct stack hec_stack;		/* Indirection table "hector" */
extern struct stack hec_saved;		/* Saved indirection pointers */

	/* interp.h */
extern struct opstack op_stack;	/* Operational stack */
RT_LNK char *IC;				/* Interpreter Counter (like PC on a CPU) */


	/* eif_malloc.h */
extern struct emallinfo m_data;		/* Accounting info from malloc */
extern struct emallinfo c_data;		/* Accounting info from malloc for C */
extern struct emallinfo e_data;		/* Accounting info from malloc for Eiffel */
extern struct ck_list cklst;		/* Head and tail of chunck list */
extern struct sc_zone sc_from;		/* Scavenging 'from' zone */
extern struct sc_zone sc_to;		/* Scavenging 'to' zone */
extern uint32 gen_scavenge;			/* Is Generation Scavenging running ? */
extern long eiffel_usage;			/* For memory statistics */
extern int eif_chunk_size;			/* Size of memory chunks */
extern int eif_scavenge_size;		/* Size of scavenge zones */
extern int eif_max_mem;				/* Maximum memory that can be allocated */

	/* plug.c */
RT_LNK int nstcall;	/* Nested call global variable: signals a nested call and
					 * trigger an invariant check in generated C routines  */

	/* sig.h */
extern int esigblk;				/* Are signals blocked for later delivery? */
extern struct s_stack sig_stk;	/* The signal stack */

	/* main.c */
RT_LNK char **EIF_once_values;	/* Once values for a thread */
RT_LNK int in_assertion;	/* Value of the assertion level */

#endif	/* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif	/* _eif_globals_h_ */
