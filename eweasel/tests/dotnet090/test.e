class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_b: B
		do
			create l_b.make
			print (l_b.get_type.get_constructors.count)
			print ("%N")
		end

end
