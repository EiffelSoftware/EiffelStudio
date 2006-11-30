indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			c32: CHARACTER_32
		do
			c32 := '%/0x1FFFFFFFF/'
		end

end
