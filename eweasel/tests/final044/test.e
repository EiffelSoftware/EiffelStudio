class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			l_test2: TEST2
			l_test1: TEST1 [ANY]
			l_test1_s: TEST1 [STRING]
			a: INTEGER
		do
			create l_test2.make
			l_test1 := l_test2
			print (l_test2.f) print ("%N")

			create l_test1_s.make
			a := l_test1_s.f

			print (l_test1.f) print ("%N")
		end


end
