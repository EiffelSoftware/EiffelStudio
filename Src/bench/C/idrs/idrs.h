/*

    #    #####   #####    ####           #    #
    #    #    #  #    #  #               #    #
    #    #    #  #    #   ####           ######
    #    #    #  #####        #   ###    #    #
    #    #    #  #   #   #    #   ###    #    #
    #    #####   #    #   ####    ###    #    #

	Internal data representation.
	Used by EiffelStudio classic debugger and by storable.

*/

#ifndef _idrs_h_
#define _idrs_h_

#include "eif_config.h"
#include "eif_portable.h"
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

#define IDR_ENCODE	0		/* Serialization */
#define IDR_DECODE	1		/* Deserialization */

/* Constants definitions for IDR routines */
#ifndef bool_t
#define bool_t	int
#endif

#ifndef FALSE
#define FALSE	0
#endif

#ifndef TRUE
#define TRUE	1
#endif

typedef struct idr {
	int i_op;			/* Type of operation */
	size_t i_size;			/* Size of buffer */
	char *i_buf;		/* Buffer where serialized data are stored */
	char *i_ptr;		/* Pointer into the serialized data */
} IDR;

typedef struct idrs {	/* An encoding/decoding IDR filter */
	IDR i_encode;		/* Stream used for encoding (serialization) */
	IDR i_decode;		/* Stream used for decoding (deserialization) */
} IDRF;

/*
 * User informations on the IDR streams.
 */

#define idrs_size(i)	((i)->i_size)
#define idrs_buf(i)		((i)->i_buf)
#define idrs_op(i)		((i)->i_op)

/*
 * IDR entry points
 */

extern int idrf_create(IDRF *idrf, size_t size);
extern void idrf_destroy(IDRF *idrf);
extern void idrf_reset_pos(IDRF *idrf);
extern bool_t idr_setpos(IDR *idrs, size_t pos);

#ifdef __cplusplus
}
#endif

#endif
