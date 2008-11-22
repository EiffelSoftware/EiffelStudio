/*
	description: "Declarations for `built_in' externals."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2008, Eiffel Software."
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

#include "eif_eiffel.h"
#include "eif_misc.h"
#include "eif_argv.h"

#ifdef __cplusplus
extern "C" {
#endif

/* ANY class */
#define eif_builtin_ANY_generator(object) 				c_generator ((object))
#define eif_builtin_ANY_generating_type(object)			eif_gen_typename ((object))
#define eif_builtin_ANY_conforms_to(source, target)		econfg ((target), (source)) 
#define eif_builtin_ANY_same_type(obj1, obj2)			estypeg ((obj1), (obj2))
#define eif_builtin_ANY_tagged_out(object)				c_tagged_out ((object))
#define eif_builtin_ANY_copy(source, target)			ecopy ((target), (source))
#define eif_builtin_ANY_standard_copy(source, target)	ecopy ((target), (source))
#define eif_builtin_ANY_twin(object)			eif_twin (object)
#define eif_builtin_ANY_standard_twin(object)			eif_standard_twin (object)
#define eif_builtin_ANY_is_deep_equal(some, other)		ediso ((some), (other))
#define eif_builtin_ANY_standard_is_equal(some, other)	eequal ((some), (other))
#define eif_builtin_ANY_deep_twin(object)				edclone ((object))

/* ARGUMENTS class */
#define eif_builtin_ARGUMENTS_argument(some,i)			arg_option(i)
#define eif_builtin_ARGUMENTS_argument_count(some)		(arg_number() - 1)

/* TUPLE class */
#define eif_builtin_TUPLE_count(area)						(sp_count (area) - 1) /* - 1 because first argument is for object_comparison */

/* SPECIAL class */
#define eif_builtin_SPECIAL_base_address(area)				(EIF_POINTER) (area)
#define eif_builtin_SPECIAL_count(area)						sp_count (area)
#define eif_builtin_SPECIAL_element_size(area)				sp_elem_size (area)
#define eif_builtin_SPECIAL_aliased_resized_area(area, n)	arycpy (area, n, 0, sp_count (area))

/* PLATFORM class */
#define eif_builtin_PLATFORM_is_vms						EIF_IS_VMS
#ifdef EIF_IL_DLL
#define eif_builtin_PLATFORM_is_thread_capable 			EIF_TRUE
#else
#define eif_builtin_PLATFORM_is_thread_capable 			EIF_THREADS_SUPPORTED
#endif
#define eif_builtin_PLATFORM_is_windows 				EIF_IS_WINDOWS
#define eif_builtin_PLATFORM_is_unix 					EIF_TEST(!(EIF_IS_VMS || EIF_IS_WINDOWS))
#define eif_builtin_PLATFORM_is_mac						EIF_OS==EIF_OS_DARWIN
#ifdef EIF_IL_DLL
#define eif_builtin_PLATFORM_is_dotnet					EIF_TRUE
#else
#define eif_builtin_PLATFORM_is_dotnet					EIF_FALSE
#endif
#define eif_builtin_PLATFORM_boolean_bytes 				sizeof(EIF_BOOLEAN)
#define eif_builtin_PLATFORM_character_bytes 			sizeof(EIF_CHARACTER)
#define eif_builtin_PLATFORM_wide_character_bytes 		sizeof(EIF_WIDE_CHAR)
#define eif_builtin_PLATFORM_integer_bytes 				sizeof(EIF_INTEGER_32)
#define eif_builtin_PLATFORM_real_bytes 				sizeof(EIF_REAL_32)
#define eif_builtin_PLATFORM_double_bytes 				sizeof(EIF_REAL_64)
#define eif_builtin_PLATFORM_pointer_bytes 				sizeof(EIF_POINTER)

