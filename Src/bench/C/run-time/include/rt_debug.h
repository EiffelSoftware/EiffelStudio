/*

 #####   ######  #####   #    #   ####           #    #
 #    #  #       #    #  #    #  #    #          #    #
 #    #  #####   #####   #    #  #               ######
 #    #  #       #    #  #    #  #  ###   ###    #    #
 #    #  #       #    #  #    #  #    #   ###    #    #
 #####   ######  #####    ####    ####    ###    #    #

	Private data structures and functions used by debugger.
*/

#ifndef _rt_debug_h_
#define _rt_debug_h_

#include "eif_debug.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
#ifdef WORKBENCH
extern struct pgcontext d_cxt;		/* Program context */
extern struct dbstack db_stack;		/* Calling context stack */
extern struct id_list once_list;	/* Calling context once_list */
#endif
#endif

#ifdef __cplusplus
}
#endif

#endif
