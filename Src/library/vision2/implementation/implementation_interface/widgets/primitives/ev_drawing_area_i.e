indexing
	description: "Eiffel Vision drawing area. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_DRAWING_AREA_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_I

feature -- Drawing operations

	redraw is
			-- Redraw the window without clearing it.
		deferred
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw the rectangle described.
		deferred
		end

	clear_and_redraw is
			-- Redraw the window after clearing it.
		deferred
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear and Redraw the rectangle described.
		deferred
		end

	flush is
			-- Update immediately the screen if needed
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

end -- class EV_DRAWING_AREA_I

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
--| Revision 1.17  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.16  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.11.4.3  2001/05/11 17:09:32  king
--| Updated rectangle functions to use new semantic
--|
--| Revision 1.11.4.2  2000/07/24 21:30:48  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.11.4.1  2000/05/03 19:09:06  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/03/03 03:58:34  pichery
--| added feature `flush'
--|
--| Revision 1.14  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/16 18:08:52  pichery
--| implemented the newly added features: redraw_rectangle, clear_and_redraw,
--| clear_and_redraw_rectangle
--|
--| Revision 1.11.6.10  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.11.6.9  2000/01/27 19:30:03  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.6.8  2000/01/21 21:35:31  oconnor
--| formatting, comments
--|
--| Revision 1.11.6.7  2000/01/17 22:29:57  brendel
--| Removed keywords.
--|
--| Revision 1.11.6.6  2000/01/15 02:07:06  oconnor
--| formatting
--|
--| Revision 1.11.6.5  1999/12/08 17:08:49  brendel
--| Removed commented out pixmapable stuff.
--| Added keywords clause.
--| This is the final version of EV_DRAWING_AREA_I.
--|
--| Revision 1.11.6.4  1999/12/01 01:02:34  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.11.6.3  1999/11/29 17:43:34  brendel
--| Ignore previous log message. Removed old event features. Commented out stuff
--| that needs figuring out.
--|
--| Revision 1.11.6.2  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.11.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.11.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
