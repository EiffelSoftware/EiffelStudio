class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			c: detachable COMPARABLE
			i
			b
			t
			p
		do
			c := 5
			i := c
			b := i < c
			print (b)
			t := [i, b]
			print (t.generating_type)
			p := $t
			print (p.generating_type)
		end

end
