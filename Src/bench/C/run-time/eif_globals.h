/*

 ######     #    ######           ####   #        ####   #####     ##    #		  ####           #    #
 #          #    #               #    #  #       #    #  #    #   #  #   #		 #               #    #
 #####      #    #####           #       #       #    #  #####   #    #  #		  ####           ######
 #          #    #               #  ###  #       #    #  #    #  ######  #		      #   ###    #    #
 #          #    #               #    #  #       #    #  #    #  #    #  #		 #    #   ###    #    #
 ######     #    #      #######   ####   ######   ####   #####   #    #  ######	  ####    ###    #    #

	Global variables handling.

*/

#ifndef _eif_globals_h_
#define _eif_globals_h_

#include "eif_threads.h"		/* Make sure we're defining global variables as requested */

#include "portable.h"
#include "eif_types.h"
#include "eif_constants.h"


#ifdef EIF_REENTRANT

/****************************************
 *                                      *
 *    Reentrant run-time definitions    *
 *                                      *
 ****************************************/


#define EIF_DECL_GLOBAL(x)
#define MTC_NOARG			/* eif_globals */
#define MTC					/* MTC_NOARG, */
#define EIF_CONTEXT_NOARG	/* eif_global_context_t	*MTC_NOARG */
#define EIF_CONTEXT			/* EIF_CONTEXT_NOARG, */
#define EIF_STATIC_OPT

extern EIF_TSD_TYPE eif_global_key

