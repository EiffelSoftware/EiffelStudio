/*
	description: "Declarations for `built_in' externals."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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

#ifdef __cplusplus
extern "C" {
#endif

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
#define eif_builtin_ARGUMENTS_32_i_th_argument_pointer(some,i)	(eif_arg_item(i))
#define eif_builtin_ARGUMENTS_32_argument_count(some)		(eif_arg_count() - 1)

/* EV_ANY_IMP class */
#define eif_builtin_EV_ANY_IMP_eif_current_object_id(object)	eif_reference_id(object)
#define eif_builtin_EV_ANY_IMP_eif_is_object_id_of_current(object,id) EIF_TEST(eif_id_object(id) == object)

/* EXCEPTION_MANAGER class */
#define eif_builtin_ISE_EXCEPTION_MANAGER_developer_raise(object, code, meaning, message)			draise(code, meaning, message)

/* IDENTIFIED_CONTROLLER class */
#define eif_builtin_IDENTIFIED_CONTROLLER_object_id_stack_size(obj)			eif_object_id_stack_size();
#define eif_builtin_IDENTIFIED_CONTROLLER_extend_object_id_stack(obj,nb)	eif_extend_object_id_stack(nb);

/* IDENTIFIED_ROUTINES class */
#define eif_builtin_IDENTIFIED_ROUTINES_eif_current_object_id(object)	eif_reference_id(object)
#define eif_builtin_IDENTIFIED_ROUTINES_eif_is_object_id_of_current(object,id) EIF_TEST(eif_id_object(id) == object)

#define eif_builtin_REFLECTOR_c_set_dynamic_type(obj,enc_ftype)		eif_set_dynamic_type(obj,enc_ftype)

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
#define eif_builtin_ISE_RUNTIME_dynamic_type(obj)					eif_encoded_type(eif_object_type(obj))
#define eif_builtin_ISE_RUNTIME_dynamic_type_at_offset(obj,offs)	eif_encoded_type(eif_object_type(eif_obj_at(obj,offs)))
#define eif_builtin_ISE_RUNTIME_field_name_of_type(i,enc_ftype)		(System(To_dtype(eif_decoded_type(enc_ftype).id)).cn_names[i - 1])
#define eif_builtin_ISE_RUNTIME_field_static_type_of_type(i,enc_ftype)	eif_encoded_type(ei_field_static_type_of_type(i - 1, enc_ftype))
#define eif_builtin_ISE_RUNTIME_field_type_of_type(i,enc_ftype)		ei_field_type_of_type(i - 1, enc_ftype)
#define eif_builtin_ISE_RUNTIME_generating_type_of_type(enc_ftype)	eif_typename_of_type(eif_decoded_type(enc_ftype))
#define eif_builtin_ISE_RUNTIME_is_copy_semantics_field(i,obj,offs)	rt_is_copy_semantics_field(i,obj,offs)
#define eif_builtin_ISE_RUNTIME_is_expanded(obj)					eif_is_expanded(HEADER(obj)->ov_flags)
#define eif_builtin_ISE_RUNTIME_is_special(obj)						ei_special(obj)
#define eif_builtin_ISE_RUNTIME_is_special_copy_semantics_item(i,obj)	rt_is_special_copy_semantics_item(i,obj)
#define eif_builtin_ISE_RUNTIME_is_special_of_expanded(obj)			(HEADER(obj)->ov_flags & EO_COMP)
#define eif_builtin_ISE_RUNTIME_is_special_of_reference(obj)		((HEADER(obj)->ov_flags & (EO_REF | EO_COMP)) == EO_REF)
#define eif_builtin_ISE_RUNTIME_is_tuple(obj)						ei_tuple(obj)
#define eif_builtin_ISE_RUNTIME_is_object_marked(obj)				ei_is_marked(obj)
#define eif_builtin_ISE_RUNTIME_mark_object(obj)					ei_mark(obj)
#define eif_builtin_ISE_RUNTIME_object_size(obj)					ei_size(obj)
#define eif_builtin_ISE_RUNTIME_unmark_object(obj)					ei_unmark(obj)
#define eif_builtin_ISE_RUNTIME_raw_reference_field_at_offset(obj,offs)	eif_obj_at(obj,offs)
#define eif_builtin_ISE_RUNTIME_reference_field_at_offset(obj,offs)		eif_obj_at(obj,offs)

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
#define eif_builtin_ISE_RUNTIME_set_pointer_field_at(field_offs,obj,offs,val)			*(EIF_POINTER *) (eif_obj_at(obj,offs) + field_offs) = (EIF_POINTER) (val)


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
#define eif_builtin_PLATFORM_boolean_bytes 				sizeof(EIF_BOOLEAN)
#define eif_builtin_PLATFORM_character_bytes 			sizeof(EIF_CHARACTER_8)
#define eif_builtin_PLATFORM_wide_character_bytes 		sizeof(EIF_CHARACTER_32)
#define eif_builtin_PLATFORM_integer_bytes 				sizeof(EIF_INTEGER_32)
#define eif_builtin_PLATFORM_real_bytes 				sizeof(EIF_REAL_32)
#define eif_builtin_PLATFORM_double_bytes 				sizeof(EIF_REAL_64)
#define eif_builtin_PLATFORM_pointer_bytes 				sizeof(EIF_POINTER)

