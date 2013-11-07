note
	description: "A editor line, Eiffel style."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_EDITOR_LINE

inherit
	EDITOR_LINE
		redefine
			make,
			make_from_lexer,
			number_token
		end

create
	make,
	make_windows_style,
	make_unix_style,
	make_from_lexer

feature -- Initialisation

	make (a_windows_style: BOOLEAN)
			-- Create an empty line.
		local
			t_eol: EDITOR_TOKEN_EOL
			t_begin: EDITOR_TOKEN_BREAKPOINT
			t_second: EDITOR_TOKEN_LINE_NUMBER
		do
			create t_eol.make_with_style (a_windows_style)
			create t_begin.make
			create t_second.make
			t_begin.set_next_token (t_second)
			t_second.set_previous_token (t_begin)
			t_second.set_next_token (t_eol)
			t_eol.set_previous_token (t_second)

			eol_token := t_eol
			real_first_token := t_begin
			update_token_information
		end

	make_from_lexer (lexer: EDITOR_SCANNER)
			-- Create a line using token from `lexer'
		local
			t_eol				: EDITOR_TOKEN_EOL
			t_begin				: EDITOR_TOKEN_BREAKPOINT
			t_second			: EDITOR_TOKEN_LINE_NUMBER
			lexer_first_token	: EDITOR_TOKEN
			lexer_end_token		: EDITOR_TOKEN
		do
			create t_eol.make_with_style (lexer.is_windows_eol_preferred)
			create t_begin.make
			create t_second.make
			t_begin.set_next_token (t_second)
			t_second.set_previous_token (t_begin)

			lexer_end_token := lexer.end_token
			if lexer_end_token /= Void then
					-- The lexer has parsed something.
				lexer_first_token := lexer.first_token

				lexer_end_token.set_next_token (t_eol)
				t_eol.set_previous_token (lexer_end_token)
				t_second.set_next_token (lexer_first_token)
				lexer_first_token.set_previous_token (t_second)
			else
					-- We have given an empty string to the parser.
					-- He has not produced any token.
				t_second.set_next_token (t_eol)
				t_eol.set_previous_token (t_second)
			end
			real_first_token := t_begin
			eol_token := t_eol
			set_part_of_verbatim_string (lexer.in_verbatim_string)
			set_end_of_verbatim_string (lexer.end_of_verbatim_string)
			set_start_of_verbatim_string (lexer.start_of_verbatim_string)
			update_token_information
		end

feature -- Access

	breakpoint_token: EDITOR_TOKEN_BREAKPOINT
			-- Token containing the breakpoint information for the line.
		do
			Result ?= real_first_token
		end

	number_token: EDITOR_TOKEN_LINE_NUMBER
			-- Token containing the line number information for the line.
		do
			Result ?= real_first_token.next
		end

	content: LIST [EDITOR_TOKEN]
			-- Content tokens in current
			-- Breakpoint token, line number token and EOL token are not included.
		local
			l_token: EDITOR_TOKEN
		do
			create {ARRAYED_LIST [EDITOR_TOKEN]}Result.make (count)
			from
				l_token := first_token
			until
				l_token = Void or else l_token = eol_token
			loop
				Result.extend (l_token)
				l_token := l_token.next
			end
		end

invariant
	has_breakpoint_token: breakpoint_token /= Void

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class EIFFEL_EDITOR_LINE
