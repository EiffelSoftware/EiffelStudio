indexing
	description: "Test for separate instruction."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SEPARATE_INSTRUCTION

feature

	make is
		local
			x, y, z: separate TEST
		do
			x := Current
			y := Current
			z := Current

				-- One argument.
			separate x as a do
				a.do_nothing
			end

				-- Two arguments.
			separate
				x as a,
				y as b
			do
				a.do_nothing
				b.do_nothing
			end

				-- More than 2 arguments.
			separate
				x as a,
				y as b,
				z as c
			do
				a.do_nothing
				b.do_nothing
				c.do_nothing
			end

		end

end
