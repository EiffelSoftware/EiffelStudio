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

#include "eif_portable.h"
#include "eif_constants.h"
#include "eif_types.h"
#include "eif_threads.h"
#include "eif_main.h"
#include "eif_macros.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS

/******************************************
 *                                        *
 *    Traditional run-time definitions    *
 *                                        *
 ******************************************/

#define EIF_GET_CONTEXT

#ifdef WORKBENCH
	/* debug.c - Debugging data structures */
extern struct dbstack db_stack;	/* Calling context stack */
extern struct id_list once_list;	/* Calling context once_list */
RT_LNK struct dbinfo d_data;	/* Global debugger information */
extern struct pgcontext d_cxt;	/* Program context */
#endif

	/* except.h - Exported data structures (used by the generated C code) */
RT_LNK struct xstack eif_stack;	/* Stack of all the Eiffel calls */
extern struct xstack eif_trace;	/* Unsolved exception trace */
RT_LNK struct eif_exception exdata;	/* Exception handling global flags */

#ifdef WORKBENCH
	/* interp.h - debug.h */
extern struct opstack op_stack;		/* Operational stack */
RT_LNK struct opstack cop_stack;	/* Operational stack */
RT_LNK unsigned char *IC;				/* Interpreter Counter (like PC on a CPU) */
#endif

	/* plug.c */
RT_LNK int nstcall;	/* Nested call global variable: signals a nested call and
					 * trigger an invariant check in generated C routines  */

	/* sig.h */
extern int esigblk;				/* Are signals blocked for later delivery? */
extern struct s_stack sig_stk;	/* The signal stack */

	/* main.c */
RT_LNK EIF_REFERENCE *EIF_once_values;	/* Once values for a thread */
RT_LNK int in_assertion;	/* Value of the assertion level */

	/* garcol.c */
RT_LNK struct stack loc_stack;	/* Local indirection stack */
RT_LNK struct stack loc_set;	/* Local variable stack */
RT_LNK struct stack once_set;	/* Once functions */

	/* hector.c */
RT_LNK struct stack hec_stack;	/* Indirection table "hector" */
extern struct stack hec_saved;	/* Saved indirection pointers */

#else

/****************************************
 *                                      *
 *    Reentrant run-time definitions    *
 *                                      *
 ****************************************/

	/*
	 * Definition of the macros EIF_GET_CONTEXT
	 *
	 * EIF_GET_CONTEXT used to contain an opening curly brace `{'. It is
	 * now changed in order not to need it anymore: it is part of the local
	 * variables declarations.
	 */

#if defined EIF_POSIX_THREADS	/* POSIX Threads */
#if defined EIF_NONPOSIX_TSD || defined POSIX_10034A
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals; \
	int ctxt_return = pthread_getspecific(eif_global_key,(void **)&eif_globals);
#else /* EIF_NONPOSIX_TSD */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = pthread_getspecific (eif_global_key);
#endif /* EIF_NONPOSIX_TSD */

#elif defined VXWORKS			/* VxWorks Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = eif_global_key;

#elif defined EIF_WIN32			/* Windows Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = \
		(eif_global_context_t *) TlsGetValue (eif_global_key);

#elif defined SOLARIS_THREADS	/* Solaris Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals; \
	int ctxt_return = thr_getspecific (eif_global_key, (void **)&eif_globals);

#else
	Platform not supported for multithreading, check that you are using
	the correct EIFFEL flags
#endif


