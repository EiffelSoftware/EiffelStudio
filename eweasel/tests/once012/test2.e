
expanded class TEST2
inherit
	ANY
		redefine
			default_create
		end
feature
	default_create
		do
			a := 1.0
			b := 2.0
			c := 3.0
			d := 4.0
			e := 5.0
		end
	
	a, b, c, d, e: DOUBLE

end
