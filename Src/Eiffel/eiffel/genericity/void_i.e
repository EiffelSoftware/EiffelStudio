indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class VOID_I

inherit
	TYPE_I
		redefine
			is_void, same_as
		end

	TYPE_C
		export
			{NONE} generate_access_cast
		undefine
			is_bit
		redefine
			is_void
		end

	SHARED_C_LEVEL

	SHARED_TYPES
		rename
			none_type as none_type_a
		export
			{NONE} all
		end

feature -- Status report

	element_type: INTEGER_8 is
			-- Void element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_void
		end

	tuple_code: INTEGER_8 is
			-- Code for Void.
		do
			-- Nothing
		end

feature

	level: INTEGER is
			-- Internal type value for generation
		do
			Result := C_void
		end

	c_type: TYPE_C is
			-- C type
		do
			Result := Current
		end

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class type.
		once
			Result := name
		end

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' the equal to Current ?
		do
			Result := other.is_void
		end

	is_void: BOOLEAN is True
			-- Type is a void one

	description: ATTR_DESC is
		do
			Result := Reference_c_type.description
		end

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate Cecil type value.
		do
			generate_sk_value (buffer)
		ensure then
			False
		end

	name, c_string: STRING is "void"
			-- String generated for the type.

	typed_field: STRING is
			-- Value field of a C structure corresponding to this type
		do
		ensure then
			False
		end

	hash_code: INTEGER is
			-- Hash code for current type
		once
			Result := {SHARED_HASH_CODE}.void_code
		end

	sk_value: INTEGER is
			-- Generate SK value associated to the current type.
		do
			Result := Sk_void
		end

	generate_typed_tag (buffer: GENERATION_BUFFER) is
			-- Generate tag of C structure "EIF_TYPED_VALUE" associated
			-- to the current C type in `buffer'.
		do
		ensure then
			False
		end

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ("SK_VOID")
		end

	type_a: TYPE_A is
		do
			Result := void_type
		end

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
