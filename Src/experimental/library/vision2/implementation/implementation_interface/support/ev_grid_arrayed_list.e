note
	description: "Array list for EV_GRID that allows insertion to any position."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ARRAYED_LIST [G -> detachable ANY]

inherit
	ARRAYED_LIST [G]
		rename
			resize as arrayed_list_resize
		export
			{NONE}
				make
			{ARRAYED_LIST, EV_GRID_DRAWER_I, EV_GRID_I, EV_GRID_ROW_I}
				area, upper
		redefine
			default_create
		end

create
	default_create,
	make

create {EV_GRID_ARRAYED_LIST}
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Create EV_GRID arrayed list and initialize to hold zero values.
		do
			make_empty_area (0)
		end

feature {EV_GRID_I, EV_GRID_ROW_I, ANY} -- Implementation

	shift_items (i, j, n: INTEGER)
			-- Shift `n' items starting at index `i' to index `j'.
		require
			i_valid: i > 0 and then i <= count
			j_valid: j > 0 and then j <= count
			n_valid: n > 0 and then n <= count - i + 1
		local
			a_duplicate: like Current
			a_count: INTEGER
			l_original_index: INTEGER
			current_index: INTEGER
			m: INTEGER
		do
				-- Save index for restoring later.
			l_original_index := index
			a_count := count
			from
				m := n
				create a_duplicate.make (n)
				current_index := i
			until
				m <= 0
			loop
				a_duplicate.extend (i_th (current_index))
				current_index := current_index + 1
				m := m - 1
			variant
				m
			end

				-- Move existing items up.
			area.move_data ((i - 1) + n, i - 1, a_count - ((i - 1) + n))

				-- Remove duplicated entries resulting from move and reset count.
			a_count := a_count - n
			area.fill_with_default (a_count, upper - 1)

			index := j - 1

			if index < a_count then
				subcopy (Current, index + 1, a_count, index + a_duplicate.count + 1)
			end
			subcopy (a_duplicate, 1, a_duplicate.count, index + 1)

				-- Restore index
			index := l_original_index
		end

	move_items (i, j, n: INTEGER)
			-- Move `n' items starting at index `i' immediately before index `j'.
		require
			i_valid: i > 0 and then i <= count
			j_valid: j > 0 and then j <= count + 1
			n_valid: n > 0 and then n <= count - i + 1
		local
			a_duplicate: like Current
			a_count: INTEGER
			l_original_index: INTEGER
			current_index: INTEGER
			m: INTEGER
		do
				-- Save index for restoring later.
			l_original_index := index
			a_count := count
			index := i
			from
				m := n
				create a_duplicate.make (n)
				current_index := i
			until
				m <= 0
			loop
				a_duplicate.extend (i_th (current_index))
				current_index := current_index + 1
				m := m - 1
			variant
				m
			end

				-- Move existing items up.
			area.move_data ((i - 1) + n, i - 1, a_count - ((i - 1) + n))

				-- Remove duplicated entries resulting from move and reset count.
			a_count := a_count - n
			area.fill_with_default (a_count, upper - 1)

				-- Calculate insertion index to insert before index `j'
			if j > i + n - 1 then
				index := j - n - 1
			else
				index := j - 1
			end

			if index < a_count then
				subcopy (Current, index + 1, a_count, index + a_duplicate.count + 1)
			end
			subcopy (a_duplicate, 1, a_duplicate.count, index + 1)

				-- Restore index.
			index := l_original_index
		end

	resize (new_capacity: INTEGER)
			-- Resize list so that it can contain
			-- at least `n' items. Lose items if `new_capacity' is less than `capacity'
		require
			new_capacity_not_negative: new_capacity >= 0
		local
			l_upper: INTEGER
		do
			l_upper := upper
			if new_capacity > upper then
					-- Increase capacity
				area_v2 := area_v2.aliased_resized_area_with_default (({G}).default, new_capacity)
			end
			area.keep_head (new_capacity)
				-- Ensure index is now valid if it was previously in the
				-- items that were removed.
			index := index.min (new_capacity + 1)
		ensure
			count_set: count = new_capacity
		end

feature {NONE} -- Implementation

	subcopy (other: like Current; start_pos, end_pos, index_pos: INTEGER_32)
			-- Copy items of `other' within bounds `start_pos' and `end_pos'
			-- to current array starting at index `index_pos'.
		require
			other_not_void: other /= Void
			valid_start_pos: other.valid_index (start_pos)
			valid_end_pos: other.valid_index (end_pos)
			valid_bounds: (start_pos <= end_pos) or (start_pos = end_pos + 1)
			valid_index_pos: valid_index (index_pos)
			enough_space: (upper - index_pos) >= (end_pos - start_pos)
		do
			area.copy_data (other.area, start_pos - other.lower, index_pos - lower, end_pos - start_pos + 1)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
