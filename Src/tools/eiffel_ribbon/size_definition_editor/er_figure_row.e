note
	description: "[
					Collect figures in one row
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_FIGURE_ROW

inherit
	COMPARABLE
		undefine
			is_equal,
			copy
		end

	ARRAYED_LIST [ER_FIGURE]
		redefine
			is_equal
		end
create
	make

feature -- Compare

	is_less alias "<" (a_other: ER_FIGURE_ROW): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		local
			l_first_item: ER_FIGURE
		do
			if attached first_item as l_item then
				if a_other.count >= 1 then
					l_first_item := a_other.first
					Result := (l_item.x < l_first_item.x)
					if l_item.x = l_first_item.x then
						Result := (l_item.y < l_first_item.y)
					end
				end
			end
		end

	is_equal (a_other: ER_FIGURE_ROW): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		local
			l_first_item: ER_FIGURE
		do
			if attached first_item as l_item then
				if a_other.count >= 1 then
					l_first_item := a_other.first
					Result := (l_first_item.x = l_item.x) and (l_first_item.y = l_item.y)
				end
			end
		end

	first_item: detachable ER_FIGURE
			-- First item if exists
		do
			if count >= 1 then
				Result := first
			end
		end
note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
