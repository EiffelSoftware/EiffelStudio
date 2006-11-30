class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			a: ARRAY [ANY]
		do
			create a.make (1, 1)
			a.put (Void, 1)
			a.compare_objects
			if a.has (Void) then
				io.put_string ("Has Void.%N")
			else
				io.put_string ("Does not have Void.%N")
			end
		end

end -- class TEST
