/*

    #    #####   #####           #####    ####   #        #   #           ####
    #    #    #  #    #          #    #  #    #  #         # #           #    #
    #    #    #  #    #          #    #  #    #  #          #            #
    #    #    #  #####           #####   #    #  #          #     ###    #
    #    #    #  #   #           #       #    #  #          #     ###    #    #
    #    #####   #    # #######  #        ####   ######     #     ###     ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_poly(IDR *idrs, int type, char *unp, struct idr_discrim *arms, bool_t (*dfltarm) (IDR *, void *))
          					/* The serializing stream */
         					/* Union discriminent, externally provided */
          					/* Pointer to the start of the union */
                         	/* Null terminated array to deal with union arms */
                    		/* Default coding for arm (may be NULL) */
{
	/* This is mainly the same as idr_union, but is used when the type of the
	 * polymorphic object held in the union is externally provided (perhaps it
	 * was serialized before, for instance).
	 * The localization of the right IDR function is done via a linear lookup
	 * into the arms array, which must end with a NULL procedure associated
	 * to a __dontcare__ tag. If the function associated with a specific type
	 * value is a NULL pointer, then an error occurs.
	 */

	bool_t (*idr_fn)(IDR *, void *);		/* Pointer to basic IDR routine from arms array */
	int value;				/* Value of currently inspected arm */

	for (/* empty */; (value = arms->id_value) != __dontcare__; arms++) {
		if (value == type) {		/* We found the right discriminent */
			idr_fn = arms->id_fn;	/* Basic IDR function for this arm */
			if (idr_fn == 0)
				return FALSE;
			return (idr_fn)(idrs, unp);
		}
	}

	/* We did not find the right function to apply for this type of union, so
	 * apply the default arm routine if one was supplied, otherwise it is a
	 * failure.
	 */

	if (dfltarm == 0)
		return FALSE;
	
	return (dfltarm)(idrs, unp);
}

