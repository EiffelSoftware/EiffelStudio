class TEST

inherit
	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			(create {LIBRARY}).test (Current)
			out := "Test data."
		end

feature -- Output

	out: STRING
			-- <Precursor>

end