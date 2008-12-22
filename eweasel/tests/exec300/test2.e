
expanded class TEST2
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create
		do
			a := 1
			b := 2
			c := 3
			d := 4
			e := 5
			f := 6
			g := 7
		end

	a, b, c, d, e, f, g: DOUBLE

end
