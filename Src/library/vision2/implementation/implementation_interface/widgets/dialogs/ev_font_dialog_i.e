indexing 
	description: "EiffelVision font selection dialog, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONT_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	font: EV_FONT is
			-- Font selected in `Current'.
		require
		deferred
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		deferred
		end

end -- class EV_FONT_DIALOG_I

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
--| Revision 1.8  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.3  2001/01/31 20:35:23  rogers
--| Removed not for release and not reviewed. Comments.
--|
--| Revision 1.5.4.2  2000/07/25 20:25:45  king
--| Changed to current structure
--|
--| Revision 1.5.4.1  2000/05/03 19:09:03  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.2  2000/01/27 19:29:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.1  1999/11/24 17:30:09  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/04 23:10:39  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.5.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
