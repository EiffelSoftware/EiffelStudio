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

#ifdef __cplusplus
extern "C" {
#endif

#include "config.h"
#include "portable.h"

#define URGENT_CHUNK	1016	/* Size of urgent chunk (1K with overhead) */
#define URGENT_NBR		10		/* Number of urgent chunks allocated */

rt_shared void ufill(void);			/* Get as many chunks as possible */
rt_shared char *uchunk(void);			/* Urgent allocation of a stack chunk */

#ifdef __cplusplus
}
#endif

#endif
