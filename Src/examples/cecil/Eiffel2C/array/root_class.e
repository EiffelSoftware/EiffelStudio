indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	ROOT_CLASS

create
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
			create a. make (1, 10)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ROOT_CLASS

