indexing
	description: "Real data type for code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class POINTER_I

inherit
	BASIC_I
		redefine
			same_as
		end

feature -- Access

	level: INTEGER is
			-- Internal code for generation
		do
			Result := {SHARED_C_LEVEL}.c_pointer
		end

	tuple_code: NATURAL_8 is
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.pointer_tuple_code
		end

	element_type: INTEGER_8 is
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_i
		end

	sk_value: INTEGER is
		do
			Result := {SK_CONST}.sk_pointer
		end

	c_string: STRING is
			-- String generated for the type.
		do
			 Result := pointer_string
		end

	typed_field: STRING is "it_p"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.pointer_code
		end

	new_attribute_description: POINTER_DESC is
			-- Type description for skeleton
		do
			create Result
		end

feature -- Status Report

	is_feature_pointer: BOOLEAN is True
			-- Is the type a feature pointer type ?

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		do
			ba.append ({BYTE_CONST}.Bc_null_pointer)
		end

feature -- C code generation

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ({SK_CONST}.sk_pointer_string)
		end

feature -- Comparison

	same_as (other: TYPE_C): BOOLEAN is
			-- Is Current same as other?
		do
				-- It really has to be POINTER_I, it cannot be the descendant TYPED_POINTER_I
			Result := same_type (other) and level = other.level
		end

feature {NONE} -- Constants

	pointer_string: STRING = "EIF_POINTER";

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
