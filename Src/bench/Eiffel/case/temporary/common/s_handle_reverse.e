indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	S_HANDLE_REVERSE


creation
	make

feature -- Initialization

	make ( i,j : INTEGER )is
			-- Creation routine
		do
			x := i
			y := j
		end

feature -- Attributes

	x : INTEGER
		-- coord. of the handle
	y : INTEGER
		-- coord of the handle

end -- class S_HANDLE_REVERSE
