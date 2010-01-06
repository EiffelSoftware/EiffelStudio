class TEST4

feature

	make
		local
			t2: TEST2
			t1: TEST1 [like test_g]
		do
			t1 := t2
			io.put_string (t1.generating_type)
			io.put_new_line
		end

	test_g: STRING

end
