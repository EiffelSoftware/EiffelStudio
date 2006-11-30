class
	TEST1 [G]

create
	make

feature -- Initialization

	make is
		local
			r: ROUTINE [ANY, TUPLE]
		do
			r := agent foo
			print (r.generating_type)
			print ("%N")
		end

	foo (o: G): like o is
		do
		end

end
