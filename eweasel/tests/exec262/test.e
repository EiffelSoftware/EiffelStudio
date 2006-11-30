class
	TEST

create make

feature

	make is
		local
			a1: C
		do
			create a1
			print (a1.cursor.generating_type)
			print ("%N")
		end

end
