/*
	description: "Declarations for `built_in` externals."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2020, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.

			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_built_in_h
#define _eif_built_in_h
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_eiffel.h"
#include "eif_misc.h"
#include "eif_helpers.h"
#include "eif_argv.h"
#include "eif_internal.h"
#include "eif_gen_conf.h"
#include "eif_object_id.h"
#include "eif_traverse.h"
#include "eif_macros.h"
#include "eif_out.h"
#include <math.h>

#ifdef __cplusplus
extern "C" {
#endif


/* ANY class */
#define eif_builtin_ANY_generator__s1(object) 				c_generator ((object))
#define eif_builtin_ANY_generator__s4(object) 				c_generator_32 ((object))
#define eif_builtin_ANY_generating_type__t(object)			RTLNTY2(eif_object_type(object), 0)
#define eif_builtin_ANY_conforms_to__o_b(source, target)		econfg ((target), (source))
#define eif_builtin_ANY_same_type__o_b(obj1, obj2)			estypeg ((obj1), (obj2))
#define eif_builtin_ANY_tagged_out__s1(object)				c_tagged_out ((object))
#define eif_builtin_ANY_tagged_out__s4(object)				c_tagged_out_32 ((object))
#define eif_builtin_ANY_copy__o_(target, source)			ecopy ((source), (target))
#define eif_builtin_ANY_standard_copy__o_(target, source)	ecopy ((source), (target))
#define eif_builtin_ANY_twin__o(object)			eif_twin (object)
#define eif_builtin_ANY_standard_twin__o(object)			eif_standard_twin (object)
#define eif_builtin_ANY_is_deep_equal__o_b(some, other)		ediso ((some), (other))
#define eif_builtin_ANY_is_equal__o_b(some, other)			eequal ((some), (other))
#define eif_builtin_ANY_standard_is_equal__o_b(some, other)	eequal ((some), (other))
#define eif_builtin_ANY_deep_twin__o(object)				edclone ((object))

/* ARGUMENTS class */
#define eif_builtin_ARGUMENTS_32_i_th_argument_pointer__i4_p(i)	(eif_arg_item(i))
#define eif_builtin_ARGUMENTS_32_argument_count__i4			(eif_arg_count() - 1)

/* CHARACTER_8 class */
RT_LNK EIF_CHARACTER_8 eif_CHARACTER_8_as_lower_table [];
RT_LNK EIF_CHARACTER_8 eif_CHARACTER_8_as_upper_table [];
#define eif_builtin_CHARACTER_8_as_lower__c1_c1(c)	(eif_CHARACTER_8_as_lower_table [(c)])
#define eif_builtin_CHARACTER_8_as_upper__c1_c1(c)	(eif_CHARACTER_8_as_upper_table [(c)])

/* EXCEPTION_MANAGER class */
#define eif_builtin_ISE_EXCEPTION_MANAGER_developer_raise__i4_p_p_(code, meaning, message)			draise(code, meaning, message)

/* IDENTIFIED_CONTROLLER class */
#define eif_builtin_IDENTIFIED_CONTROLLER_object_id_stack_size__i4(obj)			eif_object_id_stack_size();
#define eif_builtin_IDENTIFIED_CONTROLLER_extend_object_id_stack__i4_(obj,nb)	eif_extend_object_id_stack(nb);

/* IDENTIFIED_ROUTINES class */
#define eif_builtin_IDENTIFIED_ROUTINES_eif_current_object_id__i4(object)	eif_reference_id(object)
#define eif_builtin_IDENTIFIED_ROUTINES_eif_is_object_id_of_current__i4_b(object,id) EIF_TEST(eif_id_object(id) == object)

/* ISE_RUNTIME class */
/* Define helper to avoid code duplication. */
rt_private rt_inline EIF_REFERENCE eif_obj_at (EIF_REFERENCE obj, EIF_INTEGER_32 offs) {
	return ((EIF_REFERENCE) (obj)) + (offs);
}
rt_private rt_inline EIF_BOOLEAN rt_is_copy_semantics_field (EIF_INTEGER_32 i, EIF_REFERENCE obj, EIF_INTEGER_32 offs) {
	obj = *(EIF_REFERENCE *) ei_oref((i) - 1, eif_obj_at(obj,offs));
	if (obj) {
		return eif_is_expanded(HEADER(obj)->ov_flags);
	} else {
		return EIF_FALSE;
	}
}
rt_private rt_inline EIF_BOOLEAN rt_is_special_copy_semantics_item (EIF_INTEGER_32 i, EIF_REFERENCE a_spec) {
	EIF_REFERENCE obj = *((EIF_REFERENCE *) a_spec + i);
	if (obj) {
		return eif_is_expanded(HEADER(obj)->ov_flags);
	} else {
		return EIF_FALSE;
	}
}
#define eif_builtin_ISE_RUNTIME_dynamic_type__o_i4(obj)					eif_encoded_type(eif_object_type(obj))
#define eif_builtin_ISE_RUNTIME_dynamic_type_at_offset__p_i4_i4(obj,offs)	eif_encoded_type(eif_object_type(eif_obj_at(obj,offs)))
#define eif_builtin_ISE_RUNTIME_field_name_of_type__i4_i4_p(i,enc_ftype)		(System(To_dtype(eif_decoded_type(enc_ftype).id)).cn_names[i - 1])
#define eif_builtin_ISE_RUNTIME_field_static_type_of_type__i4_i4_i4(i,enc_ftype)	eif_encoded_type(ei_field_static_type_of_type(i - 1, enc_ftype))
#define eif_builtin_ISE_RUNTIME_field_type_of_type__i4_i4_i4(i,enc_ftype)		ei_field_type_of_type(i - 1, enc_ftype)
#define eif_builtin_ISE_RUNTIME_generator_of_type__i4_s1(type_id)			c_generator_of_type(eif_decoded_type(type_id))
#define eif_builtin_ISE_RUNTIME_generator_of_type__i4_s4(type_id)			c_generator_of_type_32(eif_decoded_type(type_id))
#define eif_builtin_ISE_RUNTIME_generating_type_of_type__i4_s1(enc_ftype)	eif_typename_of_type(eif_decoded_type(enc_ftype))
#define eif_builtin_ISE_RUNTIME_generating_type_of_type__i4_s4(enc_ftype)	eif_typename_of_type_32(eif_decoded_type(enc_ftype))
#define eif_builtin_ISE_RUNTIME_is_copy_semantics_field__i4_p_i4_b(i,obj,offs)	rt_is_copy_semantics_field(i,obj,offs)
#define eif_builtin_ISE_RUNTIME_is_expanded__p_b(obj)					eif_is_expanded(HEADER(obj)->ov_flags)
#define eif_builtin_ISE_RUNTIME_is_special__p_b(obj)						ei_special(obj)
#define eif_builtin_ISE_RUNTIME_is_special_copy_semantics_item__i4_p_b(i,obj)		rt_is_special_copy_semantics_item(i,obj)
#define eif_builtin_ISE_RUNTIME_is_special_of_expanded__p_b(obj)			(HEADER(obj)->ov_flags & EO_COMP)
#define eif_builtin_ISE_RUNTIME_is_special_of_reference__p_b(obj)			((HEADER(obj)->ov_flags & (EO_REF | EO_COMP)) == EO_REF)
#define eif_builtin_ISE_RUNTIME_is_tuple__p_b(obj)					ei_tuple(obj)
#define eif_builtin_ISE_RUNTIME_is_tuple_type__i4_b(type_id)				eif_is_tuple_type(type_id)
#define eif_builtin_ISE_RUNTIME_is_special_of_reference_or_basic_type__i4_b(type_id)	eif_is_special_type(type_id)
#define eif_builtin_ISE_RUNTIME_is_special_of_reference_type__i4_b(type_id)		eif_special_any_type(type_id)
#define eif_builtin_ISE_RUNTIME_is_object_marked__p_b(obj)				ei_is_marked(obj)
#define eif_builtin_ISE_RUNTIME_mark_object__p_(obj)					ei_mark(obj)
#define eif_builtin_ISE_RUNTIME_object_size__p_u8(obj)					ei_size(obj)
#define eif_builtin_ISE_RUNTIME_unmark_object__p_(obj)					ei_unmark(obj)
#define eif_builtin_ISE_RUNTIME_raw_reference_field_at_offset__p_i4_p(obj,offs)		eif_obj_at(obj,offs)
#define eif_builtin_ISE_RUNTIME_reference_field_at_offset__p_i4_o(obj,offs)		eif_obj_at(obj,offs)