#define eif_builtin_REAL_32_REF_nan						eif_real_32_nan
#define eif_builtin_REAL_32_REF_negative_infinity		eif_real_32_negative_infinity
#define eif_builtin_REAL_32_REF_positive_infinity		eif_real_32_positive_infinity

#define eif_builtin_REAL_64_REF_nan						eif_real_64_nan
#define eif_builtin_REAL_64_REF_negative_infinity		eif_real_64_negative_infinity
#define eif_builtin_REAL_64_REF_positive_infinity		eif_real_64_positive_infinity

/* SPECIAL class */
#define eif_builtin_SPECIAL_aliased_resized_area(area, n)	arycpy (area, n, RT_SPECIAL_COUNT (area))
#define eif_builtin_SPECIAL_base_address(area)				(EIF_POINTER) (area)
#define eif_builtin_SPECIAL_capacity(area)					RT_SPECIAL_CAPACITY(area)
#define eif_builtin_SPECIAL_count(area)						RT_SPECIAL_COUNT(area)
#define eif_builtin_SPECIAL_element_size(area)				RT_SPECIAL_ELEM_SIZE(area)
#define eif_builtin_SPECIAL_set_count(area,n)				RT_SPECIAL_COUNT(area) = n

/* TYPE class */
#define eif_builtin_TYPE_has_default(obj)					eif_gen_has_default(eif_gen_param(Dftype(obj), 1))	
#define eif_builtin_TYPE_is_expanded(obj)					eif_gen_is_expanded(eif_gen_param(Dftype(obj), 1).id)
#define eif_builtin_TYPE_is_attached(obj)					eif_is_attached_type2(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_type_id(obj)						eif_encoded_type(eif_gen_param(Dftype(obj), 1))
#define eif_builtin_TYPE_runtime_name(obj)					eif_typename_of_type(eif_gen_param(Dftype(obj), 1))
/* Second argument is 0, because we use the annotations from the type itself. */
#define eif_builtin_TYPE_generic_parameter_type(obj,i)		RTLNTY2(eif_gen_param(eif_gen_param(Dftype(obj), 1).id, i), 0)
#define eif_builtin_TYPE_generic_parameter_count(obj)		eif_gen_count_with_dftype(eif_gen_param(Dftype(obj), 1).id)

/* TUPLE class */
#define eif_builtin_TUPLE_count(area)						(RT_SPECIAL_COUNT(area) - 1) /* - 1 because first argument is for object_comparison */

/* WEL_IDENTIFIED class */
#define eif_builtin_WEL_IDENTIFIED_eif_current_object_id(object)	eif_reference_id(object)
#define eif_builtin_WEL_IDENTIFIED_eif_is_object_id_of_current(object,id) EIF_TEST(eif_id_object(id) == object)

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
