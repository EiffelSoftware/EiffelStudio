class
	TEST

inherit
	TEST2
		redefine
			g
		end

create
	make

feature {NONE} -- Initialization

	make is
		local
			t1: TEST1
		do
			t1.make
			f (6)
		end

	g (i: INTEGER): BOOLEAN is
		do
			print (i)
			print ("%N")
			Result := i > 5 and Precursor (i)
		end

end
