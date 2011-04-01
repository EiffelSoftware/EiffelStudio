note
	description: "[
			Analyzes local declaration blocks and to extract local declarations.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_LOCAL_LIST_STATE

inherit
	ES_EDITOR_ANALYZER_FEATURE_STATE_BASE
		redefine
			is_valid_start_token
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

feature -- Status report

	is_valid_start_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_token, a_line) and then is_local_token (a_token)
		end

feature {NONE} -- Status report

	is_local_token (a_token: EDITOR_TOKEN): BOOLEAN
			-- Determines if a token marks the beginning of a local declaration list.
			--
			-- `a_token': The token to determine local declaration block start status.
			-- `Result' : True if the token is a local's block terminating token; False otherwise.
		require
			a_token_attached: a_token /= Void
		do
			Result := is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword) or else
					is_character_8_token (a_token, '(', False) or else
					is_character_8_token (a_token, '{', False)
		end

	is_local_terminating_token (a_token: EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is considered a terminating token when scanning for a locals
			-- declaration list.
			--
			-- `a_token': The token to determine termination status of.
			-- `Result' : True if the token is a local's block terminating token; False otherwise.
		require
			a_token_attached: a_token /= Void
		local
			l_image: STRING
		do
			if attached {EDITOR_TOKEN_KEYWORD} a_token as l_keyword then
					-- Is a keyword token, check if it's not a keyword used in a local declaration.
				l_image := token_text_8 (l_keyword)
				if not l_image.is_empty then
						-- The only accepted keywords are 'Current' and 'like'.
					Result := not (l_image.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.current_keyword) or else
						l_image.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.like_keyword) or else
						l_image.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.attached_keyword) or else
						l_image.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.detachable_keyword) or else
						l_image.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.separate_keyword)
						)
				end
			elseif attached {EDITOR_TOKEN_TEXT} a_token as l_text then
					-- Check for end braces, the local could be an object test or argument list.
				l_image := token_text_8 (l_text)
				if l_image.count = 1 then
					inspect l_image.item (1)
					when ')', '}' then
						Result := True
					else
					end
				end
			end
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_end_token: detachable EDITOR_TOKEN)
			-- <Precursor>
		local
			l_result: STRING_32
			l_next: detachable like next_token
			l_token: EDITOR_TOKEN
			l_line: EDITOR_LINE
			l_stop: BOOLEAN
			l_wrapper: like eiffel_parser_wrapper
			l_type_dec: detachable TYPE_DEC_AS
			l_current_frame: ES_EDITOR_ANALYZER_FRAME
			l_in_brace: INTEGER
		do
			check
				not_is_scanning_comments: not is_scanning_comments
				not_error_handler_has_error: not error_handler.has_error
			end

			l_next := next_text_token (a_info.current_token, a_info.current_line, True, a_end_token)
			if l_next /= Void then
				create l_result.make (200)
				from
					l_token := l_next.token
					l_line := l_next.line
				until
					l_stop
				loop
					if is_character_8_token (l_token, '{', False) then
						l_in_brace := l_in_brace + 1
						l_result.append_character ('{')
					elseif l_in_brace > 0 and is_character_8_token (l_token, '}', False) then
						l_in_brace := l_in_brace - 1
						l_result.append_character ('}')
					elseif is_local_terminating_token (l_token) then
						a_info.set_current_line (l_line, l_token)
						l_stop := True
					else
							-- Append the image data.
						l_result.append (token_text (l_token))

							-- We are skipping whitespace tokens, so add space characters to allow successful parsing.
							-- The result string isn't pretty but it parses.
						l_result.append_character ({CHARACTER_32} ' ')
					end
					if not l_stop then
							-- Fetch next token data.
						l_next := next_text_token (l_token, l_line, True, a_end_token)
						if l_next /= Void then
							l_token := l_next.token
							l_line := l_next.line
						else
								-- No more tokens
							l_stop := True
						end
					end
				end

					-- Parse the local declaration block.
				if l_result.is_valid_as_string_8 then
					l_result.left_adjust
					l_result.right_adjust
				end
				if not l_result.is_empty then
						-- Parse local declaration block.
					l_result.prepend_character ({CHARACTER_32} ' ')
					l_result.prepend ({EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
					l_wrapper := eiffel_parser_wrapper
					l_wrapper.parse_with_option_32 (entity_declaration_parser, l_result, a_info.context_class.group.options, True, a_info.context_class)
					if attached {EIFFEL_LIST [TYPE_DEC_AS]} l_wrapper.ast_node as l_declarations then
						l_current_frame := a_info.current_frame
						from l_declarations.start until l_declarations.after loop
							l_type_dec := l_declarations.item
							if l_type_dec /= Void then
									-- Add the AST local declaration.
								l_current_frame.add_local (l_type_dec)
							end
							l_declarations.forth
						end
					end
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
