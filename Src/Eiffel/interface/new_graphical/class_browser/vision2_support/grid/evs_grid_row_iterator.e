indexing
	description: "Object that represents a row iterator for EV_GRID_WRAPPER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_ROW_ITERATOR

inherit
	EVS_GRID_ORDERED_ITERATOR
		rename
			comparator as comparator_by_row
		redefine
			comparator_by_row
		end

create
	make,
	make_with_first_item,
	make_with_last_item,
	make_with_first_selected_item,
	make_with_last_selected_item

feature -- Access

	index: INTEGER is
			-- Index of current position
		do
			Result := y_internal * grid_wrapper.grid_column_count + x_internal
		ensure then
			good_result: Result = y_internal * grid_wrapper.grid_column_count + x_internal
		end

feature{NONE} -- Implementation

	internal_after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		do
			Result := is_empty or else x_internal = grid_wrapper.grid_column_count + 1
		ensure then
			good_result: Result implies is_empty or else x_internal = grid_wrapper.grid_column_count + 1
		end

	internal_before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		do
			Result := is_empty or else x_internal = 0
		ensure then
			good_result: Result implies (is_empty or else x_internal = 0)
		end

	next_position: EV_COORDINATE is
			-- Next position relative to current position.
		local
			l_grid_wrapper: EVS_GRID_WRAPPER
		do
			l_grid_wrapper := grid_wrapper
			if x_internal = l_grid_wrapper.grid_column_count then
				if y_internal >= l_grid_wrapper.grid_row_count then
						-- We have reached right-bottom of `grid'.
					if is_wrap_iteration_enabled then
						x_internal := 1
						y_internal := 1
					else
						x_internal := x_internal + 1
					end
				else
					x_internal := 1
					y_internal := y_internal + 1
				end
			else
				x_internal := x_internal + 1
			end
			create Result.make (x_internal, y_internal)
		end

	previous_position: EV_COORDINATE is
			-- Previous position relative to current position.
		local
			l_grid_wrapper: EVS_GRID_WRAPPER
		do
			l_grid_wrapper := grid_wrapper
			if x_internal = 1 then
				if y_internal = 1 then
						-- We have reached left-top of `grid'.
					if is_wrap_iteration_enabled then
						x_internal := l_grid_wrapper.grid_column_count
						y_internal := l_grid_wrapper.grid_row_count
					else
						x_internal := 0
						y_internal := 1
					end
				else
					x_internal := l_grid_wrapper.grid_column_count
					y_internal := y_internal - 1
				end
			else
				x_internal := x_internal - 1
			end
			create Result.make (x_internal, y_internal)
		end

	default_invalid_coordinate: EV_COORDINATE is
			-- Default invalid coordinate
		do
			create Result.make (0, 1)
		end

	comparator_by_row: EVS_GRID_ITEM_ROW_POSITION_COMPARATOR is
			-- Comparator to decide position relationship between two grid items
		do
			create Result
		end

invariant
	y_internal_positive: y_internal > 0

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
