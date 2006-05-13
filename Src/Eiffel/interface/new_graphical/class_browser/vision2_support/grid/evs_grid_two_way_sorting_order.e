indexing
	description: "Two way sorting orders"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_TWO_WAY_SORTING_ORDER

inherit
	EB_SHARED_PIXMAPS

feature -- Sorting order

	ascending_order: INTEGER is 1
			-- Ascending order

	descending_order: INTEGER is 2
			-- Decending order

	topology_order: INTEGER is 3
			-- Topology order

	topology_indicator_pixmap: EV_PIXMAP is
			-- Indicator for `topology_order'
		do
			Result := Void
		end

	ascending_indicator_pixmap: EV_PIXMAP is
			-- Indicator for `ascending_order'
		do
			Result := icon_ascending_sort_color
		end

	descending_indicator_pixmap: EV_PIXMAP is
			-- Indicator for `decending_order'
		do
			Result := icon_descending_sort_color
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