typedef struct tag_eif_globals		/* Structure containing all global variables to the run-time */
{

#ifdef WORKBENCH
		/* debug.c */
	struct dbstack db_stack_cx;			/* Debugging stack. */
	struct id_list once_list_cx;		/* Debugging once_list */
	struct dbinfo d_data_cx;			/* Global debugger information */
	struct pgcontext d_cxt_cx;			/* Main program context */
#endif

		/* eif_threads.c - Thread management variables */
	start_routine_ctxt_t *eif_thr_context_cx;
	EIF_THR_TYPE *eif_thr_id_cx;	/* thread id of current thread */
	int n_children_cx;					/* Number or child threads */
	EIF_THR_TYPE *last_child_cx;		/* Task id of the last created thread */
	EIF_MUTEX_TYPE *children_mutex_cx;	/* Mutex for join, join_all */
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *children_cond_cx;	/* Condition variable for join, join_all */
#endif

		/* except.c */
	struct xstack eif_stack_cx;		/* Calling stack (rt_public) */
	struct xstack eif_trace_cx;		/* Unsolved exception trace */
	struct eif_exception exdata_cx;		/* Exception handling global flags */
	unsigned char ex_ign_cx[EN_NEX];	/* Item set to 1 to ignore exception */
	struct exprint eif_except_cx;		/* Where exception has been raised */
	int print_history_table_cx;		/* Enable/disable printing of hist. table */
	SMART_STRING ex_string_cx;			/* Container of the exception trace */
#ifdef WORKBENCH
	unsigned char db_ign_cx[EN_NEX];	/* Item set to 1 to ignore exception */
#endif

		/* interp.c - debug.c */
#ifdef WORKBENCH
	struct opstack cop_stack_cx;
	struct opstack op_stack_cx;			/* Operational stack */
	unsigned char *IC_cx;						/* Interpreter Counter (like PC on a CPU) */
	struct item **iregs_cx;				/* Interpreter registers */
	int iregsz_cx;						/* Size of 'iregs' array (bytes) */
	int argnum_cx;						/* Number of arguments */
	int locnum_cx;						/* Number of locals */
	unsigned long tagval_cx;			/* Records number of interpreter's call */
	char *inv_mark_table_cx;			/* Marking table to avoid checking the same invariant several times */
	struct stochunk *saved_scur_cx; 	/* current feature context */
	struct item *saved_stop_cx;			/* current feature context */
#endif	/* WORKBENCH */

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
	char sig_ign_cx[EIF_NSIG];		/* Is signal ignored by default? */
	char osig_ign_cx[EIF_NSIG];	/* Original signal default (1 = ignored) */
	int esigblk_cx;			/* By default, signals are not blocked */
	struct s_stack sig_stk_cx;	/* Initialized by initsig() */

		/* main.c */
	EIF_REFERENCE *EIF_once_values_cx;	/* Once values for a thread */
    int in_assertion_cx ;    /* Is an assertion evaluated? */


#if defined __VMS || defined EIF_OS2 || defined SYMANTEC_CPP
#else
		/* garcol.c and retrieve.c */
	int r_fides_cx;					/* File descriptor used for retrieving */
	int s_fides_cx;					/* File descriptor used for storing */
#endif

		/* string.c */
	EIF_CHARACTER eif_string_buffer_cx [MAX_NUM_LEN + 1]; /* Where string is built. */

		/* garcol.c */
	struct stack loc_stack_cx;		/* Local indirection stack */
	struct stack loc_set_cx;	/* Local variable stack */
	struct stack once_set_cx;	/* Once functions */

		/* hector.c */
	struct stack hec_stack_cx;		/* Indirection table "hector stack" for references passed to C*/
	struct stack hec_saved_cx;		/* Indirection table "hector saved" */
	struct stack free_stack_cx;		/* Entries free in hector */

} eif_global_context_t;

/*
 *	Macros definitions.
 *
 */

#ifdef WORKBENCH

	/* debug.c */
#define db_stack			(eif_globals->db_stack_cx)		/* rt_shared */
#define once_list			(eif_globals->once_list_cx)		/* rt_shared */
#define d_data				(eif_globals->d_data_cx)		/* rt_shared */
#define d_cxt				(eif_globals->d_cxt_cx)		/* rt_shared */

#endif	/* WORKBENCH */


	/* eif_threads.c */
#define eif_thr_context		(eif_globals->eif_thr_context_cx)	/* rt_public */
#define eif_thr_id			(eif_globals->eif_thr_id_cx)	/* rt_public */
#define n_children			(eif_globals->n_children_cx)
#define eif_children_mutex 	(eif_globals->children_mutex_cx)
#define eif_children_cond 	(eif_globals->children_cond_cx)
#define last_child			(eif_globals->last_child_cx)

	/* except.c */
