note
	description: "Helper for grid item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_ITEM_HELPER

feature -- Access

	relative_position (a_grid_item: EV_GRID_ITEM; a_x, a_y: INTEGER): EV_COORDINATE
			-- Position relative to top-left corner of `a_grid_item' from (`a_x', `a_y')
		require
			a_grid_item_attached: a_grid_item /= Void
			a_grid_item_parented: a_grid_item.is_parented
		local
			l_x: INTEGER
			l_y: INTEGER
			l_header_height: INTEGER
			l_grid: EV_GRID
		do
			l_grid := a_grid_item.parent
			l_x := a_x - (a_grid_item.virtual_x_position - l_grid.virtual_x_position )
			if l_grid.is_header_displayed then
				l_header_height := l_grid.header.height
			end
			l_y := a_y - (a_grid_item.virtual_y_position - l_grid.virtual_y_position ) - l_header_height
			create Result.make (l_x, l_y)
		ensure
			result_attached: Result /= Void
		end

	relative_pointer_position (a_grid_item: EV_GRID_ITEM): EV_COORDINATE
			-- Pointer position relative to top-left corner of `a_grid_item'
		require
			a_grid_item_attached: a_grid_item /= Void
			a_grid_item_parented: a_grid_item.is_parented
		local
			l_parent_pointer_position: EV_COORDINATE
		do
			l_parent_pointer_position := a_grid_item.parent.pointer_position
			Result := relative_position (a_grid_item, l_parent_pointer_position.x, l_parent_pointer_position.y)
		ensure
			result_attached: Result /= Void
		end

note
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
