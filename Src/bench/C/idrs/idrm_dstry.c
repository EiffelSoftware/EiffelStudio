/*

    #    #####   #####   #    #          #####    ####    #####  #####    #   #
    #    #    #  #    #  ##  ##          #    #  #          #    #    #    # #
    #    #    #  #    #  # ## #          #    #   ####      #    #    #     #
    #    #    #  #####   #    #          #    #       #     #    #####      #
    #    #    #  #   #   #    #          #    #  #    #     #    #   #      #
    #    #####   #    #  #    # #######  #####    ####      #    #    #     #

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public void idrmem_destroy(IDR *idrs)
{
	/* Release the memory used by the IDR stream */

	idrs->i_size = 0;
	if (idrs->i_buf != (char *) 0) {
		free(idrs->i_buf);
		idrs->i_buf = idrs->i_ptr = (char *) 0;
	}
}

