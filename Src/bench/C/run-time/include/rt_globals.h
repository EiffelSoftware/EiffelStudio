/*

 #####    #####
 #    #     #
 #    #     #
 #####      #
 #   #      #
 #    #     #   #######

  ####   #        ####   #####     ##    #        ####          #    #
 #    #  #       #    #  #    #   #  #   #       #              #    #
 #       #       #    #  #####   #    #  #        ####          ######
 #  ###  #       #    #  #    #  ######  #            #   ###   #    #
 #    #  #       #    #  #    #  #    #  #       #    #   ###   #    #
  ####   ######   ####   #####   #    #  ######   ####    ###   #    #

	Private runtime global variables handling.

*/

#ifndef _rt_globals_h_
#define _rt_globals_h_

#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS

/******************************************
 *    Traditional run-time definitions    *
 ******************************************/

#define RT_GET_CONTEXT

#else

/****************************************
 *    Reentrant run-time definitions    *
 ****************************************/

typedef struct tag_rt_globals
{
#ifdef WORKBENCH
		/* debug.c */
	struct dbstack db_stack_cx;			/* Debugging stack. */
	struct id_list once_list_cx;		/* Debugging once_list */
	struct pgcontext d_cxt_cx;			/* Main program context */
#endif

		/* eif_threads.c */
	eif_global_context_t *eif_globals;
	start_routine_ctxt_t *eif_thr_context_cx;
	EIF_THR_TYPE *eif_thr_id_cx;		/* thread id of current thread */
	int n_children_cx;					/* Number or child threads */
	EIF_THR_TYPE *last_child_cx;		/* Task id of the last created thread */
	EIF_MUTEX_TYPE *children_mutex_cx;	/* Mutex for join, join_all */
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *children_cond_cx;	/* Condition variable for join, join_all */
#endif
#ifdef ISE_GC
		/* Synchronizations for GC*/
	int volatile gc_thread_status;
#endif

		/* except.c */
	struct xstack eif_trace_cx;			/* Unsolved exception trace */
	unsigned char ex_ign_cx[EN_NEX];	/* Item set to 1 to ignore exception */
	struct exprint eif_except_cx;		/* Where exception has been raised */
	int print_history_table_cx;			/* Enable/disable printing of hist. table */
	SMART_STRING ex_string_cx;			/* Container of the exception trace */
#ifdef WORKBENCH
	unsigned char db_ign_cx[EN_NEX];	/* Item set to 1 to ignore exception */
#endif

		/* interp.c */
#ifdef WORKBENCH
	struct opstack op_stack_cx;			/* Operational stack */
	struct item **iregs_cx;				/* Interpreter registers */
	int iregsz_cx;						/* Size of 'iregs' array (bytes) */
	int argnum_cx;						/* Number of arguments */
	int locnum_cx;						/* Number of locals */
	unsigned long tagval_cx;			/* Records number of interpreter's call */
	struct stochunk *saved_scur_cx; 	/* current feature context */
	struct item *saved_stop_cx;			/* current feature context */
	char *inv_mark_table_cx;			/* Marking table to avoid checking the same invariant several times */
#endif

		/* out.c */
	char buffero_cx[TAG_SIZE];			/* Buffer for printing an object in a string */
	char *tagged_out_cx;				/* String where the tagged out is written */
	int tagged_max_cx;					/* Actual maximum size of `tagged_out' */
	int tagged_len_cx;					/* Actual length of `tagged_out' */

		/* pattern.c */
	uint32 eif_delta_cx[ASIZE];			/* Records shifting deltas */
	uint32 **darray_cx;					/* Pointer to array recording shifting tables */

		/* plug.c */
	char *inv_mark_tablep_cx;			/* Marking table to avoid checking the same invariant
										   several times */

		/* sig.c */
	char sig_ign_cx[EIF_NSIG];			/* Is signal ignored by default? */
	char osig_ign_cx[EIF_NSIG];			/* Original signal default (1 = ignored) */
	int esigblk_cx;						/* By default, signals are not blocked */
	struct s_stack sig_stk_cx;			/* Initialized by initsig() */

		/* retrieve.c and store.c */
	int r_fides_cx;						/* File descriptor used for retrieving */
	int s_fides_cx;						/* File descriptor used for storing */

		/* string.c */
	EIF_CHARACTER eif_string_buffer_cx [MAX_NUM_LEN + 1]; /* Where string is built. */


	/* hector.c */
#ifdef ISE_GC
	struct stack hec_saved_cx;			/* Indirection table "hector saved" */
	struct stack free_stack_cx;			/* Entries free in hector */
#endif

} rt_global_context_t;

	/*
	 * Definition of the macros EIF_GET_CONTEXT
	 *
	 * EIF_GET_CONTEXT used to contain an opening curly brace `{'. It is
	 * now changed in order not to need it anymore: it is part of the local
	 * variables declarations.
	 */

#if defined EIF_POSIX_THREADS	/* POSIX Threads */
#if defined EIF_NONPOSIX_TSD || defined POSIX_10034A
rt_private rt_global_context_t * eif_pthread_getspecific (EIF_TSD_TYPE global_key) {
	rt_global_context_t * Result;
	(void) pthread_getspecific(global_key,(void **)&Result);
	return Result;
}
#define RT_GET_CONTEXT \
	rt_global_context_t * EIF_VOLATILE rt_globals = eif_pthread_getspecific(rt_global_key);
