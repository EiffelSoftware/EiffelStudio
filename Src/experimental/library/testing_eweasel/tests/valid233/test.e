class
	TEST

inherit
	A
		rename
			a as make,
			b as make
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
		end

end