indexing
	description: "[
			Processes various known states in the Eiffel editor, using context inference.
			Current the implementation is specific to building completion local-scoped entities.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_CLASS_ANALYZER

inherit
	ES_EDITOR_ANALYZER_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: !like context_class)
			-- Initialize the class context analyzer.
			--
			-- `a_class': The context class to analyze the class for.
		do
			context_class := a_class
		ensure
			context_class_set: context_class = a_class
		end

feature -- Access

	context_class: !CLASS_I
			-- The class analyzer's context class.

feature {NONE} -- Status report

	is_feature_body_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- Determines if a token represents a feature body keyword token.
			--
			-- `a_token': Token to check as a feature body token.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : True if the token is a feature body token; False otherwise.
		local
			l_next: ?like next_token
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
					Result := l_next = Void or else not {l_string: EDITOR_TOKEN_STRING} l_next.token
				end
			end
		end

feature {NONE} -- Query

	token_context_state (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE; state: !ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_STATE_INFO]]
			-- Evalues a token and returns a state processing object.
			--
			-- `a_token': The token on the supplied line to start the upward locating scan on.
			-- `a_line' : The line where the supplied token is resident.
			-- `Result' : A state processing object, or Void if no state could be determined.
			--            When attached the token and line represent that actual start of the block, which
			--            differs from the passed tokens that represent the context location.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			not_is_scanning_comments: not is_scanning_comments
		local
			l_matcher: ?like brace_matcher
			l_prev: ?like previous_text_token
			l_peek: ?like previous_text_token
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_stop: BOOLEAN
			l_feature_state: ?like new_feature_state
		do
			l_matcher := brace_matcher
			l_prev := [a_token, a_line]
			from until l_stop loop
				l_token := l_prev.token
				l_line := l_prev.line
				if l_token.is_text then
					if is_keyword_token (l_token, Void) then
							-- Check the states of a keyword token.

							-- Set stopping condition and non matches will reset it.
						l_stop := True
						if
							is_feature_body_token (l_token, l_line) or else
							is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword) or else
							is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.require_keyword)
						then
							l_prev := feature_start_token (l_token, l_line)
							if l_prev /= Void then
								l_feature_state := new_feature_state (l_prev.token, l_prev.line)
								if l_feature_state /= Void and then l_feature_state.is_valid_start_token (l_prev.token, l_prev.line) then
									Result := [l_prev.token, l_prev.line, l_feature_state]
								end
							end
						elseif is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.feature_keyword) then
								-- Class feature clause
						elseif is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.convert_keyword) then
								-- In the class conversion clause
						elseif is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.inherit_keyword) then
								-- In the class inherit clause
						elseif is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.class_keyword) then
								-- In the class
						else
								-- No match, switch the stopping condition back to False.
							l_stop := False
						end
					else
						if l_matcher.is_closing_brace (l_token) and then not l_matcher.is_closing_match_exception (l_token, l_line) then
							l_peek := l_matcher.match_closing_brace (l_token, l_line, Void)
							if l_peek /= Void then
								l_token := l_peek.token
								l_line := l_peek.line
							end
						end
					end
				end

				if not l_stop then
					l_prev := previous_text_token (l_token, l_line, True, Void)
					l_stop := l_prev = Void
				end
			end
		end

	feature_start_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches to what is considered to be a "start" token, which represents where the context
			-- scanner will start its scan from.
			-- The function takes into consideration in line agents, routines, feature clauses and class
			-- declarations.
			--
			-- `a_token': The token on the supplied line to start the upward locating scan on.
			-- `a_line': The line where the supplied token is resident.
			-- `Result': A resulting token and resident line of a determined starting token, or Void if no
			--           valid start location was found.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			not_is_scanning_comments: not is_scanning_comments
		local
			l_matcher: ?like brace_matcher
			l_prev: ?like previous_text_token
			l_peek: ?like previous_text_token
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_top_feature_keyword_token: !TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			l_stop: BOOLEAN
		do
			l_matcher := brace_matcher

				-- Attempt to locate a keyword above the feature
			l_prev := [a_token, a_line]
			l_top_feature_keyword_token := [a_token, a_line]
			from until l_stop loop
				l_token := l_prev.token
				l_line := l_prev.line
				if is_keyword_token (l_token, Void) then
						-- Check specific keywords only.
					if
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword) or else
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.require_keyword) or else
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword) or else
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.note_keyword)
					then
							-- Sets the top most feature keyword token
						l_top_feature_keyword_token := [l_token, l_line]
					elseif
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.agent_keyword) or else
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.infix_keyword) or else
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.prefix_keyword)
					then
							-- Sets the top most feature keyword token
						l_top_feature_keyword_token := [l_token, l_line]
						l_stop := True
					elseif
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.end_keyword) or else
						is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.feature_keyword)
					then
							-- We have gone beyond the feautre declaration, so stop
						l_stop := True
					end
				else
					if l_matcher.is_closing_brace (l_token) and then not l_matcher.is_closing_match_exception (l_token, l_line) then
							-- Ingore braces expression, as we'll find in preconditions. We need to do this because we check
							-- for the agent keyword as a feature name token.
						l_peek := l_matcher.match_closing_brace (l_token, l_line, Void)
						if l_peek /= Void then
							l_token := l_peek.token
							l_line := l_peek.line

						else
							l_stop := True
						end
					end
				end

				if not l_stop then
					l_prev := previous_text_token (l_token, l_line, True, Void)
					l_stop := l_prev = Void
				end
			end

			if Result = Void then
				l_token := l_top_feature_keyword_token.token
				l_line := l_top_feature_keyword_token.line
				if
					is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.agent_keyword) or else
					is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.infix_keyword) or else
					is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.prefix_keyword)
				then
						-- In-line agent
					Result := l_top_feature_keyword_token
				else
						-- We should now be beyond the top of the feature but we have the best know top feature keyword. All that should be above
						-- is a comment block and a feature signature.
					from l_stop := False until l_stop loop
						l_prev := previous_text_token (l_token, l_line, True, Void)
						if l_prev /= Void then
							l_token := l_prev.token
							l_line := l_prev.line

							if l_matcher.is_closing_brace (l_token) and then not l_matcher.is_closing_match_exception (l_token, l_line) then
								l_prev := l_matcher.match_closing_brace (l_token, l_line, Void)
								if l_prev /= Void then
										-- Ensures we skip tuple and genric class declarations, as well as argument lists.

										-- Move past the matched opening brace.
									l_prev := previous_text_token (l_prev.token, l_prev.line, True, Void)
									if l_prev /= Void then
										l_token := l_prev.token
										l_line := l_prev.line
									end
								end
							end

							if l_prev /= Void then
								l_peek := previous_text_token (l_token, l_line, True, Void)
								if
									l_peek = Void or else
										not (
											is_keyword_token (l_peek.token, {EIFFEL_KEYWORD_CONSTANTS}.like_keyword) or else
											is_keyword_token (l_peek.token, {EIFFEL_KEYWORD_CONSTANTS}.assign_keyword) or else
											{l_class: EDITOR_TOKEN_CLASS} l_token
										)
								then
										-- We are just looking for a feature name or argument parenthesis, so we ignore feature name
										-- checking when using like.
									if not is_keyword_token (l_token, Void) and then token_text (l_token).item (1).to_character_8.is_alpha then
											-- Finally, nothing else is in the way, check it's a feature name.
										if not token_text (l_token).is_empty and then not {l_string: EDITOR_TOKEN_STRING} l_token then
											Result := [l_token, l_line]
											l_stop := True
										else
											l_stop := True
										end
									end
								else
										-- Just ignore the like keyword, there is no need to process it.
									l_token := l_peek.token
									l_line := l_peek.line
								end
							else
								l_stop := True
							end


						else
							l_stop := True
						end
					end
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

