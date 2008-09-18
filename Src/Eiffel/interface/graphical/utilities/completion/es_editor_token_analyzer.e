indexing
	description: "[
			A utility class for analyzing editor tokens to retrieve logical meaning from a series of tokens.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_TOKEN_ANALYZER

inherit
	ES_EDITOR_TOKEN_UTILITIES
		export
			{NONE} all
		end

feature -- Basic operations

	scan_for_type (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: ?EDITOR_TOKEN): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Scans for a type
		require
			a_start_token_has_a_token: a_start_line.has_token (a_start_token)
			a_end_token_different_to_a_start_token: a_start_token /~ a_end_token
			a_start_token_is_text: a_start_token.is_text
		local
			l_image: STRING
			l_token: !EDITOR_TOKEN
			l_line: !EDITOR_LINE
			l_next: ?like next_text_token
		do
			l_image := a_start_token.wide_image.as_string_8
			if l_image.is_equal ("!") or else l_image.is_equal ("?") then
					-- Start of the type, using an attachment mark
				l_next := next_text_token (a_start_token, a_start_line, True, a_end_token)
			else
				l_next := [a_start_token, a_start_line]
			end
			if l_next /= Void then
				l_token := l_next.token
				if {l_class: EDITOR_TOKEN_CLASS} l_token then
						-- An actual type declaration.
					l_next := next_text_token (l_token, l_next.line, True, a_end_token)
					if l_next /= Void then
						l_token := l_next.token
						l_line := l_next.line

						l_image ?= l_token.wide_image.as_string_8
						if l_image.is_equal ("[") then
								-- Continuation of type declaration, with actual generics.
							l_next := brace_matcher.match_opening_brace (l_token, l_line, a_end_token)
							if l_next /= Void then
									-- Full type declration
								Result := l_next
							end
						end
					end
				else
					if {l_like_keyword: EDITOR_TOKEN_KEYWORD} l_token then
						l_image ?= l_token.wide_image.as_string_8
						if l_image.is_case_insensitive_equal ({ES_EIFFEL_KEYWORD_CONSTANTS}.like_keyword) then
								-- An anchored type declaration.
							l_next := next_text_token (l_token, l_next.line, True, a_end_token)
							if l_next /= Void then
									-- Should be the feature name now.
								Result := l_next
							end
						end
					end
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_token_is_text: Result /= Void implies Result.token.is_text
		end

feature {NONE} -- Helpers

	brace_matcher: !ES_EDITOR_BRACE_MATCHER
			-- Shared access to a brace matcher to match expressions and signature braces.
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
