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
extern EIF_BOOLEAN b_equal(char *a, char *b);	/* needed in interp.c */
extern char *b_eout(char *bit);					/* Eiffel string for out representation of a bit */
extern char *b_clone(char *bit);				/* Clones bit */
extern void b_copy(char *a, char *b);			/* Copies bit */
extern char *bmalloc(long int size);			/* Bit object creation */
extern void b_put(char *bit, char value, int at);
extern EIF_BOOLEAN b_item(char *bit, long int at);
extern char *b_shift(char *bit, long int s);
extern char *b_rotate(char *bit, long int s);
extern char *b_and(char *a, char *b);
extern char *b_implies(char *a, char *b);
extern char *b_or(char *a, char *b);
extern char *b_xor(char *a, char *b);
extern char *b_not(char *a);
extern char *b_out(char *bit);
extern char *b_mirror(char *a);
extern int bit_dtype;

#ifdef __cplusplus
}
#endif

extern long b_count(char *bit);

#endif
