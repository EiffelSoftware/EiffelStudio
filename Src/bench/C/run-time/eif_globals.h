/*

 ######     #    ######           ####   #        ####   #####     ##    #		  ####            ####
 #          #    #               #    #  #       #    #  #    #   #  #   #		 #               #    #
 #####      #    #####           #       #       #    #  #####   #    #  #		  ####           #
 #          #    #               #  ###  #       #    #  #    #  ######  #		      #   ###    #
 #          #    #               #    #  #       #    #  #    #  #    #  #		 #    #   ###    #    #
 ######     #    #      #######   ####   ######   ####   #####   #    #  ######	  ####    ###     ####

	Global variables handling.

*/

#ifndef _eif_globals_h_
#define _eif_globals_h_

#include "eif_threads.h"		/* Make sure we're definig global variables as requested */

#ifdef EIF_REENTRANT

#define EIF_EXTERN_GLOBAL(type,name)
#define EIF_GLOBAL(scope,type,name)		#define name eif_globals->eif_##name
#define EIF_THR_CONTEXT_ALONE	EIF_GLOBALS		struct EIF_GLOBALS *eif_globals
#define EIF_THR_CONTEXT			EIF_THR_CONTEXT_ALONE,

typedef struct tagEIF_GLOBALS {		/* Structure containing all global variables to the run-time */
	char *account;				/* Array of traversed dyn types */
} EIF_GLOBALS;

rt_public EIF_GLOBALS *eif_thr_init(void) {
}

#else

#define EIF_EXTERN_GLOBAL(type,name) extern scope type name;
#define EIF_GLOBAL(scope,type,name) scope type name;
#define EIF_THR_CONTEXT_ALONE void
#define EIF_THR_CONTEXT

#endif	/* EIF_REENTRANT */

#endif	/* _eif_globals_h_ */
