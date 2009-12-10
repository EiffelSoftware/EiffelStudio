indexing
	description: "indexable cursor, from ROSE_LINEAR_CURSOR"
	author: "MK"
	date: "$Date$"
	revision: "$Revision$"
	archive: "$File: //rose/source/kernel/infrastructure/containers/rose_linear_cursor.e $"

class LINEAR_CURSOR

inherit
	CURSOR

create
	make

feature {NONE} -- Initialization

	make (a_index: INTEGER) is
			-- Create a cursor and set it up on `current_index'.
		do
			index := a_index
		end

feature {INDEXED_LINEAR} -- Access

	index: INTEGER;
		-- Index of current item

end
