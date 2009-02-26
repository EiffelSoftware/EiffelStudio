class TEST

inherit
	B
		redefine
			g
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			g (create {A [TEST]}, Current)
		end

feature {NONE} -- Test

	g (a: A [TEST]; b: TEST)
		do
		end

end
