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

#include "config.h"

/* The following includes are needed only because Eiffel has no way to direct
 * the compiler to include specific files when using some externals routines.
 * Hence, to ensure a smooth C compilation, we have to include all of them--RAM.
 */

#include "out.h"
#include <stdio.h>				/* For FILE routines */
#include "file.h"
#include <sys/types.h>			/* Needed for directory entries */
#include "dir.h"				/* Directory routines */

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

#include "macros.h"

extern double math_power ();

#endif



