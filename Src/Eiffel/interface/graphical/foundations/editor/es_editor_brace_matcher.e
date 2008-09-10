indexing
	description: "[
			Supports brace match scanning functionality in the editor.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_BRACE_MATCHER

inherit
	ES_EDITOR_TOKEN_UTILITIES

feature -- Access

	opening_brace_map: !HASH_TABLE [!STRING_32, !STRING_32]
			-- Map of open to close braces.
		once
			create Result.make (4)
			Result.put (create {STRING_32}.make_from_string (")"), create {STRING_32}.make_from_string ("("))
			Result.put (create {STRING_32}.make_from_string ("]"), create {STRING_32}.make_from_string ("["))
			Result.put (create {STRING_32}.make_from_string ("}"), create {STRING_32}.make_from_string ("{"))
			Result.put (create {STRING_32}.make_from_string (">>"), create {STRING_32}.make_from_string ("<<"))
		end

	closing_brace_map: !HASH_TABLE [!STRING_32, !STRING_32]
			-- Map of close to open braces.
		once
			create Result.make (4)
			Result.put (create {STRING_32}.make_from_string ("("), create {STRING_32}.make_from_string (")"))
			Result.put (create {STRING_32}.make_from_string ("["), create {STRING_32}.make_from_string ("]"))
			Result.put (create {STRING_32}.make_from_string ("{"), create {STRING_32}.make_from_string ("}"))
			Result.put (create {STRING_32}.make_from_string ("<<"), create {STRING_32}.make_from_string (">>"))
		end

feature -- Status report

	frozen is_opening_brace (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is an opening brace token.
			--
			-- `a_token': The token to determine brace applicability for.
			-- `Result': True if the supplied token is an opening brace token; False otherwise.
		local
			l_image: ?STRING_32
		do
			if {l_symbol: EDITOR_TOKEN_TEXT} a_token then
				l_image := a_token.wide_image
				if l_image /= Void and then not l_image.is_empty then
					Result := opening_brace_map.has (l_image)
				else
						-- Why is the image Void or empty?
					check False end
				end
			end
		ensure
			token_image_is_opening_brace: Result implies opening_brace_map.has (({!STRING_32}) #? a_token.wide_image)
		end

	frozen is_closing_brace (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is an closing brace token.
			--
			-- `a_token': The token to determine brace applicability for.
			-- `Result': True if the supplied token is an closing brace token; False otherwise.
		local
			l_image: ?STRING_32
		do
			if {l_symbol: EDITOR_TOKEN_TEXT} a_token then
				l_image := a_token.wide_image
				if l_image /= Void and then not l_image.is_empty then
					Result := closing_brace_map.has (l_image)
				else
						-- Why is the image Void or empty?
					check False end
				end
			end
		ensure
			token_image_is_opening_brace: Result implies closing_brace_map.has (({!STRING_32}) #? a_token.wide_image)
		end

	frozen is_brace (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is an opening or closing brace token.
			--
			-- `a_token': The token to determine brace applicability for.
			-- `Result': True if the supplied token is an brace token; False otherwise.
		do
			Result := is_opening_brace (a_token) or else is_closing_brace (a_token)
		ensure
			a_token_is_opening_or_closing_brace: Result implies (is_opening_brace (a_token) or else is_closing_brace (a_token))
		end

feature -- Query

	match_brace (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for a matching brace, automatically navigating backwards/forwards based on the brace symbol.
			--
			-- `a_token': The token on the supplied line to find the previous token to.
			-- `a_line': The line where the supplied token is resident.
			-- `Result': A resulting token and resident line, or Void if no previous token exists.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			a_token_is_brace: is_brace (a_token)
		do
			if is_opening_brace (a_token) then
					-- Move forward to match a opening brace with a closing brace.
				Result := match_opening_brace (a_token, a_line)
			elseif is_closing_brace (a_token) then
					-- Move backwards to match a closing brace with a open brace.
				Result := match_closing_brace (a_token, a_line)
			else
				check False end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

	match_opening_brace (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for a next open matching (closing) brace.
			--
			-- `a_token': The token on the supplied line to find the previous token to.
			-- `a_line': The line where the supplied token is resident.
			-- `Result': A resulting token and resident line, or Void if no previous token exists.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			a_token_is_opening_brace: is_opening_brace (a_token)
		local
			l_image: ?STRING_32
			l_match: ?STRING_32
			l_next: ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			l_stop: BOOLEAN
		do
			l_image := a_token.wide_image

				-- Move forward to match a opening brace with a closing brace.
			if l_image /= Void then
				l_match := opening_brace_map.item (l_image)
				if l_match /= Void then
					l_next := [a_token, a_line]
					from until l_stop loop
							-- Locate next brace token.
						l_next := next_token (l_next.token, l_next.line,
							agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE): BOOLEAN
								do
									Result := is_brace (ia_token)
								end)

						if l_next /= Void then
								-- A new brace token is found, check it's not
							if is_opening_brace (l_next.token) then
									-- Recursively find the next closing brace.
								l_next := match_opening_brace (l_next.token, l_next.line)
								l_stop := l_next = Void
							elseif is_closing_brace (l_next.token) then
									-- A closing brace is located
								if l_next.token.wide_image.is_equal (l_match) then
										-- The correct closing brace is matched
									Result := l_next
								else
										-- There must be syntax error, because an alternative closing brace was located.
								end
								l_stop := True
							end
						else
								-- No next token exists.
							l_stop := True
						end
					end
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_is_closing_brace: Result /= Void implies is_closing_brace (Result.token)
			result_is_correct_match: Result /= Void implies opening_brace_map.item (
				({!STRING_32}) #? a_token.wide_image).is_equal (({!STRING_32}) #? Result.token.wide_image)
		end

	match_closing_brace (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for a previous closing matching (opening) brace.
			--
			-- `a_token': The token on the supplied line to find the previous token to.
			-- `a_line': The line where the supplied token is resident.
			-- `Result': A resulting token and resident line, or Void if no previous token exists.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			a_token_is_closing_brace: is_closing_brace (a_token)
		local
			l_image: ?STRING_32
			l_match: ?STRING_32
			l_prev: ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			l_stop: BOOLEAN
		do
			l_image := a_token.wide_image

				-- Move forward to match a opening brace with a closing brace.
			if l_image /= Void then
				l_match := closing_brace_map.item (l_image)
				if l_match /= Void then
					l_prev := [a_token, a_line]
					from until l_stop loop
							-- Locate previous brace token.
						l_prev := previous_token (l_prev.token, l_prev.line,
							agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE): BOOLEAN
								do
									Result := is_brace (ia_token)
								end)

						if l_prev /= Void then
								-- A new brace token is found, check it's not
							if is_closing_brace (l_prev.token) then
									-- Recursively find the previous opening brace.
								l_prev := match_closing_brace (l_prev.token, l_prev.line)
								l_stop := l_prev = Void
							elseif is_opening_brace (l_prev.token) then
									-- A opening brace is located
								if l_prev.token.wide_image.is_equal (l_match) then
										-- The correct opening brace is matched
									Result := l_prev
								else
										-- There must be syntax error, because an alternative opeing brace was located.
								end
								l_stop := True
							end
						else
								-- No previous token exists.
							l_stop := True
						end
					end
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_is_opening_brace: Result /= Void implies is_opening_brace (Result.token)
			result_is_correct_match: Result /= Void implies closing_brace_map.item (
				({!STRING_32}) #? a_token.wide_image).is_equal (({!STRING_32}) #? Result.token.wide_image)
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
