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
	ES_CLASS_CONTEXT_ANALYZER_STATE
		redefine
			new_state_result
		end

feature {NONE} -- Basic operation

	process_tokens (a_result: !like new_state_result; a_end_token: ?EDITOR_TOKEN)
			-- <Precursor>
		local
			l_current_frame: ?ES_CLASS_CONTEXT_FRAME
			l_matcher: !like brace_matcher
			l_context_locals: !HASH_TABLE [!TYPE_A, !STRING_32]
			l_next: ?like next_text_token
			l_type_start: ?like next_text_token
			l_type_end: ?like next_text_token
			l_context_class: !CLASS_I
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_image: !STRING
			l_token_text: !STRING_32
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
				a_result.feature_name := l_next.token.wide_image

					-- Create new frame
				create l_current_frame.make (l_context_class)

					-- Check for routine arguments.
				l_next := next_text_token (l_next.token, l_next.line, True, a_end_token)
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
						l_token := l_next.token
						l_line := l_next.line

							-- Check for the return type.
						l_image ?= l_token.wide_image.as_string_8
						if l_image.is_case_insensitive_equal (":") then
								-- A return type is possible.
							l_type_start := next_text_token (l_next.token, l_next.line, True, a_end_token)
							if l_type_start /= Void then
								l_token := l_type_start.token
								if l_token /= a_end_token then
									l_line := l_type_start.line
									l_type_end := scan_for_type (l_type_start.token, l_type_start.line, a_end_token)
									if l_type_end /= Void then
											-- A type completed, set the current token/line.
										a_result.set_current_line (l_type_end.line, l_type_end.token)

											-- A type was found, add it to the local frame.
										l_token_text := token_text (l_type_start.token, l_type_start.line, l_type_end.token)
										if not l_token_text.is_empty then
												-- Add the Result local declaration.
											l_current_frame.add_local_string (create {STRING_32}.make_from_string ("Result"), l_token_text)
										end
									end
								end
							end
							l_context_locals := l_current_frame.all_locals
						end
					end
				end
			end
		end

feature {NONE} -- Helpers

	local_analyzer: !ES_LOCAL_ENTITY_ANALYZER
			-- Shared access to a local entities analyzer.
		once
			create Result
		end

--feature

--	build_context_information (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: !EDITOR_TOKEN; a_end_line: !EDITOR_LINE)
--			-- Constructs context information
--		local
--			l_next: ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
--			l_next_temp: ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
--			l_token: !EDITOR_TOKEN_TEXT
--			l_line: !EDITOR_LINE
--			l_image: !STRING
--			l_wide_image: !STRING_32
--			l_state: INTEGER
--			l_feature_frame: !ES_CLASS_CONTEXT_FRAME
--			l_locals_frame: !ES_CLASS_CONTEXT_FRAME
--			l_current_frame: ?ES_CLASS_CONTEXT_FRAME
--			l_locals: !HASH_TABLE [!TYPE_A, !STRING_32]
--			l_local_analyzer: !like local_analyzer
--			l_matcher: !like brace_matcher
--			l_token_text: !STRING_32

--			l_type_start: ?like next_text_token
--			l_type_end: ?like next_text_token
--			l_context_locals: !HASH_TABLE [!TYPE_A, !STRING_32]
--		do
--			l_state := unknown_context
--			if {l_keyword: EDITOR_TOKEN_KEYWORD} a_start_token then
--				l_image ?= l_keyword.wide_image.as_lower.as_string_8
--				if l_image.is_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.class_keyword) then
--					l_state := class_context
--				elseif l_image.is_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.feature_keyword) then
--					l_state := feature_clause_context
--				elseif l_image.is_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.agent_keyword) then
--					l_state := feature_context
--				end
--			elseif {l_fstart: EDITOR_TOKEN_FEATURE_START} a_start_token then
--				l_state := feature_context
--			end

--			if l_state = feature_context then


--				l_next := next_token (a_start_token, a_start_line, True,
--					agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE; ia_end_token: !EDITOR_TOKEN): BOOLEAN
--							-- Search for the (, :, require, attribute, do, once, deferred, external words
--						local
--							l_ia_image: !STRING
--							l_ia_wide_image: !STRING_32
--						do
--							Result := ia_token ~ ia_end_token
--							if not Result then
--								if {l_keyword: EDITOR_TOKEN_KEYWORD} ia_token then
--									l_ia_wide_image ?= l_keyword.wide_image.as_lower
--									Result := feature_body_keywords.has (l_ia_wide_image)
--									if not Result then
--										l_ia_image ?= l_ia_wide_image.as_string_8
--										Result := l_ia_image.is_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.require_keyword) or else
--											l_ia_image.is_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
--									end
--								elseif {l_text: EDITOR_TOKEN_TEXT} ia_token then
--									l_ia_wide_image ?= l_text.wide_image.as_lower
--								end

--							end
--						end (?, ?, a_end_token))

--				l_next := next_token (a_start_token, a_start_line, True,
--					agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE; ia_end_token: !EDITOR_TOKEN): BOOLEAN
--							-- Search for the local keyword
--						do
--							Result := ia_token ~ ia_end_token
--							if not Result and then {l_keyword: EDITOR_TOKEN_KEYWORD} ia_token then
--								Result := l_keyword.wide_image.as_string_8.is_case_insensitive_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
--							end
--						end (?, ?, a_end_token))

--				if l_next /= Void then
----					l_token := l_next.token
----					l_line := l_next.line

--						-- There was a local declaration, use scanner to extract information
--					--l_next := next_text_token (l_next.token, l_next.line, True, a_end_token)
--					if l_next /= Void then
--						l_token ?= l_next.token
--						l_line := l_next.line

--						if l_current_frame = Void then
--							create l_locals_frame.make (context_class)
--						else
--							create l_locals_frame.make_parented (context_class, l_current_frame)
--						end
--						l_current_frame := l_locals_frame

--						l_next := l_local_analyzer.scan (l_next.token, l_next.line, a_end_token, l_current_frame)
--						l_locals := l_locals_frame.all_locals
--						from l_locals.start until l_locals.after loop
--							print ("%Nlocal: ")
--							print (l_locals.key_for_iteration)
--							print (": ")
--							print (l_locals.item_for_iteration.out)
--							l_locals.forth
--						end
--					end
--				end

--					-- Check routine body for


--			end

--			print ("%N%N")


--			if l_state /= unknown_context then
--					-- A valid state
--				from
--					l_next := next_text_token (a_start_token, a_start_line, True, a_end_token)
--				until
--					l_next = Void
--				loop
--					process_token (l_next.token, l_next.line)
--					l_next := next_text_token (l_next.token, l_next.line, True, a_end_token)
--				end
--			end
--		end

feature {NONE} -- Factory

	new_state_result (a_class: !CLASS_I; a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): !ES_EDITOR_ANALYZER_FEATURE_STATE_RESULT
			-- <Precursor>
		do
			create Result.make (a_class, a_token, a_line)
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
