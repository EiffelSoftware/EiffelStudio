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

#define EIF_DECL_GLOBAL(x)
#define MTC_NOARG	eif_globals
#define MTC			MTC_NOARG,
#define EIF_CONTEXT_NOARG	eif_global_context_t	*MTC_NOARG
#define EIF_CONTEXT			EIF_CONTEXT_NOARG,
#define EIF_STATIC_OPT


typedef struct tag_eif_globals 		/* Structure containing all global variables to the run-time */
{

		/* except.c */
	struct xstack eif_stack;		/* Calling stack (rt_public) */
	struct xstack eif_trace;		/* Unsolved exception trace */
	struct eif_except exdata;		/* Exception handling global flags */
	unsigned char ex_ign[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */
	struct exprint except;		/* Where exception has been raised */
	int print_history_table = ~0;   /* Enable/disable printing of hist. table */
	SMART_STRING ex_string;			/* Container of the exception trace */

#ifdef WORKBENCH

		/* except.c */
	unsigned char db_ign[EN_NEX];	/* Item set to 1 to ignore exception */ /* %%zmt not extern... */

#endif

#ifdef EIF_WINDOWS

		/* except.c */
	char *exception_trace_string;

#endif

		/* interp.c */
	struct opstack op_stack;		/* Operational stack */
	char *IC;						/* Interpreter Counter (like PC on a CPU) */
	struct item **iregs;			/* Interpreter registers */
	int iregsz;						/* Size of 'iregs' array (bytes) */
	int argnum;						/* Number of arguments */
	int locnum;						/* Number of locals */
	unsigned long tagval;			/* Records number of interpreter's call */
	char *inv_mark_table;			/* Marking table to avoid checking the same invariant several times */

/* plug.c */
int nstcall;            /* Nested call global variable: signals a nested call and
* trigger an invariant check in generated C routines  */
char *inv_mark_tablep;  /* Marking table to avoid checking the same invariant several times */
 
/* pattern.c */
uint32 delta[ASIZE];    /* Records shifting deltas */
uint32 **darray;        /* Pointer to array recording shifting tables */
 
/* out.c */
char buffero[TAG_SIZE]; /* Buffer for printing an object in a string */ /* %%ss renamed */
char *tagged_out;       /* String where the tagged out is written */
int tagged_max;         /* Actual maximum size of `tagged_out' */
int tagged_len;         /* Actual length of `tagged_out' */


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



} eif_global_context_t;


	/* except.c */
/* Exported data structures (used by the generated C code) */
#define eif_stack (eif_globals->eif_stack)	/* Calling stack (rt_public) */
#define eif_trace (eif_globals->eif_trace)	/* Unsolved exception trace */
#define exdata (eif_globals->exdata)	/* Exception handling global flags */
#define ex_ign (eif_globals->ex_ign)	/* Item set to 1 to ignore exception */
#define except (eif_globals->except)	/* Where exception has been raised */
#define print_history_table (eif_globals->print_history_table)   /* Enable/disable printing of hist. table */ /* %%zs added 'int' type */
#define ex_string (eif_globals->ex_string)		/* Container of the exception trace */

#ifdef WORKBENCH

	/* except.c */
#define db_ign (eif_globals->db_ign)	/* Item set to 1 to ignore exception */ /* %%zmt used only once ! */

#endif

#ifdef EIF_WINDOWS

	/* except.c */
#define exception_trace_string (eif_globals->exception_trace_string)

#endif

#define op_stack	          (eif_globals->op_stack)         /* rt_shared */
#define IC                    (eif_globals->IC)               /* rt_public */
#define iregs			      (eif_globals->iregs)            /* rt_private */
#define iregsz                (eif_globals->iregsz)           /* rt_private */
#define argnum                (eif_globals->argnum)           /* rt_private */
#define locnum                (eif_globals->locnum)           /* rt_private */
#define tagval                (eif_globals->tagval)           /* rt_private */
#define inv_mark_table        (eif_globals->inv_mark_table)   /* rt_private */
 
#define nstcall               (eif_globals->nstcall)          /* rt_public */
#define inv_mark_tablep       (eif_globals->inv_mark_tablep)  /* rt_private */
 
#define delta				  (eif_globals->delta)            /* rt_private */
#define darray                (eif_globals->darray)           /* rt_private */

#define buffero               (eif_globals->buffero)          /* rt_private */
#define tagged_out            (eif_globals->tagged_out)       /* rt_private */
#define tagged_max            (eif_globals->tagged_max)       /* rt_private */
#define tagged_len            (eif_globals->tagged_len)       /* rt_private */

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



#else

#define EIF_DECL_GLOBAL(x) x
#define MTC_NOARG
#define MTC
#define EIF_CONTEXT_NOARG void
#define EIF_CONTEXT
#define EIF_STATIC_OPT static

#define EIF_GET_CONTEXT
#define EIF_END_GET_CONTEXT


	/* except.c */
/* Exported data structures (used by the generated C code) */
extern struct xstack eif_stack;	/* Stack of all the Eiffel calls */
extern struct xstack eif_trace;	/* Unsolved exception trace */
extern struct eif_except exdata;	/* Exception handling global flags */

#ifdef EIF_WINDOWS

	/* err_msg.h */
extern char *exception_trace_string;

#endif

/* interp.h */
extern char *IC;
extern struct opstack op_stack;

/* plug.c */
extern int nstcall;


	/* malloc.h */
extern struct emallinfo m_data;		/* Accounting info from malloc */
extern struct emallinfo c_data;		/* Accounting info from malloc for C */
extern struct emallinfo e_data;		/* Accounting info from malloc for Eiffel */
extern struct ck_list cklst;		/* Head and tail of chunck list */
extern struct sc_zone sc_from;		/* Scavenging 'from' zone */
extern struct sc_zone sc_to;		/* Scavenging 'to' zone */
extern uint32 gen_scavenge;			/* Is Generation Scavenging running ? */
extern long eiffel_usage;			/* For memory statistics */



#endif	/* EIF_REENTRANT */

#endif	/* _eif_globals_h_ */