/* Exported data structures (used by the generated C code) */
#define eif_stack			(eif_globals->eif_stack_cx)	/* rt_public */
#define eif_trace			(eif_globals->eif_trace_cx)	/* rt_public */
#define ex_ign				(eif_globals->ex_ign_cx)	/* rt_public */
#define exdata				(eif_globals->exdata_cx)	/* rt_public */
#define eif_except			(eif_globals->eif_except_cx)	/* rt_private */
#define print_history_table (eif_globals->print_history_table_cx)   /* rt_private */
#define ex_string			(eif_globals->ex_string_cx)	/* rt_public */
#ifdef WORKBENCH
#define db_ign				(eif_globals->db_ign_cx)	/* rt_public */
#endif

	/* interp.c - debug.c */
#ifdef WORKBENCH
#define cop_stack			(eif_globals->cop_stack_cx)		/* rt_shared */
#define op_stack			(eif_globals->op_stack_cx)		/* rt_shared */
#define IC					(eif_globals->IC_cx)			/* rt_public */
#define iregs				(eif_globals->iregs_cx)			/* rt_private */
#define iregsz				(eif_globals->iregsz_cx)		/* rt_private */
#define argnum				(eif_globals->argnum_cx)		/* rt_private */
#define locnum				(eif_globals->locnum_cx)		/* rt_private */
#define tagval				(eif_globals->tagval_cx)		/* rt_private */
#define saved_scur			(eif_globals->saved_scur_cx)	/* rt_private */
#define saved_stop			(eif_globals->saved_stop_cx)	/* rt_private */
#define inv_mark_table		(eif_globals->inv_mark_table_cx)	/* rt_private */
#endif	/* WORKBENCH */

	/* out.c */
#define buffero				(eif_globals->buffero_cx)		/* rt_private */
#define tagged_out			(eif_globals->tagged_out_cx)	/* rt_private */
#define tagged_max			(eif_globals->tagged_max_cx)	/* rt_private */
#define tagged_len			(eif_globals->tagged_len_cx)	/* rt_private */

	/* pattern.c */
#define eif_delta			(eif_globals->eif_delta_cx)		/* rt_private */
#define darray				(eif_globals->darray_cx)		/* rt_private */

	/* plug.c */
#define nstcall				(eif_globals->nstcall_cx)			/* rt_public */
#define inv_mark_tablep		(eif_globals->inv_mark_tablep_cx)	/* rt_private */

	/* sig.c */
#define sig_ign				(eif_globals->sig_ign_cx)		/* rt_public */
#define osig_ign			(eif_globals->osig_ign_cx)		/* rt_public */
#define esigblk				(eif_globals->esigblk_cx)		/* rt_shared */
#define sig_stk				(eif_globals->sig_stk_cx)		/* rt_shared */

	/* main.c */
#define EIF_once_values		(eif_globals->EIF_once_values_cx)	/* rt_public */
#define in_assertion		(eif_globals->in_assertion_cx)	/* rt_public */

	/* store.c and retrieve.c */
#if defined __VMS || defined EIF_OS2 || defined SYMANTEC_CPP
#else
#define r_fides				(eif_globals->r_fides_cx)		/* rt_private */
#define s_fides				(eif_globals->s_fides_cx)		/* rt_private */
#endif

	/* string.c */
#define eif_string_buffer	(eif_globals->eif_string_buffer_cx)	/* N/A */

	/* garcol.c */
#define loc_stack			(eif_globals->loc_stack_cx) /* rt_public */
#define loc_set				(eif_globals->loc_set_cx) /* rt_public */
#define once_set			(eif_globals->once_set_cx) /* rt_public */

	/* hector.c */
#define hec_stack			(eif_globals->hec_stack_cx)		/* rt_public */
#define hec_saved			(eif_globals->hec_saved_cx)		/* rt_public */
#define free_stack			(eif_globals->free_stack_cx)	/* rt_private */

RT_LNK EIF_TSD_TYPE eif_global_key;

#endif	/* EIF_THREADS */

#define GTCX	EIF_GET_CONTEXT

#ifdef __cplusplus
}
#endif

#endif	/* _eif_globals_h_ */
