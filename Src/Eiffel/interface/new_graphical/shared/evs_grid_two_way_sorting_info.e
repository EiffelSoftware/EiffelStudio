note
	description: "Object that represents a two-way sorting infomation object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_TWO_WAY_SORTING_INFO [G]

inherit
	EVS_GRID_SORTING_INFO [G]
		rename
			make as old_make
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

create
	make

feature{NONE} -- Initialization

	make (a_comparator: like comparator; a_current_order: INTEGER)
			-- Initialize `comparator' with `a_comparator' and `current_order' with `a_current_order'.
		require
			a_comparator_attached: a_comparator /= Void
		do
			old_make (agent next_sort_order, a_comparator, a_current_order)
			indicator.put (ascending_indicator_pixmap, ascending_order)
			indicator.put (descending_indicator_pixmap, descending_order)
			enable_auto_indicator
		end

feature -- Access

	ascending_indicator: EV_PIXMAP
			-- Indicator for ascending order

	descending_indicator: EV_PIXMAP
			-- Indicator for descending order

feature -- Sort order change

	next_sort_order (a_current_order: INTEGER): INTEGER
			-- Next sort order
		do
			if a_current_order = ascending_order then
				Result := descending_order
			else
				Result := ascending_order
			end
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
