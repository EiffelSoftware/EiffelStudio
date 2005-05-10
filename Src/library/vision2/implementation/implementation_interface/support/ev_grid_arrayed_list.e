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
			grow
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create EV_GRID arrayed list and initialize to hold zero values
		do
			arrayed_list_make (0)		
		end

feature {EV_GRID_I} -- Implementation

	resize (new_capacity: INTEGER) is
			-- Resize list so that it can contain
			-- at least `n' items. Lose items if `new_capacity' is less than `capacity'
		require
			new_capacity_not_negative: new_capacity >= 0
		local
			i, internal_new_capacity: INTEGER
		do
			if new_capacity > upper then
					-- Resize by 50% to prevent the need for resizing continuously
					-- if `new_capacity' is increased by a small number each time in a loop.
				internal_new_capacity := new_capacity.max (upper + 1 + upper // 2)
				conservative_resize (1, internal_new_capacity)
			elseif new_capacity < count then
					-- Note that we do not reduce the memory footprint, simply
					-- remove the items and update `count'. This is for speed at the sake of
					-- memory usage.

					-- Remove all items so that they can be garbage collected.
				from	
					i := upper
				until
					i = new_capacity
				loop
					put_i_th (Void, i)
					i := i - 1
				end					
			end
				-- Now always set the `count' to `new_capacity' although
				-- the actual area allocated may not equal `new_capacity'.
			set_count (new_capacity)
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
