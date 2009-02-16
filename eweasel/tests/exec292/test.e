class
	TEST

create
	make

feature

	make
		local
			t1: TEST1 [STRING, STRING]
			t2: TEST1 [detachable STRING, detachable STRING]
			t3: TEST1 [attached STRING, attached STRING]
			t4: TEST4 [STRING, STRING]
			t5: TEST4 [detachable STRING, detachable STRING]
			t6: TEST4 [attached STRING, attached STRING]
		do
			create t1
			create t2
			create t3
			create t4
			create t5
			create t6
			io.put_string ("Step 1%N")
			t1.f
			io.put_string ("Step 2%N")
			t2.f
			io.put_string ("Step 3%N")
			t3.f
			io.put_string ("Step 4%N")
			t4.f
			io.put_string ("Step 5%N")
			t5.f
			io.put_string ("Step 6%N")
			t6.f
		end

end
