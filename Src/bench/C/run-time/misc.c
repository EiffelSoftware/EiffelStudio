/*

 #    #     #     ####    ####            ####
 ##  ##     #    #       #    #          #    #
 # ## #     #     ####   #               #
 #    #     #         #  #        ###    #
 #    #     #    #    #  #    #   ###    #    #
 #    #     #     ####    ####    ###     ####

	Miscellenaous Eiffel externals

*/

#include "portable.h"
#include "misc.h"
#include "malloc.h"
#include "macros.h"

/*
 * Various casts.
 */

public char chconv(i)
long i;
{
	return (char) i;	/* (long) -> (char) */
}

public long chcode(c)
char c;
{
	return (long) c;	/* (char) -> (long) */
}

public float conv_ir(v)
long v;
{
	return (float) v;	/* (long) -> (float) */
}

public long conv_ri(v)
float v;
{
	return (long) v;	/* (float) -> (long) */
}

public float conv_dr (d)
double d;
{
	return (float) d;	/* (double) -> (float) */
}

public long bointdiv(n1, n2)
long n1, n2;
{
	/* Return the greatest integer less or equal to the
	 * integer division of `n1' by `n2'
	 */

	return ((n1 >= 0) ^ (n2 > 0))  ? (n1 % n2 ? n1 / n2 - 1: n1 / n2) : n1 / n2;
}

public long upintdiv(n1,n2)
long n1, n2;
{
	/* Return the smallest integer greater or equal to the
	 * integer division of `n1' by `n2'
	 */

    return ((n1 >= 0) ^ (n2 > 0)) ? n1 / n2: ((n1 % n2) ? n1 / n2 + 1: n1 / n2);
}

public char *arycpy(area, i, j, k)
char *area;
long i, j, k;
{
	/* Reallocation of memory for an array's `area' for new count `i', keeping
	 * the old content.(starts at `j' and is `k' long).
	 */

	union overhead *zone;
	char *new_area, *ref;
	long elem_size;			/* Size of each item within area */
	char *(*init)();		/* Initialization routine for expanded objects */
	int dtype;				/* Dynamic type of the first expanded object */
	int n;					/* Counter for initialization of expanded */

	zone = HEADER(area);
	ref = area + (zone->ov_size & B_SIZE) - LNGPAD(2);
	ref += sizeof(long);
	elem_size = *(long *) ref;			/* Extract the element size */

	new_area = sprealloc(area, i);		/* Reallocation of special object */

	/* Move old contents to the right position and fill in empty parts with
	 * zeros.
	 */

	bcopy(new_area, new_area + j * elem_size, k * elem_size);
	bzero(new_area, j * elem_size);		/* Fill empty parts of area with 0 */
	bzero(new_area + (j + k) * elem_size, (i - j - k) * elem_size);

	if (!(HEADER(new_area)->ov_flags & EO_COMP))
		return new_area;				/* No expanded objects */

	/* If there are some expanded objects, then we must initialize them by
	 * calling the initialization routine (which will set up intra references).
	 * The dynamic type of all the expanded object is the same, so we only
	 * compute the one of the first element. Note that the Dtype() macro needs
	 * a pointer to the object and not to the zone, hence the shifting by
	 * OVERHEAD bytes in the computation of 'dtype'--RAM.
	 */

	ref = (new_area + j * elem_size) + OVERHEAD;	/* Needed for stupid gcc */
	dtype = Dtype(ref);					/* Gcc won't let me expand that!! */
	init = Create(dtype);

#ifdef MAY_PANIC
	if ((char *(*)()) 0 == init)		/* There MUST be a routine */
		panic("init routine lost");
#endif
	
	/* Initialize expanded objects from 0 to (j - 1) */
	for (
		n = 0, ref = new_area + OVERHEAD;
		n < j;
		n++, ref += elem_size
	) {
		zone = HEADER(ref);
		zone->ov_size = ref - new_area;		/* For GC: offset within area */
		zone->ov_flags = dtype;				/* Expanded type */
		(init)(ref);						/* Call initialization routine */
	}

	/* Update offsets for k objects starting at j */
	for (
		n = j + k - 1, ref = new_area + (n * elem_size);
		n >= j;
		n--, ref -= elem_size
	)
		((union overhead *) ref)->ov_size = ref - new_area + OVERHEAD;
	
	/* Intialize remaining objects from (j + k) to (i - 1) */
	for (
		n = j + k, ref = new_area + (n * elem_size) + OVERHEAD;
		n < i;
		n++, ref += elem_size
	) {
		zone = HEADER(ref);
		zone->ov_size = ref - new_area;		/* For GC: offset within area */
		zone->ov_flags = dtype;				/* Expanded type */
		(init)(ref);						/* Call initialization routine */
	}

	return new_area;
}

