indexing
	description: "Matcher for completion names."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETION_NAME_MATCHER

feature -- Match

	prefix_string (a_prefix: STRING_32; a_string: STRING_32): BOOLEAN is
			-- Is `a_prefix' start of `a_string'?
		require
			a_prefix_not_void: a_prefix /= Void
			a_string_not_void: a_string /= Void
		local
			lower_s: STRING_32
		do
			if a_string.count >= a_prefix.count then
				lower_s := a_prefix.as_lower
				Result := a_string.as_lower.substring_index_in_bounds (lower_s, 1, lower_s.count) = 1
			end
		end

feature -- Status report

	binary_searchable (a_str: STRING_32): BOOLEAN is
			-- With current matcher, is binary search appliable to `a_str'?
		do
			Result := True
		end

feature {NONE} -- Implementation

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
