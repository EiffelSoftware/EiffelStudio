/*

    #    #####   #####   ######          #####    ####    ####            ####
    #    #    #  #    #  #               #    #  #    #  #               #    #
    #    #    #  #    #  #####           #    #  #    #   ####           #
    #    #    #  #####   #               #####   #    #       #   ###    #
    #    #    #  #   #   #               #       #    #  #    #   ###    #    #
    #    #####   #    #  #      #######  #        ####    ####    ###     ####

	Encapsulation of IDR streams for duplex filtering.

	This provides an easy way to manage a serializing/deserializing filter
	other some communication channel, since one structure holds both the
	input and the output structure.
*/

#include "config.h"
#include "portable.h"
#include "idrf.h"

rt_public void idrf_pos(IDRF *idrf)
{
	/* This routine should be called before any IDR operation,
	 * in order to reposition the memory streams.
	 */
	
	(void) idr_setpos(&idrf->i_encode, 0);
	(void) idr_setpos(&idrf->i_decode, 0);
}

