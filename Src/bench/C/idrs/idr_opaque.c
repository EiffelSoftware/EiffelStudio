/*

    #    #####   #####            ####   #####     ##     ####   #    #  ######
    #    #    #  #    #          #    #  #    #   #  #   #    #  #    #  #
    #    #    #  #    #          #    #  #    #  #    #  #    #  #    #  #####
    #    #    #  #####           #    #  #####   ######  #  # #  #    #  #
    #    #    #  #   #           #    #  #       #    #  #   #   #    #  #
    #    #####   #    # #######   ####   #       #    #   ### #   ####   ######

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

public bool_t idr_opaque(idrs, p, len)
IDR *idrs;		/* The serializing stream */
char *p;		/* Start of opaque data */
int len;		/* Length of opaque data */
{
	/* Opaque data are not machine portable, unless they represent something
	 * which has been made portable, like IDR data or known machine-independant
	 * data like network byte order addresses. No dynamic allocation for data
	 * storage is made here.
	 */

	CHK_SIZE(idrs, len);

	if (idrs->i_op == IDR_ENCODE)
		bcopy(p, idrs->i_ptr, len);
	else
		bcopy(idrs->i_ptr, p, len);
	
	idrs->i_ptr += len;

	return TRUE;
}

