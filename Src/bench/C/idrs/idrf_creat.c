/*

    #    #####   #####   ######           ####   #####   ######    ##     #####
    #    #    #  #    #  #               #    #  #    #  #        #  #      #
    #    #    #  #    #  #####           #       #    #  #####   #    #     #
    #    #    #  #####   #               #       #####   #       ######     #
    #    #    #  #   #   #               #    #  #   #   #       #    #     #
    #    #####   #    #  #      #######   ####   #    #  ######  #    #     #

	Encapsulation of IDR streams for duplex filtering.

	This provides an easy way to manage a serializing/deserializing filter
	other some communication channel, since one structure holds both the
	input and the output structure.
*/

#include "config.h"
#include "portable.h"
#include "idrf.h"

rt_public int idrf_create(IDRF *idrf, int size)
           		/* IDR filtering pair */
         		/* Size of IDR buffers */
{
	/* Initializes memory for IDR operations. We create memory streams for
	 * input and output. Thus, all the input requests will have the same length,
	 * regardless of their type. The same applies for output request, although
	 * the size may not be the same. Return 0 if ok, -1 for failure.
	 */
	
	char *out_addr;			/* IDR output data buffer */
	char *in_addr;			/* IDR input data buffer */

	/* Create input IDR memory stream (decode mode) */
	if ((char *) 0 == (in_addr = (char *) malloc(size)))
		return -1;

	/* Create output IDR memory stream (encode mode) */
	if ((char *) 0 == (out_addr = (char *) malloc(size))) {
		free(in_addr);
		return -1;
	}

	idrmem_create(&idrf->i_decode, in_addr, size, IDR_DECODE);
	idrmem_create(&idrf->i_encode, out_addr, size, IDR_ENCODE);
	return 0;
}

