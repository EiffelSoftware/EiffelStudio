indexing
	description: "Eiffel Vision fontable, implementation interface."
	status: "See notice at end of class"
	keywords: "font, name, property"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	font: EV_FONT is
			-- Typeface appearance for `Current'.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		deferred
		ensure
			assigned: is_usable implies font.is_equal (a_font)
		end

feature {NONE} -- Implementation

	interface: EV_FONTABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	font_not_void: is_usable implies font /= Void

end -- class EV_FONTABLE_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.10  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.9  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.6  2001/02/16 00:18:38  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.6.4.5  2000/09/12 23:02:20  rogers
--| Invariant now includes is_useable.
--|
--| Revision 1.6.4.4  2000/09/08 19:24:22  manus
--| We are not using `interface.font' in post-condition of `set_font' since the interface garantee the
--| bridge pattern, we just use `font'.
--|
--| Revision 1.6.4.3  2000/08/29 17:25:33  king
--| Corrected spelling in comment
--|
--| Revision 1.6.4.2  2000/08/18 19:47:12  king
--| Updated postcondition to account for implementation object change
--|
--| Revision 1.6.4.1  2000/05/03 19:08:59  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/02/22 18:39:41  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:35  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.6  2000/02/04 04:00:10  oconnor
--| released
--|
--| Revision 1.6.6.5  2000/01/27 19:29:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.4  2000/01/14 02:12:15  oconnor
--| tweaked comments
--|
--| Revision 1.6.6.3  2000/01/06 18:39:12  king
--| Added invariant.
--| Added keywords.
--|
--| Revision 1.6.6.2  1999/12/06 18:05:17  brendel
--| Improved comments.
--|
--| Revision 1.6.6.1  1999/11/24 17:30:06  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:35  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
