/*

    #    #####   #####           #    #   ####      #    #####            ####
    #    #    #  #    #          #    #  #    #     #    #    #          #    #
    #    #    #  #    #          #    #  #    #     #    #    #          #
    #    #    #  #####           #    #  #    #     #    #    #   ###    #
    #    #    #  #   #            #  #   #    #     #    #    #   ###    #    #
    #    #####   #    # #######    ##     ####      #    #####    ###     ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_void(IDR *idrs, void *ext)
{
	/* Sometimes, it is convenient to provide a pointer to an IDR serialization
	 * routine doing nothing. This one does just that: it always returns true
	 * and does not modify the IDR buffer.
	 */

	return TRUE;
}

