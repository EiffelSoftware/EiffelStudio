/*

 #####      #     #####  #    #    ##     ####   #    #          #    #
 #    #     #       #    ##  ##   #  #   #       #   #           #    #
 #####      #       #    # ## #  #    #   ####   ####            ######
 #    #     #       #    #    #  ######       #  #  #     ###    #    #
 #    #     #       #    #    #  #    #  #    #  #   #    ###    #    #
 #####      #       #    #    #  #    #   ####   #    #   ###    #    #

	Some useful macros for bitmasks manipulation (for select() masks)
*/

#ifndef _bitmask_h_
#define _bitmask_h_

#ifdef I_LIMITS
#include <limits.h>			/* For WORD_BIT */
#endif
#include <sys/param.h>		/* For NOFILE */

#undef BPI
#ifdef WORD_BIT				/* Some systems may not define this */
#define BPI	WORD_BIT		/* Bits per int */
#else
#define BPI	(8 * sizeof(int))
#endif

#ifndef NOFILE
#define NOFILE VAL_NOFILE	/* File descriptor limit */
#endif

#endif

