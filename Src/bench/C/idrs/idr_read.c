/*

    #    #####   #####           #####   ######    ##    #####            ####
    #    #    #  #    #          #    #  #        #  #   #    #          #    #
    #    #    #  #    #          #    #  #####   #    #  #    #          #
    #    #    #  #####           #####   #       ######  #    #   ###    #
    #    #    #  #   #           #   #   #       #    #  #    #   ###    #    #
    #    #####   #    # #######  #    #  ######  #    #  #####    ###     ####

	Internal data representation.

	All those calls exactly mimic their xdr counterpart as far as the
	interface goes. Of course, the internal coding may differ :-)

	NOTA BENE: By definition, this is NOT portable. However, it should work
	correctly when short is two bytes, int is either a short or a long and
	long is four bytes. Moreover, there must be no internal difference between
	a signed and an unsigned entity (for the "container").
*/

#include "idr.h"

rt_public bool_t idr_read(IDR *idrs, int fd, char *bp, bool_t (*idr_bp) (IDR *, void *))
          			/* The deserializing stream */
       				/* File descriptor we want to read */
         			/* Pointer to structure which must be filled with data */
                   	/* The IDR routine called to deserialize into bp */
{
	/* Read bytes from the file and deserialize them into the structure pointed
	 * to by bp. The number of bytes read is the size of the incoming buffer
	 * of the IDR stream. Note that if the stream is not of type IDR_DECODE,
	 * the routine does not do anything and returns false.
	 */

	if (idrs->i_op != IDR_DECODE)	/* Not a deserializing stream */
		return FALSE;

	if (-1 == read(fd, idrs->i_buf, idrs->i_size))
		return FALSE;
	
	idrs->i_ptr = idrs->i_buf;	/* Reposition stream, ready to deserialize */

	return (idr_bp)(idrs, bp);
}

