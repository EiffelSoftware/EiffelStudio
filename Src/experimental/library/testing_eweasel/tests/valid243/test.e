class TEST

inherit
	B [D, TEST]
		redefine
			g,
			h
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			g (create {A [TEST]}, Current)
			h (create {D}, Current)
			(create {C [TEST, TEST, D, TEST]}).h (create {D}, Current)
		end

feature {NONE} -- Test

	g (a: A [TEST]; b: TEST)
		do
		end

	h (a: D; b: TEST)
		do
		end

end