#define eif_builtin_ISE_RUNTIME_new_type_instance_of__i4_t(type_id)		eif_type_malloc(eif_decoded_type(type_id), 0)
#define eif_builtin_ISE_RUNTIME_new_special_of_reference_instance_of__i4_i4_s(type_id, a_capacity)	RTLNSP2(eif_decoded_type(type_id).id,EO_REF,a_capacity,sizeof(EIF_REFERENCE), EIF_FALSE)
#define eif_builtin_ISE_RUNTIME_new_tuple_instance_of__i4_u(type_id)		RTLNT(eif_decoded_type(type_id).id)
#define eif_builtin_ISE_RUNTIME_new_instance_of__i4_o(type_id)			RTLNALIVE(eif_decoded_type(type_id).id)

#define eif_builtin_ISE_RUNTIME_reference_field__i4_p_i4_o(i,obj,offs)			*(EIF_REFERENCE *) ei_oref((i) - 1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_character_8_field__i4_p_i4_c1(i,obj,offs)		*(EIF_CHARACTER_8 *) ei_oref((i) - 1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_character_32_field__i4_p_i4_c4(i,obj,offs)		*(EIF_CHARACTER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_boolean_field__i4_p_i4_b(i,obj,offs)			*(EIF_BOOLEAN *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_8_field__i4_p_i4_u1(i,obj,offs)			*(EIF_NATURAL_8 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_16_field__i4_p_i4_u2(i,obj,offs)		*(EIF_NATURAL_16 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_32_field__i4_p_i4_u4(i,obj,offs)		*(EIF_NATURAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_64_field__i4_p_i4_u8(i,obj,offs)		*(EIF_NATURAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_integer_8_field__i4_p_i4_i1(i,obj,offs)			*(EIF_INTEGER_8 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_integer_16_field__i4_p_i4_i2(i,obj,offs)		*(EIF_INTEGER_16 *) ei_oref((i) - 1, eif_obj_at(obj, offs))
#define eif_builtin_ISE_RUNTIME_integer_32_field__i4_p_i4_i4(i,obj,offs)		*(EIF_INTEGER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_integer_64_field__i4_p_i4_i8(i,obj,offs)		*(EIF_INTEGER_64 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_real_32_field__i4_p_i4_r4(i,obj,offs)			*(EIF_REAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_real_64_field__i4_p_i4_r8(i,obj,offs)			*(EIF_REAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_pointer_field__i4_p_i4_p(i,obj,offs)			*(EIF_POINTER *) ei_oref((i) -1, eif_obj_at(obj,offs))

#define eif_builtin_ISE_RUNTIME_raw_reference_field_at__i4_p_i4_p(field_offs,obj,offs)		*(EIF_REFERENCE *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_reference_field_at__i4_p_i4_o(field_offs,obj,offs)			*(EIF_REFERENCE *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_character_8_field_at__i4_p_i4_c1(field_offs,obj,offs)		*(EIF_CHARACTER_8 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_character_32_field_at__i4_p_i4_c4(field_offs,obj,offs)		*(EIF_CHARACTER_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_boolean_field_at__i4_p_i4_b(field_offs,obj,offs)			*(EIF_BOOLEAN *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_8_field_at__i4_p_i4_u1(field_offs,obj,offs)			*(EIF_NATURAL_8 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_16_field_at__i4_p_i4_u2(field_offs,obj,offs)		*(EIF_NATURAL_16 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_32_field_at__i4_p_i4_u4(field_offs,obj,offs)		*(EIF_NATURAL_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_64_field_at__i4_p_i4_u8(field_offs,obj,offs)		*(EIF_NATURAL_64 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_8_field_at__i4_p_i4_i1(field_offs,obj,offs)			*(EIF_INTEGER_8 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_16_field_at__i4_p_i4_i2(field_offs,obj,offs)		*(EIF_INTEGER_16 *)  (eif_obj_at(obj, offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_32_field_at__i4_p_i4_i4(field_offs,obj,offs)		*(EIF_INTEGER_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_64_field_at__i4_p_i4_i8(field_offs,obj,offs)		*(EIF_INTEGER_64 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_real_32_field_at__i4_p_i4_r4(field_offs,obj,offs)			*(EIF_REAL_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_real_64_field_at__i4_p_i4_r8(field_offs,obj,offs)			*(EIF_REAL_64 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_pointer_field_at__i4_p_i4_p(field_offs,obj,offs)			*(EIF_POINTER *) (eif_obj_at(obj,offs) + field_offs)

