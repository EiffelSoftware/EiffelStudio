indexing
	description: "[
			Supports Eiffel block brace match scanning functionality in the editor.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_BLOCK_BRACE_MATCHER

inherit
	ES_EDITOR_BRACE_MATCHER
		redefine
			opening_brace_map,
			is_opening_brace,
			is_closing_brace,
			is_opening_match_exception,
			is_closing_match_exception
		end

	ES_EDITOR_KEYWORD_BRACE_MATCHER
		redefine
			opening_brace_map,
			is_opening_brace,
			is_closing_brace,
			is_opening_match_exception,
			is_closing_match_exception
		end

feature -- Access

	opening_brace_map: !HASH_TABLE [!STRING_32, !STRING_32]
			-- <Precursor>
		once
			create Result.make (20)
			Result.merge (Precursor {ES_EDITOR_BRACE_MATCHER})
			Result.merge (Precursor {ES_EDITOR_KEYWORD_BRACE_MATCHER})
		end

feature -- Status report

	is_opening_brace (a_token: !EDITOR_TOKEN): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ES_EDITOR_BRACE_MATCHER} (a_token) or else
				Precursor {ES_EDITOR_KEYWORD_BRACE_MATCHER} (a_token)
		end

	is_opening_match_exception (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ES_EDITOR_BRACE_MATCHER} (a_token, a_line) or else
				Precursor {ES_EDITOR_KEYWORD_BRACE_MATCHER} (a_token, a_line)
		end

	is_closing_brace (a_token: !EDITOR_TOKEN): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ES_EDITOR_BRACE_MATCHER} (a_token) or else
				Precursor {ES_EDITOR_KEYWORD_BRACE_MATCHER} (a_token)
		end

	is_closing_match_exception (a_token: !EDITOR_TOKEN; a_line: !EDITOR_LINE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ES_EDITOR_BRACE_MATCHER} (a_token, a_line) or else
				Precursor {ES_EDITOR_KEYWORD_BRACE_MATCHER} (a_token, a_line)
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
