class
	MY_ARRAY [G]
inherit
	ARRAY [G]
create
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

