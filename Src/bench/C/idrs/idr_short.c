/*

    #    #####   #####            ####   #    #   ####   #####    #####
    #    #    #  #    #          #       #    #  #    #  #    #     #
    #    #    #  #    #           ####   ######  #    #  #    #     #
    #    #    #  #####                #  #    #  #    #  #####      #     ###
    #    #    #  #   #           #    #  #    #  #    #  #   #      #     ###
:   #    #####   #    # #######   ####   #    #   ####   #    #     #     ###

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_short(idrs, sp)
IDR *idrs;
short *sp;
{
	/* Serialize a short byte */

	unsigned short value;		/* Value in network byte order */

	CHK_SIZE(idrs, 2);			/* Short integer coded on two bytes */

	if (idrs->i_op == IDR_ENCODE) {
		value = htons(*(unsigned short *) sp);
		bcopy(&value, idrs->i_ptr, 2);
		idrs->i_ptr += 2;
	} else {
		bcopy(idrs->i_ptr, &value, 2);
		*sp = (short) ntohs(value);
		idrs->i_ptr += 2;
	}
	
	return TRUE;
}

