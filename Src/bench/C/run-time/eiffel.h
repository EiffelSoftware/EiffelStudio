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
#include "eif_globals.h"

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

/* Functions defined in math.c */

extern float math_rcos(float v);
extern float math_rsin(float v);
extern float math_rtan(float v);
extern float math_racos(float v);
extern float math_rasin(float v);
extern float math_ratan(float v);
extern float math_rsqrt(float v);
extern float math_rlog(float v);
extern float math_rlog10(float v);
extern float math_rfloor(float v);
extern float math_rceil(float v);
extern float math_rfabs(float v);
extern double math_power (double v1, double v2);

/* defined in pattern.c */

extern int str_str(EIF_CONTEXT EIF_OBJ text, EIF_OBJ pattern, int tlen, int plen, int start, int fuzzy);

#ifdef CONCURRENT_EIFFEL
#include "curextern.h"
#endif

#ifdef __cplusplus
}
#endif

#endif

