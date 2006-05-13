indexing
	description: "Comparator to compare positions of two EV_GRID_ITEM objects by rows"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_ITEM_ROW_POSITION_COMPARATOR

inherit
	EVS_GRID_ITEM_POSITION_COMPARATOR

feature -- Comparator

	comparator (a_item, b_item: EVS_GRID_COORDINATED): BOOLEAN is
			-- Comparator to compare the position order `a_item' and `b_item'.
			-- It will compare row first, and then the column.
		local
			l_ax, l_ay: INTEGER
			l_bx, l_by: INTEGER
		do
			l_ax := a_item.column_index
			l_ay := a_item.row_index
			l_bx := b_item.column_index
			l_by := b_item.row_index
			if l_ay < l_by then
				Result := True
			elseif l_ay = l_by and then l_ax < l_bx then
				Result := True
			end
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
