/*

    #    #####   #####           #        ####   #    #   ####            ####
    #    #    #  #    #          #       #    #  ##   #  #    #          #    #
    #    #    #  #    #          #       #    #  # #  #  #               #
    #    #    #  #####           #       #    #  #  # #  #  ###   ###    #
    #    #    #  #   #           #       #    #  #   ##  #    #   ###    #    #
    #    #####   #    # #######  ######   ####   #    #   ####    ###     ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

public bool_t idr_long(idrs, lp)
IDR *idrs;
long *lp;
{
	/* Serialize a long byte */

	unsigned long value;		/* Value in network byte order */

	CHK_SIZE(idrs, 4);			/* Long integer coded on four bytes */

	if (idrs->i_op == IDR_ENCODE) {
		value = htonl(*(unsigned long *) lp);
		bcopy(&value, idrs->i_ptr, 4);
		idrs->i_ptr += 4;
	} else {
		bcopy(idrs->i_ptr, &value, 4);
		*lp = (long) ntohl(value);
		idrs->i_ptr += 4;
	}
	
	return TRUE;
}

