
expanded class TEST1
inherit
	MEMORY
		redefine
			default_create
		end
create
	default_create

feature {NONE}
	default_create
		local
			s: STRING
			k: INTEGER
		do
			-- print ("Entering default_create%N")
			a := 0xdeadbeef
			b := 0xdeadbeef
			c := 0xdeadbeef
			d := 0xdeadbeef
			e := 0xdeadbeef
			f := 0xdeadbeef
			g := 0xdeadbeef
			h := 0xdeadbeef
			i := 0xdeadbeef
			j := 0xdeadbeef
			from
				k := 1
			until
				k > 1000
			loop
				create s.make (1000)
				s.fill_blank
				k := k + 1
			end
			a := 0xdeadbeef
			b := 0xdeadbeef
			c := 0xdeadbeef
			d := 0xdeadbeef
			e := 0xdeadbeef
			f := 0xdeadbeef
			g := 0xdeadbeef
			h := 0xdeadbeef
			i := 0xdeadbeef
			j := 0xdeadbeef
			-- print ("Leaving default_create%N")
		end

feature
	a, b, c, d, e, f, g, h, i, j: DOUBLE

end
