indexing
	description:
		 "EiffelVision EV_ARGUMENT2. To be used when passing two%
		% arguments to a command.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ARGUMENT2 [G, H]

inherit
	EV_ARGUMENT1 [G]
		rename
			make as make_1
		end

creation 
	make

feature -- Initialization

	make (first_element: G; second_element: H) is
			-- Create an argument with `first_element' and
			-- `second_element'.
		do
			make_1 (first_element)
			second := second_element
		end

feature -- Access

	second: H
			-- Second element of the argument

end -- class EV_ARGUMENT2

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
