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


#ifdef EIF_WIN32

/* Usually, the following macros are defined in <sys/types.h> or <sys/select.h>,
 * but I define mine there to ensure a wider portability. This means this file
 * has to be included at the end of the include list, or there is a chance those
 * could be redefined elsewhere.
 */

struct fd_mask {
	unsigned long fdm_bits[NOFILE/BPI+1];	/* NOFILE max # of fd available */
};

#undef FD_ZERO
#define FD_ZERO(p)		memset((char *) (p), 0, sizeof(*(p)))
#undef FD_SET
#define FD_SET(n, p)	((p)->fdm_bits[(n)/BPI] |= (1 << ((n) % BPI)))
#undef FD_CLR
#define FD_CLR(n, p)	((p)->fdm_bits[(n)/BPI] &= ~(1 << ((n) % BPI)))
#undef FD_ISSET
#define FD_ISSET(n, p)	((p)->fdm_bits[(n)/BPI] & (1 << (n) % BPI))

#endif

#endif
