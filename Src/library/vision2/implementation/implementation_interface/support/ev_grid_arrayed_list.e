indexing
	description: "Array list for EV_GRID that allows insertion to any position"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ARRAYED_LIST [G]

inherit
	ARRAYED_LIST [G]
		redefine
			grow
		end

create
	make

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
