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

#include "portable.h"

/* 
 * Functions declarations
 */

extern char *eclone();			/* Clone of an Eiffel object */
extern char *spclone();			/* Clone for a special object */
extern char *edclone();			/* Deep clone of an Eiffel object */
extern char *rtclone();			/* The Eiffel clone operation (run-time) */
extern void ecopy();			/* Standard copy of a normal Eiffel object */
extern void xcopy();			/* Expanded copy with possible exception */
extern void spcopy();			/* Standard copy of a special object */
extern void spsubcopy();		/* Copy special objects' slices */
extern void spclearall();		/* Reset special object's items to default */

#ifdef HAS_SAFE_BCOPY
#define safe_bcopy(s,d,l) bcopy((s),(d),(l))
#elif defined HAS_SAFE_MEMCPY
#define safe_bcopy(s,d,l) memcpy((d),(s),(l))
#elif defined HAS_MEMMOVE
#define safe_bcopy(s,d,l) memmove((d),(s),(l))
#else
You must define your own version of safe_bcopy
#endif

#endif
