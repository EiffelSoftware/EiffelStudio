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


/* Make sure the buffer can hold 'x' bytes, return false if this is not
 * possible. When serializing, this makes sure we'll have enough room for the
 * current type (especially simple types). When deserializing, it helps keeping
 * the consistency (trying to deserialize a longer structure).
 */
#define CHK_SIZE(i, x) { \
	if (((i)->i_ptr + (x)) > ((i)->i_buf + (i)->i_size)) \
		return FALSE; \
	}

/* Helper macro to avoid copy/pasting. */
#define EIF_IDR_SERIALIZER(a_buffer, a_value, a_data_type) \
	if (a_buffer->i_op == IDR_ENCODE) { \
		memcpy (idrs->i_ptr, a_value, sizeof(a_data_type)); \
	} else { \
		memcpy (a_value, idrs->i_ptr, sizeof(a_data_type)); \
	} \
	idrs->i_ptr += sizeof(a_data_type); 

rt_private bool_t idr_int(IDR* idrs, int *val) {
	CHK_SIZE(idrs,sizeof(int));
	EIF_IDR_SERIALIZER(idrs,val,int);
	return TRUE;
}
rt_private bool_t idr_rt_uint_ptr(IDR* idrs, rt_uint_ptr *val) {
	CHK_SIZE(idrs,sizeof(rt_uint_ptr));
	EIF_IDR_SERIALIZER(idrs,val,rt_uint_ptr);
	return TRUE;
}
rt_private bool_t idr_eif_reference(IDR* idrs, EIF_REFERENCE *val) {
	CHK_SIZE(idrs,sizeof(EIF_REFERENCE));
	EIF_IDR_SERIALIZER(idrs,val,EIF_REFERENCE);
	return TRUE;
}
rt_private bool_t idr_unsigned_char(IDR* idrs, unsigned char *val) {
	CHK_SIZE(idrs,sizeof(unsigned char));
	EIF_IDR_SERIALIZER(idrs,val,unsigned char);
	return TRUE;
}
rt_private bool_t idr_size_t(IDR* idrs, size_t *val) {
	CHK_SIZE(idrs,sizeof(size_t));
	EIF_IDR_SERIALIZER(idrs,val,size_t);
	return TRUE;
}

extern bool_t idr_string(IDR *idrs, char **sp, int maxlen);

#ifdef __cplusplus
}
#endif

#endif
