indexing
	description: "Utilities for EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_UTILITY

feature -- Access

	grid_item_at_position (a_grid: EV_GRID; a_x, a_y: INTEGER): EV_GRID_ITEM is
			-- Item at position (`a_x', `a_y') which is related to the top-left coordinate of `a_grid'
			-- Void if no item is found.
		require
			a_grid_attached: a_grid /= Void
			not_a_grid_is_destroyed: not a_grid.is_destroyed
		local
			l_header_height: INTEGER
		do
			if a_grid.is_header_displayed then
				l_header_height := a_grid.header.height
			end
			Result := a_grid.item_at_virtual_position (a_grid.virtual_x_position + a_x, a_grid.virtual_y_position + a_y - l_header_height)
		end

indexing
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
