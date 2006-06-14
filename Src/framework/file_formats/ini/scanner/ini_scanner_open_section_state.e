indexing
	description: "State scanner state when scanner passed a section opener '['."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SCANNER_OPEN_SECTION_STATE

inherit
	INI_SCANNER_STATE

feature -- Basic Operations

	scan (a_line: STRING; a_index: INTEGER) is
			-- Scans `a_line' for token information and set `token' with any located
			-- token information. `next_state' will also be set to indicate what state
			-- should be processed next.
		local
			l_next_state: like next_state
			l_index: INTEGER
			c: CHARACTER
		do
			l_next_state := Current
			c := a_line.item (1)
			if c = {INI_SCANNER_SYMBOLS}.section_end_indicator then
				set_token_info (c.out, {INI_SCANNER_TOKEN_TYPE}.section_close, a_index)
				l_next_state := state_pool.state ({INI_SCANNER_INITIAL_STATE})
			elseif a_line.count > 1 then
				l_index := a_line.index_of ({INI_SCANNER_SYMBOLS}.section_end_indicator, 2)
				if l_index > 1 then
					set_token_info (a_line.substring (1, l_index - 1), {INI_SCANNER_TOKEN_TYPE}.section_label, a_index)
				else
					set_token_info (a_line, {INI_SCANNER_TOKEN_TYPE}.section_label, a_index)
				end
			else
					-- Unknown token
				set_token_info (c.out, {INI_SCANNER_TOKEN_TYPE}.unknown, a_index)
			end
			next_state := l_next_state
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {INI_SCANNER_OPEN_SECTION_STATE}
