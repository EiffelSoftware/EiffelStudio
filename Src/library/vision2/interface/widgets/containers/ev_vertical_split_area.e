indexing
	description: 
		"Eiffel Vision vertical split area. Displays `first_item' above a%N%   
		%a separator and `second_item' below."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			implementation
		end 
	
create
	default_create

feature {EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_SPLIT_AREA_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of vertical split area.
		do
			create implementation.make (Current)
		end

end -- class EV_VERTICAL_SPLIT_AREA 

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
--| Revision 1.5  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/01/28 20:00:14  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.4  2000/01/21 22:37:09  king
--| Altered interface to fit in with new split area structure
--|
--| Revision 1.4.6.3  2000/01/20 18:59:48  oconnor
--| formatting, comments
--|
--| Revision 1.4.6.2  2000/01/19 22:16:12  king
--| First foundation of platform independent split area
--|
--| Revision 1.4.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
