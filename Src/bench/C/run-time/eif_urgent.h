/*

 #    #  #####    ####   ######  #    #   #####          #    #
 #    #  #    #  #    #  #       ##   #     #            #    #
 #    #  #    #  #       #####   # #  #     #            ######
 #    #  #####   #  ###  #       #  # #     #     ###    #    #
 #    #  #   #   #    #  #       #   ##     #     ###    #    #
  ####   #    #   ####   ######  #    #     #     ###    #    #

	Declarations for urgent memory chunk allocation.
*/

#ifndef _eif_urgent_h_
#define _eif_urgent_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef VXWORKS
#define URGENT_CHUNK	1016	/* Size of urgent chunk (1K with overhead) */
#define URGENT_NBR		1		/* Number of urgent chunks allocated */
#else
#define URGENT_CHUNK	1016	/* Size of urgent chunk (1K with overhead) */
#define URGENT_NBR		10		/* Number of urgent chunks allocated */
#endif

rt_shared void ufill(void);			/* Get as many chunks as possible */
rt_shared char *uchunk(void);			/* Urgent allocation of a stack chunk */

#ifdef __cplusplus
}
#endif

#endif