#define eif_builtin_ISE_RUNTIME_set_character_8_field__i4_p_i4_c1_(i,obj,offs,val)	*(EIF_CHARACTER_8 *) ei_oref((i) - 1, eif_obj_at(obj,offs)) = (EIF_CHARACTER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_character_32_field__i4_p_i4_c4_(i,obj,offs,val)	*(EIF_CHARACTER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_CHARACTER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_boolean_field__i4_p_i4_b_(i,obj,offs,val)		*(EIF_BOOLEAN *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_BOOLEAN) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_8_field__i4_p_i4_u1_(i,obj,offs,val)		*(EIF_NATURAL_8 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_8) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_16_field__i4_p_i4_u2_(i,obj,offs,val)	*(EIF_NATURAL_16 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_16) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_32_field__i4_p_i4_u4_(i,obj,offs,val)	*(EIF_NATURAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_64_field__i4_p_i4_u8_(i,obj,offs,val)	*(EIF_NATURAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_8_field__i4_p_i4_i1_(i,obj,offs,val)		*(EIF_INTEGER_8 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_INTEGER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_16_field__i4_p_i4_i2_(i,obj,offs,val)	*(EIF_INTEGER_16 *) ei_oref((i) - 1, eif_obj_at(obj, offs)) = (EIF_INTEGER_16) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_32_field__i4_p_i4_i4_(i,obj,offs,val)	*(EIF_INTEGER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_INTEGER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_64_field__i4_p_i4_i8_(i,obj,offs,val)	*(EIF_INTEGER_64 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_INTEGER_64) (val)
#define eif_builtin_ISE_RUNTIME_set_real_32_field__i4_p_i4_r4_(i,obj,offs,val)		*(EIF_REAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_REAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_real_64_field__i4_p_i4_r8_(i,obj,offs,val)		*(EIF_REAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_REAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_pointer_field__i4_p_i4_p_(i,obj,offs,val)		*(EIF_POINTER *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_POINTER) (val)
#define eif_builtin_ISE_RUNTIME_set_reference_field__i4_p_i4_o_(i,obj,offs,val)		RTAR(obj,val); *(EIF_REFERENCE *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_REFERENCE) (val)

#define eif_builtin_ISE_RUNTIME_set_reference_field_at__i4_p_i4_o_(field_offs,obj,offs,val)		RTAR(obj,val); *(EIF_REFERENCE *) (eif_obj_at(obj,offs) + field_offs) = (EIF_REFERENCE) (val)
#define eif_builtin_ISE_RUNTIME_set_character_8_field_at__i4_p_i4_c1_(field_offs,obj,offs,val)	*(EIF_CHARACTER_8 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_CHARACTER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_character_32_field_at__i4_p_i4_c4_(field_offs,obj,offs,val)	*(EIF_CHARACTER_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_CHARACTER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_boolean_field_at__i4_p_i4_b_(field_offs,obj,offs,val)		*(EIF_BOOLEAN *) (eif_obj_at(obj,offs) + field_offs) = (EIF_BOOLEAN) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_8_field_at__i4_p_i4_u1_(field_offs,obj,offs,val)		*(EIF_NATURAL_8 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_8) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_16_field_at__i4_p_i4_u2_(field_offs,obj,offs,val)	*(EIF_NATURAL_16 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_16) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_32_field_at__i4_p_i4_u4_(field_offs,obj,offs,val)	*(EIF_NATURAL_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_64_field_at__i4_p_i4_u8_(field_offs,obj,offs,val)	*(EIF_NATURAL_64 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_8_field_at__i4_p_i4_i1_(field_offs,obj,offs,val)		*(EIF_INTEGER_8 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_INTEGER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_16_field_at__i4_p_i4_i2_(field_offs,obj,offs,val)	*(EIF_INTEGER_16 *)  (eif_obj_at(obj, offs) + field_offs) = (EIF_INTEGER_16) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_32_field_at__i4_p_i4_i4_(field_offs,obj,offs,val)	*(EIF_INTEGER_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_INTEGER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_64_field_at__i4_p_i4_i8_(field_offs,obj,offs,val)	*(EIF_INTEGER_64 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_INTEGER_64) (val)
#define eif_builtin_ISE_RUNTIME_set_real_32_field_at__i4_p_i4_r4_(field_offs,obj,offs,val)		*(EIF_REAL_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_REAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_real_64_field_at__i4_p_i4_r8_(field_offs,obj,offs,val)		*(EIF_REAL_64 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_REAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_pointer_field_at__i4_p_i4_p_(field_offs,obj,offs,val)		*(EIF_POINTER *) (eif_obj_at(obj,offs) + field_offs) = (EIF_POINTER) (val)

#define eif_builtin_ISE_RUNTIME_eif_gen_param_id__i4_i4_i4(a_type_id, i)			eif_gen_param_id(a_type_id, i)
#define eif_builtin_ISE_RUNTIME_generic_parameter_count__i4_i4(a_type_id)		eif_gen_count_with_dftype(eif_decoded_type(a_type_id).id)
#define eif_builtin_ISE_RUNTIME_field_offset_of_type__i4_i4_i4(i,a_type_id)		ei_offset_of_type(i,a_type_id)
#define eif_builtin_ISE_RUNTIME_field_count_of_type__i4_i4(a_type_id)			ei_count_field_of_type(a_type_id)

#define eif_builtin_ISE_RUNTIME_persistent_field_count_of_type__i4_i4(a_type_id)	(System(To_dtype(eif_decoded_type(a_type_id).id)).cn_persistent_nbattr)
#define eif_builtin_ISE_RUNTIME_is_field_expanded_of_type__i4_i4_b(i,a_type_id)		((System(To_dtype(eif_decoded_type(a_type_id).id)).cn_types[i - 1] & SK_HEAD) == SK_EXP)
#define eif_builtin_ISE_RUNTIME_is_field_transient_of_type__i4_i4_b(i,a_type_id)		EIF_IS_TRANSIENT_ATTRIBUTE(System(To_dtype(eif_decoded_type(a_type_id).id)), i - 1)
#define eif_builtin_ISE_RUNTIME_attached_type__i4_i4(a_type_id)					eif_attached_type(a_type_id)
#define eif_builtin_ISE_RUNTIME_detachable_type__i4_i4(a_type_id)					eif_non_attached_type(a_type_id)
#define eif_builtin_ISE_RUNTIME_is_attached_type__i4_b(a_type_id)					eif_is_attached_type(a_type_id)
#define eif_builtin_ISE_RUNTIME_type_conforms_to__i4_i4_b(a_type_id_1, a_type_id_2)	eif_gen_conf(a_type_id_1, a_type_id_2)

/* MEMORY class */
#define eif_builtin_MEMORY_free__o_(obj)					eif_mem_free(obj)
#define eif_builtin_MEMORY_find_referers__o_i4_s(obj,enc_ftype)	find_referers(obj,enc_ftype)

