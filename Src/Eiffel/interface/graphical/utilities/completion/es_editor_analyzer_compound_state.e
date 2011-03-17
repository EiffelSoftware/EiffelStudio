note
	description: "[
			A feature body's editor analyzer's state, used in processing tokens between do..end tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_COMPOUND_STATE

inherit
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE
		redefine
			is_valid_start_token
		end

feature -- Status report

	is_valid_start_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_token, a_line) and then (
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.then_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.loop_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.from_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.until_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.all_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.some_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.invariant_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.variant_keyword)
				)
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_end_token: detachable EDITOR_TOKEN)
			-- <Precursor>
		local
			l_token: EDITOR_TOKEN
			l_line: EDITOR_LINE
			l_next: like next_token
			l_prev: like next_token
			l_state: ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_FEATURE_STATE_INFO]
			l_stop: BOOLEAN

			l_block_matcher: like block_matcher
			l_match: detachable TUPLE [token: EDITOR_TOKEN; line: EDITOR_LINE]
		do
			l_block_matcher := block_matcher

			l_token := a_info.current_token
			l_line := a_info.current_line
			from until l_stop loop
				l_next := next_token (l_token, l_line, True, a_end_token,
					agent (ia_start_token: EDITOR_TOKEN; ia_start_line: EDITOR_LINE): BOOLEAN
							-- Locate an if or across or from token.
						do
							Result := is_keyword_token (ia_start_token, {EIFFEL_KEYWORD_CONSTANTS}.if_keyword) or else
								is_keyword_token (ia_start_token, {EIFFEL_KEYWORD_CONSTANTS}.until_keyword)  or else
								is_keyword_token (ia_start_token, {EIFFEL_KEYWORD_CONSTANTS}.across_keyword) or else
								is_keyword_token (ia_start_token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword)
						end)

				if l_next /= Void then
					a_info.has_runout := False
					l_token := l_next.token
					l_line := l_next.line

						-- Check to see if we can skip this entire block.
					if l_block_matcher.is_opening_brace (l_token) then
						l_match := l_block_matcher.match_opening_brace (l_token, l_line, a_end_token)
					else
						l_match := Void
					end
					if l_match = Void then
							-- Perform nested analysis on if/across.
						a_info.current_frame.wipe_out_locals
						a_info.set_current_line (l_line, l_token)
						a_info.increment_current_frame (False)
						if is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.if_keyword) then
							create {ES_EDITOR_ANALYZER_IF_BLOCK_STATE} l_state
						elseif is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.until_keyword) then
							create {ES_EDITOR_ANALYZER_UNTIL_BLOCK_STATE} l_state
						elseif is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.across_keyword) then
							create {ES_EDITOR_ANALYZER_ACROSS_BLOCK_STATE} l_state
						else
							check is_attached_keyword: is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword) end
							if is_object_test_start_token (l_token, l_line) then
								a_info.increment_current_frame (False)
								l_prev := previous_token (l_token, l_line, True, a_end_token, Void)
								process_next_object_test_locals (a_info, l_prev.token, l_prev.line, a_end_token, a_end_token, local_list_state)
--								a_info.set_has_runout (a_end_token ~ a_info.current_token)
							end
							l_state := Void
						end
						if l_state = Void then
							if attached a_info.current_frame.locals as l_locals then
								a_info.decrement_current_frame
								if not l_locals.is_empty then
									a_info.current_frame.locals.merge (l_locals)
								end
							end
							a_info.set_has_runout (True)
						else
--							check
--									-- Should have run out
--								has_run_out: a_info.has_runout
--							end

							l_state.process (a_info, a_end_token)
							if not a_info.has_runout then
								a_info.decrement_current_frame
							end
							l_stop := True
						end
					else
						debug ("COMPLETION")
							print ("Matching [" + l_token.debug_output + "] with [" + l_match.token.debug_output + "]%N")
						end
						l_token := l_match.token
						l_line := l_match.line
						a_info.set_current_line (l_line, l_token)
						a_info.increment_current_frame (False)
					end
				else
					l_stop := True
					a_info.has_runout := True
				end
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
