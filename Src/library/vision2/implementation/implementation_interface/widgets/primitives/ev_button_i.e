indexing
	description:
		"Eiffel Vision button. Implementation interface."
	status: "See notice at end of class"
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_BUTTON_I 

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_BUTTON
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_BUTTON_I

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
--| Revision 1.24  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.6.10  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.23.6.9  2000/01/27 19:30:03  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.6.8  2000/01/19 08:05:54  oconnor
--| removed inheritance of EV_FONTABLE_I
--|
--| Revision 1.23.6.7  2000/01/19 01:44:41  king
--| Added inheritance of EV_FONTABLE_I
--|
--| Revision 1.23.6.6  2000/01/14 02:43:29  oconnor
--| removed inheritance of fontable
--|
--| Revision 1.23.6.5  1999/12/15 16:46:34  oconnor
--| formatting
--|
--| Revision 1.23.6.4  1999/12/10 00:51:25  brendel
--| Cosmetics.
--|
--| Revision 1.23.6.3  1999/11/30 22:47:13  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.23.6.2  1999/11/24 17:30:11  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.23.6.1  1999/11/23 23:56:43  oconnor
--| merged from REVIEW_BRANCH
--|
--| Revision 1.23.2.4  1999/11/18 03:41:14  oconnor
--| rewrote press command handling to use action sequence
--|
--| Revision 1.23.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.23.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
