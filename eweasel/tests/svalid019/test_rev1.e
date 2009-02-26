class TEST

inherit
	B
		redefine
			anchor, g
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			g (create {A [STRING]}, "")
		end

feature {NONE} -- Test

	anchor: A [STRING]

	g (a: like anchor; b: STRING)
		do
		end

end

