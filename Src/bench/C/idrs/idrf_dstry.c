/*

    #    #####   #####   ######          #####    ####    #####  #####    #   #
    #    #    #  #    #  #               #    #  #          #    #    #    # #
    #    #    #  #    #  #####           #    #   ####      #    #    #     #
    #    #    #  #####   #               #    #       #     #    #####      #
    #    #    #  #   #   #               #    #  #    #     #    #   #      #
    #    #####   #    #  #      #######  #####    ####      #    #    #     #

	Encapsulation of IDR streams for duplex filtering.

	This provides an easy way to manage a serializing/deserializing filter
	other some communication channel, since one structure holds both the
	input and the output structure.
*/

#include "config.h"
#include "portable.h"
#include "idrf.h"

rt_public void idrf_destroy(idrf)
IDRF *idrf;
{
	/* Release the memory used by the IDR streams */

	idrmem_destroy(&idrf->i_encode);
	idrmem_destroy(&idrf->i_decode);
}

