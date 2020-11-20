note
	description: "Mapping of real Eiffel types to underlying machine type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPE_C

inherit
	HASHABLE

feature -- Access

	level: INTEGER
			-- Internal code for generation
		deferred
		end

	tuple_code: NATURAL_8
			-- Code for TUPLE type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
		end

	element_type: INTEGER_8
			-- Type of current element. See MD_SIGNATURE_CONSTANTS for
			-- all possible values.
		deferred
		end

	sk_value: NATURAL_32
			-- SK value associated to the current type.
		deferred
		end

	c_string: STRING
			-- String generated for the type.
		deferred
		ensure
			c_string_not_null: Result /= Void
			c_string_not_empty: not Result.is_empty
		end

	typed_field: STRING
			-- Value field of a C structure corresponding to this type
		deferred
		ensure
			result_attached: Result /= Void
			result_not_empty: not Result.is_empty
		end

	new_attribute_description: ATTR_DESC
			-- New descritpion of type for skeletons
		do
			create {REFERENCE_DESC} Result
		ensure
			description_not_void: Result /= Void
		end

feature -- Comparison

	same_class_type (other: TYPE_C): BOOLEAN
			-- Is `other' the same C type as Current ?
		require
			valid_argument: other /= Void
		do
			Result := other.level = level
		end

	same_as (other: TYPE_C): BOOLEAN
			-- Is `other' the same C type as Current?
		do
			Result := other.level = level
		end

feature -- Status Report

	is_reference: BOOLEAN
			-- Is C type a reference type
		do
		end

	is_void: BOOLEAN
			-- Is C type a void type
		do
		end

	is_basic: BOOLEAN
			-- Is it a built-in basic type?
		do
		end

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY)
			-- Generate default value of basic type on stack.
		require
			valid_array: ba /= Void
		do
		end

