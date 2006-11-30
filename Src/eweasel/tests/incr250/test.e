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
			child: CHILD
		do
			create child
		end

end -- class TEST
