class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is 
		local
			c_str: ANY
		do
			io.put_string ("Enter a string to convert into a C string: %N")
			io.read_line
			eiffel_str := clone (io.last_string)
			c_str := eiffel_str.to_c
			c_printf ($c_str)
		end
						
	
feature {NONE} -- Access
	
	eiffel_str: STRING

feature -- External

	c_printf (ptr: POINTER) is
		external
			"C | %"fext.h%""
		end

end -- STRING_CONVERTER


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

