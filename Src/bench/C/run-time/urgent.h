/*

 #    #  #####    ####   ######  #    #   #####          #    #
 #    #  #    #  #    #  #       ##   #     #            #    #
 #    #  #    #  #       #####   # #  #     #            ######
 #    #  #####   #  ###  #       #  # #     #     ###    #    #
 #    #  #   #   #    #  #       #   ##     #     ###    #    #
  ####   #    #   ####   ######  #    #     #     ###    #    #

	Declarations for urgent memory chunk allocation.
*/

#ifndef _urgent_h_
#define _urgent_h_

#include "config.h"
#include "portable.h"

#define URGENT_CHUNK	1016	/* Size of urgent chunk (1K with overhead) */
#define URGENT_NBR		10		/* Number of urgent chunks allocated */

shared void ufill();			/* Get as many chunks as possible */
shared char *uchunk();			/* Urgent allocation of a stack chunk */

#endif
