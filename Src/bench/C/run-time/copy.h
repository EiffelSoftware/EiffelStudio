/*

  ####    ####   #####    #   #          #    #
 #    #  #    #  #    #    # #           #    #
 #       #    #  #    #     #            ######
 #       #    #  #####      #     ###    #    #
 #    #  #    #  #          #     ###    #    #
  ####    ####   #          #     ###    #    #

	Include file for source file copy.c
*/

#ifndef _copy_h_
#define _copy_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_globals.h"
#include "portable.h"

/* 
 * Functions declarations
 */

extern char *eclone(register char *source);			/* Clone of an Eiffel object */
extern char *spclone(register char *source);			/* Clone for a special object */
extern char *edclone(EIF_CONTEXT char *source);			/* Deep clone of an Eiffel object */
extern char *rtclone(char *source);			/* The Eiffel clone operation (run-time) */
extern void ecopy(register char *source, register char *target);			/* Standard copy of a normal Eiffel object */
extern void xcopy(char *source, char *target);			/* Expanded copy with possible exception */
extern void spcopy(register char *source, register char *target);			/* Standard copy of a special object */
extern void spsubcopy(EIF_POINTER source, EIF_POINTER target, EIF_INTEGER start, EIF_INTEGER end, EIF_INTEGER strchr);		/* Copy special objects' slices */
extern void spclearall(EIF_POINTER spobj);		/* Reset special object's items to default */

#ifdef HAS_SAFE_BCOPY
#define safe_bcopy(s,d,l) bcopy((s),(d),(l))
#elif defined HAS_SAFE_MEMCPY
#define safe_bcopy(s,d,l) memcpy((d),(s),(l))
#elif defined HAS_MEMMOVE
#define safe_bcopy(s,d,l) memmove((d),(s),(l))
#else
You must define your own version of safe_bcopy
#endif

#ifdef __cplusplus
}
#endif

#endif
