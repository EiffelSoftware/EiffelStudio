indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	RGB_TRIPLE 

creation
	make

feature -- Initialisation
	
	make (r, g, b: INTEGER) is
		do
			red := r
			blue := b
			green := g
		end 

feature {COLOR_IMP, COLOR_LOOKUP, PS_HEADER} -- Access

	blue: INTEGER

	green: INTEGER

	red: INTEGER

end -- class RGB_TRIPLE

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

