/*

    #    #####   #####            ####    #####  #####      #    #    #   ####
    #    #    #  #    #          #          #    #    #     #    ##   #  #    #
    #    #    #  #    #           ####      #    #    #     #    # #  #  #
    #    #    #  #####                #     #    #####      #    #  # #  #  ###
    #    #    #  #   #           #    #     #    #   #      #    #   ##  #    #
    #    #####   #    # #######   ####      #    #    #     #    #    #   ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_string(IDR *idrs, char **sp, int maxlen)
          				/* The serializing stream */
          				/* Pointer to area where string address is stored */
                    	/* Maximum length, 0 = no limit */
{
	/* Serialize a string. Dynamic allocation for data storage is done when
	 * deserializing if the address of the string is NULL. There is a big
	 * difference with the pending XDR routines, since maxlen may be left to 0
	 * to avoid string length limitations. The serialization will fail if the
	 * buffer limits are reached. If the size given is <0, then the absolute
	 * value gives the maximum string length, and the string will be truncated
	 * if it is longer than that.
	 * Strings are serialized by first emitting the length as an unsigned int,
	 * then the characters from the string itself, with the trailing null byte
	 * omitted.
	 */

	unsigned int len;		/* String length */
	char *string;			/* Allocated string pointer */

	if (idrs->i_op == IDR_ENCODE) {
		string = *sp;
		if (string == (char *) 0){
			return FALSE;
		}
		len = (unsigned int) strlen(string);
		if (maxlen > 0 && (int) len > maxlen)
			return FALSE;

		if (maxlen < 0 && (int) len > -maxlen)
			len = (unsigned int) -maxlen;				/* Truncate string if too long */

		if (!idr_u_int(idrs, &len))		/* Emit string length */
			return FALSE;

		CHK_SIZE(idrs, len);			/* Make sure there is enough room */
		memcpy (idrs->i_ptr, string, len + 1);
	} else {
		if (!idr_u_int(idrs, &len))		/* Get string length */
			return FALSE;

		if (maxlen > 0 && (int) len > maxlen)
			return FALSE;

		if (maxlen < 0 && (int) len > -maxlen)
			return FALSE;

		string = *sp;
		if (string == (char *) 0) {
			string = malloc(len + 1);	/* Don't forget trailing null byte */
			if (string == (char *) 0){
				return FALSE;
			}
			*sp = string;				/* Set up string pointer dynamically */
		}
		memcpy (string, idrs->i_ptr, len + 1);
	}

	
	idrs->i_ptr += len + 1;

	return TRUE;
}

