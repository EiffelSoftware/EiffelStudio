class TEST

create
       make, f, g, h

feature {NONE} -- Creation

        make
		local
			a: separate TEST
		do
			create a.f (5)
			create a.g (Current)
			create a.g (a)
			create a.h (Current)
			create a.h (a)
		end

feature -- Access

	f (i: INTEGER)
		do
		end

	g (x: separate TEST)
		local
			a: separate TEST
			b: BOOLEAN
		do
			a := x
			x.f (5)
			x.g (Current)
			x.g (a)
			x.h (Current)
			x.h (a)
			b := x.w (Current)
			b := x.w (a)
			b := x [Current] 
			b := x [a]
			b := x + Current
			b := x + a
		end

	h (y: TEST)
		do
		end

	w alias "[]" (z: TEST): BOOLEAN
		do
		end

	t alias "+" (z: TEST): BOOLEAN
		do
		end

end
