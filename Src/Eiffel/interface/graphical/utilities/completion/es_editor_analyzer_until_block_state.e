note
	description: "[
			feature's if block editor analyzer's state, used in processing tokens between until .. loop ..end tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_UNTIL_BLOCK_STATE

inherit
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE
		redefine
			is_valid_start_token
		end

feature -- Status report

	is_valid_start_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_token, a_line) and then is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.until_keyword)
		end

feature {NONE} -- Status report

	is_loop_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- Determines if a token is a loop keyword token.
			--
			-- `a_token': Token to check for an loop token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is an until or loop token; False otherwise.
		do
			if attached {EDITOR_TOKEN_KEYWORD} a_token as l_keyword then
				Result := is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.loop_keyword)
			end
		ensure
			is_until_or_loop: Result implies is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.loop_keyword)
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_end_token: detachable EDITOR_TOKEN)
			-- <Precursor>
		local
			l_start_token: EDITOR_TOKEN
			l_start_line: EDITOR_LINE
			l_until_closure_token: detachable EDITOR_TOKEN
			l_until_closure_line: detachable EDITOR_LINE
			l_next_state: ES_EDITOR_ANALYZER_COMPOUND_STATE
			l_next: like next_token
			l_local_list_state: like local_list_state
		do
			l_start_token := a_info.current_token
			l_start_line := a_info.current_line

				-- Search for a until token so we can limit the scope when searching for an object test.
			l_next := next_token (l_start_token, l_start_line, True, a_end_token, agent is_loop_token (?, ?))
			if l_next /= Void and then is_keyword_token (l_next.token, {EIFFEL_KEYWORD_CONSTANTS}.loop_keyword) then
					-- A loop keyword was found, use it as end token.
				l_until_closure_token := l_next.token
				l_until_closure_line := l_next.line
			else
					-- No token, so use the previous set end token.
					-- we should be in the `until-loop' part
				l_until_closure_token := a_end_token
			end

			--| Find local with scope on body
			l_local_list_state := local_list_state
			process_next_object_test_locals (a_info, l_start_token, l_start_line, l_until_closure_token, a_end_token, l_local_list_state)
			l_next := token_line_data (a_info.current_token, a_info.current_line)

			--| END: Find local with scope on body

			if l_until_closure_token /~ a_end_token then
				if l_next.token /~ l_until_closure_token and then l_until_closure_line /= Void then
					--| we are in the until clause, but it is likely
					--| to be no more object test, or any local impacting
					--| the loop's body.
					--| This is then safe to "skip" to the "loop" token
					a_info.set_current_line (l_until_closure_line, l_until_closure_token)
				else
					a_info.set_current_line (l_next.line, l_next.token)
				end
				a_info.increment_current_frame (False)
				create l_next_state
				l_next_state.process (a_info, a_end_token)
					-- Need to check for end token...
--				if not a_info.has_runout then
--					a_info.decrement_current_frame
--				end
			elseif l_next /= Void and then l_next.token /~ a_end_token then
				--| the completion cursor is not yet reached, let's process remaining tokens
				a_info.has_runout := True
			else
				--| There was no next token above so the actual end token was reached.
				a_info.has_runout := True
			end
		end

;note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
