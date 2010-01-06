class
	TEST

create
	make

feature -- Initialization

	make is
		local
			r: ROUTINE [ANY, TUPLE]
			t1: TEST1 [STRING]
			t2: TEST1 [INTEGER]
		do
			r := agent foo
			print (r.generating_type)
			print ("%N")

			create t1.make
			create t2.make
		end

	foo (o: STRING): like o is
		do
		end

end
