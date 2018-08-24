class
	L_TUPLES

create
	make

feature

	make
		note
			status: creator
		do
			x := 5
		ensure
			x > 0
		end

	x: INTEGER

	good (t: TUPLE [a: INTEGER; b: BOOLEAN; c: L_TUPLES])
		require
			t.a > 0
			t.b
			t.c.x > 0
		local
			a: INTEGER
			b: BOOLEAN
			c: L_TUPLES
		do
			a := t.a
			check a > 0 end

			c := t.c
			check c.x > 0 end

			b := t.b
			check b end
		end

	bad (t: TUPLE [d: INTEGER; e: BOOLEAN; f: L_TUPLES])
		require
			t.d > 0
			t.e
			t.f.x > 0
		local
			a: INTEGER
			b: BOOLEAN
			c: L_TUPLES
		do
			a := t.d
			check a = 1 end -- bad

			c := t.f
			check c.x = 1 end -- bad

			b := t.e
			check not b end -- bad
		end

	update_good
		local
			t: TUPLE [n: INTEGER; r: L_TUPLES]
		do
			t := [5, create {L_TUPLES}.make]
			check t.n = 5 end
			check t.r.x > 0 end

			t.unwrap
			t.n := 6
			t.wrap
			check t.n = 6 end
		end

	update_bad
		local
			t: TUPLE [n: INTEGER; r: L_TUPLES]
		do
			t := [5, create {L_TUPLES}.make]
			check t.r.x = 1 end -- bad

			t.unwrap
			t.n := 6
			t.wrap
			check t.n = 5 end -- bad
		end

end