#else /* EIF_NONPOSIX_TSD */
#define RT_GET_CONTEXT \
	rt_global_context_t * EIF_VOLATILE rt_globals = pthread_getspecific (rt_global_key);
#endif /* EIF_NONPOSIX_TSD */

#elif defined VXWORKS			/* VxWorks Threads */
#define RT_GET_CONTEXT \
	rt_global_context_t * EIF_VOLATILE rt_globals = rt_global_key;

#elif defined EIF_WIN32			/* Windows Threads */
#define RT_GET_CONTEXT \
	rt_global_context_t * EIF_VOLATILE rt_globals = \
		(rt_global_context_t *) TlsGetValue (rt_global_key);

#elif defined SOLARIS_THREADS	/* Solaris Threads */
rt_private rt_global_context_t * eif_thr_getspecific (EIF_TSD_TYPE global_key) {
	rt_global_context_t * Result;
	(void) thr_getspecific(global_key,(void **)&Result);
	return Result;
}
#define RT_GET_CONTEXT \
	rt_global_context_t * EIF_VOLATILE rt_globals = eif_thr_getspecific (rt_global_key);

#else
	Platform not supported for multithreading, check that you are using
	the correct EIFFEL flags
#endif
	

	/* debug.c */
#ifdef WORKBENCH
#define db_stack			(rt_globals->db_stack_cx)		/* rt_shared */
#define once_list			(rt_globals->once_list_cx)		/* rt_shared */
#define d_cxt				(rt_globals->d_cxt_cx)		/* rt_shared */
#endif

	/* eif_threads.c */
#define eif_thr_context		(rt_globals->eif_thr_context_cx)	/* rt_public */
#define eif_thr_id			(rt_globals->eif_thr_id_cx)	/* rt_public */
#define n_children			(rt_globals->n_children_cx)
#define eif_children_mutex 	(rt_globals->children_mutex_cx)
#define eif_children_cond 	(rt_globals->children_cond_cx)
#define last_child			(rt_globals->last_child_cx)

	/* except.c */
#define eif_trace			(rt_globals->eif_trace_cx)	/* rt_public */
#define ex_ign				(rt_globals->ex_ign_cx)	/* rt_public */
#define eif_except			(rt_globals->eif_except_cx)	/* rt_private */
#define print_history_table (rt_globals->print_history_table_cx)   /* rt_private */
#define ex_string			(rt_globals->ex_string_cx)	/* rt_public */
#ifdef WORKBENCH
#define db_ign				(rt_globals->db_ign_cx)	/* rt_public */
#endif

	/* interp.c - debug.c */
#ifdef WORKBENCH
#define op_stack			(rt_globals->op_stack_cx)		/* rt_shared */
#define iregs				(rt_globals->iregs_cx)			/* rt_private */
#define iregsz				(rt_globals->iregsz_cx)		/* rt_private */
#define argnum				(rt_globals->argnum_cx)		/* rt_private */
#define locnum				(rt_globals->locnum_cx)		/* rt_private */
#define tagval				(rt_globals->tagval_cx)		/* rt_private */
#define saved_scur			(rt_globals->saved_scur_cx)	/* rt_private */
#define saved_stop			(rt_globals->saved_stop_cx)	/* rt_private */
#define inv_mark_table		(rt_globals->inv_mark_table_cx)	/* rt_private */
#endif	/* WORKBENCH */

	/* out.c */
#define buffero				(rt_globals->buffero_cx)		/* rt_private */
#define tagged_out			(rt_globals->tagged_out_cx)	/* rt_private */
#define tagged_max			(rt_globals->tagged_max_cx)	/* rt_private */
#define tagged_len			(rt_globals->tagged_len_cx)	/* rt_private */

	/* pattern.c */
#define eif_delta			(rt_globals->eif_delta_cx)		/* rt_private */
#define darray				(rt_globals->darray_cx)		/* rt_private */

	/* plug.c */
#define inv_mark_tablep		(rt_globals->inv_mark_tablep_cx)	/* rt_private */

	/* sig.c */
#define sig_ign				(rt_globals->sig_ign_cx)		/* rt_public */
#define osig_ign			(rt_globals->osig_ign_cx)		/* rt_public */
#define esigblk				(rt_globals->esigblk_cx)		/* rt_shared */
#define sig_stk				(rt_globals->sig_stk_cx)		/* rt_shared */

	/* retrieve.c and store.c */
#define r_fides				(rt_globals->r_fides_cx)		/* rt_private */
#define s_fides				(rt_globals->s_fides_cx)		/* rt_private */

	/* string.c */
#define eif_string_buffer	(rt_globals->eif_string_buffer_cx)	/* N/A */

#ifdef ISE_GC
	/* hector.c */
#define hec_saved			(rt_globals->hec_saved_cx)		/* rt_public */
#define free_stack			(rt_globals->free_stack_cx)	/* rt_private */
#endif

RT_LNK EIF_TSD_TYPE rt_global_key;

#endif

#ifdef __cplusplus
}
#endif

#endif

