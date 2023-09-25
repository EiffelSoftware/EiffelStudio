note
	description: "[
			Editor token utilitizes to one day replace some of the implementation of {EB_TOKEN_TOOLKIT}.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_TOKEN_UTILITIES

feature -- Query

	token_text (a_token: EDITOR_TOKEN): STRING_32
			-- Retrieve the token image text.
			--
			-- `a_token': Token to retrieve text for.
			-- `Result': Token text, or an empty string if it does not have a representation.
		require
			a_token_attached: a_token /= Void
		do
			if attached a_token.wide_image as l_result then
				Result := l_result
			else
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	token_text_8 (a_token: EDITOR_TOKEN): STRING
			-- Retrieve the token image text.
			--
			-- `a_token': Token to retrieve text for.
			-- `Result': Token text, or an empty string if it does not have a representation.
		require
			a_token_attached: a_token /= Void
		do
			if attached a_token.wide_image as l_result then
				Result := l_result.as_string_8
			else
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	token_range_text (a_start_token: EDITOR_TOKEN; a_start_line: EDITOR_LINE; a_end_token: detachable EDITOR_TOKEN): STRING_32
			-- Retrieve the text representation of a series of tokens.
			--
			-- `a_start_token': The inclusive token to retrieve the token text from.
			-- `a_start_line' : The inclusive line where the start token is resident.
			-- `a_end_token'  : An inclusive token to stop at or Void to fetch the remaining text.
			-- `Result'       : The resulting text.
		require
			a_start_token_attached: a_start_token /= Void
			a_start_line_attached: a_start_line /= Void
			a_start_line_has_a_token: a_start_line.has_token (a_start_token)
		local
			l_next: detachable like next_token
			l_token: EDITOR_TOKEN
		do
			create Result.make (200)
			from
				l_next := token_line_data (a_start_token, a_start_line)
			until
				l_next = Void
			loop
				l_token := l_next.token
				if l_token.is_text or l_token.is_blank then
					Result.append (l_token.wide_image)
				end
				if a_end_token = Void or else l_token /= a_end_token then
					l_next := next_text_token (l_token, l_next.line, False, a_end_token)
				else
						-- End loop
					l_next := Void
				end
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_character_8_token (a_token: EDITOR_TOKEN; a_char_8: CHARACTER_8; a_ignore_case: BOOLEAN): BOOLEAN
			-- Detemines if a token is a specific text token.
			--
			-- `a_token'      : The token to determine if to be a specific keyword.
			-- `a_char_8'     : The single-character text of the token to match a token.
			-- `a_ignore_case': True to match case insensitive; False otherwise.
			-- `Result'       : True if the supplied token is a keyword with the given text; False otherwise.
		require
			a_token_attached: a_token /= Void
		local
			l_token_text_8: like token_text_8
			c: CHARACTER_8
		do
			if attached {EDITOR_TOKEN_TEXT} a_token then
				l_token_text_8 := token_text_8 (a_token)
				if l_token_text_8.count = 1 then
					c := l_token_text_8.item (1)
					if a_ignore_case then
						Result := c.as_lower = a_char_8
					else
						Result := c = a_char_8
					end
				end
			end
		end

	is_text_token (a_token: EDITOR_TOKEN; a_text: detachable READABLE_STRING_GENERAL; a_ignore_case: BOOLEAN): BOOLEAN
			-- Detemines if a token is a specific text token.
			--
			-- `a_token'      : The token to determine if to be a specific keyword.
			-- `a_text'       : The text of the keyword to match or Void to just match a keyword.
			-- `a_ignore_case': True to match case insensitive; False otherwise.
			-- `Result'       : True if the supplied token is a keyword with the given text; False otherwise.
		require
			a_token_attached: a_token /= Void
			not_a_text_is_empty: a_text /= Void implies not a_text.is_empty
		do
			if attached {EDITOR_TOKEN_TEXT} a_token then
				Result := True
				if a_text /= Void then
					if attached {STRING_32} a_text as l_wide_string then
						if a_ignore_case then
							Result := token_text (a_token).is_case_insensitive_equal (l_wide_string)
						else
							Result := token_text (a_token).same_string (l_wide_string)
						end
					else
						if a_ignore_case then
							Result := a_text.is_case_insensitive_equal (token_text (a_token))
						else
							Result := a_text.same_string (token_text (a_token))
						end
					end
				end
			end
		end

	is_keyword_token (a_token: EDITOR_TOKEN; a_keyword: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Detemines if a token is a specific keyword token.
			--
			-- `a_token'  : The token to determine if to be a specific keyword.
			-- `a_keyword': The text of the keyword to match or Void to just match a keyword.
			-- `Result'   : True if the supplied token is a keyword with the given text; False otherwise.
		require
			a_token_attached: a_token /= Void
			not_a_keyword_is_empty: a_keyword /= Void implies not a_keyword.is_empty
		do
			if attached {EDITOR_TOKEN_KEYWORD} a_token then
				Result := True
				if a_keyword /= Void then
					if attached {STRING_32} a_keyword as l_wide_string then
						Result := l_wide_string.is_case_insensitive_equal (token_text (a_token))
					else
						Result := a_keyword.is_case_insensitive_equal (token_text (a_token))
					end
				end
			end
		end

	is_comment_start_token (a_token: EDITOR_TOKEN): BOOLEAN
			-- Detemines if a token is a comment start token.
			--
			-- `a_token' : The token to determine if to be a comment start token.
			-- `Result'  : True if the supplied token is a comment start token; False otherwise.
		require
			a_token_attached: a_token /= Void
		do
			if
				attached {EDITOR_TOKEN_COMMENT} a_token as l_comment and then
				attached l_comment.wide_image as l_image and then
				l_image.count >= 2
			then
				Result := l_image.item (1) = '-' and l_image.item (2) = '-'
			end
		end

	is_scanning_comments: BOOLEAN assign set_is_scanning_comments
			-- Indicates if the scanning includes analysis of comments.

feature -- Status setting

	set_is_scanning_comments (a_scan: BOOLEAN)
			-- Sets state to detemine if comments should be included in scanning or not.
			--
			-- `a_scan': True to include comment tokens when scanning; False otherwise.
		do
			is_scanning_comments := a_scan
		ensure
			is_scanning_comments_set: is_scanning_comments = a_scan
		end

feature -- Query

	previous_text_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: detachable EDITOR_TOKEN): like next_token
			-- Searches for the previous token given a start token and line. A predicate can be used to
			-- locate special tokens or else the previous text token will be located.
			--
			-- `a_token'  : The token on the supplied line to find the previous token to.
			-- `a_line'   : The line where the supplied token is resident.
			-- `a_skip_ws': True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `Result'   : A resulting token and resident line, or Void if no previous token exists.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_token: EDITOR_TOKEN
		do
			if a_token /~ a_finish_token then
				if attached previous_token (a_token, a_line, a_skip_ws, a_finish_token, Void) as l_result then
					l_token := l_result.token
					if l_token.is_text or else (not (l_token.is_blank or else l_token.is_tabulation or else l_token.is_new_line) or else not a_skip_ws) then
						Result := token_line_data (l_token, l_result.line)
					end
				end
			end
		ensure
			result_token_attached: Result /= Void implies Result.token /= Void
			result_line_attached: Result /= Void implies Result.line /= Void
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_token_is_text: (Result /= Void and a_skip_ws) implies Result.token.is_text
		end

	next_text_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: detachable EDITOR_TOKEN): like next_token
			-- Searches for the next token given a start token and line. A predicate can be used to
			-- locate special tokens or else the next text token will be located.
			--
			-- `a_token'  : The token on the supplied line to find the previous token to.
			-- `a_line'   : The line where the supplied token is resident.
			-- `a_skip_ws': True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `Result'   : A resulting token and resident line, or Void if no previous token exists.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_token: EDITOR_TOKEN
		do
			if a_token /~ a_finish_token then
				if attached next_token (a_token, a_line, a_skip_ws, a_finish_token, Void) as l_result then
					l_token := l_result.token
					if l_token.is_text or else (not (l_token.is_blank or else l_token.is_tabulation or else l_token.is_new_line) or else not a_skip_ws) then
						Result := token_line_data (l_token, l_result.line)
					end
				end
			end
		ensure
			result_token_attached: Result /= Void implies Result.token /= Void
			result_line_attached: Result /= Void implies Result.line /= Void
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_token_is_text: (Result /= Void and a_skip_ws) implies Result.token.is_text
		end

