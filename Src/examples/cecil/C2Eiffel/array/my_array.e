class
	MY_ARRAY [G]
inherit
	ARRAY [G]
creation
	make	
feature	-- Display

	display is
			-- Display all items
		local
			i: INTEGER
		do
			io.put_string ("Display an Eiffel Array: %N")
			from 
				i := lower
			until
				i > upper
			loop
				io.put_string ("@")
				io.put_integer (i);
				io.put_string (" = ")
				print (item (i))
				io.new_line
				i := i + 1
			end
		end
		
end -- class MY_ARRAY 
