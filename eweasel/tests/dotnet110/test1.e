expanded class
	TEST1

inherit
	TEST2
		redefine
			g
		end

feature -- Initialization

	make is
		do
			f (6)
		end

	g (i: INTEGER): BOOLEAN is
		do
			print (i)
			print ("%N")
			Result := i > 5 and Precursor (i)
		end

end