/* PLATFORM class */
#define eif_builtin_PLATFORM_is_vms__b						EIF_IS_VMS
#ifdef EIF_IL_DLL
#define eif_builtin_PLATFORM_is_thread_capable__b 			EIF_TRUE
#else
#define eif_builtin_PLATFORM_is_thread_capable__b 			EIF_THREADS_SUPPORTED
#endif
#define eif_builtin_PLATFORM_is_scoop_capable__b 			EIF_TEST((egc_is_scoop_capable==1) && EIF_IS_SCOOP_CAPABLE)
#define eif_builtin_PLATFORM_is_windows__b 				EIF_IS_WINDOWS
#define eif_builtin_PLATFORM_is_unix__b 					EIF_TEST(!(EIF_IS_VMS || EIF_IS_WINDOWS))
#define eif_builtin_PLATFORM_is_mac__b						EIF_TEST(EIF_OS==EIF_OS_DARWIN)
#define eif_builtin_PLATFORM_is_vxworks__b					EIF_TEST(EIF_OS==EIF_OS_VXWORKS)
#ifdef EIF_IL_DLL
#define eif_builtin_PLATFORM_is_dotnet__b					EIF_TRUE
#else
#define eif_builtin_PLATFORM_is_dotnet__b					EIF_FALSE
#endif
#define eif_builtin_PLATFORM_is_64_bits__b					EIF_IS_64_BITS
#define eif_builtin_PLATFORM_boolean_bytes__i4 				sizeof(EIF_BOOLEAN)
#define eif_builtin_PLATFORM_character_bytes__i4 			sizeof(EIF_CHARACTER_8)
#define eif_builtin_PLATFORM_wide_character_bytes__i4 		sizeof(EIF_CHARACTER_32)
#define eif_builtin_PLATFORM_integer_bytes__i4 				sizeof(EIF_INTEGER_32)
#define eif_builtin_PLATFORM_real_bytes__i4 				sizeof(EIF_REAL_32)
#define eif_builtin_PLATFORM_double_bytes__i4 				sizeof(EIF_REAL_64)
#define eif_builtin_PLATFORM_pointer_bytes__i4 				sizeof(EIF_POINTER)

#define eif_builtin_REAL_32_REF_nan__r4				eif_real_32_nan
#define eif_builtin_REAL_32_REF_negative_infinity__r4		eif_real_32_negative_infinity
#define eif_builtin_REAL_32_REF_positive_infinity__r4		eif_real_32_positive_infinity
#define eif_builtin_REAL_32_ieee_is_equal__r4_b(x,y)			(*(EIF_REAL_32 *)(x) == (y))
#define eif_builtin_REAL_32_ieee_is_greater__r4_b(x,y)		isgreater(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_is_greater_equal__r4_b(x,y)		isgreaterequal(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_is_less__r4_b(x,y)			isless(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_is_less_equal__r4_b(x,y)		islessequal(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_maximum_number__r4_r4(x,y)		fmaxf(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_minimum_number__r4_r4(x,y)		fminf(*(EIF_REAL_32 *)(x),(y))

#define eif_builtin_REAL_64_REF_nan__r8				eif_real_64_nan
#define eif_builtin_REAL_64_REF_negative_infinity__r8		eif_real_64_negative_infinity
#define eif_builtin_REAL_64_REF_positive_infinity__r8		eif_real_64_positive_infinity
#define eif_builtin_REAL_64_ieee_is_equal__r8_b(x,y)			(*(EIF_REAL_64 *)(x) == (y))
#define eif_builtin_REAL_64_ieee_is_greater__r8_b(x,y)		isgreater(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_is_greater_equal__r8_b(x,y)		isgreaterequal(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_is_less__r8_b(x,y)			isless(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_is_less_equal__r8_b(x,y)		islessequal(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_maximum_number__r8_r8(x,y)		fmax(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_minimum_number__r8_r8(x,y)		fmin(*(EIF_REAL_64 *)(x),(y))

/* SPECIAL class */
#define eif_builtin_SPECIAL_aliased_resized_area__i4_s(area, n)	arycpy (area, n, RT_SPECIAL_COUNT (area))
#define eif_builtin_SPECIAL_base_address__p(area)				(EIF_POINTER) (area)
#define eif_builtin_SPECIAL_capacity__i4(area)					RT_SPECIAL_CAPACITY(area)
#define eif_builtin_SPECIAL_count__i4(area)						RT_SPECIAL_COUNT(area)
#define eif_builtin_SPECIAL_element_size__i4(area)				RT_SPECIAL_ELEM_SIZE(area)
#define eif_builtin_SPECIAL_set_count__i4_(area,n)				RT_SPECIAL_COUNT(area) = n

/* TYPE class */
#define eif_builtin_TYPE_has_default__b(obj)					eif_gen_has_default(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_is_attached__b(obj)					eif_is_attached_type2(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_is_deferred__b(obj)					eif_gen_is_deferred(eif_gen_param(Dftype(obj), 1).id)
#define eif_builtin_TYPE_is_expanded__b(obj)					eif_gen_is_expanded(eif_gen_param(Dftype(obj), 1).id)
#define eif_builtin_TYPE_type_id__i4(obj)						eif_encoded_type(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_runtime_name__s1(obj)					eif_typename_of_type(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_runtime_name__s4(obj)					eif_typename_of_type_32(eif_gen_param(Dftype(obj), 1))
/* Second argument is 0, because we use the annotations from the type itself. */
#define eif_builtin_TYPE_generic_parameter_type__i4_t(obj,i)		RTLNTY2(eif_gen_param(eif_gen_param(Dftype(obj), 1).id, i), 0)
#define eif_builtin_TYPE_generic_parameter_count__i4(obj)		eif_gen_count_with_dftype(eif_gen_param(Dftype(obj), 1).id)

