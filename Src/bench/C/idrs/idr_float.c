/*

    #    #####   #####          ######   #        ####     ##    #######         ####
    #    #    #  #    #         #        #       #    #   #  #      #           #    #
    #    #    #  #    #         ####     #       #    #  #    #     #           #
    #    #    #  #####          #        #       #    #  ######     #    ###    #
    #    #    #  #   #          #        #       #    #  #    #     #    ###    #    #
    #    #####   #    # ####### #        ######   ####   #    #     #    ###     ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_float(IDR *idrs, float *fp)
{
	/* Serialize a long byte */

	CHK_SIZE(idrs, sizeof (float));			/* Long integer coded on four bytes */

	if (idrs->i_op == IDR_ENCODE) {
		memcpy (idrs->i_ptr, fp, sizeof (float));
		idrs->i_ptr += sizeof (float);
	} else {
		memcpy ( fp, idrs->i_ptr, sizeof (float));
		idrs->i_ptr += sizeof (float);
	}
	
	return TRUE;
}

