note
	description: "Mapping of real Eiffel types to underlying machine type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REFERENCE_I

inherit
	TYPE_C
		redefine
			is_pointer
		end

feature -- Access

	level: INTEGER
			-- Internal code for generation
		do
			Result := {SHARED_C_LEVEL}.c_ref
		end

	element_type: INTEGER_8
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_object
		end

	sk_value: NATURAL_32
		do
			Result := {SK_CONST}.sk_ref
		end

	c_string: STRING = "EIF_REFERENCE"
			-- String generated for the type.

	typed_field: STRING = "it_r"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.reference_code
		end

feature -- Status report

	is_pointer: BOOLEAN = True
			-- The C type is a reference type.

feature -- C code generation

	generate_sk_value (buffer: GENERATION_BUFFER)
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ({SK_CONST}.sk_ref_string)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
