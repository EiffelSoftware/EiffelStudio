indexing
	description: 
		"Eiffel Vision text field. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_FIELD_I
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_I

feature -- Status report

	capacity: INTEGER is
			-- Maximum number of characters field can hold.
		deferred
		end

feature -- Status setting

	set_capacity (a_capacity: INTEGER) is
			-- Assign `a_capacity' to `capacity'.
		require
			a_capacity_not_negative: a_capacity >= 0
		deferred
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	capacity_not_negative: capacity >= 0

end --class EV_TEXT_FIELD_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.20  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.19  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.4.2  2000/07/24 21:30:48  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.16.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.18  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.17  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.6.5  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.16.6.4  2000/01/27 19:30:05  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.6.3  2000/01/18 07:13:26  oconnor
--| rewoked in like with new interface class
--|
--| Revision 1.16.6.2  1999/11/30 22:47:14  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.16.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.3  1999/11/04 23:10:45  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.16.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
