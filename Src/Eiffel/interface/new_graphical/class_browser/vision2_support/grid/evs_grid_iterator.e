indexing
	description: "Object that represents an iterator for EVS_GRID_WRAPPER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GRID_ITERATOR

inherit
	BILINEAR [EVS_GRID_SEARCHABLE_ITEM]
		redefine
			do_all, do_if, there_exists, for_all,
			search, sequential_search,
			item
		end

feature -- Iteration

	start is
			-- Move to first position if any.
		deferred
		end

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		deferred
		end

	finish is
			-- Move to last position.
		deferred
		end

	back is
			-- Move to previous position.
		deferred
		end

	go_to (x, y: INTEGER) is
			-- Move to position (x, y).
		require
			valid_position: not is_empty and then grid_wrapper.is_position_valid (x, y)
		deferred
		ensure
			position_arrived: not off and then (x_internal = x and y_internal = y)
		end

feature -- Access

	item: EVS_GRID_SEARCHABLE_ITEM is
			-- Item at current position
		deferred
		end

	index: INTEGER is
			-- Index of current position
		deferred
		end

	item_column_index: INTEGER is
			-- Column index of `item'
		require
			not_off: not off
		deferred
		end

	item_row_index: INTEGER is
			-- Row index of `item'
		require
			not_off: not off
		deferred
		end

feature -- Status setting

	enable_wrap_iteration is
			-- Enable wrap iteration.
		do
			is_wrap_iteration_enabled := True
		ensure
			wrap_iteration_enabled: is_wrap_iteration_enabled
		end

	disable_wrap_iteration is
			-- Disable wrap iteration.
		do
			is_wrap_iteration_enabled := False
		ensure
			wrap_iteration_disabled: not is_wrap_iteration_enabled
		end

feature -- Status report

	is_wrap_iteration_enabled: BOOLEAN
			-- Is wrap iteration enabled?

	is_empty: BOOLEAN is
			-- Is there no element?
			-- e.g. Is there no items in `grid_wrapper'.`grid'?
		do
			Result := grid_wrapper.is_grid_empty
		ensure then
			good_result: Result implies grid_wrapper.is_grid_empty
		end

	before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		do
			if is_wrap_iteration_enabled then
				Result := is_empty
			else
				Result := internal_before
			end
		ensure then
			good_result:  (Result implies (not is_wrap_iteration_enabled and then internal_before) or (is_wrap_iteration_enabled and then is_empty)) and
						  (not Result implies (is_wrap_iteration_enabled or else  not internal_before))
		end

	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		do
			if is_wrap_iteration_enabled then
				Result := is_empty
			else
				Result := internal_after
			end
		ensure then
			good_result:  (Result implies (not is_wrap_iteration_enabled and then internal_after) or (is_wrap_iteration_enabled and then is_empty)) and
						  (not Result implies (is_wrap_iteration_enabled or else  not internal_after))
		end

	is_same_position (a_column_index, a_row_index: INTEGER): BOOLEAN is
			-- Is position (`a_column_index', `a_row_index') same as
			-- position of `item'?
		require
			not_off: not off
		do
			Result := a_column_index = item_column_index and a_row_index = item_row_index
		ensure
			good_result: Result implies (a_column_index = item_column_index and a_row_index = item_row_index)
		end

feature -- Iteration

	do_all (action: PROCEDURE [ANY, TUPLE [EVS_GRID_SEARCHABLE_ITEM]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
			-- If `is_wrap_iteration_enabled', it will be turn off temporarily.
		do
			if is_wrap_iteration_enabled then
				disable_wrap_iteration
				Precursor (action)
				enable_wrap_iteration
			else
				Precursor (action)
			end
		end

	do_if (action: PROCEDURE [ANY, TUPLE [EVS_GRID_SEARCHABLE_ITEM]]; test: FUNCTION [ANY, TUPLE [EVS_GRID_SEARCHABLE_ITEM], BOOLEAN]) is
			-- Apply `action' to every item that satisfies `test'.
			-- Semantics not guaranteed if `action' or `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
			-- If `is_wrap_iteration_enabled', it will be turn off temporarily.			
		do
			if is_wrap_iteration_enabled then
				disable_wrap_iteration
				Precursor (action, test)
				enable_wrap_iteration
			else
				Precursor (action, test)
			end
		end

	there_exists (test: FUNCTION [ANY, TUPLE [EVS_GRID_SEARCHABLE_ITEM], BOOLEAN]): BOOLEAN is
			-- Is `test' true for at least one item?
			-- Semantics not guaranteed if `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
			-- If `is_wrap_iteration_enabled', it will be turn off temporarily.			
		do
			if is_wrap_iteration_enabled then
				disable_wrap_iteration
				Result := Precursor (test)
				enable_wrap_iteration
			else
				Result := Precursor (test)
			end
		end

	for_all (test: FUNCTION [ANY, TUPLE [EVS_GRID_SEARCHABLE_ITEM], BOOLEAN]): BOOLEAN is
			-- Is `test' true for all items?
			-- Semantics not guaranteed if `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead.
			-- If `is_wrap_iteration_enabled', it will be turn off temporarily.			
		do
			if is_wrap_iteration_enabled then
				disable_wrap_iteration
				Result := Precursor (test)
				enable_wrap_iteration
			else
				Result := Precursor (test)
			end
		end

feature -- Access

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- If structure does not include `v' ensure that
			-- `exhausted' will be true.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- If `is_wrap_iteration_enabled', it will be turn off temporarily.						
		do
			if is_wrap_iteration_enabled then
				disable_wrap_iteration
				Precursor (v)
				enable_wrap_iteration
			else
				Precursor (v)
			end
		end

feature -- Access

	grid_wrapper: EVS_GRID_WRAPPER
			-- Grid rwapper in which iteration is performed

feature{NONE} -- Implementation

	x_internal: INTEGER
			-- Internal column index

	y_internal: INTEGER
			-- Internal row index


	internal_after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		deferred
		end

	internal_before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		deferred
		end

	sequential_search (v: like item) is
		do
			if is_wrap_iteration_enabled then
				disable_wrap_iteration
				Precursor (v)
				enable_wrap_iteration
			else
				Precursor (v)
			end
		end

	force_go_to (x, y: INTEGER) is
			-- Move to position (x, y) even the position is not valid in `grid_wrapper'.`grid'.
		require
			x_non_negative: x >= 0
			y_non_negative: y >= 0
		do
			x_internal := x
			y_internal := y
		ensure
			position_arrived: x_internal = x and y_internal = y
		end

invariant
	grid_wrapper_attached: grid_wrapper /= Void
	x_internal_non_negative: x_internal >= 0
	y_internal_non_negative: y_internal >= 0

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
