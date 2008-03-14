class TEST 
create
	make
feature

	make is
		local
			t1: TEST1
			t2: TEST2
			b: BOOLEAN
		do
			create t2
			t1 := t2

			b := t1.is_equal (create {TEST1})
		end

end
