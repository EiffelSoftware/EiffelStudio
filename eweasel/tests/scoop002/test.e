class TEST

create
	default_create, make, f, g, h

feature {NONE} -- Creation

        make
		local
			a: separate TEST
		do
			create a.f (5)
			create a.g (Current)
			create a.g (a)
			create a.g (e)       -- VUAR(2)         VUAR(4)
			create a.h (Current) --         VUAR(3)
			create a.h (a)       -- VUAR(2) VUAR(3)
			create a.h (e)       --                 VUAR(4)
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
			x.g (e)            -- VUAR(2)         VUAR(4)
			x.h (Current)      --         VUAR(3)
			x.h (a)            -- VUAR(2) VUAR(3)
			x.h (e)            --                 VUAR(4)
			b := x.w (Current) --         VUAR(3)
			b := x.w (a)       -- VUAR(2) VUAR(3)
			b := x.w (e)       --                 VUAR(4)
			b := x.q (e)       --                 VUAR(4)
			b := x [Current]   --         VUAR(3)
			b := x [a]         -- VUAR(2) VUAR(3)
			b := x [e]         --                 VUAR(4)
			b := x + Current   --         VUAR(3)
			b := x + a         --                         VWOE
			b := x + e         --                 VUAR(4)
			b := x - e         --                 VUAR(4)
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

	q alias "-" (z: A): BOOLEAN
		do
		end

	e: A
		do
		end

end
