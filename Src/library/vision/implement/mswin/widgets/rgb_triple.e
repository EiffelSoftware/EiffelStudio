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

feature {COLOR_WINDOWS, COLOR_LOOKUP} -- Access

	blue: INTEGER

	green: INTEGER

	red: INTEGER

end -- class RGB_TRIPLE
--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
