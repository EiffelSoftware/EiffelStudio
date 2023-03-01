note
	description: "Detector of a block keyword match in the editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_KEYWORD_BRACE_MATCHER

inherit
	ES_EDITOR_PAIRED_MATCHER
		redefine
			is_opening_brace,
			is_closing_brace,
			is_opening_match_exception
		end

feature -- Access

	opening_brace_map: HASH_TABLE [STRING_32, STRING_32]
			-- <Precursor>
		once
			create Result.make (16)

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.across_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.attribute_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.check_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.class_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.debug_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.deferred_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.do_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.export_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.external_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.from_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.if_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.inspect_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.once_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.redefine_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.rename_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.select_keyword))

			Result.put (create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.end_keyword),
			            create {STRING_32}.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.undefine_keyword))
		end

feature -- Status report

	is_opening_brace (a_token: EDITOR_TOKEN): BOOLEAN
			-- <Precursor>
		do
			if attached {EDITOR_TOKEN_KEYWORD} a_token then
				Result := Precursor (a_token)
			end
		end

	is_closing_brace (a_token: EDITOR_TOKEN): BOOLEAN
			-- <Precursor>
		do
			if attached {EDITOR_TOKEN_KEYWORD} a_token then
				Result := Precursor (a_token)
			end
		end

feature {NONE} -- Status report

	is_opening_match_exception (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- <Precursor>
		local
			l_next: detachable like next_text_token
			l_prev: detachable like previous_text_token
			l_image: like {EDITOR_TOKEN}.wide_image
		do
			if attached {EDITOR_TOKEN_KEYWORD} a_token as l_keyword then
				l_image := l_keyword.wide_image
				if l_image.is_case_insensitive_equal_general ({EIFFEL_KEYWORD_CONSTANTS}.once_keyword) then
					l_next := next_text_token (a_token, a_line, True, Void)
						-- Check the token is not a once string.
					Result := l_next /= Void and then attached {EDITOR_TOKEN_STRING} l_next.token
				elseif
					l_image.is_case_insensitive_equal_general ({EIFFEL_KEYWORD_CONSTANTS}.rename_keyword) or else
					l_image.is_case_insensitive_equal_general ({EIFFEL_KEYWORD_CONSTANTS}.export_keyword) or else
					l_image.is_case_insensitive_equal_general ({EIFFEL_KEYWORD_CONSTANTS}.redefine_keyword) or else
					l_image.is_case_insensitive_equal_general ({EIFFEL_KEYWORD_CONSTANTS}.rename_keyword) or else
					l_image.is_case_insensitive_equal_general ({EIFFEL_KEYWORD_CONSTANTS}.select_keyword) or else
					l_image.is_case_insensitive_equal_general ({EIFFEL_KEYWORD_CONSTANTS}.undefine_keyword)
				then
						-- Parent clause is only a valid match if the previous token is a class name.
					l_prev := previous_token (a_token, a_line, True, Void, agent (ia_token: EDITOR_TOKEN; ia_line: EDITOR_LINE): BOOLEAN
							-- We are looking for the parent class declaration which could either be a class name or generic type, in which
							-- case a closing ] might be found.
						require
							ia_token_attached: ia_token /= Void
							ia_line_attached: ia_line /= Void
						do
							if attached {EDITOR_TOKEN_TEXT} ia_token as l_text then
									-- Return matches for all tokens execpt closing square brackets, because we want to skip
									-- over these to find the type. ] are the only acceptable characters before a class type name.
								Result := not (l_text.wide_image.count = 1 and then l_text.wide_image.is_equal ("]"))
							end
						end)
					Result := l_prev = Void or else not attached {EDITOR_TOKEN_CLASS} l_prev.token
				end
			elseif attached {EDITOR_TOKEN_STRING} a_token then
				Result := True
			end
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