feature -- C code generation

	generate (buffer: GENERATION_BUFFER)
			-- Generate C type in `buffer'.
		require
			good_argument: buffer /= Void
		do
			buffer.put_string (c_string)
		end

	generate_cast (buffer: GENERATION_BUFFER)
			-- Generate C cast in `buffer'.
		require
			good_argument: buffer /= Void
		do
			buffer.put_character ('(')
			generate (buffer)
			buffer.put_two_character (')', ' ')
		end

	generate_access_cast (buffer: GENERATION_BUFFER)
			-- Generate access C cast in `buffer'.
		require
			good_argument: buffer /= Void
			not_void_type: not is_void
		do
			buffer.put_character ('(')
			generate (buffer)
			buffer.put_three_character (' ', '*', ')')
		end

	generate_size (buffer: GENERATION_BUFFER)
			-- Generate size of C type
		require
			good_argument: buffer /= Void
		do
			buffer.put_string ({C_CONST}.sizeof)
			buffer.put_character ('(')
			generate (buffer)
			buffer.put_character (')')
		end

	generate_default_value (buffer: GENERATION_BUFFER)
			-- Generate default value associated to current basic type.
		require
			buffer_not_void: buffer /= Void
		do
			buffer.put_two_character ('(', '(')
			generate (buffer)
			buffer.put_four_character (')', ' ', '0', ')')
		end

	generate_function_cast (buffer: GENERATION_BUFFER; arg_types: ARRAY [STRING]; workbench_mode: BOOLEAN)
			-- Generate C function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		do
			buffer.put_string ({C_CONST}.function_cast)
			buffer.put_character ('(')
			if workbench_mode and then not is_void then
				buffer.put_string ({C_CONST}.eif_typed_value)
			else
				generate (buffer)
			end
			buffer.put_three_character (',', ' ', '(')
			buffer.put_string_array (arg_types)
			buffer.put_three_character (')', ')', ' ')
		end

	generate_external_function_cast_type (buffer: GENERATION_BUFFER; call_type: STRING; arg_types: ARRAY [STRING])
			-- Generate C external function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		do
			if call_type /= Void then
				buffer.put_string ({C_CONST}.function_cast_type)
				buffer.put_character ('(')
				generate (buffer)
				buffer.put_character (',')
				buffer.put_string (call_type)
			else
				buffer.put_string ({C_CONST}.function_cast)
				buffer.put_character ('(')
				generate (buffer)
			end
			buffer.put_three_character (',', ' ', '(')
			buffer.put_string_array (arg_types)
			buffer.put_three_character (')', ')', ' ')
		end

	generate_conversion_to_real_64 (buffer: GENERATION_BUFFER)
			-- Generate conversion to `REAL_64', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_64.
		require
			buffer_not_void: buffer /= Void
		do
			check
				not_called: False
			end
		end

	generate_conversion_to_real_32 (buffer: GENERATION_BUFFER)
			-- Generate conversion to `REAL_32', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_32.
		require
			buffer_not_void: buffer /= Void
		do
			check
				not_called: False
			end
		end

	frozen generate_typed_field (buffer: GENERATION_BUFFER)
			-- Generate field of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		require
			buffer_attached: buffer /= Void
		do
			buffer.put_string (typed_field)
		end

	generate_typed_tag (buffer: GENERATION_BUFFER)
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		require
			buffer_attached: buffer /= Void
		do
			buffer.put_string (once "type = ")
			generate_sk_value (buffer)
		end

	generate_sk_value (buffer: GENERATION_BUFFER)
			-- Generate SK value associated to current C type in `buffer'.
		require
			good_argument: buffer /= Void
		deferred
		end

	generate_tuple_item (buffer: GENERATION_BUFFER)
			-- Generate a name of a macro to access a tuple element of this type.
		require
			buffer_attached: attached buffer
		do
			inspect sk_value
			when {SK_CONST}.sk_bool then buffer.put_string (once "eif_boolean_item")
			when {SK_CONST}.sk_char8 then buffer.put_string (once "eif_character_8_item")
			when {SK_CONST}.sk_char32 then buffer.put_string (once "eif_character_32_item")
			when {SK_CONST}.sk_real32 then buffer.put_string (once "eif_real_32_item")
			when {SK_CONST}.sk_real64 then buffer.put_string (once "eif_real_64_item")
			when {SK_CONST}.sk_uint8 then buffer.put_string (once "eif_natural_8_item")
			when {SK_CONST}.sk_uint16 then buffer.put_string (once "eif_natural_16_item")
			when {SK_CONST}.sk_uint32 then buffer.put_string (once "eif_natural_32_item")
			when {SK_CONST}.sk_uint64 then buffer.put_string (once "eif_natural_64_item")
			when {SK_CONST}.sk_int8 then buffer.put_string (once "eif_integer_8_item")
			when {SK_CONST}.sk_int16 then buffer.put_string (once "eif_integer_16_item")
			when {SK_CONST}.sk_int32 then buffer.put_string (once "eif_integer_32_item")
			when {SK_CONST}.sk_int64 then buffer.put_string (once "eif_integer_64_item")
			when {SK_CONST}.sk_pointer then buffer.put_string (once "eif_pointer_item")
			else
				buffer.put_string (once "eif_reference_item")
			end
		end

	generate_tuple_put (buffer: GENERATION_BUFFER)
			-- Generate a name of a macro to change a tuple element of this type.
		require
			buffer_attached: attached buffer
		do
			inspect sk_value
			when {SK_CONST}.sk_bool then buffer.put_string (once "eif_put_boolean_item")
			when {SK_CONST}.sk_char8 then buffer.put_string (once "eif_put_character_8_item")
			when {SK_CONST}.sk_char32 then buffer.put_string (once "eif_put_character_32_item")
			when {SK_CONST}.sk_real32 then buffer.put_string (once "eif_put_real_32_item")
			when {SK_CONST}.sk_real64 then buffer.put_string (once "eif_put_real_64_item")
			when {SK_CONST}.sk_uint8 then buffer.put_string (once "eif_put_natural_8_item")
			when {SK_CONST}.sk_uint16 then buffer.put_string (once "eif_put_natural_16_item")
			when {SK_CONST}.sk_uint32 then buffer.put_string (once "eif_put_natural_32_item")
			when {SK_CONST}.sk_uint64 then buffer.put_string (once "eif_put_natural_64_item")
			when {SK_CONST}.sk_int8 then buffer.put_string (once "eif_put_integer_8_item")
			when {SK_CONST}.sk_int16 then buffer.put_string (once "eif_put_integer_16_item")
			when {SK_CONST}.sk_int32 then buffer.put_string (once "eif_put_integer_32_item")
			when {SK_CONST}.sk_int64 then buffer.put_string (once "eif_put_integer_64_item")
			when {SK_CONST}.sk_pointer then buffer.put_string (once "eif_put_pointer_item")
			else
				buffer.put_string (once "eif_put_reference_item")
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
