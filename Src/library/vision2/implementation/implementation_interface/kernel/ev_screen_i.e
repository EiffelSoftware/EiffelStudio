indexing 
	description: "EiffelVision screen. Implementation interface."
	status: "See notice at end of class"
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCREEN_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

feature -- Measurement

    width: INTEGER is
            -- Horizontal size in pixels.
		deferred
        ensure
            positive: Result > 0
        end

    height: INTEGER is
            -- Vertical size in pixels.
		deferred
        ensure
            positive: Result > 0
        end

feature {NONE} -- Implementation

	interface: EV_SCREEN

end -- class EV_SCREEN_I

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
--| Revision 1.3  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.6  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.2.6.5  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.4  1999/12/16 03:45:48  oconnor
--| added width and height
--|
--| Revision 1.2.6.3  1999/12/09 19:00:56  brendel
--| Improved cosmetics and indexing clauses.
--|
--| Revision 1.2.6.2  1999/11/30 22:45:13  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.2.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
