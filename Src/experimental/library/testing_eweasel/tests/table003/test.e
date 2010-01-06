indexing
	description:
		""

	status:	"See notice at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create

	make

feature {NONE} -- Initialization

	make is
		local
			h: HASH_TABLE [INTEGER, INTEGER]
		do
			create h.make (5)
			h.force (0, 1)
			h.replace_key (1, 2)
			
			h.wipe_out
			h.force (0, 1)
			h.force (0, 2)
			h.replace_key (2, 1)
		end

end -- class TEST
