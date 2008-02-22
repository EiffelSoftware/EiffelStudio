class TEST

create
	make

feature {NONE} -- Creation.

	make is
			-- Run test.
		local
			a: A
			x: X
			y: Y
		do
			create x
			x.f
			x.g
			a := x
			a.f
			create y
			y.f
			y.g
			a := y
			a.f
			io.put_new_line
		end

end
