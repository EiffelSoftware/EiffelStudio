class 
	TEST

create
	make, another_simple_make,  make_from_reference, make_from_expanded, make_complex

feature -- Initialization

	make is
			-- A creation procedure
		do

		end

	another_simple_make is
			-- Another creation procedure
		do

		end


	make_from_reference (a: ANY) is
			-- Creation procedure which covers reference types.
		do

		end


	make_from_expanded (i: INTEGER) is
			-- Creation procedure which covers expanded types.
		do

		end

	make_complex (i1, i2: INTEGER; a1, a2: ANY)
			-- Creation procedure which covers a morge complex argument list
		do

		end

	foo is
			-- bar
		do

		end


end -- class TEST
