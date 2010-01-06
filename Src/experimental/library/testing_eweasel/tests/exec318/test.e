class
	TEST

inherit
	TEST2
		redefine
			g, x
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

feature

	g (i: INTEGER): BOOLEAN is
		do
			print (i)
			print ("%N")
			Result := i > 5 and Precursor (i)
		end

	x: INTEGER
		do
		end

end
