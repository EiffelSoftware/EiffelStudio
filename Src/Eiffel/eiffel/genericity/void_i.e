indexing
	description: "Mapping of real Eiffel types to underlying machine type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VOID_I

inherit
	TYPE_C
		redefine
			is_void
		end

feature -- Access

	level: INTEGER is
			-- Internal type value for generation
		do
			Result := {SHARED_C_LEVEL}.c_void
		end

	element_type: INTEGER_8 is
		do
			Result := {MD_SIGNATURE_CONSTANTS}.element_type_void
		end

	sk_value: INTEGER is
		do
			Result := {SK_CONST}.sk_void
		end

	c_string: STRING is "void"
			-- String generated for the type.

	typed_field: STRING is
			-- Value field of a C structure corresponding to this type
		do
				-- Dummy value to fullfil inherited contract to cause
				-- a syntax error at C compilation time instead of a
				-- crash during compilation.
			Result := "it_v"
		ensure then
			False
		end

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.void_code
		end

feature -- Status Report

	is_void: BOOLEAN is True
			-- Type is a void one

feature -- C code generation

	generate_sk_value (buffer: GENERATION_BUFFER) is
			-- Generate SK value associated to current C type in `buffer'.
		do
			buffer.put_string ({SK_CONST}.sk_void_string)
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
