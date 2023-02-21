note
	description: "Object that represents an ordered (either by columns or by rows) EVS_GRID_WRAPPER iterator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GRID_ORDERED_ITERATOR

inherit
	EVS_GRID_ITERATOR

	EVS_GRID_SORTER

	ITERATION_CURSOR [detachable EVS_GRID_SEARCHABLE_ITEM]

feature{NONE} -- Initialization

	make (start_column, start_row: INTEGER; a_grid_wrapper: like grid_wrapper)
			-- Initialize start iteration point at position (`start_column', `start_row').
			-- If position (`start_column', `start_row') is not valid in `grid_wrapper.grid`,
			-- Initialize start iteration point at `default_invalid_coordinate'.
		require
			grid_wrapper_attached: a_grid_wrapper /= Void
		local
			l_coordinate: like default_invalid_coordinate
		do
			grid_wrapper := a_grid_wrapper
			if grid_wrapper.is_position_valid (start_column, start_row) then
				x_internal := start_column
				y_internal := start_row
			else
				l_coordinate := default_invalid_coordinate
				x_internal := l_coordinate.x
				y_internal := l_coordinate.y
			end
		end

	make_with_first_item (a_grid_wrapper: like grid_wrapper)
			-- Initialize start iteration point at position (1, 1).
		require
			grid_wrapper_attached: a_grid_wrapper /= Void
		do
			make (1, 1, a_grid_wrapper)
		end

	make_with_last_item (a_grid_wrapper: like grid_wrapper)
			-- Initialize start iteration point at the last item in `grid_wrapper'.`grid',
			-- e.g. item at position (`grid'.`column_count', `grid'.`row_count').
		require
			grid_wrapper_attached: a_grid_wrapper /= Void
		do
			if a_grid_wrapper.is_grid_empty then
				make (0, 0, a_grid_wrapper)
			else
				make (a_grid_wrapper.grid_column_count, a_grid_wrapper.grid_row_count, a_grid_wrapper)
			end
		end

	make_with_first_selected_item (a_grid_wrapper: like grid_wrapper)
			-- Initialize start iteration point at the first selected item in `grid_wrapper'.`grid'.
			-- If no item is selected, initialize start iteration point at position (1, 1).
		require
			grid_wrapper_attached: a_grid_wrapper /= Void
		local
			l_list: LIST [EVS_GRID_COORDINATED]
		do
			l_list := a_grid_wrapper.grid_selected_items
			if l_list.is_empty then
				make (1, 1, a_grid_wrapper)
			else
				sort_with_position_comparator (l_list, comparator)
				make (l_list.first.column_index, l_list.first.row_index, a_grid_wrapper)
			end
		end

	make_with_last_selected_item (a_grid_wrapper: like grid_wrapper)
			-- Initialize start iteration point at the last selected item in `grid_wrapper'.`grid'.
			-- If no item is selected, initialize start iteration point at position (1, 1).
		require
			grid_wrapper_attached: a_grid_wrapper /= Void
		local
			l_list: LIST [EVS_GRID_COORDINATED]
		do
			l_list := a_grid_wrapper.grid_selected_items
			if l_list.is_empty then
				make (1, 1, a_grid_wrapper)
			else
				sort_with_position_comparator (l_list, comparator)
				make (l_list.last.column_index, l_list.last.row_index, a_grid_wrapper)
			end
		end

feature -- Iteration

	start
			-- Move to first position if any.
		do
			force_go_to (1, 1)
		end

	forth
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		local
			l_coordinate: EV_COORDINATE
		do
			l_coordinate := next_position
			force_go_to (l_coordinate.x, l_coordinate.y)
		end

	finish
			-- Move to last position.
		do
			force_go_to (grid_wrapper.grid_column_count, grid_wrapper.grid_row_count)
		end

	back
			-- Move to previous position.
		local
			l_coordinate: EV_COORDINATE
		do
			l_coordinate := previous_position
			force_go_to (l_coordinate.x, l_coordinate.y)
		end

	go_to (x, y: INTEGER)
			-- Move to position (x, y).
		do
			force_go_to (x, y)
		end

feature -- Access

	item: detachable EVS_GRID_SEARCHABLE_ITEM
			-- Item at current position
		do
			Result := {like item} / grid_wrapper.grid_item (x_internal, y_internal)
		end

	item_column_index: INTEGER
			-- Column index of `item'
		do
			Result := x_internal
		end

	item_row_index: INTEGER
			-- Row index of `item'
		do
			Result := y_internal
		end

	sortable_list (a_unsortable_list: LIST [EV_GRID_ITEM]): LIST [EVS_GRID_COORDINATED]
			-- A sortable list of EVS_GRID_COORDINATED objects which represents `a_unsortable'
		require
			a_unsortable_list_attached: a_unsortable_list /= Void
		do
			create {ARRAYED_LIST [EVS_GRID_COORDINATED]} Result.make (a_unsortable_list.count)
			from
				a_unsortable_list.start
			until
				a_unsortable_list.after
			loop
				Result.force (coordinated_item (a_unsortable_list.item))
				a_unsortable_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	comparator: EVS_GRID_ITEM_POSITION_COMPARATOR
			-- Comparator to decide position relationship between two grid items
		deferred
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	next_position: EV_COORDINATE
			-- Next position relative to current position.
		require
			grid_not_empty:  not grid_wrapper.is_grid_empty
		deferred
		ensure
			result_attached: Result /= Void
			good_result: Result.x >=0 and Result.y >=0
		end

	previous_position: EV_COORDINATE
			-- Previous position relative to current position.
		require
			grid_not_empty:  not grid_wrapper.is_grid_empty
		deferred
		ensure
			result_attached: Result /= Void
			good_result: Result.x >=0 and Result.y >=0
		end

	default_invalid_coordinate: EV_COORDINATE
			-- Default invalid coordinate
		deferred
		ensure
			result_attached: Result /= Void
		end

	coordinated_item (a_grid_item: EV_GRID_ITEM): EVS_GRID_COORDINATED
			-- EVS_GRID_COORDINATED representation of `a_grid_item'
		require
			a_grid_item_attached: a_grid_item /= Void
			a_grid_item_parented: a_grid_item.is_parented
		do
			create {EVS_EMPTY_COORDINATED_ITEM}Result.make (a_grid_item.column.index, a_grid_item.row.index)
		ensure
			result_attached: Result /= Void
		end

invariant
	comparator_attached: comparator /= Void

note
        copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
        license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
