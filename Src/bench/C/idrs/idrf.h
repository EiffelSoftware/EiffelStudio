/*

    #    #####   #####   ######          #    #
    #    #    #  #    #  #               #    #
    #    #    #  #    #  #####           ######
    #    #    #  #####   #        ###    #    #
    #    #    #  #   #   #        ###    #    #
    #    #####   #    #  #        ###    #    #

	IDR duplex filter.
*/

#ifndef _idrf_h_
#define _idrf_h_

#include "idrs.h"

typedef struct idrs {	/* An encoding/decoding IDR filter */
	IDR i_encode;		/* Stream used for encoding (serialization) */
	IDR i_decode;		/* Stream used for decoding (deserialization) */
} IDRF;

extern int idrf_create();		/* Creation of the two IDR memory streams */
extern void idrf_destroy();		/* Destruction of the two IDR memory streams */
extern void idrf_pos();			/* Reposition both streams to the beginning */

#endif

