indexing
	description: "Array list for EV_GRID that allows insertion to any position."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ARRAYED_LIST [G]

inherit
	ARRAYED_LIST [G]
		rename
			make as arrayed_list_make,
			resize as arrayed_list_resize
		export
			{NONE}
				arrayed_list_make
			{EV_GRID_ARRAYED_LIST, EV_GRID_DRAWER_I, EV_GRID_I, EV_GRID_ROW_I}
				area
		redefine
			grow,
			default_create
		end

create
	default_create

create {EV_GRID_ARRAYED_LIST}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create EV_GRID arrayed list and initialize to hold zero values.
		do
			lower := 1
			create area.make (0)
		end

feature {EV_GRID_I, EV_GRID_ROW_I, ANY} -- Implementation

	shift_items (i, j, n: INTEGER) is
			-- Shift `n' items starting at index `i' to index `j'.
		require
			i_valid: i > 0 and then i <= count
			j_valid: j > 0 and then j <= count
			n_valid: n > 0 and then n <= count - i + 1
		local
			a_duplicate: like Current
			l_default: G
			a_count: INTEGER
		do
			a_count := count
			index := i
			a_duplicate := duplicate (n)

				-- Move existing items up.
			area.move_data ((i - 1) + n, i - 1, a_count - ((i - 1) + n))

				-- Remove duplicated entries resulting from move and reset count.
			a_count := a_count - n
			area.fill_with (l_default, a_count, upper - 1)

			if j > (i + n - 1) then
				index := j - n
			else
				index := j - 1
			end
			if index < a_count then
				subcopy (Current, index + 1, a_count, index + a_duplicate.count + 1)
			end
			subcopy (a_duplicate, 1, a_duplicate.count, index + 1)
		end

	move_items (i, j, n: INTEGER) is
			-- Move `n' items starting at index `i' immediately before index `j'.
		require
			i_valid: i > 0 and then i <= count
			j_valid: j > 0 and then j <= count + 1
			n_valid: n > 0 and then n <= count - i + 1
		local
			a_duplicate: like Current
			l_default: G
			a_count: INTEGER
		do
			a_count := count
			index := i
			a_duplicate := duplicate (n)

				-- Move existing items up.
			area.move_data ((i - 1) + n, i - 1, a_count - ((i - 1) + n))

				-- Remove duplicated entries resulting from move and reset count.
			a_count := a_count - n
			area.fill_with (l_default, a_count, upper - 1)

				-- Calculate insertion index to insert before index `j'
			if j > (i + n - 1) then
				index := j - n - 1
			else
				index := j - 1
			end

			if index < a_count then
				subcopy (Current, index + 1, a_count, index + a_duplicate.count + 1)
			end
			subcopy (a_duplicate, 1, a_duplicate.count, index + 1)
		end

	resize (new_capacity: INTEGER) is
			-- Resize list so that it can contain
			-- at least `n' items. Lose items if `new_capacity' is less than `capacity'
		require
			new_capacity_not_negative: new_capacity >= 0
		local
			l_default: G
			l_upper: INTEGER
		do
			l_upper := upper
			if new_capacity > upper then
					-- Resize by 50% to prevent the need for resizing continuously
					-- if `new_capacity' is increased by a small number each time in a loop.
				conservative_resize (1, new_capacity.max (l_upper + 1 + l_upper // 2))
			elseif new_capacity < count then
					-- Note that we do not reduce the memory footprint, simply
					-- remove the items and update `count'. This is for speed at the sake of
					-- memory usage.

					-- Remove all items so that they can be garbage collected.
				area.fill_with (l_default, new_capacity, l_upper - 1)
			end
				-- Now always set the `count' to `new_capacity' although
				-- the actual area allocated may not equal `new_capacity'.
			count := new_capacity

				-- Ensure index is now valid if it was previously in the
				-- items that were removed.
			index := index.min (new_capacity + 1)
		ensure
			count_set: count = new_capacity
		end

feature {NONE} -- Implementation

	grow (i: INTEGER) is
			-- Change the capacity to at least `i'.
		do
			if i > count then
				conservative_resize (lower, upper + i - capacity)
				set_count (capacity)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
