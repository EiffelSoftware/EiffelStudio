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
			-- Run the test.
		do
			;(create {A [TEST]}).f (Current)
		end


feature -- Output

	out: like {ANY}.out = "OK"
			-- <Precursor>

end