feature -- Basic operation

	scan (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): ?ES_EDITOR_ANALYZER_STATE_INFO
			-- Scans the editor content for a context given the token.
			--
			-- `a_token': The start token to begin scanning at.
			-- `a_line' : The start line which the start token is resident on.
			-- `Result' : A result describing the result of the analysis.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_context_state: ?like token_context_state
			l_info: !like new_state_info_for_state
			l_state: !ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_STATE_INFO]
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
		do
			reset
			l_context_state := token_context_state (a_token, a_line)
			if l_context_state /= Void then
				l_state := l_context_state.state
				l_token := l_context_state.token
				l_line := l_context_state.line
				if l_state.is_valid_start_token (l_token, l_line) then
						-- Create the necessary information object and process the state.
					l_info := new_state_info_for_state (l_token, l_line, l_state)
					l_state.process (l_info, a_token)
					Result := l_info
				end
			end
		end

feature {NONE} -- Basic operations

	reset
			-- Resets the analyzer to start a new analysis.
		do
			set_is_scanning_comments (False)
		ensure
			not_is_scanning_comments: not is_scanning_comments
		end

feature {NONE} -- Factory

	new_feature_state (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): ?ES_EDITOR_ANALYZER_FEATURE_STATE
			-- Create a new feature level state object using the supplied feature tokens.
			--
			-- `a_token': The token to start processing the state at.
			-- `a_line' : The line where the supplied start token is resident.
			-- `Result' : A state object to use to process the tokens.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		do
			create Result
		end

	new_state_info_for_state (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE; a_state: !ES_EDITOR_ANALYZER_STATE [ES_EDITOR_ANALYZER_STATE_INFO]): !ES_EDITOR_ANALYZER_STATE_INFO
			-- Create a new state info object for a given editor analyzer's state.
			--
			-- `a_token': The token to start processing the state at.
			-- `a_line' : The line where the supplied start token is resident.
			-- `a_state': The state object to create an information result object for.
			-- `Result' : A state information object compabile with the supplied state.
		require
			a_line_has_a_token: a_line.has_token (a_token)
			a_token_is_valid_start_token: a_state.is_valid_start_token (a_token, a_line)
		local
			l_feature_info: !ES_EDITOR_ANALYZER_FEATURE_STATE_INFO
		do
			if {l_feature_state: ES_EDITOR_ANALYZER_FEATURE_STATE} a_state then
				create l_feature_info.make (context_class, a_token, a_line)
				l_feature_info.increment_current_frame (True)
				Result := l_feature_info
			else
				create Result.make (context_class, a_token, a_line)
			end
		ensure
			result_is_valid_state_info: a_state.is_valid_state_info (Result)
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
