indexing
	description: "a ARRAYED_LIST with STOREABLE"
	date: "$Date$"
	revision: "$Revision$"

class
	MA_ARRAYED_LIST_STORABLE [G]

inherit
	ARRAYED_LIST [G]
		redefine
			make
		end
	STORABLE
		undefine
			copy, is_equal
		end

create
	make

create {MA_ARRAYED_LIST_STORABLE}
	make_filled

feature {NONE} -- Initlization

	make (n: INTEGER) is
			-- Creation method
		do
			Precursor {ARRAYED_LIST} (n)
		end


end
