/*

 ######   ####   #    #    ##    #               #    #
 #       #    #  #    #   #  #   #               #    #
 #####   #    #  #    #  #    #  #               ######
 #       #  # #  #    #  ######  #        ###    #    #
 #       #   #   #    #  #    #  #        ###    #    #
 ######   ### #   ####   #    #  ######   ###    #    #

	Include file for Eiffel equality
*/

#ifndef _eif_equal_h_
#define _eif_equal_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

/*
 * Routine declarations
 */

RT_LNK EIF_BOOLEAN xequal(EIF_REFERENCE ref1, EIF_REFERENCE ref2);			/* Equality with no conformance constraint */
RT_LNK EIF_BOOLEAN eequal(register EIF_REFERENCE target, register EIF_REFERENCE source);			/* Standard equality on standard objects */
extern EIF_BOOLEAN eiso(EIF_REFERENCE target, EIF_REFERENCE source);				/* Standard isomorphism on normal objects */
extern EIF_BOOLEAN spiso(register EIF_REFERENCE target, register EIF_REFERENCE source);				/* Standard isomorphism on special objects */
RT_LNK EIF_BOOLEAN ediso(EIF_REFERENCE target, EIF_REFERENCE source);				/* Standard recursive isomorphism */

#ifdef __cplusplus
}
#endif

#endif
