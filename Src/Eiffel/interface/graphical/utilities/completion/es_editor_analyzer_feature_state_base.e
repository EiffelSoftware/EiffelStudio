note
	description: "[
			A base implementation for feature-based analyzer states ({ES_EDITOR_ANALYZER_STATE}).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE

inherit
	ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_FEATURE_STATE_INFO]
		redefine
			is_valid_state_info
		end

feature -- Status report

	is_valid_state_info (a_info: ES_EDITOR_ANALYZER_STATE_INFO): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_info)
			if Result and then attached {ES_EDITOR_ANALYZER_FEATURE_STATE_INFO} a_info as l_info then
				Result := l_info.has_current_frame
			end
		ensure then
			a_info_has_current_frame: Result implies (
					attached {ES_EDITOR_ANALYZER_FEATURE_STATE_INFO} a_info as l_info and then
					l_info.has_current_frame
				)
		end

feature {NONE} -- Status report

	is_feature_body_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- Determines if a token represents a feature body keyword token.
			--
			-- `a_token': Token to check as a feature body token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is a feature body token; False otherwise.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
		local
			l_next: like next_token
		do
			Result := is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.do_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.attribute_keyword)
			if not Result then
				if is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.deferred_keyword) or else is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.external_keyword) then
						-- Make sure there is no class keyword
					l_next := next_token (a_token, a_line, True, Void, Void)
					Result := l_next = Void or else not is_keyword_token (l_next.token, {EIFFEL_KEYWORD_CONSTANTS}.class_keyword)
				elseif is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.once_keyword) then
						-- Make sure there is no string keyword after the once
					l_next := next_token (a_token, a_line, True, Void, Void)
					Result := l_next = Void or else not attached {EDITOR_TOKEN_STRING} l_next.token
				end
			end
		end

	is_object_test_start_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- Determines if a token is an object test start token.
			--
			-- `a_token': Token to check for an object test token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is an object test start token; False otherwise.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
		do
			Result := is_character_8_token (a_token, '{', False) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword)
		ensure
			is_object_test_start_token: Result implies (
				is_character_8_token (a_token, '{', False) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword))
		end

	is_object_test_or_across_start_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- Determines if a token is an object test or across start token.
			--
			-- `a_token': Token to check for an object test or across token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is an object test or across start token; False otherwise.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
		do
			Result := is_object_test_start_token (a_token, a_line) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.across_keyword)
		ensure
			is_object_test_or_across_start_token: Result implies (
				is_character_8_token (a_token, '{', False) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.across_keyword)
				)
		end

	is_across_closure (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- Determines if a token is an until or loop or some or all keyword token.
			--
			-- `a_token': Token to check for an if/elseif token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is an until or loop or some or all token; False otherwise.
		do
			if attached {EDITOR_TOKEN_KEYWORD} a_token as l_keyword then
				Result :=
						  is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.from_keyword) or else
						  is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.invariant_keyword) or else
						  is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.until_keyword) or else
						  is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.loop_keyword) or else
						  is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.some_keyword) or else
						  is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.all_keyword)
			end
		ensure
			is_until_or_loop: Result implies (
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.from_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.invariant_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.until_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.loop_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.some_keyword) or else
				is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.all_keyword)
				)
		end

