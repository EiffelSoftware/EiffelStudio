indexing
	description: "Array list for EV_GRID that allows insertion to any position"
	author: ""
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
			{EV_GRID_DRAWER_I, EV_GRID_I}
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
			temp_array: ARRAY [G]
		do
			if new_capacity > count then
				conservative_resize (lower, upper + new_capacity - capacity)
				set_count (capacity)				
			elseif count > 0 then
					-- Shrink existing array only losing items with index greater than `new_capacity'
				temp_array := subarray (lower, upper + new_capacity - capacity)
				make_from_array (temp_array)
			else
				arrayed_list_make (new_capacity)
			end
		ensure
			capacity_set: capacity = new_capacity
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
