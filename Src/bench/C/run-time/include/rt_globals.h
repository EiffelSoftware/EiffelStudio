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
#include "rt_hash.h"
#include "rt_retrieve.h"
#include "idrf.h"
#include "rt_traverse.h"

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
		/* copy.c and equal.c */
	struct hash hclone_cx;					/* Cloning hash table */
	struct s_table *eif_equality_table_cx;				/* Search table for deep equal */

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

		/* gen_conf.c */
	int16 cid_array_cx[3];

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

		/* retrieve.c */
	struct htable *rt_table_cx;
	int32 nb_recorded_cx;
	char rt_kind_cx;
	char rt_kind_version_cx;
	EIF_BOOLEAN eif_discard_pointer_value_cx;
	type_table *type_conversions_cx;
	mismatch_table *mismatches_cx;
	int **dattrib_cx;
	int *dtypes_cx;
	uint32 *spec_elm_size_cx;
	uint32 old_overhead_cx;
	char *r_buffer_cx;
	int r_fides_cx;
	class_translations_table class_translations_cx;
	int (*retrieve_read_func_cx)(void);
	int (*char_read_func_cx)(char *, int);
	int (*old_retrieve_read_func_cx)(void);
	int (*old_char_read_func_cx)(char *, int);
	char old_rt_kind_cx;
	long old_buffer_size_cx;
	int end_of_buffer_cx;
	char *stream_buffer_cx;
	int stream_buffer_position_cx;
	long stream_buffer_size_cx;
	int16 cidarr_cx[256];
	EIF_PROCEDURE mismatch_information_initialize_cx;
	EIF_PROCEDURE mismatch_information_add_cx;
	EIF_OBJECT mismatch_information_object_cx;
	EIF_BOOLEAN eif_use_old_independent_retrieve_cx;

		/* run_idr.c */
	char *idr_temp_buf_cx;
	int amount_read_cx;
	long idrf_buffer_size_cx;
	IDRF idrf_cx;
	int (*run_idr_read_func_cx) (IDR *);

		/* store.c */
	long object_count_cx;
	char *cmps_general_buffer_cx;
	char *general_buffer_cx;
	int current_position_cx;
	long buffer_size_cx;
	long old_store_buffer_size_cx;
	long cmp_buffer_size_cx;
	int s_fides_cx;
	void (*store_write_func_cx)(void);
	void (*flush_buffer_func_cx)(void);
	void (*st_write_func_cx)(EIF_REFERENCE);
	void (*make_header_func_cx)(void);
	int (*char_write_func_cx)(char *, int);
	void (*old_store_write_func_cx)(void);
	int (*old_char_write_func_cx)(char *, int);
	void (*old_flush_buffer_func_cx)(void);
	void (*old_st_write_func_cx)(EIF_REFERENCE);
	void (*old_make_header_func_cx)(void);
	int accounting_cx;
	int old_accounting_cx;
	EIF_BOOLEAN eif_is_new_independent_format_cx;
	char *account_cx;
	unsigned int **sorted_attributes_cx;
	char *store_stream_buffer_cx;
	long store_stream_buffer_position_cx;
	long store_stream_buffer_size_cx;
	EIF_BOOLEAN eif_is_new_recoverable_format_cx;

		/* string.c */
	EIF_CHARACTER eif_string_buffer_cx [MAX_NUM_LEN + 1]; /* Where string is built. */

		/* traverse.c */
	struct mstack map_stack_cx;
	EIF_INTEGER_32 obj_nb_cx;
	EIF_REFERENCE referers_target_cx;
	EIF_INTEGER instance_type_cx;
	struct obj_array *found_collection_cx;
	struct obj_array *marked_collection_cx;

		/* hector.c */
#ifdef ISE_GC
	struct stack hec_saved_cx;			/* Indirection table "hector saved" */
	struct stack free_stack_cx;			/* Entries free in hector */
#endif

		/* option.c */
	int last_dtype_cx;
	int last_origin_cx;
	char *last_name_cx;
	struct htable *class_table_cx;
#ifdef HAS_GETRUSAGE
	struct 	prof_rusage	*init_date_cx;
#elif defined(HAS_TIMES)
	double 	       init_date_cx;
#elif defined(EIF_WIN32)
	SYSTEMTIME 	*init_date_cx;
#endif  /* HAS_GERUSAGE */


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
rt_private rt_global_context_t * rt_thr_getspecific (EIF_TSD_TYPE global_key) {
	rt_global_context_t * Result;
	(void) thr_getspecific(global_key,(void **)&Result);
	return Result;
}
#define RT_GET_CONTEXT \
	rt_global_context_t * EIF_VOLATILE rt_globals = rt_thr_getspecific (rt_global_key);

#else
	Platform not supported for multithreading, check that you are using
	the correct EIFFEL flags
#endif
	

	/* copy.c and equal.c */
#define hclone				(rt_globals->hclone_cx)		/* rt_private */
#define eif_equality_table	(rt_globals->eif_equality_table_cx)		/* rt_private */

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

	/* gen_conf.c */
#define cid_array			(rt_globals->cid_array_cx)

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

	/* retrieve.c */
