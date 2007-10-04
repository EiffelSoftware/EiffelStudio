class TEST
		
create
	make

feature {NONE}

	make is
		local
			t1: TEST1
			t2: TEST2 [TEST4]
		do
			create t2
			t1 := t2
			print (t1.a) print ("%N")
			print (t2.a) print ("%N")
		end


end
