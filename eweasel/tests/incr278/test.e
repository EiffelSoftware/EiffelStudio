indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization

	make is
		local
			a: A [STRING]
		do
			create a
		end

end -- class TEST
