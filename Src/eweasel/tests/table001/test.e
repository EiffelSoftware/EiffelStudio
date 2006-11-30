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
			create h.make (100)
			h.extend (1, 0)
		end

end -- class TEST
