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

#include "eif_threads.h"		/* Make sure we're definig global variables as requested */

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

#else

#define EIF_DECL_GLOBAL(x) x
#define MTC_NOARG
#define MTC
#define EIF_CONTEXT_NOARG void
#define EIF_CONTEXT
#define EIF_STATIC_OPT static


	/* except.c */
/* Exported data structures (used by the generated C code) */
extern struct xstack eif_stack;	/* Stack of all the Eiffel calls */
extern struct xstack eif_trace;	/* Unsolved exception trace */
extern struct eif_except exdata;	/* Exception handling global flags */

#ifdef EIF_WINDOWS

	/* err_msg.h */
extern char *exception_trace_string;

#endif

#endif	/* EIF_REENTRANT */

#endif	/* _eif_globals_h_ */