feature {NONE} -- Implementation

	expression_type_name_from_string (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_expr: READABLE_STRING_32; a_default: STRING): STRING_32
			-- The expression `a_expr' is an attached factored expression, which requires an expression
			-- evaluation. This does not work for agent expression yet.
		do
			if attached editor_expression_analyzer.expression_type_from_string (a_info, a_expr) as l_expr_type then
				Result := l_expr_type.name
			else
				Result := a_default
			end
		ensure
			result_attached: Result /= Void
		end

	editor_expression_analyzer: ES_EDITOR_EXPRESSION_ANALYZER
			-- Analyzer a series of editor tokens for evaluation expressions.
		once
			create Result
		end

feature {NONE} -- Object test local implementation

	process_next_object_test_locals (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO;
				a_start_token: EDITOR_TOKEN; a_start_line: EDITOR_LINE;
				a_condition_closure_token: EDITOR_TOKEN;
				a_end_token: EDITOR_TOKEN;
				l_local_list_state: like local_list_state)
		local
			l_start_token: EDITOR_TOKEN
			l_start_line: EDITOR_LINE
			l_stop: BOOLEAN
			l_next: like next_token
		do
			l_start_token := a_start_token
			l_start_line := a_start_line

			from until l_stop loop
					-- Check for an object test between the if...then (or the passed end token if no then was found) keywords.
				l_next := next_token (l_start_token, l_start_line, True, a_condition_closure_token, agent is_object_test_or_across_start_token (?, ?))
				if l_next /= Void then
						-- Object test.

					if is_keyword_token (l_next.token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword) then
							-- Attached expression.
						l_next := scan_object_test_local (a_info, l_next.token, l_next.line, a_condition_closure_token)
						if l_next /= Void then
							l_start_token := l_next.token
							l_start_line := l_next.line
							a_info.set_current_line (l_start_line, l_start_token)
						else
							l_stop := True
						end

					elseif is_keyword_token (l_next.token, {EIFFEL_KEYWORD_CONSTANTS}.across_keyword) then
							-- Across expression.
						l_next := scan_across_local (a_info, l_next.token, l_next.line, a_condition_closure_token)
						if l_next /= Void then
							l_start_token := l_next.token
							l_start_line := l_next.line
							a_info.set_current_line (l_start_line, l_start_token)
						else
							l_stop := True
						end
					else
							-- Old object test.
						if l_local_list_state.is_valid_start_token (l_next.token, l_next.line) then
							a_info.set_current_line (l_next.line, l_next.token)
							l_local_list_state.process (a_info, a_condition_closure_token)
							if a_condition_closure_token /~ a_end_token then
								l_start_token := a_info.current_token
								l_start_line := a_info.current_line
							else
								l_stop := True
							end
						else
								-- Why is the token not a valid local list block start token?
							check False end
						end
					end
				else
					l_stop := True
				end
			end
		end

	scan_object_test_local (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_start_token: EDITOR_TOKEN; a_start_line: EDITOR_LINE; a_end_token: EDITOR_TOKEN): like next_token
			-- Scan object test local, and return next token
			-- note: this does not handle old syntax for object test local.
		require
			has_attached_keyword: is_keyword_token (a_start_token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword)
		local
			l_start_point_token: EDITOR_TOKEN
			l_start_point_line: EDITOR_LINE
			l_prev,
			l_next,
			l_next_as,
			l_type: like next_token
			l_expression_string: STRING_32
			l_type_string: STRING_32
		do
				-- Attached expression.
			l_next := next_text_token (a_start_token, a_start_line, True, a_end_token)
			if l_next /= Void then
					-- We have the next token, which will either be an expression or a type specifier.
					-- Store the start token and line for expression extraction later.
				l_start_point_token := l_next.token
				l_start_point_line := l_next.line


					-- We only need to examine the attached expression if there is an 'as' assignment.
				l_next_as := next_token (l_start_point_token, l_start_point_line, True, a_end_token,
					agent (ia_token: EDITOR_TOKEN; ia_line: EDITOR_LINE): BOOLEAN
						do
							Result := is_keyword_token (ia_token, {EIFFEL_KEYWORD_CONSTANTS}.as_keyword)
						end)

				if l_next_as /= Void and then is_keyword_token (l_next_as.token, {EIFFEL_KEYWORD_CONSTANTS}.as_keyword) then
						-- The located token was an 'as' token.

					l_next := next_text_token (l_next_as.token, l_next_as.line, True, a_end_token)
					if l_next /= Void and then is_identifier_token (l_next.token, l_next.line) then
							-- We have the identifier token in `l_next_as' to use as the local name.

							-- Now use the stored start token and start line to extract the expression or type declaration.
						if is_character_8_token (l_start_point_token, '{', False) then
								-- Type declaration - {TYPE}
							l_type := next_text_token (l_start_point_token, l_start_point_line, True, l_next_as.token)
							if l_type /= Void then
								l_start_point_token := l_type.token
								l_start_point_line := l_type.line
								l_type := scan_for_type (l_type.token, l_type.line, l_next_as.token)
								if l_type /= Void then
										-- Add local
									a_info.current_frame.add_local_string (
										token_text (l_next.token),
										token_range_text (l_start_point_token, l_start_point_line, l_type.token))
								end
							end
						else
								-- Expression (just prefix like)
							l_prev := previous_text_token (l_next_as.token, l_next_as.line, True, Void)
							check l_prev_attached: l_prev /= Void end

								-- build the 'like' type string.
							l_expression_string := token_range_text (l_start_point_token, l_start_point_line, l_prev.token)
							if l_expression_string.has ({CHARACTER_32} '.') then
									-- The expression is an attached factored expression, which requires an expression
									-- evaluation. This does not work for agent expression yet.
								l_type_string := expression_type_name_from_string (a_info, l_expression_string, once "ANY")
							else
								create l_type_string.make (30)
								l_type_string.append_string_general ({EIFFEL_KEYWORD_CONSTANTS}.like_keyword)
								l_type_string.append_character ({CHARACTER_32} ' ')
								l_type_string.append (l_expression_string)
							end

								-- Add local
							a_info.current_frame.add_local_string (token_text (l_next.token), l_type_string)
						end
					end
				else
						-- There is no as so we just continue
				end
			end
			Result := l_next
		end

	scan_across_local (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_start_token: EDITOR_TOKEN; a_start_line: EDITOR_LINE; a_end_token: EDITOR_TOKEN): like next_token
			-- Scan across local variable, and return next token
		require
			has_across_keyword: is_keyword_token (a_start_token, {EIFFEL_KEYWORD_CONSTANTS}.across_keyword)
		local
			l_start_point_token: EDITOR_TOKEN
			l_start_point_line: EDITOR_LINE
			l_prev,
			l_next,
			l_next_as: like next_token
			l_expression_string: STRING_32
			l_type_string: STRING_32
			l_across_closure: like next_token
		do
				-- Across expression.
			l_across_closure := next_token (a_start_token, a_start_line, True, a_end_token, agent is_across_closure (?, ?))
			l_next := next_text_token (a_start_token, a_start_line, True, a_end_token)
			if l_next /= Void then
					-- We have the next token, which will either be an expression or a type specifier.
					-- Store the start token and line for expression extraction later.
				l_start_point_token := l_next.token
				l_start_point_line := l_next.line


					-- We only need to examine the attached expression if there is an 'as' assignment.
				l_next_as := next_token (l_start_point_token, l_start_point_line, True, a_end_token,
					agent (ia_token: EDITOR_TOKEN; ia_line: EDITOR_LINE): BOOLEAN
						do
							Result := is_keyword_token (ia_token, {EIFFEL_KEYWORD_CONSTANTS}.as_keyword)
						end)

				if l_next_as /= Void and then is_keyword_token (l_next_as.token, {EIFFEL_KEYWORD_CONSTANTS}.as_keyword) then
						-- The located token was an 'as' token.

					l_next := next_text_token (l_next_as.token, l_next_as.line, True, a_end_token)
					if l_next /= Void and then is_identifier_token (l_next.token, l_next.line) then
							-- We have the identifier token in `l_next_as' to use as the local name.

							-- Now use the stored start token and start line to extract the expression or type declaration.
						l_prev := previous_text_token (l_next_as.token, l_next_as.line, True, Void)
						check l_prev_attached: l_prev /= Void end

							-- Build expression string for across
						l_expression_string := token_range_text (l_start_point_token, l_start_point_line, l_prev.token)
						l_expression_string.append (once ".new_cursor") --| Note: might be broken, if descendant rename the `new_cursor' function
							-- Extract expression type
						l_type_string := expression_type_name_from_string (a_info, l_expression_string, once "ITERATION_CURSOR [ANY]")

							-- Add local
						a_info.current_frame.add_local_string (token_text (l_next.token), l_type_string)
					end
				else
						-- There is no as so we just continue
				end
			end
			Result := l_next
		end


feature {NONE} -- Helpers

	local_list_state: ES_EDITOR_ANALYZER_LOCAL_LIST_STATE
			-- Access to the local list state.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

;note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
