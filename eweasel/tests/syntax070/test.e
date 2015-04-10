class TEST
create
	make
feature
	
	make
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
			separate x as a, y as b do
				a.do_nothing
				b.do_nothing
			end

				-- More than 2 arguments.
			separate x as a, y as b, z as c do
				a.do_nothing
				b.do_nothing
				c.do_nothing
			end

				-- Other variants.
			separate $ARGUMENTS do
				a.do_nothing
			end
		end

end
