indexing
	description: "Multiple tool manager item"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_MULTIPLE_MANAGER_BASIC_ITEM

inherit
	EB_MULTIPLE_MANAGER_ITEM

creation
	make

feature {NONE} -- Initialization

	make (c: like container) is
			-- Initialize Current by putting `c' in `container'.
		do
			container := c
		end

feature -- Access

	container: EV_CONTAINER

end -- class EB_MULTIPLE_MANAGER_BASIC_ITEM
