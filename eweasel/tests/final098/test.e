class
	TEST

create
	make

feature

	make
		do
			g.do_nothing
		end

	g: TEST3 [INTEGER, INTEGER, ANY]
		do
			Result.set_x (x)
			Result.set_y (x)
		end

	x: X

end
