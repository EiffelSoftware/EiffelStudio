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

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

/*
 * Routine declarations
 */

extern int xequal(char *ref1, char *ref2);			/* Equality with no conformance constraint */
extern int eequal(register char *target, register char *source);			/* Standard equality on standard objects */
extern int spequal(register char *target, register char *source);			/* Standard equality on special objects */
extern int eiso(char *target, char *source);				/* Standard isomorphism on normal objects */
extern int spiso(register char *target, register char *source);				/* Standard isomorphism on special objects */
extern int ediso(char *target, char *source);				/* Standard recursive isomorphism */

#ifdef __cplusplus
}
#endif

#endif
