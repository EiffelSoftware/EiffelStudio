/*

    #    #####   #####            ####    #####    ##     ####   #    #
    #    #    #  #    #          #          #     #  #   #    #  #   #
    #    #    #  #    #           ####      #    #    #  #       ####
    #    #    #  #####                #     #    ######  #       #  #     ###
    #    #    #  #   #           #    #     #    #    #  #    #  #   #    ###
    #    #####   #    # #######   ####      #    #    #   ####   #    #   ###

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_stack(IDR *idrs, char **ap, int size, int elemsize, bool_t (*idr_elem) (IDR *, void *))
          				/* The serializing stream */
          				/* Where address of arena is stored */
         				/* Number of items in the fixed stack */
             			/* Size of each item */
                     	/* How to encode each item */
{
	/* Encode a dynamically sized stack. The parameter ap must point to a
	 * variable of type 'char *' holding the address of the array's arena.
	 * When deserializing, if this address is a null pointer, the array will
	 * be dynamically allocated. It will be up to the client to free it.
	 * As usual, idr_elem(idrs, ptr) is called to (de)serialize each item.
	 * NOTA BENE: There is no xdr counterpart for this routine. The routine is
	 * the same as idr_array() excepted that no static storage is asssumed when
	 * deserializing, that is to say the size is provided externally.
	 */

	int i;				/* Index to iterate through array */
	char *ptr;			/* Pointer in the arena */

	CHK_SIZE(idrs, size * elemsize);	/* And make sure we have enough room */

	/* If the array pointer is null and we are deserializing, then allocate
	 * the arena dynamically.
	 */

	ptr = *ap;
	if (ptr == (char *) 0) {
		if (idrs->i_op == IDR_ENCODE)
			return FALSE;
		ptr = malloc(size * elemsize);
		if (ptr == (char *) 0)
			return FALSE;
		*ap = ptr;
	}

	for (i = 0; i < size; i++) {
		if (!(idr_elem)(idrs, ptr))
			return FALSE;
		ptr += elemsize;
	}

	return TRUE;
}

