--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision pick and drop event data.% 
				%Class for representing pick and drop event data."
	status: "See notice at end of class";
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_EVENT_DATA_IMP

inherit
	EV_PND_EVENT_DATA_I

	EV_BUTTON_EVENT_DATA_IMP

feature -- Implementation

	set_absolute_x (value: INTEGER) is
			-- Let `value' be the absolute x coord
		do
			absolute_x := value
		end

	set_absolute_y (value: INTEGER) is
			-- Let `value' be the absolute x coord
		do
			absolute_y := value
		end
	
end -- class EV_PND_EVENT_DATA_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.6  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.4.2.2.3  2000/01/27 19:29:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.4.2.2.2  1999/12/09 01:25:25  oconnor
--| king: renamed absol_x|y to absolute_x|y
--|
--| Revision 1.2.4.2.2.1  1999/11/24 17:29:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
