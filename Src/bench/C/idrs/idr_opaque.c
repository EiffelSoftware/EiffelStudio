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

rt_public bool_t idr_opaque(IDR *idrs, char *p, int len)
          		/* The serializing stream */
        		/* Start of opaque data */
        		/* Length of opaque data */
{
	/* Opaque data are not machine portable, unless they represent something
	 * which has been made portable, like IDR data or known machine-independant
	 * data like network byte order addresses. No dynamic allocation for data
	 * storage is made here.
	 */

	CHK_SIZE(idrs, len);

	if (idrs->i_op == IDR_ENCODE)
		memcpy (idrs->i_ptr, p, len);
	else
		memcpy (p, idrs->i_ptr, len);
	
	idrs->i_ptr += len;

	return TRUE;
}

