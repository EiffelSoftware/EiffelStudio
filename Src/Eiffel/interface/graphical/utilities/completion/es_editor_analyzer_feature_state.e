indexing
	description: "[
			A feature's declaration editor analyzer's state, used in processing tokens between the feature name and end tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_FEATURE_STATE

inherit
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE
		redefine
			is_valid_start_token
		end

feature -- Status report

	is_valid_start_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a given token is valid as the state's start token.
		do
			Result := Precursor (a_token, a_line) and then (a_token.is_text or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.agent_keyword))
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: !ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_end_token: ?EDITOR_TOKEN)
			-- <Precursor>
		local
			l_current_frame: !ES_EDITOR_ANALYZER_FRAME
			l_matcher: !like brace_matcher
			l_next: ?like next_text_token
			l_type_start: ?like next_text_token
			l_type_end: ?like next_text_token
			l_context_class: !CLASS_C
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_token_text: !STRING_32
			l_state: !ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_FEATURE_STATE_INFO]
			l_local_list_state: !like local_list_state
		do
				-- Fetch the most relivant information.
			l_context_class := a_info.context_class
			if {l_current_token: EDITOR_TOKEN_TEXT} a_info.current_token then
				l_next := [l_current_token, a_info.current_line]
			else
				l_next := next_text_token (a_info.current_token, a_info.current_line, True, a_end_token)
			end
			if l_next /= Void then
				l_matcher := brace_matcher
				l_local_list_state := local_list_state

					-- Set the feature name.
				a_info.set_feature_name (l_next.token.wide_image)
				l_current_frame := a_info.current_frame

					-- Check for routine arguments.
				l_next := next_text_token (l_next.token, l_next.line, True, a_end_token)
				a_info.has_runout := l_next = Void
				if l_next /= Void then
						-- Store the next token, for fallback.
					l_token := l_next.token
					l_line := l_next.line
					a_info.set_current_line (l_line, l_token)

						-- Check for routine arguments
					if l_matcher.is_opening_brace (l_token) then
							-- An opening brace was found, check the argument list.
						l_next := l_matcher.match_opening_brace (l_token, l_line, a_end_token)
						if l_next /= Void then
								-- A matching argument brace was found, add the locals
							check is_local_token: local_list_state.is_valid_start_token (l_token, l_line) end
							if l_local_list_state.is_valid_state_info (a_info) then
								l_local_list_state.process (a_info, l_next.token)
							else
								check False end
							end
							l_next := [a_info.current_token, a_info.current_line]
						end
						if l_next = Void then
								-- Failed to find the arguments, fallback to last stored position.
							l_next := [a_info.current_token, a_info.current_line]
						else
							a_info.set_current_line (l_next.line, l_next.token)
								-- Move to the next token, because we found a full argument list.
							l_next := next_text_token (l_next.token, l_next.line, True, a_end_token)
						end
					end

					if l_next /= Void then
							-- Because the argument list was completely analyzed, set the state results.

							-- Check for the return type.
						if (":").is_equal (token_text_8 (l_next.token)) then
								-- A return type is possible.
							l_type_start := next_text_token (l_next.token, l_next.line, True, a_end_token)
							l_next := l_type_start
							a_info.has_runout := l_type_start = Void
							if l_type_start /= Void then
								l_token := l_type_start.token
								if l_token /= a_end_token then
									l_line := l_type_start.line
									l_type_end := scan_for_type (l_type_start.token, l_type_start.line, a_end_token)
									if l_type_end /= Void then
											-- A type completed, set the current token/line.
										a_info.set_current_line (l_type_end.line, l_type_end.token)
										l_next := l_type_end

											-- A type was found, add it to the local frame.
										l_token_text := token_range_text (l_type_start.token, l_type_start.line, l_type_end.token)
										if not l_token_text.is_empty then
												-- Add the Result local declaration.
											l_current_frame.add_local_string (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.result_keyword), l_token_text)
										end
									end
								end
							end
						end
					end

					a_info.has_runout := l_next = Void
					if l_next /= Void then
							-- Step back because there might not have been any arguments or return type, which means we
							-- are already on the feature body or local keyword token.
						l_next := previous_token (l_next.token, l_next.line, False, Void, Void)
						check l_next_attached: l_next /= Void end
						if l_next /= Void then
								-- Check for local declaration.
							l_next := next_token (l_next.token, l_next.line, True, a_end_token,
								agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE): BOOLEAN
										-- Search for the attribute, do, once, deferred, external or local words
									do
										Result := is_feature_body_token (ia_token, ia_line) or else
											is_keyword_token (ia_token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
									end)
						end

						if l_next /= Void then
								-- Check for local keyword
							if is_keyword_token (l_next.token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword) then
									-- Local declaration block found
								a_info.set_current_line (l_next.line, l_next.token)
								check is_local_token: local_list_state.is_valid_start_token (l_next.token, l_next.line) end
								if l_local_list_state.is_valid_state_info (a_info) then
									l_local_list_state.process (a_info, a_end_token)
								else
									check False end
								end
								l_next := [a_info.current_token, a_info.current_line]
							end
						end

						if l_next /= Void then
								-- Check if we already have the necessary feature body start token.
							if not is_feature_body_token (l_next.token, l_next.line) then
								l_next := next_token (l_next.token, l_next.line, True, a_end_token, agent is_feature_body_token)
							end
						end

						a_info.has_runout := l_next = Void
						if l_next /= Void then
							a_info.set_current_line (l_next.line, l_next.token)

								-- Feature body declaration found.
							a_info.increment_current_frame (False)
							create {ES_EDITOR_ANALYZER_FEATURE_BODY_STATE} l_state
							l_state.process (a_info, a_end_token)
							if not a_info.has_runout then
								a_info.decrement_current_frame
							end
						end
					end
				end
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
