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

#define LENGTH(b)	(((struct bit *) b)->b_length)
#define ARENA(b)	(((struct bit *) b)->b_value)

#ifndef TRUE
#define TRUE		1		/* The boolean true value */
#endif
#ifndef FALSE
#define FALSE		0		/* The boolean false value */
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* 
 * Functions declarations
 */
rt_public int b_equal();	/* needed in interp.c */

extern char *b_clone();			/* Clones bit */
extern void b_copy();			/* Copies bit */
extern char *bmalloc();			/* Bit object creation */
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
extern int bit_dtype;

#ifdef __cplusplus
}
#endif

#endif
