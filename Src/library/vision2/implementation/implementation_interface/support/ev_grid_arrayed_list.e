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
			make as arrayed_list_make
		export
			{NONE}
				arrayed_list_make
			{EV_GRID_I}
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
