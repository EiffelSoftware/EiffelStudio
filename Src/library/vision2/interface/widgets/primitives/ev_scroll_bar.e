indexing
	description: "Eiffel Vision scrollbar."
	status: "See notice at end of class."
	keywords: "scroll, bar, horizontal, vertical, gauge, leap, step, page"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR

inherit
	EV_GAUGE
		redefine
			implementation
		end

feature {NONE} -- Implementation

	implementation: EV_SCROLL_BAR_I
			-- Platform dependent access.

end -- class EV_SCROLL_BAR

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
--| Revision 1.4  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/02/02 00:57:44  brendel
--| Removed leap-functions since they are now defined in EV_GAUGE.
--|
--| Revision 1.3.6.4  2000/01/31 21:30:17  brendel
--| Improved contracts.
--|
--| Revision 1.3.6.3  2000/01/28 22:24:25  oconnor
--| released
--|
--| Revision 1.3.6.2  2000/01/27 19:30:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:30:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
