/*

    #    #####   #####            ####      #    ######  ######           ####
    #    #    #  #    #          #          #        #   #               #    #
    #    #    #  #    #           ####      #       #    #####           #
    #    #    #  #####                #     #      #     #        ###    #
    #    #    #  #   #           #    #     #     #      #        ###    #    #
    #    #####   #    # #######   ####      #    ######  ######   ###     ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public int idr_size(idrs, lp, maxlength)
IDR *idrs;				/* The serializing stream */
int *lp;				/* Where actual size of the array is stored */
int maxlength;			/* Maximum length (hint to know size of lp) */
{
	/* This routine retrieves or stores the size pointed to by lp, knowing the
	 * maximum possible size. As an optimization, if the maximum size can be
	 * held on only 16 bits, then lp is supposed to be a pointer to a short.
	 * If the value fits into 8 bits, then lp is a pointer to a char. As a
	 * special case, a maximum length of 0 means the pointer is an integer.
	 * This function returns the size read, or -1 in case of errors.
	 */

	int size;			/* Size written (serialization) or read */

	if (maxlength < 256) {
		if (!idr_u_char(idrs, (unsigned char *) lp))
			return -1;
		size = *(unsigned char *) lp;		/* Get the array size */
		if (size > maxlength)
			return -1;
	} else if (maxlength < 65536) {
		if (!idr_u_short(idrs, (unsigned short *) lp))
			return -1;
		size = *(unsigned short *) lp;		/* Get the array size */
		if (size > maxlength)
			return -1;
	} else {
		if (!idr_int(idrs, lp))
			return -1;
		size = *lp;							/* Get the array size */
		if (size > maxlength)
			return -1;
	}

	return size;	/* Note that 0 is considered a valid size */
}

