indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	RGB_TRIPLE 

create
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

