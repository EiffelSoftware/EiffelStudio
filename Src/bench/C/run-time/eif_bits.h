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

#ifdef __cplusplus
extern "C" {
#endif

#define LENGTH(b)	(((struct bit *) b)->b_length)
#define ARENA(b)	(((struct bit *) b)->b_value)

#ifndef TRUE
#define TRUE		1		/* The boolean true value */
#endif
#ifndef FALSE
#define FALSE		0		/* The boolean false value */
#endif

/* 
 * Functions declarations
 */
RT_LNK EIF_BOOLEAN b_equal(EIF_REFERENCE a, EIF_REFERENCE b);	/* needed in interp.c */
RT_LNK EIF_REFERENCE b_eout(EIF_REFERENCE bit);					/* Eiffel string for out representation of a bit */
RT_LNK EIF_REFERENCE b_clone(EIF_REFERENCE bit);				/* Clones bit */
RT_LNK void b_copy(EIF_REFERENCE a, EIF_REFERENCE b);			/* Copies bit */
RT_LNK void b_put(EIF_REFERENCE bit, char value, int at);
RT_LNK EIF_BOOLEAN b_item(EIF_REFERENCE bit, long int at);
RT_LNK EIF_REFERENCE b_shift(EIF_REFERENCE bit, long int s);
RT_LNK EIF_REFERENCE b_rotate(EIF_REFERENCE bit, long int s);
RT_LNK EIF_REFERENCE b_and(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_implies(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_or(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_xor(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_not(EIF_REFERENCE a);
RT_LNK EIF_REFERENCE b_out(EIF_REFERENCE bit);
RT_LNK EIF_REFERENCE b_mirror(EIF_REFERENCE a);
RT_LNK long b_count(EIF_REFERENCE bit);

#ifdef __cplusplus
}
#endif


#endif
