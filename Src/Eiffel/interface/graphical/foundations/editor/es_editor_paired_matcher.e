indexing
	description: "[
			Supports brace match scanning functionality in the editor.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EDITOR_PAIRED_MATCHER

inherit
	ES_EDITOR_TOKEN_UTILITIES

feature -- Access

	opening_brace_map: !HASH_TABLE [!STRING_32, !STRING_32]
			-- Map of open to close braces.
			--
			--| Note: Implement as a once!
		deferred
		end

	closing_brace_map: !HASH_TABLE [!ARRAY [!STRING_32], !STRING_32]
			-- Map of close to open braces.
		do
			if {l_result: HASH_TABLE [!ARRAY [!STRING_32], !STRING_32]} internal_closing_brace_map then
				Result := l_result
			else
				Result := reserve_opening_brace_map (opening_brace_map)
				internal_closing_brace_map := Result
			end
		end

feature -- Status report

	is_opening_brace (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is an opening brace token.
			--
			-- `a_token': The token to determine brace applicability for.
			-- `Result' : True if the supplied token is an opening brace token; False otherwise.
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

	is_closing_brace (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is an closing brace token.
			--
			-- `a_token': The token to determine brace applicability for.
			-- `Result' : True if the supplied token is an closing brace token; False otherwise.
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
			-- `Result' : True if the supplied token is an brace token; False otherwise.
		do
			Result := is_opening_brace (a_token) or else is_closing_brace (a_token)
		ensure
			a_token_is_opening_or_closing_brace: Result implies (is_opening_brace (a_token) or else is_closing_brace (a_token))
		end

feature {NONE} -- Status report

	is_opening_match_exception (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a matching opening token is an exception to the rule when paired with a closing brace.
			--
			-- `a_token': An open brace token to determine exception status for.
			-- `a_line': The line the supplied token is resident.
			-- `Result': True if the token should be a regular token; False to treat as a opening brace.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			a_token_is_opening_brace: is_opening_brace (a_token)
		do
			Result := False
		end

	is_closing_match_exception (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a matching closing token is an exception to the rule when paired with a opening brace.
			--
			-- `a_token': A closing brace token to determine exception status for.
			-- `a_line': The line the supplied token is resident.
			-- `Result': True if the token should be a regular token; False to treat as a closing brace.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			a_token_is_closing_brace: is_closing_brace (a_token)
		do
			Result := False
		end

feature -- Query

	match_brace (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: ?EDITOR_TOKEN): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for a matching brace, automatically navigating backwards/forwards based on the brace symbol.
			--
			-- `a_start_token': The token on the supplied line to find the previous token to.
			-- `a_start_line' : The line where the supplied token is resident.
			-- `a_end_token'  : An optional token to stop scanning at.
			-- `Result'       : A resulting token and resident line, or Void if no previous token exists.
		require
			a_start_line_has_a_start_token: a_start_line.has_token (a_start_token)
			a_start_token_is_brace: is_brace (a_start_token)
		do
			if is_opening_brace (a_start_token) then
					-- Move forward to match a opening brace with a closing brace.
				Result := match_opening_brace (a_start_token, a_start_line, a_end_token)
			elseif is_closing_brace (a_start_token) then
					-- Move backwards to match a closing brace with a open brace.
				Result := match_closing_brace (a_start_token, a_start_line, a_end_token)
			else
				check False end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

	match_opening_brace (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: ?EDITOR_TOKEN): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for a next open matching (closing) brace.
			--
			-- `a_start_token': The token on the supplied line to find the previous token to.
			-- `a_start_line' : The line where the supplied token is resident.
			-- `a_end_token'  : An optional token to stop scanning at.
			-- `Result'       : A resulting token and resident line, or Void if no previous token exists.
		require
			a_start_line_has_a_start_token: a_start_line.has_token (a_start_token)
			a_start_token_is_opening_brace: is_opening_brace (a_start_token)
		local
			l_image: ?STRING_32
			l_match: ?STRING_32
			l_next: ?like next_token
			l_stop: BOOLEAN
		do
			if a_start_token /~ a_end_token and then not is_opening_match_exception (a_start_token, a_start_line) then
				l_image := a_start_token.wide_image

					-- Move forward to match a opening brace with a closing brace.
				if l_image /= Void then
					l_match := opening_brace_map.item (l_image)
					if l_match /= Void then
						l_next := [a_start_token, a_start_line]
						from until l_stop loop
								-- Locate next brace token.
							l_next := next_token (l_next.token, l_next.line, True,
								agent (ia_start_token: !EDITOR_TOKEN; ia_start_line: !EDITOR_LINE; ia_end_token: ?EDITOR_TOKEN): BOOLEAN
									do
										Result := is_brace (ia_start_token) or else ia_start_token ~ ia_end_token
									end (?, ?, a_end_token))
							if l_next /= Void and then {l_text: EDITOR_TOKEN_TEXT} l_next.token then
									-- A new brace token is found, check it's not
								if is_opening_brace (l_text) then
									if not is_opening_match_exception (l_text, l_next.line) then
											-- Recursively find the next closing brace.
										l_next := match_opening_brace (l_text, l_next.line, a_end_token)
										l_stop := l_next = Void
									end
								elseif is_closing_brace (l_text) then
										-- A closing brace is located
									if l_text.wide_image.is_equal (l_match) then
										if not is_closing_match_exception (l_text, l_next.line) then
												-- The correct closing brace is matched
											Result := [l_text, l_next.line]
											l_stop := True
										end
									else
											-- There must be syntax error, because an alternative closing brace was located.
										l_stop := True
									end
								else
										-- This happens then the matching end token was matched
									l_stop := True
								end
							else
									-- No next token exists.
								l_stop := True
							end
						end
					end
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_is_closing_brace: Result /= Void implies is_closing_brace (Result.token)
			result_is_correct_match: Result /= Void implies opening_brace_map.item (
				({!STRING_32}) #? a_start_token.wide_image).is_equal (({!STRING_32}) #? Result.token.wide_image)
		end

	match_closing_brace (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: ?EDITOR_TOKEN): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for a previous closing matching (opening) brace.
			--
			-- `a_start_token': The token on the supplied line to find the previous token to.
			-- `a_start_line' : The line where the supplied token is resident.
			-- `a_end_token'  : An optional token to stop scanning at.
			-- `Result'       : A resulting token and resident line, or Void if no previous token exists.
		require
			a_start_line_has_a_start_token: a_start_line.has_token (a_start_token)
			a_start_token_is_closing_brace: is_closing_brace (a_start_token)
		local
			l_image: ?STRING_32
			l_match_image: ?STRING_32
			l_matches: ?ARRAY [!STRING_32]
			l_prev: ?like previous_token
			l_stop: BOOLEAN
		do
			if a_start_token /~ a_end_token then
				l_image := a_start_token.wide_image

					-- Move forward to match a opening brace with a closing brace.
				if l_image /= Void then
					l_matches := closing_brace_map.item (l_image)
					if l_matches /= Void then
						check l_matches_compares_objects: l_matches.object_comparison end

						l_prev := [a_start_token, a_start_line]
						from until l_stop loop
								-- Locate previous brace token.
							l_prev := previous_token (l_prev.token, l_prev.line, True,
								agent (ia_start_token: !EDITOR_TOKEN; ia_start_line: !EDITOR_LINE; ia_end_token: ?EDITOR_TOKEN): BOOLEAN
									do
										Result := (ia_start_token.is_text and then is_brace (ia_start_token)) or else ia_start_token ~ ia_end_token
									end (?, ?, a_end_token))
							if l_prev /= Void and then {l_text: EDITOR_TOKEN_TEXT} l_prev.token then
									-- A new brace token is found, check it's not
								if is_closing_brace (l_text) then
									if not is_closing_match_exception (l_text, l_prev.line) then
											-- Recursively find the previous opening brace.
										l_prev := match_closing_brace (l_text, l_prev.line, a_end_token)
										l_stop := l_prev = Void
									end
								elseif is_opening_brace (l_text) then
										-- A opening brace is located
									l_match_image := l_text.wide_image
									if l_match_image /= Void and then l_matches.has (l_match_image) then
										if not is_opening_match_exception (l_text, l_prev.line) then
												-- The correct opening brace is matched
											Result := [l_text, l_prev.line]
											l_stop := True
										else
											-- Keep going, the match wasn't applicable.
										end
									else
											-- There must be syntax error, because an alternative opeing brace was located.
										l_stop := True
									end
								else
										-- This happens then the matching end token was matched
									l_stop := True
								end
							else
									-- No previous token exists.
								l_stop := True
							end
						end
					end
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_is_opening_brace: Result /= Void implies is_opening_brace (Result.token)
			result_is_correct_match: Result /= Void implies closing_brace_map.item (
				({!STRING_32}) #? a_start_token.wide_image).has (({!STRING_32}) #? Result.token.wide_image)
		end

feature {NONE} -- Query

	reserve_opening_brace_map (a_map: !HASH_TABLE [!STRING_32, !STRING_32]): !HASH_TABLE [!ARRAYED_LIST [!STRING_32], !STRING_32]
			-- Reverses and opening map to retrieve a closing map.
			--
			-- `a_map': An opening map to reverse.
			-- `Result': The reserved closing map.
		local
			l_key: !STRING_32
			l_value: !STRING_32
			l_list: !ARRAYED_LIST [!STRING_32]
			l_cursor: CURSOR
		do
			create Result.make (a_map.count)
			if not a_map.is_empty then
				l_cursor := a_map.cursor
				from a_map.start until a_map.after loop
					l_key := a_map.key_for_iteration
					l_value := a_map.item_for_iteration
					if Result.has (l_value) then
						l_list := Result.item (l_value)
					else
						create l_list.make (1)
						l_list.compare_objects
						Result.put (l_list, l_value)
					end
					l_list.extend (l_key)
					a_map.forth
				end
				a_map.go_to (l_cursor)
			end
		ensure
			a_map_unmoved: a_map.cursor.is_equal (old a_map.cursor)
		end

feature {NONE} -- Implementation: Internal cache

	internal_closing_brace_map: ?like closing_brace_map
			-- Cached version of `closing_brace_map'
			-- Note: Do not use directly!

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
