note
	description: "Enlarged node for attribute access in workbench mode."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class ATTRIBUTE_BW

inherit

	ATTRIBUTE_BL
		redefine
			generate_access_on_type,
			is_polymorphic
		end

create
	fill_from,
	fill_from_access

feature -- C code generation

	is_polymorphic: BOOLEAN = True
			-- Is the attribute access polymorphic?

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate attribute access in a `typ' context
		local
			is_nested: BOOLEAN
			type_i: TYPE_A
			buf: GENERATION_BUFFER
		do
			if not reg.c_type.is_reference then
					-- An access on an object of basic type is its value.
				reg.print_register
			else
				buf := buffer
				is_nested := not is_first
				type_i := real_type (type)
				if not type_i.is_true_expanded then
						-- For dereferencing, we need a star...
					buf.put_character ('*')
						-- ...followed by the appropriate access cast
					type_i.c_type.generate_access_cast (buf)
				end
				buf.put_character ('(')
				reg.print_register
				buf.put_two_character (' ', '+')
				if reg.is_predefined or reg.register /= No_register then
					buf.put_character (' ')
				else
					buf.put_new_line
				end
				buf.indent
				buf.put_string (if is_nested then "RTVA(" else"RTWA(" end)
				buf.put_integer (routine_id)
				buf.put_string ({C_CONST}.comma_space)
				if is_nested then
					buf.put_string_literal (attribute_name)
					buf.put_string ({C_CONST}.comma_space)
					reg.print_register
				else
					context.generate_current_dtype
				end
				buf.put_string ("))")
				buf.exdent
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