feature -- Query

	previous_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: detachable EDITOR_TOKEN; a_predicate: detachable FUNCTION [like token_line_data, BOOLEAN]): like next_token
			-- Searches for the previous token given a start token and line. A predicate can be used to
			-- locate special tokens or else the previous text token will be located.
			--
			-- `a_token'       : The token on the supplied line to find the next token to.
			-- `a_line'        : The line where the supplied token is resident.
			-- `a_skip_ws'     : True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `a_finish_token': An optional token to terminate navigation at.
			-- `a_predicate'   : An optional predicate to detemine result matching applicability.
			-- `Result'        : A resulting token and resident line, or Void if no next token exists.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_token: detachable EDITOR_TOKEN
			l_line: detachable EDITOR_LINE
			l_prev: detachable like previous_token
			l_scan_comments: BOOLEAN
			l_stop: BOOLEAN
		do
			if a_token /~ a_finish_token then
				l_token := a_token
				l_line := a_line
				l_scan_comments := is_scanning_comments
				from until l_stop loop
					l_token := l_token.previous
					if l_token = Void then
						l_line := l_line.previous
						if l_line /= Void then
							l_token := l_line.eol_token
						end
					end
					if l_token /= Void and l_line /= Void then
						if not l_token.is_margin_token and then not l_token.is_fake then
							if l_scan_comments or else not attached {EDITOR_TOKEN_COMMENT} l_token then
								if a_predicate /= Void then
									if a_predicate.item ([l_token, l_line]) then
										Result := token_line_data (l_token, l_line)
									end
								elseif l_token.is_text or else (not (l_token.is_blank or else l_token.is_tabulation or else l_token.is_new_line) or else not a_skip_ws) then
										-- There is no stop condition test predicate, so just locate text tokens
									Result := token_line_data (l_token, l_line)
								end
								l_stop := Result /= Void
							else
									-- Find the previous comment start token
								if not is_comment_start_token (l_token) then
									if not l_scan_comments then
										set_is_scanning_comments (True)
									end
									l_prev := previous_token_simplified (l_token, l_line, True, a_finish_token, agent is_comment_start_token)
									if not l_scan_comments then
										set_is_scanning_comments (l_scan_comments)
									end
									l_stop := l_prev = Void
									if l_prev /= Void then
										l_token := l_prev.token
										l_line := l_prev.line
									end
								end
							end
						end
					else
							-- The top of the document was hit, which means there should have not been a finish token.
						check a_finish_token_detached: a_finish_token = Void end
						l_stop := True
					end

					if not l_stop and then l_token ~ a_finish_token then
						l_stop := True
					end
				end
			end
		ensure
			result_token_attached: Result /= Void implies Result.token /= Void
			result_line_attached: Result /= Void implies Result.line /= Void
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

	previous_token_simplified (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: detachable EDITOR_TOKEN; a_predicate: FUNCTION [TUPLE [token: EDITOR_TOKEN], BOOLEAN]): like next_token
			-- Searches for the previous token given a start token and line. A predicate can be used to
			-- locate special tokens or else the previous text token will be located.
			--
			-- `a_token'       : The token on the supplied line to find the next token to.
			-- `a_line'        : The line where the supplied token is resident.
			-- `a_skip_ws'     : True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `a_finish_token': An optional token to terminate navigation at.
			-- `a_predicate'   : A predicate to detemine result matching applicability.
			-- `Result'        : A resulting token and resident line, or Void if no next token exists.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_line_has_a_token: a_line.has_token (a_token)
			a_predicate_attached: a_predicate /= Void
		do
			Result := previous_token (a_token, a_line, a_skip_ws, a_finish_token,
				agent (ia_token: EDITOR_TOKEN; ia_line: EDITOR_LINE; ia_predicate: FUNCTION [TUPLE [token: EDITOR_TOKEN], BOOLEAN]): BOOLEAN
					do
						Result := ia_predicate.item ([ia_token])
					end (?, ?, a_predicate))
		ensure
			result_token_attached: Result /= Void implies Result.token /= Void
			result_line_attached: Result /= Void implies Result.line /= Void
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

	next_token (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: detachable EDITOR_TOKEN; a_predicate: detachable FUNCTION [like token_line_data, BOOLEAN]): detachable like token_line_data
			-- Searches for the next token given a start token and line. A predicate can be used to locate
			-- special tokens or else the next text token will be located.
			--
			-- `a_token'       : The token on the supplied line to find the next token to.
			-- `a_line'        : The line where the supplied token is resident.
			-- `a_skip_ws'     : True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `a_finish_token': An optional token to terminate navigation at.
			-- `a_predicate'   : An optional predicate to detemine result matching applicability.
			-- `Result'        : A resulting token and resident line, or Void if no next token exists.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_token: detachable EDITOR_TOKEN
			l_line: detachable EDITOR_LINE
			l_scan_comments: BOOLEAN
			l_in_comment: BOOLEAN
			l_stop: BOOLEAN
		do
			if a_token /~ a_finish_token then
				l_token := a_token
				l_line := a_line
				from until l_stop loop
					l_token := l_token.next
					if l_token = Void then
						l_line := l_line.next
						if l_line /= Void then
							l_token := l_line.first_token

								-- Reset comment state because comments are only per-line
							l_in_comment := False
						end
					end
					if l_token /= Void and l_line /= Void then
						if not l_token.is_margin_token and then not l_token.is_fake then
							if l_scan_comments or else (not l_in_comment and then not attached {EDITOR_TOKEN_COMMENT} l_token) then
								if a_predicate /= Void then
									if a_predicate.item ([l_token, l_line]) then
										Result := token_line_data (l_token, l_line)
									end
								elseif l_token.is_text or else (not (l_token.is_blank or else l_token.is_tabulation or else l_token.is_new_line) or else not a_skip_ws) then
										-- There is no stop condition test predicate, so just locate text tokens
									Result := token_line_data (l_token, l_line)
								end
								l_stop := Result /= Void
							else
									-- In a comment so ignore everything until the next line.
								if a_finish_token = Void then
										-- There is no finish token so just skip to the end of the line.
									l_token := l_line.eol_token
								else
										-- We do not simply head to the end of the line because we are looking for a end token.
									l_in_comment := True
								end
							end
						end
					else
							-- The bottom of the document was hit, which means there should have not been a finish token.
						check a_finish_token_detached: a_finish_token = Void end
						l_stop := True
					end

					if not l_stop and then l_token ~ a_finish_token then
						l_stop := True
					end
				end
			end
		ensure
			result_token_attached: Result /= Void implies Result.token /= Void
			result_line_attached: Result /= Void implies Result.line /= Void
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

	next_token_simplified (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: detachable EDITOR_TOKEN; a_predicate: FUNCTION [TUPLE [token: EDITOR_TOKEN], BOOLEAN]): like next_token
			-- Searches for the next token given a start token and line. A predicate can be used to locate
			-- special tokens or else the next text token will be located.
			--
			-- `a_token'       : The token on the supplied line to find the next token to.
			-- `a_line'        : The line where the supplied token is resident.
			-- `a_skip_ws'     : True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `a_finish_token': An optional token to terminate navigation at.
			-- `a_predicate'   : A predicate to detemine result matching applicability.
			-- `Result'        : A resulting token and resident line, or Void if no next token exists.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_predicate_attached: a_predicate /= Void
			a_line_has_a_token: a_line.has_token (a_token)
		do
			Result := next_token (a_token, a_line, a_skip_ws, a_finish_token,
				agent (ia_token: EDITOR_TOKEN; ia_line: EDITOR_LINE; ia_predicate: FUNCTION [TUPLE [token: EDITOR_TOKEN], BOOLEAN]): BOOLEAN
					do
						Result := ia_predicate.item ([ia_token])
					end (?, ?, a_predicate))
		ensure
			result_token_attached: Result /= Void implies Result.token /= Void
			result_line_attached: Result /= Void implies Result.line /= Void
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

	token_line_data (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): TUPLE [token: EDITOR_TOKEN; line: EDITOR_LINE]
			-- Token/line data
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
		do
			Result := [a_token, a_line]
		ensure
			Result_attached: Result /= Void
		end

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
