indexing 
	description:
		"Eiffel Vision screen.%N%
		%Drawable that provides for direct drawing on the screen."
	status: "See notice at end of class"
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCREEN

inherit
	EV_DRAWABLE
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature -- Measurement

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		ensure
			bridge_ok: Result = implementation.width
			positive: Result > 0
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := implementation.height
		ensure
			bridge_ok: Result = implementation.height
			positive: Result > 0
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_SCREEN_I

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of drawing area.
		do
			create {EV_SCREEN_IMP} implementation.make (Current)
		end

end -- class EV_SCREEN

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
--| Revision 1.5  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.10  2000/01/28 20:00:22  oconnor
--| released
--|
--| Revision 1.4.6.9  2000/01/27 19:30:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.8  1999/12/17 19:21:05  rogers
--| implementation is now exported to EV_ANY_I.
--|
--| Revision 1.4.6.7  1999/12/16 03:47:51  oconnor
--| added width and height, removed expose action, inablicable
--|
--| Revision 1.4.6.6  1999/12/15 19:17:00  king
--| Removed fixme from interface
--|
--| Revision 1.4.6.5  1999/12/13 19:31:14  oconnor
--| kernel/ev_application.e
--|
--| Revision 1.4.6.4  1999/12/09 23:13:26  brendel
--| Corrected export status of implementation.
--|
--| Revision 1.4.6.3  1999/12/09 19:00:56  brendel
--| Improved cosmetics and indexing clauses.
--|
--| Revision 1.4.6.2  1999/12/04 00:40:00  brendel
--| Added expose_actions.
--|
--| Revision 1.4.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
