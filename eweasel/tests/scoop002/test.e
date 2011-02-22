class TEST

create
       make

feature {NONE} -- Creation

        make
		do
			g (Current)
		end

feature -- Access

	f (i: INTEGER)
		do
		end

	g (x: separate TEST)
		local
			a: separate TEST
		do
			a := x
			x.f (5)
			x.g (Current)
			x.g (a)
			x.h (Current)
			x.h (a)
		end

	h (y: TEST)
		do
		end

end
