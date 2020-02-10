note
	description: "Wild cards matcher for completion unicode symbols."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNICODE_SYMBOL_COMPLETION_NAME_MATCHER

inherit
	WILD_COMPLETION_NAME_MATCHER
		redefine
			prefix_string,
			binary_searchable
		end

create
	make_with_minimum_count

feature {NONE} -- Initialization

	make_with_minimum_count (nb: INTEGER)
		require
			nb >= 0
		do
			min_count := nb
		end

feature -- Access

	min_count: INTEGER

feature -- Element change

	set_minimum_count (nb: INTEGER)
		require
			nb >= 0
		do
			min_count := nb
		end

feature -- Match

	prefix_string (a_prefix: STRING_32; a_string: STRING_32): BOOLEAN
			-- Is `a_prefix' start of `a_string'?
		do
			if
				a_prefix.count >= min_count
				or else a_string.count < min_count
			then
				Result := Precursor (a_prefix, a_string)
			end
		end

feature -- Status report

	binary_searchable (a_str: STRING_32): BOOLEAN
		do
			if a_str.count >= min_count then
				Result := Precursor (a_str)
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
