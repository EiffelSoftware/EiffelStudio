indexing
	description:
		"EiffelVision EV_ARGUMENT1. To be used when passing one%
		% argument to a command.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_ARGUMENT1 [G]
	
inherit
	EV_ARGUMENT

creation 
	make
	
feature -- Initialization
	
	make (element: G) is
			-- Create an argument with `element'.
		do
			first := element
		end
	
feature -- Access
	
	first: G
			-- First and only data of the argument.
	
end -- class EV_ARGUMENT1

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