#define rt_table						(rt_globals->rt_table_cx)
#define nb_recorded						(rt_globals->nb_recorded_cx)
#define rt_kind							(rt_globals->rt_kind_cx)
#define rt_kind_version					(rt_globals->rt_kind_version_cx)
#define eif_discard_pointer_values		(rt_globals->eif_discard_pointer_value_cx)
#define type_conversions				(rt_globals->type_conversions_cx)
#define mismatches						(rt_globals->mismatches_cx)
#define dattrib							(rt_globals->dattrib_cx)
#define dtypes							(rt_globals->dtypes_cx)
#define spec_elm_size					(rt_globals->spec_elm_size_cx)
#define old_overhead					(rt_globals->old_overhead_cx)
#define r_buffer						(rt_globals->r_buffer_cx)
#define r_fides							(rt_globals->r_fides_cx)
#define class_translations				(rt_globals->class_translations_cx)
#define retrieve_read_func				(rt_globals->retrieve_read_func_cx)
#define char_read_func					(rt_globals->char_read_func_cx)
#define old_retrieve_read_func			(rt_globals->old_retrieve_read_func_cx)
#define old_char_read_func				(rt_globals->old_char_read_func_cx)
#define old_rt_kind						(rt_globals->old_rt_kind_cx)
#define old_buffer_size					(rt_globals->old_buffer_size_cx)
#define end_of_buffer					(rt_globals->end_of_buffer_cx)
#define stream_buffer					(rt_globals->stream_buffer_cx)
#define stream_buffer_position			(rt_globals->stream_buffer_position_cx)
#define stream_buffer_size				(rt_globals->stream_buffer_size_cx)
#define cidarr							(rt_globals->cidarr_cx)
#define mismatch_information_initialize	(rt_globals->mismatch_information_initialize_cx)
#define mismatch_information_add		(rt_globals->mismatch_information_add_cx)
#define mismatch_information_object		(rt_globals->mismatch_information_object_cx)
#define eif_use_old_independent_retrieve (rt_globals->eif_use_old_independent_retrieve_cx)

	/* run_idr.c */
#define idr_temp_buf		(rt_globals->idr_temp_buf_cx)
#define amount_read			(rt_globals->amount_read_cx)
#define idrf_buffer_size	(rt_globals->idrf_buffer_size_cx)
#define idrf				(rt_globals->idrf_cx)
#define run_idr_read_func	(rt_globals->run_idr_read_func_cx)

	/* store.c */
#define object_count					(rt_globals->object_count_cx)
#define cmps_general_buffer				(rt_globals->cmps_general_buffer_cx)
#define general_buffer					(rt_globals->general_buffer_cx)
#define current_position				(rt_globals->current_position_cx)
#define buffer_size						(rt_globals->buffer_size_cx)
#define old_store_buffer_size			(rt_globals->old_store_buffer_size_cx)
#define cmp_buffer_size					(rt_globals->cmp_buffer_size_cx)
#define s_fides							(rt_globals->s_fides_cx)
#define store_write_func				(rt_globals->store_write_func_cx)
#define flush_buffer_func				(rt_globals->flush_buffer_func_cx)
#define st_write_func					(rt_globals->st_write_func_cx)
#define make_header_func				(rt_globals->make_header_func_cx)
#define char_write_func			 		(rt_globals->char_write_func_cx)
#define old_store_write_func			(rt_globals->old_store_write_func_cx)
#define old_char_write_func 			(rt_globals->old_char_write_func_cx)
#define old_flush_buffer_func			(rt_globals->old_flush_buffer_func_cx)
#define old_st_write_func				(rt_globals->old_st_write_func_cx)
#define old_make_header_func			(rt_globals->old_make_header_func_cx)
#define accounting						(rt_globals->accounting_cx)
#define old_accounting					(rt_globals->old_accounting_cx)
#define eif_is_new_independent_format	(rt_globals->eif_is_new_independent_format_cx)
#define account							(rt_globals->account_cx)
#define sorted_attributes				(rt_globals->sorted_attributes_cx)
#define store_stream_buffer				(rt_globals->store_stream_buffer_cx)
#define store_stream_buffer_position	(rt_globals->store_stream_buffer_position_cx)
#define store_stream_buffer_size		(rt_globals->store_stream_buffer_size_cx)
#define eif_is_new_recoverable_format	(rt_globals->eif_is_new_recoverable_format_cx)

	/* string.c */
#define eif_string_buffer	(rt_globals->eif_string_buffer_cx)	/* N/A */

	/* traverse.c */
#define map_stack			(rt_globals->map_stack_cx)
#define obj_nb				(rt_globals->obj_nb_cx)
#define referers_target		(rt_globals->referers_target_cx)
#define instance_type		(rt_globals->instance_type_cx)
#define found_collection	(rt_globals->found_collection_cx)
#define marked_collection	(rt_globals->marked_collection_cx)

#ifdef ISE_GC
	/* hector.c */
#define hec_saved			(rt_globals->hec_saved_cx)		/* rt_public */
#define free_stack			(rt_globals->free_stack_cx)	/* rt_private */
#endif

	/* option.c */
#define last_dtype			(rt_globals->last_dtype_cx)
#define last_origin			(rt_globals->last_origin_cx)
#define last_name			(rt_globals->last_name_cx)
#define class_table			(rt_globals->class_table_cx)
#define init_date			(rt_globals->init_date_cx)

RT_LNK EIF_TSD_TYPE rt_global_key;

#endif

#ifdef __cplusplus
}
#endif

#endif