#define EIF_GET_CONTEXT \
	EIF_TSD_TYPE eif_globals;\
	EIF_ERRCODE_TYPE tsd_key_err;
	EIF_TSD_GET(eif_global_key,eif_globals,tsd_key_err);
	if (EIF_TSD_INVALID_ERRCODE(tsd_key_err)) {
		panic();
	else {
#define EIF_END_GET_CONTEXT }


typedef struct tag_eif_globals		/* Structure containing all global variables to the run-time */
{

		/* except.c */
	struct xstack eif_stack;		/* Calling stack (rt_public) */
	struct xstack eif_trace;		/* Unsolved exception trace */
	struct eif_except exdata;		/* Exception handling global flags */
	unsigned char ex_ign[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */
	struct exprint except;			/* Where exception has been raised */
	int print_history_table;		/* Enable/disable printing of hist. table */
	SMART_STRING ex_string;			/* Container of the exception trace */

		/* garcol.c */
	struct gacinfo g_data;			/* Global status */
	struct gacstat g_stat[GST_NBR];	/* Run-time statistics */
	struct stack loc_stack;			/* Local indirection stack */

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
	uint32 delta[ASIZE];	/* Records shifting deltas */
	uint32 **darray;		/* Pointer to array recording shifting tables */

		/* plug.c */
	int nstcall;			/* Nested call global variable: signals a nested call and
							 * trigger an invariant check in generated C routines  */
	char *inv_mark_tablep;	/* Marking table to avoid checking the same invariant several times */


		/* sig.c */
	char sig_ign[NSIG];		/* Is signal ignored by default? */
	char osig_ign[NSIG];	/* Original signal default (1 = ignored) */
	int esigblk = 0;		/* By default, signals are not blocked */
	struct s_stack sig_stk;	/* Initialized by initsig() */


#ifdef WORKBENCH
		/* except.c */
	unsigned char db_ign[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */
#endif

#ifdef EIF_WINDOWS
		/* except.c */
	char *exception_trace_string;
#endif

#ifdef ITERATIVE_MARKING
		/* garcol.c */
	struct stack path_stack;				/* Keeps track of explored nodes */
	struct stack parent_expanded_stack;		/* Records expanded parents */
#endif

} eif_global_context_t;


	/* except.c */
/* Exported data structures (used by the generated C code) */
#define eif_stack	(eif_globals->eif_stack)	/* rt_public */
#define eif_trace	(eif_globals->eif_trace)	/* rt_public */
#define ex_ign		(eif_globals->ex_ign)		/* rt_public */
#define exdata		(eif_globals->exdata)		/* rt_public */
#define except		(eif_globals->except)		/* rt_private */
#define print_history_table (eif_globals->print_history_table)   /* rt_private */
#define ex_string	(eif_globals->ex_string)	/* rt_public */
#ifdef WORKBENCH
#define db_ign (eif_globals->db_ign)	/* rt_public */
#endif
#ifdef EIF_WINDOWS
#define exception_trace_string (eif_globals->exception_trace_string)	/* no rt_ */
#endif

	/* garcol.c */
#define g_data		(eif_globals->g_data)			/* rt_shared */
#define g_stat		(eif_globals->g_stat)			/* rt_shared */
#define loc_stack	(eif_globals->loc_stack)		/* rt_shared */
#ifdef ITERATIVE_MARKING
#define path_stack	(eif_globals->path_stack)		/* rt_private */
#define parent_expanded_stack (eif_globals->parent_expanded_stack)	/* rt_private */
#endif

	/* interp.c */
#define op_stack	(eif_globals->op_stack)         /* rt_shared */
#define IC			(eif_globals->IC)               /* rt_public */
#define iregs		(eif_globals->iregs)            /* rt_private */
#define iregsz		(eif_globals->iregsz)           /* rt_private */
#define argnum		(eif_globals->argnum)           /* rt_private */
#define locnum		(eif_globals->locnum)           /* rt_private */
#define tagval		(eif_globals->tagval)           /* rt_private */
#define inv_mark_table	(eif_globals->inv_mark_table)   /* rt_private */

	/* malloc.c */
#define m_data					(eif_globals->m_data)         /* rt_shared */
#define c_data					(eif_globals->c_data)         /* rt_shared */
#define e_data					(eif_globals->e_data)         /* rt_shared */
#define cklst					(eif_globals->cklst)		  /* rt_shared */
#define c_hlist					(eif_globals->c_hlist)		  /* rt_private */
#define e_hlist					(eif_globals->e_hlist)		  /* rt_private */
#define c_buffer				(eif_globals->c_buffer)		  /* rt_private */
#define e_buffer				(eif_globals->e_buffer)		  /* rt_private */
#define sc_from					(eif_globals->sc_from)        /* rt_shared */
#define sc_to					(eif_globals->sc_to)		  /* rt_shared */
#define gen_scavenge			(eif_globals->gen_scavenge)	  /* rt_shared */
#define eiffel_usage			(eif_globals->eiffel_usage)   /* rt_public */
#define type_use				(eif_globals->type_use)		  /* rt_private */
#define c_mem					(eif_globals->c_mem)		  /* rt_private */

	/* memory.c */
#define m_largest				(eif_globals->m_largest)	  /* rt_private */
#define mem_stats				(eif_globals->mem_stats)	  /* rt_private */
#define gc_stats				(eif_globals->gc_stats)		  /* rt_private */
#define gc_count				(eif_globals->gc_count)		  /* rt_private */

	/* out.c */
#define buffero		(eif_globals->buffero)		/* rt_private */
#define tagged_out	(eif_globals->tagged_out)	/* rt_private */
#define tagged_max	(eif_globals->tagged_max)	/* rt_private */
#define tagged_len	(eif_globals->tagged_len)	/* rt_private */

	/* pattern.c */
#define delta	(eif_globals->delta)	/* rt_private */
#define darray	(eif_globals->darray)	/* rt_private */

	/* plug.c */
#define nstcall			(eif_globals->nstcall)			/* rt_public */
#define inv_mark_tablep	(eif_globals->inv_mark_tablep)	/* rt_private */

	/* sig.c */
#define sig_ign					(eif_globals->sig_ign)		/* rt_public */
#define osig_ign				(eif_globals->osig_ign)		/* rt_public */
#define esigblk					(eif_globals->esigblk)		/* rt_shared */
#define sig_stk					(eif_globals->sig_stk)		/* rt_shared */


#else

/******************************************
 *                                        *
 *    Traditional run-time definitions    *
 *                                        *
 ******************************************/


#define EIF_DECL_GLOBAL(x) x
#define MTC_NOARG
#define MTC
#define EIF_CONTEXT_NOARG void
#define EIF_CONTEXT
#define EIF_STATIC_OPT static

#define EIF_GET_CONTEXT
#define EIF_END_GET_CONTEXT


	/* err_msg.h */
#ifdef EIF_WINDOWS
extern char *exception_trace_string;
#endif

	/* except.c */
/* Exported data structures (used by the generated C code) */
extern struct xstack eif_stack;	/* Stack of all the Eiffel calls */
extern struct xstack eif_trace;	/* Unsolved exception trace */
extern struct eif_except exdata;	/* Exception handling global flags */

	/* garcol.c */
extern struct gacinfo g_data;			/* Garbage collection status */
extern struct gacstat g_stat[GST_NBR];	/* Collection statistics */
extern struct stack loc_stack;			/* Local indirection stack */

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


#endif	/* EIF_REENTRANT */

#endif	/* _eif_globals_h_ */
