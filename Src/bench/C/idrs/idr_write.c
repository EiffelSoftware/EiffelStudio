/*

    #    #####   #####           #    #  #####      #     #####  ######
    #    #    #  #    #          #    #  #    #     #       #    #
    #    #    #  #    #          #    #  #    #     #       #    #####
    #    #    #  #####           # ## #  #####      #       #    #        ###
    #    #    #  #   #           ##  ##  #   #      #       #    #        ###
    #    #####   #    # #######  #    #  #    #     #       #    ######   ###

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_write(IDR *idrs, int fd, char *bp, bool_t (*idr_bp) (IDR *, void *))
          			/* The serializing stream */
       				/* File descriptor we want to write to */
         			/* Pointer to structure which contains the data */
                   	/* The IDR routine called to serialize contents in bp */
{
	/* Write serialized bytes from the structure pointed to by bp into the file.
	 * The number of bytes writtem is the size of the incoming buffer of the
	 * IDR stream. Note that if the stream is not of type IDR_ENCODE, the
	 * routine does not do anything and returns false.
	 */

	if (idrs->i_op != IDR_ENCODE)	/* Not a serializing stream */
		return FALSE;

	idrs->i_ptr = idrs->i_buf;		/* Reposition stream, ready to serialize */
	if (!(idr_bp)(idrs, bp))		/* Cannot serialize data */
		return FALSE;

	if (-1 == write(fd, idrs->i_buf, idrs->i_size))
		return FALSE;
	
	return TRUE;
}

