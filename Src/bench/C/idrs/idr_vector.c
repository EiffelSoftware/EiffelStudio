/*

    #    #####   #####           #    #  ######   ####    #####   ####   #####
    #    #    #  #    #          #    #  #       #    #     #    #    #  #    #
    #    #    #  #    #          #    #  #####   #          #    #    #  #    #
    #    #    #  #####           #    #  #       #          #    #    #  #####
    #    #    #  #   #            #  #   #       #    #     #    #    #  #   #
    #    #####   #    # #######    ##    ######   ####      #     ####   #    #

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_vector(IDR *idrs, char *array, int size, int elemsize, bool_t (*idr_elem) (IDR *, void *))
          				/* The serializing stream */
            			/* Pointer on the base of the array */
         				/* Fixed size of the array */
             			/* Size of each item */
                     	/* How to encode each item */
{
	/* Encode a fixed size array. The parameter array must point (when decoding)
	 * to a preallocated array, if not a statically allocated one, because IDR
	 * won't do any dynamic allocation. The routine which codes each items must
	 * be a simple one, i.e. one which takes two arguments: an IDR stream and
	 * a pointer to where data is located, viz. idr_elem(idrs, ptr).
	 */

	int i;

	CHK_SIZE(idrs, size * elemsize);

	for (i = 0; i < size; i++) {
		if (!(idr_elem)(idrs, array))
			return FALSE;
		array += elemsize;
	}

	return TRUE;
}

