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

#include "portable.h"
#include "eif_constants.h"
#include "eif_types.h"
#include "eif_threads.h"
#include "main.h"

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

#define EIF_GET_CONTEXT \
	eif_global_context_t *eif_globals;\
	EIF_TSD_GET((eif_global_context_t *),eif_global_key,eif_globals,"Thread data not available"); \
	{
#define EIF_END_GET_CONTEXT }

typedef struct tag_eif_globals		/* Structure containing all global variables to the run-time */
{
		/*debug.c */
	struct dbstack db_stack;		/* Debugging stack. */
	struct dbinfo d_data;			/* Global debugger information */
	struct pgcontext d_cxt;			/* Main program context */

		/* eif_threads.c */
	start_routine_ctxt_t *eif_thr_context;

		/* except.c */
	struct xstack eif_stack;		/* Calling stack (rt_public) */
	struct xstack eif_trace;		/* Unsolved exception trace */
	struct eif_exception exdata;		/* Exception handling global flags */
	unsigned char ex_ign[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */
	struct exprint eif_except_cx;		/* Where exception has been raised */
	int print_history_table;		/* Enable/disable printing of hist. table */
	SMART_STRING ex_string;			/* Container of the exception trace */

		/* garcol.c */
	struct gacinfo g_data;			/* Global status */
	struct gacstat g_stat[GST_NBR];	/* Run-time statistics */
	struct stack loc_stack;			/* Local indirection stack */
	struct stack loc_set;			/* Local variable stack */
	struct stack rem_set;			/* Remembered set */
	struct stack moved_set;			/* Moved objects set */
	struct stack once_set;			/* Once functions */
	uint32 age_table[TENURE_MAX];	/* Number of objects/age */
	uint32 size_table[TENURE_MAX];	/* Amount of bytes/age */
	uint32 tenure;					/* Hector needs to see that */
	long plsc_per;					/* Period of plsc in acollect */
	int gc_running;					/* Is the GC running */
	double last_gc_time;			/* The time spent on the last collect, sweep or whatever the GC did */
	int gc_ran;						/* Has the GC been running */
	struct s_table *spoilt_tbl;
	struct sc_zone ps_from;			/* From zone */
	struct sc_zone ps_to;			/* To zone */
	struct chunk *last_from;		/* Last 'from' used by partial scavenging */
	long th_alloc;					/* Allocation threshold before calling GC */
	int gc_monitor;					/* Disable GC time-monitoring by default */
	char *root_obj;					/* Address of the 'root' object */

		/* hector.c */
	struct stack hec_stack;			/* Indirection table "hector" */
	struct stack hec_saved;			/* Entries free in hector */
	struct stack free_stack;		/* Entries free in hector */

		/* interp.c */
	struct opstack op_stack;		/* Operational stack */
	char *IC;						/* Interpreter Counter (like PC on a CPU) */
	struct item **iregs;			/* Interpreter registers */
	int iregsz;						/* Size of 'iregs' array (bytes) */
	int argnum;						/* Number of arguments */
	int locnum;						/* Number of locals */
	unsigned long tagval;			/* Records number of interpreter's call */
	char *inv_mark_table;			/* Marking table to avoid checking the same invariant several times */

		/* malloc.c */
	struct emallinfo m_data;		/* general information about the memory */
	struct emallinfo c_data;		/* Informations on C memory */
	struct emallinfo e_data;		/* Informations on Eiffel memory */
	struct ck_list cklst;			/* Record head and tail of the chunk list */
	union overhead *c_hlist[NBLOCKS];	/* H list for C blocks */
	union overhead *e_hlist[NBLOCKS];	/* H list for Eiffel blocks */
	union overhead *c_buffer[NBLOCKS];	/* Buffer cache for C list */
	union overhead *e_buffer[NBLOCKS];	/* Buffer cache for Eiffel list */
	struct sc_zone sc_from;				/* Scavenging 'from' zone */
	struct sc_zone sc_to;				/* Scavenging 'to' zone */
	uint32 gen_scavenge;				/* Generation scavenging to be set */
	long eiffel_usage;					/* Monitor Eiffel memory usage */
	uint32 *type_use;					/* Object usage table by dynamic type */
	uint32 c_mem;						/* C memory used (bytes) */

		/* memory.c */
	int m_largest;						/* Size of the largest coalesced block */
	struct emallinfo mem_stats;			/* Memory usage.*/
	struct gacstat gc_stats;			/* GC statistics.*/
	long gc_count;						/* GC statistics.*/

		/* out.c */
	char buffero[TAG_SIZE];	/* Buffer for printing an object in a string */ /* %%ss renamed */
	char *tagged_out;		/* String where the tagged out is written */
	int tagged_max;			/* Actual maximum size of `tagged_out' */
	int tagged_len;			/* Actual length of `tagged_out' */

		/* pattern.c */
	uint32 eif_delta[ASIZE];	/* Records shifting deltas */
	uint32 **darray;		/* Pointer to array recording shifting tables */

		/* plug.c */
	int nstcall;			/* Nested call global variable: signals a nested call and
							 * trigger an invariant check in generated C routines  */
	char *inv_mark_tablep;	/* Marking table to avoid checking the same invariant several times */


		/* sig.c */
	char sig_ign[NSIG];		/* Is signal ignored by default? */
	char osig_ign[NSIG];	/* Original signal default (1 = ignored) */
	int esigblk;			/* By default, signals are not blocked */
	struct s_stack sig_stk;	/* Initialized by initsig() */

		/* main.c */
	char **EIF_once_values;	/* Once values for a thread */

#ifdef WORKBENCH
		/* except.c */
	unsigned char db_ign[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */
#endif

#ifdef EIF_WIN32
		/* except.c */
	char *exception_trace_string;
#endif

#ifdef ITERATIVE_MARKING
		/* garcol.c */
	struct stack path_stack;				/* Keeps track of explored nodes */
	struct stack parent_expanded_stack;		/* Records expanded parents */
#endif

#if defined __VMS || defined EIF_OS2 || defined SYMANTEC_CPP
#else
		/* garcol.c and retrieve.c */
	int r_fides;					/* File descriptor use for retrieve */
	char r_fstoretype;				/* File storage type used for retrieve */
#endif

#if defined THREAD_DEVEL
#warning "PaulCDV: development feature of the runtime: DO NOT DELIVER"
	int n_children;					/* Number or child threads */
	int *n_brothers;				/* Number of "brother" threads, including 
									   self - protected by mutex */
#endif

} eif_global_context_t;

	/* debug.c */
#define db_stack		(eif_globals->db_stack)		/* rt_shared */
#define d_data			(eif_globals->d_data)		/* rt_shared */
#define d_cxt			(eif_globals->d_cxt)		/* rt_shared */

	/* eif_threads.c */
#define eif_thr_context	(eif_globals->eif_thr_context)	/* rt_public */

	/* except.c */
/* Exported data structures (used by the generated C code) */
#define eif_stack		(eif_globals->eif_stack)	/* rt_public */
#define eif_trace		(eif_globals->eif_trace)	/* rt_public */
#define ex_ign			(eif_globals->ex_ign)		/* rt_public */
#define exdata			(eif_globals->exdata)		/* rt_public */
#define eif_except		(eif_globals->eif_except_cx)		/* rt_private */
#define print_history_table (eif_globals->print_history_table)   /* rt_private */
#define ex_string		(eif_globals->ex_string)	/* rt_public */
#ifdef WORKBENCH
#define db_ign			(eif_globals->db_ign)		/* rt_public */
#endif
#ifdef EIF_WINDOWS
#define exception_trace_string (eif_globals->exception_trace_string)	/* no rt_ */
#endif

	/* garcol.c */
#ifdef ITERATIVE_MARKING
#define path_stack		(eif_globals->path_stack)	/* rt_private */
#define parent_expanded_stack (eif_globals->parent_expanded_stack)	/* rt_private */
#endif
#define g_data			(eif_globals->g_data)		/* rt_shared */
#define g_stat			(eif_globals->g_stat)		/* rt_shared */
#define loc_stack		(eif_globals->loc_stack)	/* rt_shared */
#define loc_set			(eif_globals->loc_set)		/* rt_public */
#define rem_set			(eif_globals->rem_set)		/* rt_private */
#define moved_set		(eif_globals->moved_set)	/* rt_shared */
#define once_set		(eif_globals->once_set)		/* rt_public */
#define age_table		(eif_globals->age_table)	/* rt_private */
#define size_table		(eif_globals->size_table)	/* rt_private */
#define tenure			(eif_globals->tenure)		/* rt_shared */
#define plsc_per		(eif_globals->plsc_per)		/* rt_public */
#define gc_running		(eif_globals->gc_running)	/* rt_public */
#define last_gc_time	(eif_globals->last_gc_time)	/* rt_public */
#define gc_ran			(eif_globals->gc_ran)		/* rt_public */
#if defined __VMS || defined EIF_OS2 || defined SYMANTEC_CPP
#else
#define r_fides			(eif_globals->r_fides)		/* rt_public */
#define r_fstoretype	(eif_globals->r_fstoretype)	/* rt_public */
#endif
#define spoilt_tbl		(eif_globals->spoilt_tbl)	/* rt_private */
#define ps_from			(eif_globals->ps_from)		/* rt_shared */
#define ps_to			(eif_globals->ps_to)		/* rt_shared */
#define last_from		(eif_globals->last_from)	/* rt_shared */
#define th_alloc		(eif_globals->th_alloc)		/* rt_public */
#define gc_monitor		(eif_globals->gc_monitor)	/* rt_public */
#define root_obj		(eif_globals->root_obj)		/* rt_public */

	/* hector.c */
#define hec_stack		(eif_globals->hec_stack)	/* rt_public */
#define hec_saved		(eif_globals->hec_saved)	/* rt_public */
#define free_stack		(eif_globals->free_stack)	/* rt_private */

	/* interp.c */
#define op_stack		(eif_globals->op_stack)		/* rt_shared */
#define IC				(eif_globals->IC)			/* rt_public */
#define iregs			(eif_globals->iregs)		/* rt_private */
#define iregsz			(eif_globals->iregsz)		/* rt_private */
#define argnum			(eif_globals->argnum)		/* rt_private */
#define locnum			(eif_globals->locnum)		/* rt_private */
#define tagval			(eif_globals->tagval)		/* rt_private */
#define inv_mark_table	(eif_globals->inv_mark_table)	/* rt_private */

	/* malloc.c */
#define m_data			(eif_globals->m_data)		/* rt_shared */
#define c_data			(eif_globals->c_data)		/* rt_shared */
#define e_data			(eif_globals->e_data)		/* rt_shared */
#define cklst			(eif_globals->cklst)		/* rt_shared */
#define c_hlist			(eif_globals->c_hlist)		/* rt_private */
#define e_hlist			(eif_globals->e_hlist)		/* rt_private */
#define c_buffer		(eif_globals->c_buffer)		/* rt_private */
#define e_buffer		(eif_globals->e_buffer)		/* rt_private */
#define sc_from			(eif_globals->sc_from)		/* rt_shared */
#define sc_to			(eif_globals->sc_to)		/* rt_shared */
#define gen_scavenge	(eif_globals->gen_scavenge)	/* rt_shared */
#define eiffel_usage	(eif_globals->eiffel_usage)	/* rt_public */
#define type_use		(eif_globals->type_use)		/* rt_private */
#define c_mem			(eif_globals->c_mem)		/* rt_private */

	/* memory.c */
#define m_largest		(eif_globals->m_largest)	/* rt_private */
#define mem_stats		(eif_globals->mem_stats)	/* rt_private */
#define gc_stats		(eif_globals->gc_stats)		/* rt_private */
#define gc_count		(eif_globals->gc_count)		/* rt_private */

	/* out.c */
#define buffero			(eif_globals->buffero)		/* rt_private */
#define tagged_out		(eif_globals->tagged_out)	/* rt_private */
#define tagged_max		(eif_globals->tagged_max)	/* rt_private */
#define tagged_len		(eif_globals->tagged_len)	/* rt_private */

	/* pattern.c */
#define eif_delta		(eif_globals->eif_delta)		/* rt_private */
#define darray			(eif_globals->darray)		/* rt_private */

	/* plug.c */
#define nstcall			(eif_globals->nstcall)			/* rt_public */
#define inv_mark_tablep	(eif_globals->inv_mark_tablep)	/* rt_private */

	/* sig.c */
#define sig_ign			(eif_globals->sig_ign)		/* rt_public */
#define osig_ign		(eif_globals->osig_ign)		/* rt_public */
#define esigblk			(eif_globals->esigblk)		/* rt_shared */
#define sig_stk			(eif_globals->sig_stk)		/* rt_shared */

	/* main.c */
#define EIF_once_values	(eif_globals->EIF_once_values)	/* rt_public */

	/* special */
/* These variables are defined only if
 * __VMS, EIF_OS2 or SYMANTEC_CPP
 * Found in retrieve.h */
/*extern int r_fides;				/* moved here from retrieve.c */
/*extern char r_fstoretype;		/* File storage type use for retrieve */

#define n_children		(eif_globals->n_children)
#define n_brothers		(eif_globals->n_brothers)

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


	/* debug.c */
/* Debugging data structures */
extern struct dbstack db_stack;	/* Calling context stack */
extern struct dbinfo d_data;	/* Global debugger information */
extern struct pgcontext d_cxt;	/* Program context */


	/* err_msg.h */
#ifdef EIF_WIN32
extern char *exception_trace_string;
#endif


	/* except.h */
/* Exported data structures (used by the generated C code) */
extern struct xstack eif_stack;	/* Stack of all the Eiffel calls */
extern struct xstack eif_trace;	/* Unsolved exception trace */
extern struct eif_exception exdata;	/* Exception handling global flags */


	/* garcol.h */
extern struct gacinfo g_data;			/* Garbage collection status */
extern struct gacstat g_stat[GST_NBR];	/* Collection statistics */
/* Exported data-structure declarations */
extern struct stack loc_stack;			/* Local indirection stack */
extern struct stack loc_set;	/* Local variable stack */
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
extern char *root_obj;			/* Address of the 'root' object */

	/* hector.c */
extern struct stack hec_stack;		/* Indirection table "hector" */
extern struct stack hec_saved;		/* Saved indirection pointers */

	/* interp.h */
extern struct opstack op_stack;	/* Operational stack */
extern char *IC;				/* Interpreter Counter (like PC on a CPU) */


	/* malloc.h */
extern struct emallinfo m_data;		/* Accounting info from malloc */
extern struct emallinfo c_data;		/* Accounting info from malloc for C */
extern struct emallinfo e_data;		/* Accounting info from malloc for Eiffel */
extern struct ck_list cklst;		/* Head and tail of chunck list */
extern struct sc_zone sc_from;		/* Scavenging 'from' zone */
extern struct sc_zone sc_to;		/* Scavenging 'to' zone */
extern uint32 gen_scavenge;			/* Is Generation Scavenging running ? */
extern long eiffel_usage;			/* For memory statistics */

	/* plug.c */
extern int nstcall;	/* Nested call global variable: signals a nested call and
					 * trigger an invariant check in generated C routines  */

	/* sig.h */
extern int esigblk;				/* Are signals blocked for later delivery? */
extern struct s_stack sig_stk;	/* The signal stack */

	/* main.c */
extern char **EIF_once_values;	/* Once values for a thread */

	/* special */
/* These variables are defined only if
 * __VMS, EIF_OS2 or SYMANTEC_CPP
 * Found in retrieve.h */
extern int r_fides;				/* moved here from retrieve.c */
extern char r_fstoretype;		/* File storage type use for retrieve */


#endif	/* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif	/* _eif_globals_h_ */
