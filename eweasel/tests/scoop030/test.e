class TEST

create
	default_create, make

feature {NONE} -- Creation

        make
		do
			g (create {separate TEST})
		end

feature -- Access

	f (i: INTEGER)
		do
		end

	g (x: separate TEST)
		local
			a: separate TEST
			r: ROUTINE [separate ANY, TUPLE]
		do
			a := x
			r := agent x.f (5)
			r := agent x.g (Current)
			r := agent x.g (a)
			r := agent x.g (e)       -- VUAR(2)         VUAR(4)
			r := agent x.h (Current) --         VUAR(3)
			r := agent x.h (a)       -- VUAR(2) VUAR(3)
			r := agent x.h (e)       --                 VUAR(4)
			r := agent x.w (Current) --         VUAR(3)
			r := agent x.w (a)       -- VUAR(2) VUAR(3)
			r := agent x.w (e)       --                 VUAR(4)
			r := agent x.q (e)       --                 VUAR(4)
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
