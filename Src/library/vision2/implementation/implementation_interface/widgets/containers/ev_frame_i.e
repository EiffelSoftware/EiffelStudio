indexing
	description: 
		"Eiffel Vision Frame. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FRAME_I

inherit
	EV_CELL_I
		redefine
			interface
		end
	
	EV_TEXTABLE_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_FRAME_I

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
--| Revision 1.5  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.6  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.3.6.5  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.4  2000/01/18 19:37:56  oconnor
--| inherit textable
--|
--| Revision 1.3.6.3  2000/01/18 07:35:45  oconnor
--| comenting, formatting
--|
--| Revision 1.3.6.2  1999/12/17 18:35:53  rogers
--| Redfined interface to be of a more refined type.
--|
--| Revision 1.3.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:41  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
