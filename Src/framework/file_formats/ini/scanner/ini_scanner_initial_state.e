note
	description: "State scanner initial state, where each line will being at."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SCANNER_INITIAL_STATE

inherit
	INI_SCANNER_STATE

feature -- Basic Operations

	scan (a_line: STRING; a_index: INTEGER)
			-- Scans `a_line' for token information and set `token' with any located
			-- token information. `next_state' will also be set to indicate what state
			-- should be processed next.
		local
			l_next_state: like next_state
			l_index: INTEGER
			c: CHARACTER
		do
			l_next_state := Current
			l_index := non_whitespace_index (a_line)
			if l_index = 1 then
				c := a_line.item (1)
				inspect c
				when {INI_SCANNER_SYMBOLS}.section_start_indicator then
					l_next_state := state_pool.state ({INI_SCANNER_OPEN_SECTION_STATE})
					set_token_info (c.out, {INI_SCANNER_TOKEN_TYPE}.section_open, a_index)
				when {INI_SCANNER_SYMBOLS}.assigner_indicator then
					l_next_state := state_pool.state ({INI_SCANNER_POST_ASSIGNER_STATE})
					set_token_info (c.out, {INI_SCANNER_TOKEN_TYPE}.assigner, a_index)
				when {INI_SCANNER_SYMBOLS}.comment_indicator then
					set_token_info (a_line, {INI_SCANNER_TOKEN_TYPE}.comment, a_index)
				else
					l_index := a_line.index_of ({INI_SCANNER_SYMBOLS}.assigner_indicator, a_index)
					if l_index > 1 then
						set_token_info (a_line.substring (1, l_index - 1), {INI_SCANNER_TOKEN_TYPE}.identifier, a_index)
					else
						set_token_info (a_line, {INI_SCANNER_TOKEN_TYPE}.identifier, a_index)
					end
					l_next_state := state_pool.state ({INI_SCANNER_POST_PROPERTY_STATE})
				end
			elseif l_index > 1 then
				set_token_info (a_line.substring (1, l_index - 1), {INI_SCANNER_TOKEN_TYPE}.whitespace, a_index)
			else
				set_token_info (a_line, {INI_SCANNER_TOKEN_TYPE}.whitespace, a_index)
			end
			next_state := l_next_state
		end

note
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

end -- class {INI_SCANNER_INITIAL_STATE}
