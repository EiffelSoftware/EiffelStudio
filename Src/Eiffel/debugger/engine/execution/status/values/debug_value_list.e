note
	description: "Summary description for {DEBUG_VALUE_LIST}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_VALUE_LIST

inherit
	DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]

create
	make, make_equal

feature -- Access

	named_value (n: STRING): detachable ABSTRACT_DEBUG_VALUE
			-- Value named `n' if exists.
		require
			not_void: n /= Void
		local
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			l_item: ABSTRACT_DEBUG_VALUE
		do
			from
				l_cursor := new_cursor
				l_cursor.start
			until
				l_cursor.after or Result /= Void
			loop
				l_item := l_cursor.item
				if attached l_item.name as l_name and then l_name.is_equal (n) then
					Result := l_item
				end
				l_cursor.forth
			end
			l_cursor.go_after
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end


note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
