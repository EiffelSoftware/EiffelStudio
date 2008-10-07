indexing
	description: "[
			A feature's if block editor analyzer's state, used in processing tokens between if..end tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_IF_BLOCK_STATE

inherit
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE
		redefine
			is_valid_start_token
		end

feature -- Status report

	is_valid_start_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_token, a_line) and then is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.if_keyword)
		end

feature {NONE} -- Status report

	is_if_or_elseif_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a token is an if or elseif keyword token.
			--
			-- `a_token': Token to check for an if/elseif token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is an if or elseif token; False otherwise.
		do
			if {l_keyword: EDITOR_TOKEN_KEYWORD} a_token then
				Result := is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.if_keyword) or else
					is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.elseif_keyword)
			end
		ensure
			is_if_or_elseif: Result implies (is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.if_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.elseif_keyword))
		end

	is_then_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a token is a single then keyword token.
			--
			-- `a_token': Token to check for a then token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is an if or elseif token; False otherwise.
		local
			l_prev: ?like previous_text_token
		do
			if {l_keyword: EDITOR_TOKEN_KEYWORD} a_token then
				if is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.then_keyword) then
						-- It's a then token, but be sure there are no kewords before the then token,
						-- like 'and' or 'ensure'.
					l_prev := previous_text_token (a_token, a_line, True, Void)
						-- There is another keyword, which means it's not a single 'then' end token.
					Result := l_prev = Void or else not is_keyword_token (l_prev.token, {EIFFEL_KEYWORD_CONSTANTS}.not_keyword)
				end
			end
		ensure
			is_if_or_elseif: Result implies is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.then_keyword)
		end

	is_object_test_start_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a token is an object test start token.
			--
			-- `a_token': Token to check for an object test token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is an object test start token; False otherwise.
		do
			Result := is_text_token (a_token, "{", False)
		ensure
			is_object_test_start_token: Result implies is_text_token (a_token, "{", False)
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: !ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_end_token: ?EDITOR_TOKEN)
			-- <Precursor>
		local
			l_start_token: !EDITOR_TOKEN
			l_start_line: !EDITOR_LINE
			l_current_frame: !ES_EDITOR_ANALYZER_FRAME
			l_then_token: ?EDITOR_TOKEN
			l_block_matcher: !like block_matcher
			l_brace_matcher: !like brace_matcher
			l_match: ?like next_token
			l_next: ?like next_token
			l_next_then: ?like next_token
			l_local_list_state: !like local_list_state
			l_stop: BOOLEAN
		do
			l_start_token := a_info.current_token
			l_start_line := a_info.current_line

			l_block_matcher := block_matcher
			check l_start_token_is_opening_brace: l_block_matcher.is_opening_brace (l_start_token) end
			l_match := l_block_matcher.match_opening_brace (l_start_token, l_start_line, a_end_token)
			if l_match = Void then
				l_brace_matcher := brace_matcher
				l_current_frame := a_info.current_frame

					-- Iterate block to find object tests.
				from until l_stop loop
					check
						l_start_token_is_start_token: is_if_or_elseif_token (l_start_token, l_start_line)
					end

						-- Search for a then token so we can limit the scope when searching for an object test.
					l_next_then := next_token (l_start_token, l_start_line, True, a_end_token, agent is_then_token (?, ?))
					if l_next_then /= Void then
							-- A then keyword was found, use it as the terminating token when looking for an object test.
						l_then_token := l_next_then.token
					else
							-- No then token, so use the previous set end token.
						l_then_token := a_end_token
					end

						-- Search for all object tests
					l_local_list_state := local_list_state
					from until l_stop loop
							-- Check for an object test between the if...then (or the passed end token if no then was found) keywords.
						l_next := next_token (l_start_token, l_start_line, True, l_then_token, agent is_object_test_start_token (?, ?))
						if l_next /= Void then
							if l_local_list_state.is_valid_start_token (l_next.token, l_next.line) then
								a_info.set_current_line (l_next.line, l_next.token)
								l_local_list_state.process (a_info, l_then_token)
								if l_then_token /~ a_end_token then
									l_start_token := a_info.current_token
									l_start_line := a_info.current_line
								else
									l_stop := True
								end
							else
									-- Why is the token not a valid local list block start token?
								check False end
							end
						else
							l_stop := True
						end
					end
					if l_then_token /~ a_end_token then
						l_start_token := l_next_then.token
						l_start_line := l_next_then.line
						l_stop := False
					elseif l_stop then
							-- There was no next token above so the actual end token was reached.
						a_info.has_runout := True
					end
					a_info.set_current_line (l_start_line, l_start_token)

					from until l_stop or else a_info.has_runout loop
							-- Look for nested ifs or adjectent elseifs
						l_next := next_token (l_start_token, l_start_line, True, a_end_token, agent is_if_or_elseif_token (?, ?))
						if l_next /= Void then
							l_start_token := l_next.token
							l_start_line := l_next.line

							a_info.set_current_line (l_start_line, l_start_token)
							if is_keyword_token (l_start_token, {EIFFEL_KEYWORD_CONSTANTS}.if_keyword) then
									-- Recurse into next if.
								a_info.increment_current_frame (False)
									-- Duplicate current so we are using the same state processing type.
								Current.twin.process (a_info, a_end_token)
								l_start_token := a_info.current_token
								l_start_line := a_info.current_line
								if not a_info.has_runout then
										-- We are continuing which means we need to pop the previous frame because it wont be used.
									a_info.decrement_current_frame
								end

									-- fetch the next frame in case it has changed.
								l_current_frame := a_info.current_frame
							else
									-- Must be an elseif, perform next iteration
								l_stop := True
							end
						else
								-- No more tokens to process.
							a_info.has_runout := True
						end
					end
					l_stop := a_info.has_runout
				end
			else
					-- There was a matching end to the if block, which means the context does not reside in this if block - skip it.
				a_info.set_current_line (l_match.line, l_match.token)
			end
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
