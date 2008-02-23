indexing
	description: "Mapping of real Eiffel types to underlying machine type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPE_C

inherit
	HASHABLE

feature -- Access

	level: INTEGER is
			-- Internal code for generation
		deferred
		end

	tuple_code: NATURAL_8 is
			-- Code for TUPLE type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.reference_tuple_code
		end

	element_type: INTEGER_8 is
			-- Type of current element. See MD_SIGNATURE_CONSTANTS for
			-- all possible values.
		deferred
		end

	sk_value: INTEGER is
			-- SK value associated to the current type.
		deferred
		end

	c_string: STRING is
			-- String generated for the type.
		deferred
		ensure
			c_string_not_null: Result /= Void
			c_string_not_empty: not Result.is_empty
		end

	typed_field: STRING is
			-- Value field of a C structure corresponding to this type
		deferred
		ensure
			result_attached: Result /= Void
			result_not_empty: not Result.is_empty
		end

	new_attribute_description: ATTR_DESC is
			-- New descritpion of type for skeletons
		do
			create {REFERENCE_DESC} Result
		ensure
			description_not_void: Result /= Void
		end

feature -- Comparison

	same_class_type (other: TYPE_C): BOOLEAN is
			-- Is `other' the same C type as Current ?
		require
			valid_argument: other /= Void
		do
			Result := other.level = level
		end

	same_as (other: TYPE_C): BOOLEAN is
			-- Is `other' the same C type as Current?
		do
			Result := other.level = level
		end

feature -- Status Report

	is_pointer: BOOLEAN is
			-- Is C type a reference type
		do
		end

	is_bit: BOOLEAN is
			-- Is C type a a bit type (Conveniencee)
		do
		end

	is_void: BOOLEAN is
			-- Is C type a void type
		do
		end

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		require
			valid_array: ba /= Void
		do
		end

feature -- C code generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate C type in `buffer'.
		require
			good_argument: buffer /= Void
		do
			buffer.put_string (C_string)
			buffer.put_character (' ')
		end

	generate_cast (buffer: GENERATION_BUFFER) is
			-- Generate C cast in `buffer'.
		require
			good_argument: buffer /= Void
		do
			buffer.put_character ('(')
			buffer.put_string (C_string)
			buffer.put_character (')')
			buffer.put_character (' ')
		end

	generate_access_cast (buffer: GENERATION_BUFFER) is
			-- Generate access C cast in `buffer'.
		require
			good_argument: buffer /= Void
			not_void_type: not is_void
		do
			buffer.put_character ('(')
			buffer.put_string (C_string)
			buffer.put_character (' ')
			buffer.put_character ('*')
			buffer.put_character (')')
		end

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate size of C type
		require
			good_argument: buffer /= Void
		do
			buffer.put_string (Sizeof)
			buffer.put_string (C_string)
			buffer.put_character (')')
		end

	generate_default_value (buffer: GENERATION_BUFFER) is
			-- Generate default value associated to current basic type.
		require
			buffer_not_void: buffer /= Void
		do
			buffer.put_two_character ('(', '(')
			buffer.put_string (c_string)
			buffer.put_four_character (')', ' ', '0', ')')
		end

	generate_function_cast (buffer: GENERATION_BUFFER; arg_types: ARRAY [STRING]; workbench_mode: BOOLEAN) is
			-- Generate C function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		do
			buffer.put_string (function_cast_string)
			buffer.put_character ('(')
			if workbench_mode and then not is_void then
				buffer.put_string (union_string)
			else
				buffer.put_string (c_string)
			end
			buffer.put_three_character (',', ' ', '(')
			buffer.put_string_array (arg_types)
			buffer.put_three_character (')', ')', ' ')
		end

	generate_external_function_cast_type (buffer: GENERATION_BUFFER; call_type: STRING; arg_types: ARRAY [STRING]) is
			-- Generate C external function cast in `buffer'.
		require
			good_arguments: buffer /= Void and arg_types /= Void
			good_array: arg_types.lower = 1
		do
			if call_type /= Void then
				buffer.put_string (function_cast_type_string)
				buffer.put_character ('(')
				buffer.put_string (c_string)
				buffer.put_character (',')
				buffer.put_string (call_type)
			else
				buffer.put_string (function_cast_string)
				buffer.put_character ('(')
				buffer.put_string (c_string)
			end
			buffer.put_three_character (',', ' ', '(')
			buffer.put_string_array (arg_types)
			buffer.put_three_character (')', ')', ' ')
		end

	generate_conversion_to_real_64 (buffer: GENERATION_BUFFER) is
			-- Generate conversion to `REAL_64', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_64.
		require
			buffer_not_void: buffer /= Void
		do
			check
				not_called: False
			end
		end

	generate_conversion_to_real_32 (buffer: GENERATION_BUFFER) is
			-- Generate conversion to `REAL_32', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_32.
		require
			buffer_not_void: buffer /= Void
		do
			check
				not_called: False
			end
		end

	frozen generate_typed_field (buffer: GENERATION_BUFFER) is
			-- Generate field of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		require
			buffer_attached: buffer /= Void
		do
			buffer.put_string (typed_field)
		end

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		require
			buffer_attached: buffer /= Void
		do
			buffer.put_string ("type = ")
			generate_sk_value (buffer)
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		require
			good_argument: buffer /= Void
		deferred
		end

feature {NONE} -- Constants

	Sizeof: STRING is "sizeof("
			-- Used for generation.

	union_string: STRING is "EIF_TYPED_VALUE"
			-- Name for union structure.

	function_cast_string: STRING is "FUNCTION_CAST"
	function_cast_type_string: STRING is "FUNCTION_CAST_TYPE";
			-- Name of different function casts.

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
