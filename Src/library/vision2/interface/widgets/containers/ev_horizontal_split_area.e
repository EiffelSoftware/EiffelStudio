indexing
	description: 
		"Eiffel Vision horizontal split area. Displays `first_item' on the%N%
		%left of a separator and `second_item' on the right."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			implementation
		end
	
create
	default_create

feature {EV_ANY_I} -- Implementation

	implementation: EV_HORIZONTAL_SPLIT_AREA_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of horizontal split area.
		do
			create implementation.make (Current)
		end
	
end -- class EV_HORIZONTAL_SPLIT_AREA

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.4  2000/01/20 18:59:47  oconnor
--| formatting, comments
--|
--| Revision 1.4.6.3  2000/01/20 18:49:09  oconnor
--| reimplemented in line with new EV_SPLIT_AREA
--|
--| Revision 1.4.6.2  2000/01/19 22:16:12  king
--| First foundation of platform independent split area
--|
--| Revision 1.4.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
