class TEST

create
	make

feature

	make is
		local
			i: INTEGER
		do
			create t2
			create t3

			t1 := t2
			i := t1.f
			io.put_integer (i)
			io.new_line

			t1 := t3
			i := t1.f
			io.put_integer (i)
			io.new_line
		end

	t1: TEST1
	t2: TEST2
	t3: TEST3

end
