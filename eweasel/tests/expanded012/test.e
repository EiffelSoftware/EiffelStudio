class TEST

create

	make

feature {NONE} -- Creation

	make
		local
			b: BOOLEAN
			c1: CHARACTER_8
			c4: CHARACTER_32
			i1: INTEGER_8
			i2: INTEGER_16
			i4: INTEGER_32
			i8: INTEGER_64
			n1: NATURAL_8
			n2: NATURAL_16
			n4: NATURAL_32
			n8: NATURAL_64
			p: POINTER
			r4: REAL_32
			r8: REAL_64
			t: TYPED_POINTER [TEST]
		do
			b  := True
			c1 := '1'
			c4 := '4'
			i1 := -1
			i2 := -2
			i4 := -4
			i8 := -8
			n1 := 11
			n2 := 22
			n4 := 44
			n8 := 88
			p  := p + 1
			r4 := 444
			r8 := 888
			t.set_item (t + 1)
			print (b);  io.put_new_line
			print (c1); io.put_new_line
			print (c4); io.put_new_line
			print (i1); io.put_new_line
			print (i2); io.put_new_line
			print (i4); io.put_new_line
			print (i8); io.put_new_line
			print (n1); io.put_new_line
			print (n2); io.put_new_line
			print (n4); io.put_new_line
			print (n8); io.put_new_line
			print (p);  io.put_new_line
			print (r4); io.put_new_line
			print (r8); io.put_new_line
			print (t);  io.put_new_line
			create b
			create c1
			create c4
			create i1
			create i2
			create i4
			create i8
			create n1
			create n2
			create n4
			create n8
			create p
			create r4
			create r8
			create t
			print (b);  io.put_new_line
			print (c1.natural_32_code); io.put_new_line
			print (c4); io.put_new_line
			print (i1); io.put_new_line
			print (i2); io.put_new_line
			print (i4); io.put_new_line
			print (i8); io.put_new_line
			print (n1); io.put_new_line
			print (n2); io.put_new_line
			print (n4); io.put_new_line
			print (n8); io.put_new_line
			print (p);  io.put_new_line
			print (r4); io.put_new_line
			print (r8); io.put_new_line
			print (t);  io.put_new_line
		end

end