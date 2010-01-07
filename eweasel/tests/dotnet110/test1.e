expanded class
	TEST1

inherit
	TEST2
		redefine
			f, g
		end

feature -- Initialization

	make is
		do
			f (6)
		end

	f (i: INTEGER)
		do
			Precursor (i)
		end

	g (i: INTEGER): BOOLEAN is
		do
			print (i)
			print ("%N")
			Result := i > 5 and Precursor (i)
		end

end
