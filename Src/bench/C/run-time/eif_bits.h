/*

 #####      #     #####   ####           #    #
 #    #     #       #    #               #    #
 #####      #       #     ####           ######
 #    #     #       #         #   ###    #    #
 #    #     #       #    #    #   ###    #    #
 #####      #       #     ####    ###    #    #

	Declarations for bits handling routines.
*/

#ifndef _eif_bits_h_
#define _eif_bits_h_

#include "eif_portable.h"
#include "eif_plug.h"

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
RT_LNK EIF_BOOLEAN b_equal(char *a, char *b);	/* needed in interp.c */
RT_LNK char *b_eout(char *bit);					/* Eiffel string for out representation of a bit */
RT_LNK char *b_clone(char *bit);				/* Clones bit */
RT_LNK void b_copy(char *a, char *b);			/* Copies bit */
RT_LNK char *bmalloc(long int size);			/* Bit object creation */
RT_LNK void b_put(char *bit, char value, int at);
RT_LNK EIF_BOOLEAN b_item(char *bit, long int at);
RT_LNK char *b_shift(char *bit, long int s);
RT_LNK char *b_rotate(char *bit, long int s);
RT_LNK char *b_and(char *a, char *b);
RT_LNK char *b_implies(char *a, char *b);
RT_LNK char *b_or(char *a, char *b);
RT_LNK char *b_xor(char *a, char *b);
RT_LNK char *b_not(char *a);
RT_LNK char *b_out(char *bit);
RT_LNK char *b_mirror(char *a);

#ifdef __cplusplus
}
#endif

RT_LNK long b_count(char *bit);

#endif
