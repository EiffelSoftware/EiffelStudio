indexing
	description: 
		"Eiffel Vision frame. A container displayed with a border and%N%
		%optional textual label."
	status: "See notice at end of class"
	keywords: "container, frame, box, border"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FRAME

inherit
	EV_CELL
		undefine
			create_implementation
		redefine
			implementation
		end

	EV_TEXTABLE
		redefine
			implementation
		end

create
	default_create,
	make_with_text

feature {NONE} -- Implementation

	implementation: EV_FRAME_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of frame.
		do
			create {EV_FRAME_IMP} implementation.make (Current)
		end

end -- class EV_FRAME

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
--| Revision 1.7  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.9  2000/02/05 04:14:39  oconnor
--| removed make_with_text
--|
--| Revision 1.6.6.8  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.6.6.7  2000/01/27 19:30:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.6  2000/01/20 18:47:55  oconnor
--| removed invariant text_not_void: text /= Void
--|
--| Revision 1.6.6.5  2000/01/18 19:38:45  oconnor
--| inherit textable
--|
--| Revision 1.6.6.4  2000/01/17 02:47:25  oconnor
--| Removed press action sequence.
--| Added and improved comments.
--| improved attribute names.
--|
--| Revision 1.6.6.3  2000/01/15 02:15:37  oconnor
--| formatting
--|
--| Revision 1.6.6.2  1999/12/17 20:03:29  rogers
--| redefined implementation to be a a more refined type. make_with_text no
--| longer takes a parent. added press actions and create_implementation.
--|
--| Revision 1.6.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
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
