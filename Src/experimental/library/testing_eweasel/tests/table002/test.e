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
			i: INTEGER
		do
			create h.make (5)
			from
				i := 1
			until
				i > 20
			loop
				h.replace_key (i, 800)
				i := i + 1
			end
		end

end -- class TEST
