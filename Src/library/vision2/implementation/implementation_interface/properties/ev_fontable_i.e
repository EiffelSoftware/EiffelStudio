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
			-- Typface appearance for `Current'.
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
			font_assigned: font.is_equal (a_font)
		end

feature {NONE} -- Implementation

	interface: EV_FONTABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	font_not_void: font /= Void

end -- class EV_FONTABLE_I

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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
