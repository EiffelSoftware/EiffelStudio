class TEST

create

	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			n1: NATURAL_8
			n2: NATURAL_16
			n4: NATURAL_32
			n8: NATURAL_64
			i1: INTEGER_8
			i2: INTEGER_16
			i4: INTEGER_32
			i8: INTEGER_64
			r4: REAL_32
			r8: REAL_64
			c1: CHARACTER_8
			c4: CHARACTER_32
			b: BOOLEAN
			p: POINTER
		do
			n1 := 1; print_type (n1)
			n2 := 1; print_type (n2)
			n4 := 1; print_type (n4)
			n8 := 1; print_type (n8)
			i1 := 1; print_type (i1)
			i2 := 1; print_type (i2)
			i4 := 1; print_type (i4)
			i8 := 1; print_type (i8)
			r4 := 1; print_type (r4)
			r8 := 1; print_type (r8)
			c1 := '1'; print_type (c1)
			c4 := '1'; print_type (c4)
			b := True; print_type (b)
			p := default_pointer; print_type (p)
		end

feature {NONE} -- Output

	print_type (a: ANY)
			-- Print type of `a'.
		do
			print (a.generating_type)
			io.put_new_line
		end

end