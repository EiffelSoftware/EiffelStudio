/*

 #####      #     #####   ####           #    #
 #    #     #       #    #               #    #
 #####      #       #     ####           ######
 #    #     #       #         #   ###    #    #
 #    #     #       #    #    #   ###    #    #
 #####      #       #     ####    ###    #    #

	Declarations for bits handling routines.
*/

#ifndef _bits_h_
#define _bits_h_

#include "portable.h"
#include "plug.h"

/* Bits are stored in unsigned 32 bits integer, and padding occurs if needed.
 * This means some garbage bits may be found at the end of the bit field.
 * BIT_NBPACK computes the number of 'uint32' fields (bit units) needed to
 * store a given amount of bits.
 */
#define BIT_PACKSIZE	sizeof(uint32)		/* Size of a bit unit in bytes */
#define BIT_UNIT		32					/* Size of a bit unit in bits */
#define BIT_NBPACK(s)	(((s) / BIT_UNIT) + (((s) % BIT_UNIT) ? 1 : 0))

#define LENGTH(b)	(((struct bit *) b)->b_length)
#define ARENA(b)	(((struct bit *) b)->b_value)

#define TRUE		1		/* The boolean true value */
#define FALSE		0		/* The boolean false value */

/* 
 * Functions declarations
 */

extern void b_put();
extern char b_item();
extern char *b_shift();
extern char *b_rotate();
extern char *b_and();
extern char *b_implies();
extern char *b_or();
extern char *b_xor();
extern char *b_not();
extern char *b_out();
extern char *b_mirror();

#endif
