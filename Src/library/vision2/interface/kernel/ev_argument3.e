indexing
	description: 
		"EiffelVision EV_ARGUMENT3. To be used when passing three%
		% arguments to a command.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ARGUMENT3 [G, H, I]
	
inherit
	EV_ARGUMENT2 [G, H]
		rename
			make as make_2
		end

creation 
	make
	
feature -- Initialization
	
	make (first_element: G; second_element: H; third_element: I) is
			-- Create an argument with `first_element',
			-- `second_element' and `third_element'.
		do
			make_2 (first_element, second_element)
			third := third_element
		end
	
feature -- Access
	
	third: I
			-- Third element of the argument
	
end -- class EV_ARGUMENT3

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
