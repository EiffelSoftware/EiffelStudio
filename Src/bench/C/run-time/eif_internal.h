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

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_eiffel.h"

RT_LNK long ei_dtype (EIF_REFERENCE object);
RT_LNK long ei_count_field (EIF_REFERENCE object);
RT_LNK char *ei_field (long i, EIF_REFERENCE object);
RT_LNK char *ei_field_name (long i, EIF_REFERENCE object);
RT_LNK long ei_field_type(long i, EIF_REFERENCE object);
RT_LNK char ei_char_field(long i, EIF_REFERENCE object);
RT_LNK char ei_bool_field(long i, EIF_REFERENCE object);
RT_LNK long ei_int_field(long i, EIF_REFERENCE object);
RT_LNK float ei_float_field(long i, EIF_REFERENCE object);
RT_LNK EIF_POINTER ei_ptr_field(long i, EIF_REFERENCE object);
RT_LNK double ei_double_field(long i, EIF_REFERENCE object);
RT_LNK char *ei_exp_type(long i, EIF_REFERENCE object);
RT_LNK long ei_bit_size(long i, EIF_REFERENCE object);
RT_LNK long ei_size(EIF_REFERENCE object);
RT_LNK char ei_special(EIF_REFERENCE object);
RT_LNK long ei_offset(long i, EIF_REFERENCE object);
RT_LNK void ei_set_reference_field(EIF_INTEGER i, EIF_POINTER object, EIF_POINTER value);
RT_LNK void ei_set_double_field(EIF_INTEGER i, EIF_POINTER object, EIF_DOUBLE value);
RT_LNK void ei_set_char_field(EIF_INTEGER i, EIF_POINTER object, EIF_CHARACTER value);
RT_LNK void ei_set_boolean_field(EIF_INTEGER i, EIF_POINTER object, EIF_BOOLEAN value);
RT_LNK void ei_set_integer_field(EIF_INTEGER i, EIF_POINTER object, EIF_INTEGER value);
RT_LNK void ei_set_float_field(EIF_INTEGER i, EIF_POINTER object, EIF_REAL value);
RT_LNK void ei_set_pointer_field(EIF_INTEGER i, EIF_POINTER object, EIF_POINTER value);

#ifdef __cplusplus
}
#endif

#endif

