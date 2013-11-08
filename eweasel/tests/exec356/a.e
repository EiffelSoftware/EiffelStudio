class A [
		GE1 -> B rename e1 as e1 alias "()" end,
		GE2 -> B rename e2 as e2 alias "()" end,
		GI1 -> B rename i1 as i1 alias "()" end,
		GI2 -> B rename i2 as i2 alias "()" end
	]

feature -- Test

	test_renaming (ge1: GE1; ge2: GE2; gi1: GI1; gi2: GI2)
		do
			io.put_string (ge1 (1)); io.put_new_line
			io.put_string (ge2 (2, 3)); io.put_new_line
			gi1 (4)
			gi2 (5, 6)
		end

	e1 (a1: INTEGER): STRING
		do
			Result := "A.e1: " + a1.out
		end

	e2 (a1, a2: INTEGER): STRING
		do
			Result := "A.e2: " + a1.out + ", " + a2.out
		end

	i1 (a1: INTEGER)
		do
			io.put_string ("A.i1: ")
			io.put_integer (a1)
			io.put_new_line
		end

	i2 (a1, a2: INTEGER)
		do
			io.put_string ("A.i2: ")
			io.put_integer (a1)
			io.put_string (", ")
			io.put_integer (a2)
			io.put_new_line
		end

end