class TEST

inherit
	TEST1
		redefine
			f, h, k, x
		end

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local 
			t: TEST1
		do
			f (t)
			g (Current)
			h (Current)
		end

	f (a: TEST1)
		do
		end

	h (a: like Current) is
		do
		end

	k (a: STRING) is
		do
		end

	x: PATH_NAME

end
