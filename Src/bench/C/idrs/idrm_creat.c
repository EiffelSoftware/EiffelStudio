/*

    #    #####   #####   #    #           ####   #####   ######    ##     #####
    #    #    #  #    #  ##  ##          #    #  #    #  #        #  #      #
    #    #    #  #    #  # ## #          #       #    #  #####   #    #     #
    #    #    #  #####   #    #          #       #####   #       ######     #
    #    #    #  #   #   #    #          #    #  #   #   #       #    #     #
    #    #####   #    #  #    # #######   ####   #    #  ######  #    #     #

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public void idrmem_create(idrs, addr, len, i_op)
IDR *idrs;			/* The IDR structure managing the stream */
char *addr;			/* Address of the serializing buffer */
int len;			/* Length of the serializing buffer */
int i_op;			/* Operation wanted */
{
	/* Initialize a memory stream, where the (de)serialization is done in the
	 * provided buffer pointed to by addr.
	 */

	idrs->i_op = i_op;
	idrs->i_size = len;
	idrs->i_buf = addr;
	idrs->i_ptr = addr;
}

