/*

 ######   ####   #    #    ##    #               #    #
 #       #    #  #    #   #  #   #               #    #
 #####   #    #  #    #  #    #  #               ######
 #       #  # #  #    #  ######  #        ###    #    #
 #       #   #   #    #  #    #  #        ###    #    #
 ######   ### #   ####   #    #  ######   ###    #    #

	Include file for Eiffel equality
*/

#ifndef _equal_h_
#define _equal_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "portable.h"

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

/*
 * Routine declarations
 */

rt_public int xequal(char *ref1, char *ref2);			/* Equality with no conformance constraint */
rt_public int eequal(register char *target, register char *source);			/* Standard equality on standard objects */
rt_public int spequal(register char *target, register char *source);			/* Standard equality on special objects */
rt_public int eiso(char *target, char *source);				/* Standard isomorphism on normal objects */
rt_public int spiso(register char *target, register char *source);				/* Standard isomorphism on special objects */
rt_public int ediso(char *target, char *source);				/* Standard recursive isomorphism */

#ifdef __cplusplus
}
#endif

#endif
