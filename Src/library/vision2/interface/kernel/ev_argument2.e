--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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

create 
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

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.4  2000/01/27 19:30:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.3  2000/01/25 00:03:21  oconnor
--| oops, back again :)
--|
--| Revision 1.4.6.1  1999/11/24 17:30:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
