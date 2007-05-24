class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			a: A
		do
			create a.make
			a.property_a := 10
			print (a.property_a)
			print ("%N")
		end

end