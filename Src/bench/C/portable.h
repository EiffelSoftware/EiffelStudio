/*

 #####    ####   #####    #####    ##    #####   #       ######          #    #
 #    #  #    #  #    #     #     #  #   #    #  #       #               #    #
 #    #  #    #  #    #     #    #    #  #####   #       #####           ######
 #####   #    #  #####      #    ######  #    #  #       #        ###    #    #
 #       #    #  #   #      #    #    #  #    #  #       #        ###    #    #
 #        ####   #    #     #    #    #  #####   ######  ######   ###    #    #

	Some portable declarations.

*/

#ifndef _portable_h_
#define _portable_h_

#ifdef __cplusplus
extern "C" {
#endif
 
#ifndef _config_h_
#include "config.h"
#endif

#ifdef EIF_WINDOWS
#ifdef EIF_WIN32
#include "confmagic.h"
#include <stdlib.h>
#else
#include "confmagc.h"
#endif
#else
#include "confmagic.h"
#endif

#ifdef __VMS
#include <unixlib.h>
#include <unixio.h>
#include <stdlib.h>
#endif

/*
 * Standard types
 */
#if INTSIZE < 4
typedef int int16;
typedef long int32;
typedef unsigned int uint16;
typedef unsigned long uint32;
#else
typedef short int16;
typedef int int32;
typedef unsigned short uint16;
typedef unsigned int uint32;
#endif

/*
 * Integer 32 bit constants
 */
#define INT32_MAX 2147483647
#define INT32_MIN (- INT32_MAX - 1)

/*
 * Scope control pseudo-keywords
 */
#define rt_public				/* default C scope */
#define rt_private static		/* static outside a block means private */
#define rt_shared				/* data shared between modules, but not public */

/* Maps an Eiffel type on a C type */
typedef long            EIF_INTEGER;
typedef unsigned char   EIF_CHARACTER;
typedef float           EIF_REAL;
typedef double          EIF_DOUBLE;
typedef char *          EIF_REFERENCE;
typedef char *          EIF_POINTER;
typedef unsigned char   EIF_BOOLEAN;

#ifdef __cplusplus
}
#endif

#endif