/* TUPLE class */
#define eif_builtin_TUPLE_boolean_item__i4_b(obj,i)				eif_boolean_item((obj), (i))
#define eif_builtin_TUPLE_character_8_item__i4_c1(obj,i)			eif_character_8_item((obj), (i))
#define eif_builtin_TUPLE_character_32_item__i4_c4(obj,i)			eif_character_32_item((obj), (i))
#define eif_builtin_TUPLE_count__i4(area)						(RT_SPECIAL_COUNT(area) - 1) /* - 1 because first argument is for object_comparison */
#define eif_builtin_TUPLE_integer_8_item__i4_i1(obj,i)				eif_integer_8_item((obj), (i))
#define eif_builtin_TUPLE_integer_16_item__i4_i2(obj,i)			eif_integer_16_item((obj), (i))
#define eif_builtin_TUPLE_integer_32_item__i4_i4(obj,i)			eif_integer_32_item((obj), (i))
#define eif_builtin_TUPLE_integer_64_item__i4_i8(obj,i)			eif_integer_64_item((obj), (i))
#define eif_builtin_TUPLE_item_code__i4_u1(obj,i)					eif_item_type((obj), (i))
#define eif_builtin_TUPLE_natural_8_item__i4_u1(obj,i)				eif_natural_8_item((obj), (i))
#define eif_builtin_TUPLE_natural_16_item__i4_u2(obj,i)			eif_natural_16_item((obj), (i))
#define eif_builtin_TUPLE_natural_32_item__i4_u4(obj,i)			eif_natural_32_item((obj), (i))
#define eif_builtin_TUPLE_natural_64_item__i4_u8(obj,i)			eif_natural_64_item((obj), (i))
#define eif_builtin_TUPLE_object_comparison__b(obj)			eif_boolean_item((obj), 0)
#define eif_builtin_TUPLE_pointer_item__i4_p(obj,i)				eif_pointer_item((obj), (i))
#define eif_builtin_TUPLE_put_boolean__b_i4_(obj,v,i)				eif_put_boolean_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_character_8__c1_i4_(obj,v,i)			eif_put_character_8_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_character_32__c4_i4_(obj,v,i)			eif_put_character_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_8__i1_i4_(obj,v,i)			eif_put_integer_8_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_16__i2_i4_(obj,v,i)			eif_put_integer_16_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_32__i4_i4_(obj,v,i)			eif_put_integer_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_64__i8_i4_(obj,v,i)			eif_put_integer_64_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_8__u1_i4_(obj,v,i)			eif_put_natural_8_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_16__u2_i4_(obj,v,i)			eif_put_natural_16_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_32__u4_i4_(obj,v,i)			eif_put_natural_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_64__u8_i4_(obj,v,i)			eif_put_natural_64_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_pointer__p_i4_(obj,v,i)				eif_put_pointer_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_real_32__r4_i4_(obj,v,i)				eif_put_real_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_real_64__r8_i4_(obj,v,i)				eif_put_real_64_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_reference__o_i4_(obj,v,i)			eif_put_reference_item((obj), (i), (v))
#define eif_builtin_TUPLE_real_32_item__i4_r4(obj,i)				eif_real_32_item((obj), (i))
#define eif_builtin_TUPLE_real_64_item__i4_r8(obj,i)				eif_real_64_item((obj), (i))
#define eif_builtin_TUPLE_reference_item__i4_o(obj,i)				eif_reference_item((obj), (i))
#define eif_builtin_TUPLE_set_object_comparison__b_(obj,b)		eif_put_boolean_item((obj), 0, (b))

/* EQA_EXTERNALS class */
#ifdef WORKBENCH
#define eif_builtin_EQA_EXTERNALS_invoke_routine__EQA_TEST_SET_i4_(obj, body_id)		eif_invoke_test_routine(obj,body_id)
#define eif_builtin_EQA_EXTERNALS_override_byte_code_of_body__i4_i4_p_i4_(body_id, pattern_id, byte_code, length)	eif_override_byte_code_of_body((int) body_id, (int) pattern_id, (unsigned char *) byte_code, (int)length)
#else
#define eif_builtin_EQA_EXTERNALS_invoke_routine__EQA_TEST_SET_i4_(obj, body_id)
#define eif_builtin_EQA_EXTERNALS_override_byte_code_of_body__i4_i4_p_i4_(body_id, pattern_id, byte_code, length)
#endif


/* Macros before 20.05 */

/* ANY class */
#define eif_builtin_ANY_generator(object) 				c_generator ((object))
#define eif_builtin_ANY_generating_type(object)			RTLNTY2(eif_object_type(object), 0)
#define eif_builtin_ANY_conforms_to(source, target)		econfg ((target), (source))
#define eif_builtin_ANY_same_type(obj1, obj2)			estypeg ((obj1), (obj2))
#define eif_builtin_ANY_tagged_out(object)				c_tagged_out ((object))
#define eif_builtin_ANY_copy(target, source)			ecopy ((source), (target))
#define eif_builtin_ANY_standard_copy(target, source)	ecopy ((source), (target))
#define eif_builtin_ANY_twin(object)			eif_twin (object)
#define eif_builtin_ANY_standard_twin(object)			eif_standard_twin (object)
#define eif_builtin_ANY_is_deep_equal(some, other)		ediso ((some), (other))
#define eif_builtin_ANY_is_equal(some, other)			eequal ((some), (other))
#define eif_builtin_ANY_standard_is_equal(some, other)	eequal ((some), (other))
#define eif_builtin_ANY_deep_twin(object)				edclone ((object))

/* ARGUMENTS class */
#define eif_builtin_ARGUMENTS_32_i_th_argument_pointer(i)	(eif_arg_item(i))
#define eif_builtin_ARGUMENTS_32_argument_count			(eif_arg_count() - 1)

/* EXCEPTION_MANAGER class */
#define eif_builtin_ISE_EXCEPTION_MANAGER_developer_raise(code, meaning, message)			draise(code, meaning, message)

/* IDENTIFIED_CONTROLLER class */
#define eif_builtin_IDENTIFIED_CONTROLLER_object_id_stack_size(obj)			eif_object_id_stack_size();
#define eif_builtin_IDENTIFIED_CONTROLLER_extend_object_id_stack(obj,nb)	eif_extend_object_id_stack(nb);

/* IDENTIFIED_ROUTINES class */
#define eif_builtin_IDENTIFIED_ROUTINES_eif_current_object_id(object)	eif_reference_id(object)
#define eif_builtin_IDENTIFIED_ROUTINES_eif_is_object_id_of_current(object,id) EIF_TEST(eif_id_object(id) == object)

/* ISE_RUNTIME class */
#define eif_builtin_ISE_RUNTIME_dynamic_type(obj)					eif_encoded_type(eif_object_type(obj))
#define eif_builtin_ISE_RUNTIME_dynamic_type_at_offset(obj,offs)	eif_encoded_type(eif_object_type(eif_obj_at(obj,offs)))
#define eif_builtin_ISE_RUNTIME_field_name_of_type(i,enc_ftype)		(System(To_dtype(eif_decoded_type(enc_ftype).id)).cn_names[i - 1])
#define eif_builtin_ISE_RUNTIME_field_static_type_of_type(i,enc_ftype)	eif_encoded_type(ei_field_static_type_of_type(i - 1, enc_ftype))
#define eif_builtin_ISE_RUNTIME_field_type_of_type(i,enc_ftype)		ei_field_type_of_type(i - 1, enc_ftype)
#define eif_builtin_ISE_RUNTIME_generating_type_of_type(enc_ftype)	eif_typename_of_type(eif_decoded_type(enc_ftype))
#define eif_builtin_ISE_RUNTIME_generating_type_8_of_type(enc_ftype)	eif_typename_of_type(eif_decoded_type(enc_ftype))
#define eif_builtin_ISE_RUNTIME_is_copy_semantics_field(i,obj,offs)	rt_is_copy_semantics_field(i,obj,offs)
#define eif_builtin_ISE_RUNTIME_is_expanded(obj)					eif_is_expanded(HEADER(obj)->ov_flags)
#define eif_builtin_ISE_RUNTIME_is_special(obj)						ei_special(obj)
#define eif_builtin_ISE_RUNTIME_is_special_copy_semantics_item(i,obj)	rt_is_special_copy_semantics_item(i,obj)
#define eif_builtin_ISE_RUNTIME_is_special_of_expanded(obj)			(HEADER(obj)->ov_flags & EO_COMP)
#define eif_builtin_ISE_RUNTIME_is_special_of_reference(obj)		((HEADER(obj)->ov_flags & (EO_REF | EO_COMP)) == EO_REF)
#define eif_builtin_ISE_RUNTIME_is_tuple(obj)						ei_tuple(obj)
#define eif_builtin_ISE_RUNTIME_is_tuple_type(type_id)				eif_is_tuple_type(type_id)
#define eif_builtin_ISE_RUNTIME_is_special_of_reference_or_basic_type(type_id)	eif_is_special_type(type_id)
#define eif_builtin_ISE_RUNTIME_is_special_of_reference_type(type_id)	eif_special_any_type(type_id)
#define eif_builtin_ISE_RUNTIME_is_object_marked(obj)				ei_is_marked(obj)
#define eif_builtin_ISE_RUNTIME_mark_object(obj)					ei_mark(obj)
#define eif_builtin_ISE_RUNTIME_object_size(obj)					ei_size(obj)
#define eif_builtin_ISE_RUNTIME_unmark_object(obj)					ei_unmark(obj)
#define eif_builtin_ISE_RUNTIME_raw_reference_field_at_offset(obj,offs)	eif_obj_at(obj,offs)
#define eif_builtin_ISE_RUNTIME_reference_field_at_offset(obj,offs)		eif_obj_at(obj,offs)

