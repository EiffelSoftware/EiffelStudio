class
	ROOT_CLASS

creation
	make

feature	-- Initialization

	a: ARRAY [INTEGER]
	any: ANY
	
	make is
		local 
			i : INTEGER
		do
			io.put_string ("This example create n array on the Eiffel side and print it on the C side%N");
			io.put_string ("Enter 10 integers: %N")	
			!!a. make (1, 10)
			from 
				i := 1
			until
				i > 10
			loop
				io.read_integer
				a.put (io.last_integer, i)
				i := i + 1
			end

			any := a.to_c
			c_print ($any)	
		end

feature --External

	c_print (ptr: POINTER) is
		external
			"C | %"fext.h%""
		end

end -- class ROOT_CLASS
