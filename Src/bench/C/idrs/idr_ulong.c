/*

    #    #####   #####           #    #  #        ####   #    #   ####
    #    #    #  #    #          #    #  #       #    #  ##   #  #    #
    #    #    #  #    #          #    #  #       #    #  # #  #  #
    #    #    #  #####           #    #  #       #    #  #  # #  #  ###   ###
    #    #    #  #   #           #    #  #       #    #  #   ##  #    #   ###
    #    #####   #    # #######   ####   ######   ####   #    #   ####    ###

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"
#include "eif_size.h"

#ifdef EIF_WIN32
#include "networku.h"
#endif

rt_public bool_t idr_u_long(IDR *idrs, long unsigned int *lp)
{
	/* Serialize a long byte */

	uint32 value;		/* Value in network byte order */
	uint32 size;
	char csize;

	size = sizeof(long);
	csize = (char) size;

	if (!idr_char(idrs, &csize))	/*record the size of the long */
		return FALSE;
	size = (uint32) csize;

	CHK_SIZE(idrs, size);			/* Long integer coded on four or eight bytes */

	if (idrs->i_op == IDR_ENCODE) {
#if LNGSIZ == 4
					/*encode for long = 4 bytes */
			value = htonl((uint32)(*lp));
			bcopy(&value, idrs->i_ptr, size);
			idrs->i_ptr += size;
#else
							/*encode for long = 8bytes */
			uint32 upper, lower;
			unsigned long temp;
		
			temp = *lp;			/*split long into upper and */
							/*lower 4 bytes */
			lower = (uint32) (temp & 0x00000000ffffffff);
			upper = (uint32) ((temp >> 32) & 0x00000000ffffffff);
			value = htonl((uint32)(lower));
			bcopy(&value, idrs->i_ptr, 4);
			idrs->i_ptr += 4;

			value = htonl((uint32)(upper));
			bcopy(&value, idrs->i_ptr, 4);
			idrs->i_ptr += 4;
#endif
	} else {
		if (size == 4) {				/* decode a 4 byte long */
			bcopy(idrs->i_ptr, &value, size);
			*lp = (unsigned long) ntohl(value);
			idrs->i_ptr += size;
		}
		else {						/*decode an 8 byte long */
			unsigned long lower;
#if LNGSIZ == 4
#else
			unsigned long upper;
#endif

			bcopy(idrs->i_ptr, &value, 4);
			lower = (unsigned long) ntohl(value);
			idrs->i_ptr += 4;
			bcopy(idrs->i_ptr, &value, 4);
			idrs->i_ptr += 4;
#if LNGSIZ == 4
						/*if the data has come from a 8 byte */
			*lp = lower;		/* long machine and we are only a 4 byte*/
						/*long machine only take the lower 4 bytes*/
						/* This will cause lost of data but l am */
						/* assuming we do not send any longs between*/
						/* 64 bit to 32 bit that are larger than 2^32 */
#else
			upper = (unsigned long) ntohl(value);
						/* rejoin the upper and lower parts */ 

			*lp = (lower & 0x00000000ffffffff) | (upper << 32);
#endif
		}
	}
	
	return TRUE;
}