/* INTERNAL class */
#define eif_builtin_INTERNAL_c_is_instance_of(dftype,obj)	RTRA(dftype,obj)
#define eif_builtin_INTERNAL_c_field(i,obj)					ei_field(i,obj)
#define eif_builtin_INTERNAL_c_expanded_type(i,obj)			ei_exp_type(i,obj)
#define eif_builtin_INTERNAL_c_character_8_field(i,obj)		ei_char_field(i,obj)
#define eif_builtin_INTERNAL_c_character_32_field(i,obj)	ei_char_32_field(i,obj)
#define eif_builtin_INTERNAL_c_boolean_field(i,obj)			ei_bool_field(i,obj)
#define eif_builtin_INTERNAL_c_natural_8_field(i,obj)		ei_uint_8_field(i,obj)
#define eif_builtin_INTERNAL_c_natural_16_field(i,obj)		ei_uint_16_field(i,obj)
#define eif_builtin_INTERNAL_c_natural_32_field(i,obj)		ei_uint_32_field(i,obj)
#define eif_builtin_INTERNAL_c_natural_64_field(i,obj)		ei_uint_64_field(i,obj)
#define eif_builtin_INTERNAL_c_integer_8_field(i,obj)		ei_int_8_field(i,obj)
#define eif_builtin_INTERNAL_c_integer_16_field(i,obj)		ei_int_16_field(i,obj)
#define eif_builtin_INTERNAL_c_integer_32_field(i,obj)		ei_int_32_field(i,obj)
#define eif_builtin_INTERNAL_c_integer_64_field(i,obj)		ei_int_64_field(i,obj)
#define eif_builtin_INTERNAL_c_real_32_field(i,obj)			ei_float_field(i,obj)
#define eif_builtin_INTERNAL_c_real_64_field(i,obj)			ei_double_field(i,obj)
#define eif_builtin_INTERNAL_c_pointer_field(i,obj)			ei_ptr_field(i,obj)
#define eif_builtin_INTERNAL_c_is_special(obj)				ei_special(obj)
#define eif_builtin_INTERNAL_c_is_tuple(obj)				ei_tuple(obj)
#define eif_builtin_INTERNAL_c_field_offset(i,obj)			ei_offset(i,obj)
#define eif_builtin_INTERNAL_c_bit_size(i,obj)				ei_bit_size(i,obj)
#define eif_builtin_INTERNAL_c_size(obj)					ei_size(obj)
#define eif_builtin_INTERNAL_c_set_reference_field(i,obj,val)		ei_set_reference_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_character_8_field(i,obj,val)		ei_set_char_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_character_32_field(i,obj,val)	ei_set_char_32_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_boolean_field(i,obj,val)			ei_set_boolean_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_natural_8_field(i,obj,val)		ei_set_natural_8_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_natural_16_field(i,obj,val)		ei_set_natural_16_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_natural_32_field(i,obj,val)		ei_set_natural_32_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_natural_64_field(i,obj,val)		ei_set_natural_64_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_integer_8_field(i,obj,val)		ei_set_integer_8_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_integer_16_field(i,obj,val)		ei_set_integer_16_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_integer_32_field(i,obj,val)		ei_set_integer_32_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_integer_64_field(i,obj,val)		ei_set_integer_64_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_real_32_field(i,obj,val)			ei_set_float_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_real_64_field(i,obj,val)			ei_set_double_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_pointer_field(i,obj,val)			ei_set_pointer_field(i,obj,val)
#define eif_builtin_INTERNAL_c_set_dynamic_type(obj,dftype)	eif_set_dynamic_type(obj,dftype)
#define eif_builtin_INTERNAL_c_mark(obj)					ei_mark(obj)
#define eif_builtin_INTERNAL_c_unmark(obj)					ei_unmark(obj)
#define eif_builtin_INTERNAL_c_is_marked(obj)				ei_is_marked(obj)

/* ISE_RUNTIME class */
#define eif_builtin_ISE_RUNTIME_dynamic_type(obj)			Dftype(obj)

/* EXCEPTION_MANAGER */
#define eif_builtin_ISE_EXCEPTION_MANAGER_developer_raise(object, code, meaning, message)			draise(code, meaning, message)

#ifdef __cplusplus
}
#endif

#endif
