indexing
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FEATURE_ANALYZER_STATE

inherit
	ES_EDITOR_TOKEN_ANALYZER_STATE
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

	process_next_tokens (a_result: !ES_EDITOR_TOKEN_ANALYZER_STATE_RESULT; a_end_token: ?EDITOR_TOKEN)
			-- <Precursor>
		local
			l_current_frame: !ES_EDITOR_TOKEN_ANALYZER_FRAME
			l_matcher: !like brace_matcher
			l_next: ?like next_text_token
			l_type_start: ?like next_text_token
			l_type_end: ?like next_text_token
			l_context_class: !CLASS_I
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_image: !STRING
			l_token_text: !STRING_32
			l_state: !ES_EDITOR_TOKEN_ANALYZER_STATE
			l_skip_feature_body_start_search: BOOLEAN
		do
			l_matcher := brace_matcher

				-- Fetch the most relivant information.
			l_context_class := a_result.context_class
			if {l_current_token: EDITOR_TOKEN_TEXT} a_result.current_token then
				l_next := [l_current_token, a_result.current_line]
			else
				l_next := next_text_token (a_result.current_token, a_result.current_line, True, a_end_token)
			end
			if l_next /= Void then
					-- Set the feature name.
				--a_result.set_feature_name (l_next.token.wide_image)

					-- Create new frame
				a_result.increment_current_frame (False)
				l_current_frame ?= a_result.current_frame

					-- Check for routine arguments.
				l_next := next_text_token (l_next.token, l_next.line, True, a_end_token)
				a_result.has_runout := l_next = Void
				if l_next /= Void then
						-- Store the next token, for fallback.
					a_result.set_current_line (l_next.line, l_next.token)
					l_token := l_next.token
					l_line := l_next.line

						-- Check for routine arguments
					if l_matcher.is_opening_brace (l_token) then
							-- An opening brace was found, check the argument list.
						l_next := l_matcher.match_opening_brace (l_token, l_line, a_end_token)
						if l_next /= Void then
								-- A matching argument brace was found, add the locals
							check is_local_token: local_analyzer.is_local_token (l_token) end
							l_next := local_analyzer.scan (l_token, l_line, a_end_token, l_current_frame)
						end
						if l_next = Void then
								-- Failed to find the arguments, fallback to last stored position.
							l_next := [a_result.current_token, a_result.current_line]
						else
							a_result.set_current_line (l_next.line, l_next.token)
								-- Move to the next token, because we found a full argument list.
							l_next := next_text_token (l_next.token, l_next.line, True, a_end_token)
						end
					end

					if l_next /= Void then
							-- Because the argument list was completely analyzed, set the state results.

							-- Check for the return type.
						l_image ?= l_token.wide_image.as_string_8
						if l_image.is_case_insensitive_equal (":") then
								-- A return type is possible.
							l_type_start := next_text_token (l_next.token, l_next.line, True, a_end_token)
							l_next := l_type_start
							a_result.has_runout := l_type_start = Void
							if l_type_start /= Void then
								l_token := l_type_start.token
								if l_token /= a_end_token then
									l_line := l_type_start.line
									l_type_end := scan_for_type (l_type_start.token, l_type_start.line, a_end_token)
									if l_type_end /= Void then
											-- A type completed, set the current token/line.
										a_result.set_current_line (l_type_end.line, l_type_end.token)
										l_next := l_type_start

											-- A type was found, add it to the local frame.
										l_token_text := token_text (l_type_start.token, l_type_start.line, l_type_end.token)
										if not l_token_text.is_empty then
												-- Add the Result local declaration.
											l_current_frame.add_local_string (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.result_keyword), l_token_text)
										end
									end
								end
							end
						end
					end

					a_result.has_runout := l_next = Void
					if l_next /= Void then
							-- Skip back one token because me might be directly on the token we are looking for, and next
							-- will cause a shift
						l_next := previous_token (l_next.token, l_next.line, True, Void, Void)

							-- Check for local declaration.
						l_next := next_token (l_next.token, l_next.line, True, a_end_token,
							agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE): BOOLEAN
									-- Search for the attribute, do, once, deferred, external words
								local
									l_ia_wide_image: !STRING_32
								do
									if {l_keyword: EDITOR_TOKEN_KEYWORD} ia_token then
										l_ia_wide_image ?= l_keyword.wide_image.as_lower
										Result := feature_body_keywords.has (l_ia_wide_image)
										if not Result then
											Result := is_keyword_token (ia_token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
										end
									elseif {l_text: EDITOR_TOKEN_TEXT} ia_token then
										l_ia_wide_image ?= l_text.wide_image.as_lower
									end
								end)

						if l_next /= Void then
								-- Check for local keyword
							if is_keyword_token (l_next.token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword) then
									-- Local declaration block found
								a_result.increment_current_frame (False)
								l_next := local_analyzer.scan (l_next.token, l_next.line, a_end_token, l_current_frame)
								if l_next /= Void then
									a_result.set_current_line (l_next.line, l_next.token)
								end
							end
						end

						if l_next /= Void then
							l_token_text ?= l_next.token.wide_image.as_lower
								-- Check if we already have the necessary feature body start token.
							l_skip_feature_body_start_search := feature_body_keywords.has (l_token_text)
						end
						if not l_skip_feature_body_start_search then
							l_next := next_token (l_next.token, l_next.line, True, a_end_token,
								agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE): BOOLEAN
										-- Search for the routine body keywords.
									local
										l_ia_wide_image: !STRING_32
									do
										if {l_keyword: EDITOR_TOKEN_KEYWORD} ia_token then
											l_ia_wide_image ?= l_keyword.wide_image
											Result := feature_body_keywords.has (l_ia_wide_image)
										end
									end)
						end

						a_result.has_runout := l_next = Void
						if l_next /= Void then
								-- Feature body declaration found.
							create {ES_FEATURE_BODY_ANALYZER_STATE} l_state
							l_state.process (a_result, a_end_token)
						end
					end
				end
			end
		end

feature {NONE} -- Helpers

	local_analyzer: !ES_EDITOR_TOKEN_LOCAL_ENTITY_ANALYZER
			-- Shared access to a local entities analyzer.
		once
			create Result
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
