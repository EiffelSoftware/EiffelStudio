indexing
	description: "Wild cards matcher for completion names."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WILD_COMPLETION_NAME_MATCHER

inherit
	COMPLETION_NAME_MATCHER
		redefine
			prefix_string
		end

feature -- Match

	prefix_string (a_prefix: STRING; a_string: STRING): BOOLEAN is
			-- Is `a_prefix' start of `a_string'?
		local
			l_pattern: STRING
			l_char: CHARACTER
		do
			if a_prefix.is_empty then
				l_pattern := "*"
			else
				l_pattern := a_prefix.twin.as_lower
				l_char := l_pattern.item (l_pattern.count)
				if not l_char.is_equal ('*') and then not l_char.is_equal ('?')  then
					l_pattern.extend ('*')
				end
			end
			wild_matcher.set_pattern (l_pattern)
			wild_matcher.set_text (a_string.as_lower)
			if wild_matcher.pattern_matches then
				Result := True
			end
		end

feature {NONE} -- Implementation

	wild_matcher: KMP_WILD is
			-- Wild card matcher
		once
			create Result.make_empty
		end

invariant
	invariant_clause: True -- Your invariant here

indexing
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
