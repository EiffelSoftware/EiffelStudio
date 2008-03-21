indexing
	description: "[
		Used to render code templates to a string.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TEMPLATE_STRING_RENDERER

inherit
	CODE_TEMPLATE_RENDERER
		redefine
			is_interface_usable,
			reset
		end

feature -- Access

	code: ?STRING_32
			-- The rendered code.

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {CODE_TEMPLATE_RENDERER} and then (code /= Void)
		ensure then
			code_attached: Result implies code /= Void
		end

feature {NONE} -- Basic operations

	reset
			-- <Precursor>
		do
			Precursor {CODE_TEMPLATE_RENDERER}
			create code.make_empty
		ensure then
			code_attached: code /= Void
			code_is_empty: code.is_empty
		end

feature {CODE_TOKEN} -- Processing

	process_code_token_cursor (a_value: !CODE_TOKEN_CURSOR)
			-- <Precursor>
		do
		end

	process_code_token_eol (a_value: !CODE_TOKEN_EOL)
			-- <Precursor>
		do
			code.append_character ('%N')
		end

	process_code_token_id (a_value: !CODE_TOKEN_ID) is
			-- <Precursor>
		local
			l_table: like symbol_table
		do
			l_table := symbol_table
			if {l_id: !STRING_8} a_value.text.as_string_8 then
				if l_table.has_id (l_id) then
					code.append (l_table.item (l_id).value)
				else
					code.append (a_value.printable_text)
				end
			end
		end

	process_code_token_id_ref (a_value: !CODE_TOKEN_ID_REF)
			-- <Precursor>
		do
			process_code_token_id (a_value.code_token_id)
		end

	process_code_token_text (a_value: !CODE_TOKEN_TEXT)
			-- <Precursor>
		do
			code.append (a_value.printable_text)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
