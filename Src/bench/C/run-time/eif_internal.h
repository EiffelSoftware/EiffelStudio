/*

 #    #    #   #####  ######  #####   #    #    ##    #               #    #
 #    ##   #     #    #       #    #  ##   #   #  #   #               #    #
 #    # #  #     #    #####   #    #  # #  #  #    #  #               ######
 #    #  # #     #    #       #####   #  # #  ######  #        ###    #    #
 #    #   ##     #    #       #   #   #   ##  #    #  #        ###    #    #
 #    #    #     #    ######  #    #  #    #  #    #  ######   ###    #    #

	Routines to implement class INTERNAL
*/

#ifndef _eif_internal_h_
#define _eif_internal_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Returns the number of logical fields in `object'. */
#define ei_count_field_of_type(type_id)		(System(Deif_bid(type_id)).cn_nbattr)

/* Returns name of the i_th logical field of `object'. */
#define ei_field_name_of_type(i,type_id)	(System(Deif_bid(type_id)).cn_names[i])

RT_LNK char *ei_field (long i, EIF_REFERENCE object);
RT_LNK long ei_field_type_of_type(long i, EIF_INTEGER type_id);
RT_LNK char *ei_exp_type(long i, EIF_REFERENCE object);
RT_LNK long ei_bit_size(long i, EIF_REFERENCE object);
RT_LNK long ei_size(EIF_REFERENCE object);
RT_LNK char ei_special(EIF_REFERENCE object);
RT_LNK void *ei_oref(long, EIF_REFERENCE);

#define	ei_offset(i,object)			(EIF_INTEGER) ((EIF_REFERENCE) ei_oref(i, (EIF_REFERENCE) (object)) - (EIF_REFERENCE) (object))

/* Attribute access */
#define ei_char_field(i,object)		*(EIF_CHARACTER *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_bool_field(i,object)		*(EIF_BOOLEAN *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_8_field(i,object)	*(EIF_INTEGER_8 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_16_field(i,object)	*(EIF_INTEGER_16 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_field(i,object)		*(EIF_INTEGER_32 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_64_field(i,object)	*(EIF_INTEGER_64 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_float_field(i,object)	*(EIF_REAL *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_double_field(i,object)	*(EIF_DOUBLE *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_ptr_field(i,object)		*(EIF_POINTER *) ei_oref(i,(EIF_REFERENCE) (object))

/* Attribute setting */
#define ei_set_reference_field(i,object,value)	RTAR(value,object); *(EIF_REFERENCE *) ei_oref(i,object) = (EIF_REFERENCE) (value)
#define ei_set_char_field(i,object,value)		*(EIF_CHARACTER *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_CHARACTER) (value)
#define ei_set_boolean_field(i,object,value)	*(EIF_BOOLEAN *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_BOOLEAN) (value)
#define ei_set_integer_8_field(i,object,value)	*(EIF_INTEGER_8 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_8) (value)
#define ei_set_integer_16_field(i,object,value)	*(EIF_INTEGER_16 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_16) (value)
#define ei_set_integer_field(i,object,value)	*(EIF_INTEGER_32 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_32) (value)
#define ei_set_integer_64_field(i,object,value)	*(EIF_INTEGER_64 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_64) (value)
#define ei_set_float_field(i,object,value)		*(EIF_REAL *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_REAL) (value)
#define ei_set_double_field(i,object,value)		*(EIF_DOUBLE *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_DOUBLE) (value)
#define ei_set_pointer_field(i,object,value)	*(EIF_POINTER *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_POINTER) (value)

#ifdef __cplusplus
}
#endif

#endif

