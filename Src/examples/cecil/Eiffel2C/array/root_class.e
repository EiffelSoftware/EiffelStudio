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

end -- class ROOT_CLASS

--|----------------------------------------------------------------
--| CECIL: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

