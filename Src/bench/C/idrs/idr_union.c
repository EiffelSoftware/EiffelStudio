/*

    #    #####   #####           #    #  #    #     #     ####   #    #
    #    #    #  #    #          #    #  ##   #     #    #    #  ##   #
    #    #    #  #    #          #    #  # #  #     #    #    #  # #  #
    #    #    #  #####           #    #  #  # #     #    #    #  #  # #   ###
    #    #    #  #   #           #    #  #   ##     #    #    #  #   ##   ###
    #    #####   #    # #######   ####   #    #     #     ####   #    #   ###

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_union(IDR *idrs, int *type, char *unp, struct idr_discrim *arms, bool_t (*dfltarm) (IDR *, void *))
          					/* The serializing stream */
          					/* Union discriminent, serialized in the process */
          					/* Pointer to the start of the union */
                         	/* Null terminated array to deal with union arms */
                    		/* Default coding for arm (may be NULL) */
{
	/* Serialization of an union, based on the contents of the union's type
	 * which is an integer. Depending on the value of this disciminent, the
	 * correct basic serialization routine is called to serialize the right
	 * component. If the type is not found in the arms array, then the default
	 * arm routine is called if not nulled (otherwise this makes the routine
	 * fail immediately).
	 */

	if (!idr_int(idrs, type))
		return FALSE;

	return idr_poly(idrs, *type, unp, arms, dfltarm);
}

