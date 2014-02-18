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
			io.put_new_line
			t := [i, b]
			print (t.generating_type)
			io.put_new_line
			p := $t
			print (p.generating_type)
			io.put_new_line
		end

end
