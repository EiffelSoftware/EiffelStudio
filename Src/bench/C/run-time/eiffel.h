/*

 ######     #    ######  ######  ######  #               #    #
 #          #    #       #       #       #               #    #
 #####      #    #####   #####   #####   #               ######
 #          #    #       #       #       #        ###    #    #
 #          #    #       #       #       #        ###    #    #
 ######     #    #       #       ######  ######   ###    #    #

	Some configured inclusions/definitions.
*/

#ifndef _eiffel_h_
#define _eiffel_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "config.h"

/* The following includes are needed only because Eiffel has no way to direct
 * the compiler to include specific files when using some externals routines.
 * Hence, to ensure a smooth C compilation, we have to include all of them--RAM.
 */

#include "out.h"
#include <stdio.h>				/* For FILE routines */
#include <sys/types.h>			/* Needed for directory entries */
#include "dir.h"				/* Directory routines */
#include "file.h"				/* %%ss moved from 3 lines above */

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#include "macros.h"

extern double math_power (double v1, double v2);

#ifdef CONCURRENT_EIFFEL
#include "curextern.h"
#endif

#ifdef __cplusplus
}
#endif

#endif

