/*

    #    #####   #####             ##    #####   #####     ##     #   #
    #    #    #  #    #           #  #   #    #  #    #   #  #     # #
    #    #    #  #    #          #    #  #    #  #    #  #    #     #
    #    #    #  #####           ######  #####   #####   ######     #     ###
    #    #    #  #   #           #    #  #   #   #   #   #    #     #     ###
    #    #####   #    # #######  #    #  #    #  #    #  #    #     #     ###

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_array(IDR *idrs, char **ap, int *lp, int maxlength, int elemsize, bool_t (*idr_elem) (IDR *, void *))
          				/* The serializing stream */
          				/* Where address of arena is stored */
        				/* Where actual size of the array is stored */
              			/* Maximum length (hint to know size of lp) */
             			/* Size of each item */
                     	/* How to encode each item */
{
	/* Encode a dynamically sized array. The parameter ap must point to a
	 * variable of type 'char *' holding the address of the array's arena.
	 * When deserializing, if this address is a null pointer, the array will
	 * be dynamically allocated. It will be up to the client to free it.
	 * As usual, idr_elem(idrs, ptr) is called to (de)serialize each item.
	 * Note that the maxlength parameters is NOT used, but has been kept only
	 * to have the same interface as XDR.
	 * NOTA BENE: if the maxlength specified holds on 16 bits, then the length
	 * is supposed to be held in a short. If it can be held on 8 bits, then it
	 * is put in a char.
	 */

	int size;			/* Size of array */

	if (-1 == (size = idr_size(idrs, lp, maxlength)))
		return FALSE;

	return idr_stack(idrs, ap, size, elemsize, idr_elem);
}

