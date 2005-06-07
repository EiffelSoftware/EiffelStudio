indexing
	description: "Array list for EV_GRID that allows insertion to any position."
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
			{EV_GRID_DRAWER_I, EV_GRID_I, EV_GRID_ROW_I}
				area
		redefine
			grow,
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Create EV_GRID arrayed list and initialize to hold zero values.
		do
			lower := 1
			create area.make (0)
		end

feature {EV_GRID_I} -- Implementation

	move_items (i, j, n: INTEGER) is
			-- Move `n' items starting at index `i' to index `j'.
		require
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_count: i <= count
			j_valid: j <= count + 1
			n_valid: i + n <= count + 1	
		local
			a_duplicate: like Current
			l_default: G
			a_count: INTEGER
		do
			if j < i or else j >= i + n then
				a_count := count
				index := i
				a_duplicate := duplicate (n)

					-- Move existing items up.
				area.move_data ((i - 1) + n, i - 1, a_count - ((i - 1) + n))

					-- Remove duplicated entries resulting from move and reset count.
				a_count := a_count - n
				area.fill_with (l_default, a_count, upper - 1)
				count := a_count

				if j > (i + n - 1) then
					index := j - n
				else
					index := j - 1
				end
				merge_right (a_duplicate)
			end
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

end
