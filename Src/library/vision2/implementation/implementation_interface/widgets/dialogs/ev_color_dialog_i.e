indexing 
	description: "EiffelVision color selection dialog %
		%implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLOR_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	color: EV_COLOR is
			-- Currently selected color.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		end

end -- class EV_COLOR_DIALOG_I

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
--| Revision 1.8  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.7  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.5  2000/08/14 17:59:00  rogers
--| Removed fixme not_reviewed. Comments.
--|
--| Revision 1.4.4.4  2000/08/14 17:42:29  rogers
--| Removed fixme not for release.
--|
--| Revision 1.4.4.3  2000/07/20 18:56:47  king
--| select_color->set_color
--|
--| Revision 1.4.4.2  2000/06/21 19:08:37  rogers
--| Now inherits from EV_STANDARD_DIALOG_I instead of EV_SELECTION_DIALOG_I.
--| Removed old command association."
--|
--| Revision 1.4.4.1  2000/05/03 19:09:03  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.2  2000/01/27 19:29:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:08  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.3  1999/11/04 23:10:39  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
