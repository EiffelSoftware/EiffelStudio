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

public int xequal();			/* Equality with no conformance constraint */
public int eequal();			/* Standard equality on standard objects */
public int spequal();			/* Standard equality on special objects */
public int eiso();				/* Standard isomorphism on normal objects */
public int spiso();				/* Standard isomorphism on special objects */
public int ediso();				/* Standard recursive isomorphism */

#endif
