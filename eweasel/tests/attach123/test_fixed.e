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
			out := "Test data."
			(create {LIBRARY}).test (Current)
		end

feature -- Output

	out: STRING
			-- <Precursor>

end