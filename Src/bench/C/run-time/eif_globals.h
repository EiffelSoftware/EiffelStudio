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
#define EIF_CONTEXT_NOARG	eif_global_context_t	*eif_globals
#define EIF_CONTEXT			EIF_CONTEXT_NOARG,
#define EIF_STATIC_OPT


typedef struct tag_eif_globals 		/* Structure containing all global variables to the run-time */
{
		/* debug */
	int breakpoint_number;			/* used for application interrupt */


		/* garcol */
	uint32 age_table[TENURE_MAX];	/* Number of objects/age */

		/* interp */
	int argnum;						/* Number of arguments */

		/* wbench */
	struct bounds *bounds_tab;		/* Bounds of the various classes */


} eif_global_context_t;

#define breakpoint_number	(eif_globals->breakpoint_number)	/* used only in debug.c */
#define age_table	(eif_globals->age_table)		/* global to garcol.c */
#define argnum		(eif_globals->argnum)			/* global to interp.c */
#define bounds_tab	(eif_globals->bounds_tab)		/* appears only in wbench.c */

#else

#define EIF_DECL_GLOBAL(x) x
#define EIF_CONTEXT_NOARG void
#define EIF_CONTEXT
#define EIF_STATIC_OPT static


#endif	/* EIF_REENTRANT */

#endif	/* _eif_globals_h_ */