#define eif_builtin_ISE_RUNTIME_new_type_instance_of(type_id)		eif_type_malloc(eif_decoded_type(type_id), 0)
#define eif_builtin_ISE_RUNTIME_new_special_of_reference_instance_of(type_id, a_capacity)	RTLNSP2(eif_decoded_type(type_id).id,EO_REF,a_capacity,sizeof(EIF_REFERENCE), EIF_FALSE)
#define eif_builtin_ISE_RUNTIME_new_tuple_instance_of(type_id)		RTLNT(eif_decoded_type(type_id).id)
#define eif_builtin_ISE_RUNTIME_new_instance_of(type_id)			RTLNALIVE(eif_decoded_type(type_id).id)

#define eif_builtin_ISE_RUNTIME_reference_field(i,obj,offs)			*(EIF_REFERENCE *) ei_oref((i) - 1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_character_8_field(i,obj,offs)		*(EIF_CHARACTER_8 *) ei_oref((i) - 1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_character_32_field(i,obj,offs)		*(EIF_CHARACTER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_boolean_field(i,obj,offs)			*(EIF_BOOLEAN *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_8_field(i,obj,offs)			*(EIF_NATURAL_8 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_16_field(i,obj,offs)		*(EIF_NATURAL_16 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_32_field(i,obj,offs)		*(EIF_NATURAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_natural_64_field(i,obj,offs)		*(EIF_NATURAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_integer_8_field(i,obj,offs)			*(EIF_INTEGER_8 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_integer_16_field(i,obj,offs)		*(EIF_INTEGER_16 *) ei_oref((i) - 1, eif_obj_at(obj, offs))
#define eif_builtin_ISE_RUNTIME_integer_32_field(i,obj,offs)		*(EIF_INTEGER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_integer_64_field(i,obj,offs)		*(EIF_INTEGER_64 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_real_32_field(i,obj,offs)			*(EIF_REAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_real_64_field(i,obj,offs)			*(EIF_REAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs))
#define eif_builtin_ISE_RUNTIME_pointer_field(i,obj,offs)			*(EIF_POINTER *) ei_oref((i) -1, eif_obj_at(obj,offs))

#define eif_builtin_ISE_RUNTIME_raw_reference_field_at(field_offs,obj,offs)		*(EIF_REFERENCE *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_reference_field_at(field_offs,obj,offs)			*(EIF_REFERENCE *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_character_8_field_at(field_offs,obj,offs)		*(EIF_CHARACTER_8 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_character_32_field_at(field_offs,obj,offs)		*(EIF_CHARACTER_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_boolean_field_at(field_offs,obj,offs)			*(EIF_BOOLEAN *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_8_field_at(field_offs,obj,offs)			*(EIF_NATURAL_8 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_16_field_at(field_offs,obj,offs)		*(EIF_NATURAL_16 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_32_field_at(field_offs,obj,offs)		*(EIF_NATURAL_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_natural_64_field_at(field_offs,obj,offs)		*(EIF_NATURAL_64 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_8_field_at(field_offs,obj,offs)			*(EIF_INTEGER_8 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_16_field_at(field_offs,obj,offs)		*(EIF_INTEGER_16 *)  (eif_obj_at(obj, offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_32_field_at(field_offs,obj,offs)		*(EIF_INTEGER_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_integer_64_field_at(field_offs,obj,offs)		*(EIF_INTEGER_64 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_real_32_field_at(field_offs,obj,offs)			*(EIF_REAL_32 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_real_64_field_at(field_offs,obj,offs)			*(EIF_REAL_64 *) (eif_obj_at(obj,offs) + field_offs)
#define eif_builtin_ISE_RUNTIME_pointer_field_at(field_offs,obj,offs)			*(EIF_POINTER *) (eif_obj_at(obj,offs) + field_offs)

#define eif_builtin_ISE_RUNTIME_set_character_8_field(i,obj,offs,val)	*(EIF_CHARACTER_8 *) ei_oref((i) - 1, eif_obj_at(obj,offs)) = (EIF_CHARACTER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_character_32_field(i,obj,offs,val)	*(EIF_CHARACTER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_CHARACTER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_boolean_field(i,obj,offs,val)		*(EIF_BOOLEAN *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_BOOLEAN) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_8_field(i,obj,offs,val)		*(EIF_NATURAL_8 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_8) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_16_field(i,obj,offs,val)	*(EIF_NATURAL_16 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_16) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_32_field(i,obj,offs,val)	*(EIF_NATURAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_64_field(i,obj,offs,val)	*(EIF_NATURAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_NATURAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_8_field(i,obj,offs,val)		*(EIF_INTEGER_8 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_INTEGER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_16_field(i,obj,offs,val)	*(EIF_INTEGER_16 *) ei_oref((i) - 1, eif_obj_at(obj, offs)) = (EIF_INTEGER_16) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_32_field(i,obj,offs,val)	*(EIF_INTEGER_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_INTEGER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_64_field(i,obj,offs,val)	*(EIF_INTEGER_64 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_INTEGER_64) (val)
#define eif_builtin_ISE_RUNTIME_set_real_32_field(i,obj,offs,val)		*(EIF_REAL_32 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_REAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_real_64_field(i,obj,offs,val)		*(EIF_REAL_64 *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_REAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_pointer_field(i,obj,offs,val)		*(EIF_POINTER *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_POINTER) (val)
#define eif_builtin_ISE_RUNTIME_set_reference_field(i,obj,offs,val)		RTAR(obj,val); *(EIF_REFERENCE *) ei_oref((i) -1, eif_obj_at(obj,offs)) = (EIF_REFERENCE) (val)

