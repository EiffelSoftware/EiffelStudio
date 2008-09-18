indexing
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

	previous_text_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: ?EDITOR_TOKEN): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for the previous token given a start token and line. A predicate can be used to
			-- locate special tokens or else the previous text token will be located.
			--
			-- `a_token'  : The token on the supplied line to find the previous token to.
			-- `a_line'   : The line where the supplied token is resident.
			-- `a_skip_ws': True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `Result'   : A resulting token and resident line, or Void if no previous token exists.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_result: ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
		do
			if a_token /~ a_finish_token then
				if a_finish_token = Void then
					l_result := next_token (a_token, a_line, a_skip_ws, Void)
				else
					l_result := previous_token (a_token, a_line, a_skip_ws, agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE; ia_finish_token: !EDITOR_TOKEN): BOOLEAN
						do
							Result := ia_finish_token ~ ia_token or else ia_token.is_text
						end (?, ?, a_finish_token))
				end
				if l_result /= Void and then {l_token: EDITOR_TOKEN_TEXT} l_result.token then
					Result := [l_token, l_result.line]
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_token_is_text: (Result /= Void and a_skip_ws) implies Result.token.is_text
		end

	next_text_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE; a_skip_ws: BOOLEAN; a_finish_token: ?EDITOR_TOKEN): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for the previous token given a start token and line. A predicate can be used to
			-- locate special tokens or else the previous text token will be located.
			--
			-- `a_token'  : The token on the supplied line to find the previous token to.
			-- `a_line'   : The line where the supplied token is resident.
			-- `a_skip_ws': True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `Result'   : A resulting token and resident line, or Void if no previous token exists.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_result: ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
		do
			if a_token /~ a_finish_token then
				if a_finish_token = Void then
					l_result ?= next_token (a_token, a_line, a_skip_ws, Void)
				else
					l_result ?= next_token (a_token, a_line, a_skip_ws, agent (ia_token: !EDITOR_TOKEN; ia_line: !EDITOR_LINE; ia_finish_token: !EDITOR_TOKEN): BOOLEAN
						do
							Result := ia_finish_token ~ ia_token or else ia_token.is_text
						end (?, ?, a_finish_token))
				end
				if l_result /= Void and then {l_token: EDITOR_TOKEN_TEXT} l_result.token then
					Result := [l_token, l_result.line]
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_token_is_text: (Result /= Void and a_skip_ws) implies Result.token.is_text
		end

feature -- Query

	previous_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE; a_skip_ws: BOOLEAN; a_predicate: ?FUNCTION [ANY, TUPLE [token: EDITOR_TOKEN; line: EDITOR_LINE], BOOLEAN]): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for the previous token given a start token and line. A predicate can be used to
			-- locate special tokens or else the previous text token will be located.
			--
			-- `a_token'  : The token on the supplied line to find the previous token to.
			-- `a_line'   : The line where the supplied token is resident.
			-- `a_skip_ws': True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `Result'   : A resulting token and resident line, or Void if no previous token exists.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_token: ?EDITOR_TOKEN
			l_line: ?EDITOR_LINE
			l_stop: BOOLEAN
		do
			l_token := a_token
			l_line := a_line
			from until l_stop loop
				l_token := l_token.previous
				if l_token = Void then
					l_line := l_line.previous
					if l_line /= Void then
						l_token := l_line.eol_token
					end
				end
				if l_token /= Void and l_line /= Void then
					if a_predicate /= Void then
						if a_predicate.item ([l_token, l_line]) then
							Result := [l_token, l_line]
						end
					elseif l_token.is_text or else (not a_skip_ws and then l_token.is_blank) then
							-- There is no stop condition test predicate, so just locate text tokens
						Result := [l_token, l_line]
					end
					l_stop := Result /= Void
				else
					l_stop := True
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

	next_token (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE; a_skip_ws: BOOLEAN; a_predicate: ?FUNCTION [ANY, TUPLE [token: EDITOR_TOKEN; line: EDITOR_LINE], BOOLEAN]): ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Searches for the next token given a start token and line. A predicate can be used to locate
			-- special tokens or else the next text token will be located.
			--
			-- `a_token'  : The token on the supplied line to find the next token to.
			-- `a_line'   : The line where the supplied token is resident.
			-- `a_skip_ws': True to skip whitespace tokens; False to include text and whitespace tokens.
			-- `Result'   : A resulting token and resident line, or Void if no next token exists.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		local
			l_token: ?EDITOR_TOKEN
			l_line: ?EDITOR_LINE
			l_stop: BOOLEAN
		do
			l_token := a_token
			l_line := a_line
			from until l_stop loop
				l_token := l_token.next
				if l_token = Void then
					l_line := l_line.next
					if l_line /= Void then
						l_token := l_line.first_token
					end
				end
				if l_token /= Void and l_line /= Void then
					if a_predicate /= Void then
						if a_predicate.item ([l_token, l_line]) then
							Result := [l_token, l_line]
						end
					elseif l_token.is_text or else (not a_skip_ws and then l_token.is_blank) then
							-- There is no stop condition test predicate, so just locate text tokens
						Result := [l_token, l_line]
					end
					l_stop := Result /= Void
				else
					l_stop := True
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
		end

feature -- Conversion

	token_text (a_start_token: !EDITOR_TOKEN; a_start_line: !EDITOR_LINE; a_end_token: ?EDITOR_TOKEN): !STRING_32
			-- Retrieve the text representation of a series of tokens.
			--
			-- `a_start_token': The inclusive token to retrieve the token text from.
			-- `a_start_line' : The inclusive line where the start token is resident.
			-- `a_end_token'  : An inclusive token to stop at or Void to fetch the remaining text.
			-- `Result'       : The resulting text.
		require
			a_start_line_has_a_token: a_start_line.has_token (a_start_token)
		local
			l_next: ?like next_token
			l_token: !EDITOR_TOKEN
		do
			create Result.make (200)
			from
				l_next := [a_start_token, a_start_line]
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
		end

feature {NONE} -- Access: Keywords

	feature_body_block_keywords: !HASH_TABLE [BOOLEAN, !STRING_32]
			-- Block initializer keywords that can appear within the confines of a feature.
		once
			create Result.make (15)
			Result.put (True, create {STRING_32}.make_from_string ("from"))
			Result.put (True, create {STRING_32}.make_from_string ("if"))
			Result.put (True, create {STRING_32}.make_from_string ("inspect"))
			Result.merge (feature_body_keywords)
		end

	feature_body_keywords: !HASH_TABLE [BOOLEAN, !STRING_32]
			-- Keywords that mark the beginning of an Eiffel feature body.
		once
			create Result.make (5)
			Result.put (True, create {STRING_32}.make_from_string ("attribute"))
			Result.put (True, create {STRING_32}.make_from_string ("deferred"))
			Result.put (True, create {STRING_32}.make_from_string ("do"))
			Result.put (True, create {STRING_32}.make_from_string ("external"))
			Result.put (True, create {STRING_32}.make_from_string ("once"))
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
