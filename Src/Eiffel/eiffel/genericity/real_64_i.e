note
	description: "Mapping of real Eiffel types to underlying machine type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	REAL_64_I

inherit
	BASIC_I

feature -- Access

	level: INTEGER
			-- Internal code for generation
		do
			Result := {SHARED_C_LEVEL}.C_real64
		end

	tuple_code: NATURAL_8
			-- Tuple code for class type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.real_64_tuple_code
		end

	element_type: INTEGER_8
			-- Pointer element type
		do
			Result := {MD_SIGNATURE_CONSTANTS}.Element_type_r8
		end
	sk_value: NATURAL_32
		do
			Result := {SK_CONST}.sk_real64
		end

	c_string: STRING
			-- String generated for the type.
		do
			Result := {C_CONST}.eif_real_64
		end

	typed_field: STRING = "it_r8"
			-- Value field of a C structure corresponding to this type

	hash_code: INTEGER
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.real_64_code
		end

	new_attribute_description: REAL_64_DESC
			-- Type description for skeleton
		do
			create Result
		end

feature -- Byte code generation

	make_default_byte_code (ba: BYTE_ARRAY)
			-- Generate default value of basic type on stack.
		do
			ba.append ({BYTE_CONST}.Bc_real64)
			ba.append_double (0.0)
		end

feature -- C code generation

	generate_sk_value (buffer: GENERATION_BUFFER)
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ({SK_CONST}.sk_real64_string)
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
