indexing
	description: "Eiffel Vision fontable, objects that have a font."
	status: "See notice at end of class"
	keywords: "font, name, property"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Access

	font: EV_FONT is
			-- Typeface appearance for `Current'.
			-- Default: FIXME
		do
			Result := implementation.font
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.font)
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		do
			implementation.set_font (a_font)
		ensure
			font_assigned: font.is_equal (a_font)
		end

feature {NONE} -- Implementation

	implementation: EV_FONTABLE_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

invariant
	font_not_void: font /= Void

end -- class EV_FONTABLE

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
--| Revision 1.7  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.9  2000/01/28 20:00:10  oconnor
--| released
--|
--| Revision 1.6.6.8  2000/01/27 19:30:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.7  2000/01/14 02:12:28  oconnor
--| tweaked comments
--|
--| Revision 1.6.6.6  2000/01/06 18:34:57  king
--| Removed undefine clause.
--|
--| Revision 1.6.6.5  1999/12/16 03:49:55  oconnor
--| mutiple inheritance of creation_action_sequences tweaked
--|
--| Revision 1.6.6.4  1999/12/16 03:45:48  oconnor
--| added width and height
--|
--| Revision 1.6.6.3  1999/12/06 18:01:58  brendel
--| Improved contracts.
--|
--| Revision 1.6.6.2  1999/12/04 22:44:50  brendel
--| Improved EV_FONTABLE. EV_DRAWABLE is now fontable.
--|
--| Revision 1.6.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.4  1999/11/23 23:01:25  oconnor
--| undefine create_action_sequences on repeated inherit
--|
--| Revision 1.6.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
 
