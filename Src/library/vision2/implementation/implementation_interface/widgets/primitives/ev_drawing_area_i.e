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

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

end -- class EV_DRAWING_AREA_I

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
--| Revision 1.12  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
