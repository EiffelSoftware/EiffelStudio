class
	TEST

inherit
	TEST2
		redefine
			f, g
		end

create
	make

feature -- Initialization

	make is
		local
			t1: TEST1
		do
			t1.make
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
