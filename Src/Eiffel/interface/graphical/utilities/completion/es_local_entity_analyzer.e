indexing
	description: "[
			Analyzes local declaration blocks and to extract local declarations.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LOCAL_ENTITY_ANALYZER

inherit
	ES_EDITOR_TOKEN_UTILITIES
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

feature --

	scan (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: ?EDITOR_TOKEN; a_frame: !ES_CLASS_CONTEXT_FRAME): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Scans a local declaration block for local declarations and adds found valid locals to the
			-- supplied context frame.
			--
			-- `a_start_token': The token to start scanning at, which should be a local declaration start
			--                  block token.
			-- `a_start_line' : The line where the supplied start token is resident.
			-- `a_end_token'  : An optional end token to stop processing at, which may prevent any locals
			--                  from being added to the supplied context frame.
			-- `Result'       : The next token after the local declaration block, or Void if there are no
			--                  more tokens or the end token was reached.
		require
			a_start_line_has_a_token: a_start_line.has_token (a_start_token)
			a_start_token_is_local_token: is_local_token (a_start_token)
		local
			l_result: !STRING_32
			l_next: ?like next_token
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_stop: BOOLEAN
			l_parser: !like entity_declaration_parser
			l_declarations: ?EIFFEL_LIST [TYPE_DEC_AS]
			l_type_dec: ?TYPE_DEC_AS
		do
			l_next := next_text_token (a_start_token, a_start_line, True, a_end_token)
			if l_next /= Void then
				create l_result.make (200)
				from
					l_token := l_next.token
					l_line := l_next.line
				until
					l_stop
				loop
					if l_token = a_end_token or else is_local_terminating_token (l_token) then
						l_stop := True
						if l_token /= a_end_token then
								-- The token is a terminating token, so return the result
							Result := [l_token, l_line]
						end
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

				l_result.left_adjust
				l_result.right_adjust
				if not l_result.is_empty then
						-- Parse local declaration block.
					l_result.prepend_character (' ')
					l_result.prepend ({ES_EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
					l_parser ?= entity_declaration_parser
					l_parser.parse_from_string (l_result)
					l_declarations ?= l_parser.entity_declaration_node
					if l_declarations /= Void then
						from l_declarations.start until l_declarations.after loop
							l_type_dec := l_declarations.item
							if l_type_dec /= Void then
								a_frame.add_local (l_type_dec)
							end
							l_declarations.forth
						end
					end
				end
			end
		end

feature -- Status report

	is_local_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token marks the beginning of a local declaration list.
			--
			-- `a_token': The token to determine local declaration block start status.
			-- `Result' : True if the token is a local's block terminating token; False otherwise.			
		local
			l_image: ?STRING
		do
			if {l_keyword: EDITOR_TOKEN_KEYWORD} a_token then
					-- Check the local keyword.
				l_image := l_keyword.wide_image.as_string_8
				if l_image /= Void and then not l_image.is_empty then
						-- The only accepted keywords are 'local'.
					Result := not l_image.is_case_insensitive_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
				end
			elseif {l_text: EDITOR_TOKEN_TEXT} a_token then
					-- Check for open braces, the local could be an object test or argument list
				l_image := l_text.wide_image.as_string_8
				if l_image /= Void and then not l_image.is_empty then
					Result := l_image.is_equal (once "(") or else
						l_image.is_equal (once "{")
				end
			end
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
					Result := not (l_image.is_case_insensitive_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.current_keyword) or else
						l_image.is_case_insensitive_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.like_keyword))
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