#define eif_builtin_ISE_RUNTIME_set_reference_field_at(field_offs,obj,offs,val)		RTAR(obj,val); *(EIF_REFERENCE *) (eif_obj_at(obj,offs) + field_offs) = (EIF_REFERENCE) (val)
#define eif_builtin_ISE_RUNTIME_set_character_8_field_at(field_offs,obj,offs,val)	*(EIF_CHARACTER_8 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_CHARACTER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_character_32_field_at(field_offs,obj,offs,val)	*(EIF_CHARACTER_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_CHARACTER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_boolean_field_at(field_offs,obj,offs,val)		*(EIF_BOOLEAN *) (eif_obj_at(obj,offs) + field_offs) = (EIF_BOOLEAN) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_8_field_at(field_offs,obj,offs,val)		*(EIF_NATURAL_8 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_8) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_16_field_at(field_offs,obj,offs,val)	*(EIF_NATURAL_16 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_16) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_32_field_at(field_offs,obj,offs,val)	*(EIF_NATURAL_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_natural_64_field_at(field_offs,obj,offs,val)	*(EIF_NATURAL_64 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_NATURAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_8_field_at(field_offs,obj,offs,val)		*(EIF_INTEGER_8 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_INTEGER_8) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_16_field_at(field_offs,obj,offs,val)	*(EIF_INTEGER_16 *)  (eif_obj_at(obj, offs) + field_offs) = (EIF_INTEGER_16) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_32_field_at(field_offs,obj,offs,val)	*(EIF_INTEGER_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_INTEGER_32) (val)
#define eif_builtin_ISE_RUNTIME_set_integer_64_field_at(field_offs,obj,offs,val)	*(EIF_INTEGER_64 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_INTEGER_64) (val)
#define eif_builtin_ISE_RUNTIME_set_real_32_field_at(field_offs,obj,offs,val)		*(EIF_REAL_32 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_REAL_32) (val)
#define eif_builtin_ISE_RUNTIME_set_real_64_field_at(field_offs,obj,offs,val)		*(EIF_REAL_64 *) (eif_obj_at(obj,offs) + field_offs) = (EIF_REAL_64) (val)
#define eif_builtin_ISE_RUNTIME_set_pointer_field_at(field_offs,obj,offs,val)		*(EIF_POINTER *) (eif_obj_at(obj,offs) + field_offs) = (EIF_POINTER) (val)

#define eif_builtin_ISE_RUNTIME_unlock_marking							eif_unlock_marking()
#define eif_builtin_ISE_RUNTIME_eif_gen_param_id(a_type_id, i)			eif_gen_param_id(a_type_id, i)
#define eif_builtin_ISE_RUNTIME_generic_parameter_count(a_type_id)		eif_gen_count_with_dftype(eif_decoded_type(a_type_id).id)
#define eif_builtin_ISE_RUNTIME_field_offset_of_type(i,a_type_id)		ei_offset_of_type(i,a_type_id)
#define eif_builtin_ISE_RUNTIME_field_count_of_type(a_type_id)			ei_count_field_of_type(a_type_id)

#define eif_builtin_ISE_RUNTIME_persistent_field_count_of_type(a_type_id)	(System(To_dtype(eif_decoded_type(a_type_id).id)).cn_persistent_nbattr)
#define eif_builtin_ISE_RUNTIME_is_field_expanded_of_type(i,a_type_id)		((System(To_dtype(eif_decoded_type(a_type_id).id)).cn_types[i - 1] & SK_HEAD) == SK_EXP)
#define eif_builtin_ISE_RUNTIME_is_field_transient_of_type(i,a_type_id)		EIF_IS_TRANSIENT_ATTRIBUTE(System(To_dtype(eif_decoded_type(a_type_id).id)), i - 1)
#define eif_builtin_ISE_RUNTIME_attached_type(a_type_id)					eif_attached_type(a_type_id)
#define eif_builtin_ISE_RUNTIME_detachable_type(a_type_id)					eif_non_attached_type(a_type_id)
#define eif_builtin_ISE_RUNTIME_is_attached_type(a_type_id)					eif_is_attached_type(a_type_id)
#define eif_builtin_ISE_RUNTIME_type_conforms_to(a_type_id_1, a_type_id_2)	eif_gen_conf(a_type_id_1, a_type_id_2)

/* MEMORY class */
#define eif_builtin_MEMORY_free(obj)					eif_mem_free(obj)
#define eif_builtin_MEMORY_find_referers(obj,enc_ftype)	find_referers(obj,enc_ftype)

/* PLATFORM class */
#define eif_builtin_PLATFORM_is_vms						EIF_IS_VMS
#ifdef EIF_IL_DLL
#define eif_builtin_PLATFORM_is_thread_capable 			EIF_TRUE
#else
#define eif_builtin_PLATFORM_is_thread_capable 			EIF_THREADS_SUPPORTED
#endif
#define eif_builtin_PLATFORM_is_scoop_capable 			EIF_TEST((egc_is_scoop_capable==1) && EIF_IS_SCOOP_CAPABLE)
#define eif_builtin_PLATFORM_is_windows 				EIF_IS_WINDOWS
#define eif_builtin_PLATFORM_is_unix 					EIF_TEST(!(EIF_IS_VMS || EIF_IS_WINDOWS))
#define eif_builtin_PLATFORM_is_mac						EIF_TEST(EIF_OS==EIF_OS_DARWIN)
#define eif_builtin_PLATFORM_is_vxworks					EIF_TEST(EIF_OS==EIF_OS_VXWORKS)
#ifdef EIF_IL_DLL
#define eif_builtin_PLATFORM_is_dotnet					EIF_TRUE
#else
#define eif_builtin_PLATFORM_is_dotnet					EIF_FALSE
#endif
#define eif_builtin_PLATFORM_is_64_bits					EIF_IS_64_BITS
#define eif_builtin_PLATFORM_boolean_bytes 				sizeof(EIF_BOOLEAN)
#define eif_builtin_PLATFORM_character_bytes 			sizeof(EIF_CHARACTER_8)
#define eif_builtin_PLATFORM_wide_character_bytes 		sizeof(EIF_CHARACTER_32)
#define eif_builtin_PLATFORM_integer_bytes 				sizeof(EIF_INTEGER_32)
#define eif_builtin_PLATFORM_real_bytes 				sizeof(EIF_REAL_32)
#define eif_builtin_PLATFORM_double_bytes 				sizeof(EIF_REAL_64)
#define eif_builtin_PLATFORM_pointer_bytes 				sizeof(EIF_POINTER)

