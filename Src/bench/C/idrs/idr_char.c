/*

    #    #####   #####            ####   #    #    ##    #####            ####
    #    #    #  #    #          #    #  #    #   #  #   #    #          #    #
    #    #    #  #    #          #       ######  #    #  #    #          #
    #    #    #  #####           #       #    #  ######  #####    ###    #
    #    #    #  #   #           #    #  #    #  #    #  #   #    ###    #    #
    #    #####   #    # #######   ####   #    #  #    #  #    #   ###     ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_char(idrs, cp)
IDR *idrs;
char *cp;
{
	/* Serialize a single byte */

	CHK_SIZE(idrs, 1);			/* Single byte coded on one byte */

	if (idrs->i_op == IDR_ENCODE)
		*(idrs->i_ptr++) = *cp;
	else
		*cp = *(idrs->i_ptr++);
	
	return TRUE;
}

