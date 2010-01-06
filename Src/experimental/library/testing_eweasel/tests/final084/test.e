class TEST
create
	make

feature
	make
		local
			t2: TEST2
			t1: TEST1 [INTEGER]
			t4: TEST4
			h: HASH_TABLE [LIST [TEST2], HASHABLE]
			int: INTERNAL
		do
			create t4
			t1 := t4
			io.put_string (t1.g.generating_type)
			io.put_new_line

			create t2
			t1 := t2
			io.put_string (t1.g.generating_type)
			io.put_new_line

			create h.make (0)
			io.put_string (h.generating_type)
			io.put_new_line

			create int
			if int.dynamic_type (t1.g) /= int.dynamic_type (h) then
				io.put_string ("Not OK!!")
				io.put_new_line
			end
		end

end
