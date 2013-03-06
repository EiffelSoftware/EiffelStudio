class
	TEST

create 
	make

feature

	make
		local
			t1: TEST1 [REAL_64]
			t2: TEST1 [NATURAL_64]
			t3: TEST1 [detachable ANY]
			t4: TEST1 [TEST2]
			test2: TEST2
		do
			create t1.make (5.0)
			create t2.make (5)
			create t3.make (Void)
			create t4.make (test2)
		end

end
