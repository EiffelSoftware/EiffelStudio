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

#define true		'\01'		/* The boolean true value */
#define false		'\0'		/* The boolean false value */

/* 
 * Functions declarations
 */

extern char *bmalloc();
extern char b_equal();
extern void b_copy();
extern char *b_clone();
extern void b_put();
extern char b_item();
extern char *b_shift();
extern char *b_rotate();
extern char *b_and();
extern char *b_implies();
extern char *b_or();
extern char *b_xor();
extern char *b_not();

#endif
