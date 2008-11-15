indexing
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

	is_valid_start_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_token, a_line) and then is_local_token (a_token)
		end

feature {NONE} -- Status report

	is_local_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token marks the beginning of a local declaration list.
			--
			-- `a_token': The token to determine local declaration block start status.
			-- `Result' : True if the token is a local's block terminating token; False otherwise.			
		do
			Result := is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.local_keyword) or else
					is_text_token (a_token, "(", False) or else
					is_text_token (a_token, "{", False)
		end

	is_local_terminating_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is considered a terminating token when scanning for a locals
			-- declaration list.
			--
			-- `a_token': The token to determine termination status of.
			-- `Result' : True if the token is a local's block terminating token; False otherwise.
		local
			l_image: ?STRING
		do
			if {l_keyword: EDITOR_TOKEN_KEYWORD} a_token then
					-- Is a keyword token, check if it's not a keyword used in a local declaration.
				l_image := l_keyword.wide_image.as_string_8
				if l_image /= Void and then not l_image.is_empty then
						-- The only accepted keywords are 'Current' and 'like'.
					Result := not (l_image.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.current_keyword) or else
						l_image.is_case_insensitive_equal ({EIFFEL_KEYWORD_CONSTANTS}.like_keyword))
				end
			elseif {l_text: EDITOR_TOKEN_TEXT} a_token then
					-- Check for end braces, the local could be an object test or argument list.
				l_image := l_text.wide_image.as_string_8
				if l_image /= Void and then not l_image.is_empty then
					Result := l_image.is_equal (once ")") or else
						l_image.is_equal (once "}")
				end
			end
		end

feature {NONE} -- Basic operation

	process_next_tokens (a_info: !ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_end_token: ?EDITOR_TOKEN)
			-- <Precursor>
		local
			l_result: !STRING_32
			l_next: ?like next_token
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_stop: BOOLEAN
			l_parser: like entity_declaration_parser
			l_declarations: ?EIFFEL_LIST [TYPE_DEC_AS]
			l_type_dec: ?TYPE_DEC_AS
			l_current_frame: !ES_EDITOR_ANALYZER_FRAME
		do
			check
				not_is_scanning_comments: not is_scanning_comments
				not_error_hadler_has_error: not error_handler.has_error
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
					if is_local_terminating_token (l_token) then
						a_info.set_current_line (l_line, l_token)
						l_stop := True
					else
							-- Append the image data.
						l_result.append (l_token.wide_image)
							-- We are skipping whitespace tokens, so add space characters to allow successful parsing.
							-- The result string isn't pretty but it parses.
						l_result.append_character (' ')

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
				l_result.left_adjust
				l_result.right_adjust
				if not l_result.is_empty then
						-- Parse local declaration block.
					l_result.prepend_character (' ')
					l_result.prepend ({EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
					l_parser ?= entity_declaration_parser
					l_parser.parse_from_string (l_result)
					l_declarations ?= l_parser.entity_declaration_node
					if l_declarations /= Void then
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
						-- Clear any errors
					error_handler.wipe_out
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
