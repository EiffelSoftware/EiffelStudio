class
	TEST

inherit
	BASE

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			print (a)
			print ("%N")
		end
		

feature -- Tests

	a: SYSTEM_STRING assign set_a
		indexing
			property: auto
		do
			-- Implemented a function instead of an attribute
			Result := "Success"
		end

end
