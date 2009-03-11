note
	description: "[
			A utility class for analyzing editor tokens to retrieve logical meaning from a series of tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_UTILITIES

inherit
	ANY

	ES_EDITOR_TOKEN_UTILITIES
		export
			{NONE} all
		end

feature -- Status report

	is_attachment_token (a_token: attached EDITOR_TOKEN; a_line: attached EDITOR_LINE): BOOLEAN
			-- Determines if a token is an attached/detachable marker token
			--
			-- `a_token' : The token to determine if to be an attachment token.
			-- `Result'  : True if the supplied token is an atachment token; False otherwise.
		do
			Result := is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.detachable_keyword) or else
					is_keyword_token (a_token, {EIFFEL_KEYWORD_CONSTANTS}.attached_keyword) or else
					is_text_token (a_token, "?", False) or else
					is_text_token (a_token, "!", False)
		end

	is_identifier_token (a_token: attached EDITOR_TOKEN; a_line: attached EDITOR_LINE): BOOLEAN
			-- Determines if a token is an Eiffel identifier token
			--
			-- `a_token' : The token to determine if to be an identifier token.
			-- `Result'  : True if the supplied token is an identifier token; False otherwise.
		local
			l_image: STRING_32
			i, l_count: INTEGER
			c32: CHARACTER_32
			c: CHARACTER
		do
			if is_text_token (a_token, Void, False) and then not is_keyword_token (a_token, Void) then
				l_image := a_token.wide_image
				check attached l_image end
				if not l_image.is_empty then
					Result := True
					l_count := l_image.count
					from i := 1 until i > l_count or not Result loop
						c32 := l_image.item (i)
						if c32.is_character_8 then
							c := c32.to_character_8
							Result := c.is_alpha
							if not Result and then i > 1 then
								Result := c.is_digit or else c = '_'
							end
						else
							check editor_is_now_accepting_unicode: False end
						end
						i := i + 1
					end
				end
			end
		end

feature -- Basic operations

	scan_for_type (a_start_token: attached EDITOR_TOKEN; a_start_line: attached EDITOR_LINE; a_end_token: detachable EDITOR_TOKEN): detachable TUPLE [token: attached EDITOR_TOKEN; line: attached EDITOR_LINE]
			-- Scans for a type.
			--
			-- `a_start_token': A token to commence scanning.
			-- `a_line'       : The line where the supplied token is resident.
			-- `Result'       : A resulting token and resident line, or Void if no previous token exists.
		require
			a_start_token_has_a_token: a_start_line.has_token (a_start_token)
			a_end_token_different_to_a_start_token: a_start_token /~ a_end_token
			a_start_token_is_text: a_start_token.is_text
		local
			l_image: attached STRING
			l_token: attached EDITOR_TOKEN
			l_line: attached EDITOR_LINE
			l_next: detachable like next_text_token
			l_match: detachable like next_text_token
		do
			if is_attachment_token (a_start_token, a_start_line) then
					-- Start of the type, using an attachment mark
				l_next := next_text_token (a_start_token, a_start_line, True, a_end_token)
			else
				l_next := [a_start_token, a_start_line]
			end
			if l_next /= Void then
				l_token := l_next.token
				if attached {EDITOR_TOKEN_CLASS} l_token as l_class then
					l_line := l_next.line

						-- An actual type declaration.
					l_next := next_text_token (l_token, l_next.line, True, a_end_token)
					if l_next /= Void then
						l_image := token_text_8 (l_next.token)
						if l_image.is_equal ("[") then
								-- Continuation of type declaration, with actual generics.
							l_match := brace_matcher.match_opening_brace (l_next.token, l_next.line, a_end_token)
							if l_match /= Void then
									-- Full type declration retrieved, set new token and line
								l_token := l_match.token
								l_line := l_match.line
							end
						end
					end
					Result := [l_token, l_line]
				else
					if is_keyword_token (l_token, {EIFFEL_KEYWORD_CONSTANTS}.like_keyword) then
							-- An anchored type declaration.
						l_next := next_text_token (l_token, l_next.line, True, a_end_token)
						if l_next /= Void then
								-- Should be the feature name now.
							Result := l_next
						end
					end
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_token_is_text: Result /= Void implies Result.token.is_text
		end

feature {NONE} -- Helpers

	brace_matcher: attached ES_EDITOR_BRACE_MATCHER
			-- Shared access to a brace matcher to match expressions and signature braces.
		once
			create Result
		end

	block_matcher: attached ES_EDITOR_BLOCK_BRACE_MATCHER
			-- Shared access to a block/brace matcher to match expressions and signature braces.
		once
			create Result
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
