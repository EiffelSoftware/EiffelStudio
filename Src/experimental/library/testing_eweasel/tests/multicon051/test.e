class TEST

inherit
	B [D]
		redefine
			anchor, g
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			g (create {D}, "")
		end

feature {NONE} -- Test

	anchor: D

	g (a: like anchor; b: STRING)
		do
		end

end