#define eif_builtin_REAL_32_REF_nan				eif_real_32_nan
#define eif_builtin_REAL_32_REF_negative_infinity		eif_real_32_negative_infinity
#define eif_builtin_REAL_32_REF_positive_infinity		eif_real_32_positive_infinity
#define eif_builtin_REAL_32_ieee_is_equal(x,y)			(*(EIF_REAL_32 *)(x) == (y))
#define eif_builtin_REAL_32_ieee_is_greater(x,y)		isgreater(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_is_greater_equal(x,y)		isgreaterequal(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_is_less(x,y)			isless(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_is_less_equal(x,y)		islessequal(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_maximum_number(x,y)		fmaxf(*(EIF_REAL_32 *)(x),(y))
#define eif_builtin_REAL_32_ieee_minimum_number(x,y)		fminf(*(EIF_REAL_32 *)(x),(y))

#define eif_builtin_REAL_64_REF_nan				eif_real_64_nan
#define eif_builtin_REAL_64_REF_negative_infinity		eif_real_64_negative_infinity
#define eif_builtin_REAL_64_REF_positive_infinity		eif_real_64_positive_infinity
#define eif_builtin_REAL_64_ieee_is_equal(x,y)			(*(EIF_REAL_64 *)(x) == (y))
#define eif_builtin_REAL_64_ieee_is_greater(x,y)		isgreater(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_is_greater_equal(x,y)		isgreaterequal(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_is_less(x,y)			isless(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_is_less_equal(x,y)		islessequal(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_maximum_number(x,y)		fmax(*(EIF_REAL_64 *)(x),(y))
#define eif_builtin_REAL_64_ieee_minimum_number(x,y)		fmin(*(EIF_REAL_64 *)(x),(y))

/* SPECIAL class */
#define eif_builtin_SPECIAL_aliased_resized_area(area, n)	arycpy (area, n, RT_SPECIAL_COUNT (area))
#define eif_builtin_SPECIAL_base_address(area)				(EIF_POINTER) (area)
#define eif_builtin_SPECIAL_capacity(area)					RT_SPECIAL_CAPACITY(area)
#define eif_builtin_SPECIAL_count(area)						RT_SPECIAL_COUNT(area)
#define eif_builtin_SPECIAL_element_size(area)				RT_SPECIAL_ELEM_SIZE(area)
#define eif_builtin_SPECIAL_set_count(area,n)				RT_SPECIAL_COUNT(area) = n

/* TYPE class */
#define eif_builtin_TYPE_has_default(obj)					eif_gen_has_default(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_is_attached(obj)					eif_is_attached_type2(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_is_deferred(obj)					eif_gen_is_deferred(eif_gen_param(Dftype(obj), 1).id)
#define eif_builtin_TYPE_is_expanded(obj)					eif_gen_is_expanded(eif_gen_param(Dftype(obj), 1).id)
#define eif_builtin_TYPE_type_id(obj)						eif_encoded_type(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_runtime_name(obj)					eif_typename_of_type(eif_gen_param(Dftype(obj), 1))
/* Second argument is 0, because we use the annotations from the type itself. */
#define eif_builtin_TYPE_generic_parameter_type(obj,i)		RTLNTY2(eif_gen_param(eif_gen_param(Dftype(obj), 1).id, i), 0)
#define eif_builtin_TYPE_generic_parameter_count(obj)		eif_gen_count_with_dftype(eif_gen_param(Dftype(obj), 1).id)

/* TUPLE class */
#define eif_builtin_TUPLE_boolean_item(obj,i)				eif_boolean_item((obj), (i))
#define eif_builtin_TUPLE_character_8_item(obj,i)			eif_character_8_item((obj), (i))
#define eif_builtin_TUPLE_character_32_item(obj,i)			eif_character_32_item((obj), (i))
#define eif_builtin_TUPLE_count(area)						(RT_SPECIAL_COUNT(area) - 1) /* - 1 because first argument is for object_comparison */
#define eif_builtin_TUPLE_integer_8_item(obj,i)				eif_integer_8_item((obj), (i))
#define eif_builtin_TUPLE_integer_16_item(obj,i)			eif_integer_16_item((obj), (i))
#define eif_builtin_TUPLE_integer_32_item(obj,i)			eif_integer_32_item((obj), (i))
#define eif_builtin_TUPLE_integer_64_item(obj,i)			eif_integer_64_item((obj), (i))
#define eif_builtin_TUPLE_item_code(obj,i)					eif_item_type((obj), (i))
#define eif_builtin_TUPLE_natural_8_item(obj,i)				eif_natural_8_item((obj), (i))
#define eif_builtin_TUPLE_natural_16_item(obj,i)			eif_natural_16_item((obj), (i))
#define eif_builtin_TUPLE_natural_32_item(obj,i)			eif_natural_32_item((obj), (i))
#define eif_builtin_TUPLE_natural_64_item(obj,i)			eif_natural_64_item((obj), (i))
#define eif_builtin_TUPLE_object_comparison(obj)			eif_boolean_item((obj), 0)
#define eif_builtin_TUPLE_pointer_item(obj,i)				eif_pointer_item((obj), (i))
#define eif_builtin_TUPLE_put_boolean(obj,v,i)				eif_put_boolean_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_character_8(obj,v,i)			eif_put_character_8_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_character_32(obj,v,i)			eif_put_character_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_8(obj,v,i)			eif_put_integer_8_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_16(obj,v,i)			eif_put_integer_16_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_32(obj,v,i)			eif_put_integer_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_integer_64(obj,v,i)			eif_put_integer_64_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_8(obj,v,i)			eif_put_natural_8_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_16(obj,v,i)			eif_put_natural_16_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_32(obj,v,i)			eif_put_natural_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_natural_64(obj,v,i)			eif_put_natural_64_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_pointer(obj,v,i)				eif_put_pointer_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_real_32(obj,v,i)				eif_put_real_32_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_real_64(obj,v,i)				eif_put_real_64_item((obj), (i), (v))
#define eif_builtin_TUPLE_put_reference(obj,v,i)			eif_put_reference_item((obj), (i), (v))
#define eif_builtin_TUPLE_real_32_item(obj,i)				eif_real_32_item((obj), (i))
#define eif_builtin_TUPLE_real_64_item(obj,i)				eif_real_64_item((obj), (i))
#define eif_builtin_TUPLE_reference_item(obj,i)				eif_reference_item((obj), (i))
#define eif_builtin_TUPLE_set_object_comparison(obj,b)		eif_put_boolean_item((obj), 0, (b))

/* EQA_EXTERNALS class */
#ifdef WORKBENCH
#define eif_builtin_EQA_EXTERNALS_invoke_routine(obj, body_id)		eif_invoke_test_routine(obj,body_id)
#define eif_builtin_EQA_EXTERNALS_override_byte_code_of_body(body_id, pattern_id, byte_code, length)	eif_override_byte_code_of_body((int) body_id, (int) pattern_id, (unsigned char *) byte_code, (int)length)
#else
#define eif_builtin_EQA_EXTERNALS_invoke_routine(obj, body_id)
#define eif_builtin_EQA_EXTERNALS_override_byte_code_of_body(body_id, pattern_id, byte_code, length)
#endif


#ifdef __cplusplus
}
#endif

#endif
