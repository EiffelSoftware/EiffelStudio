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

feature -- Status report

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer.
		deferred
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET is
			-- Widget at position (`x', `y') if any.
		deferred
		end

feature -- Basic operation

	set_pointer_position (a_x, a_y: INTEGER) is
			-- Set `pointer_position' to (`a_x',`a_y`).		
		deferred
		end

	fake_pointer_button_press (a_button: INTEGER) is
			-- Simulate the user pressing a `a_button' on the pointing device.
		deferred
		end

	fake_pointer_button_release (a_button: INTEGER) is
			-- Simulate the user releasing a `a_button' on the pointing device.
		deferred
		end

	fake_key_press (a_key: EV_KEY) is
			-- Simulate the user pressing a `key'.
		deferred
		end

	fake_key_release (a_key: EV_KEY) is
			-- Simulate the user releasing a `key'.
		deferred
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
--| Revision 1.10  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.9  2001/06/14 18:24:19  rogers
--| Renamed EV_COORDINATES to EV_COORDINATE.
--|
--| Revision 1.8  2001/06/07 23:08:11  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.4.2  2000/10/06 21:40:30  rogers
--| Implemented widget_at_position.
--|
--| Revision 1.2.4.1  2000/05/03 19:09:09  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/04/25 22:54:11  king
--| Removed invalid post-condition on set_pointer_position
--|
--| Revision 1.6  2000/04/11 18:53:04  king
--| Added pointer manipulation deferrals
--|
--| Revision 1.5  2000/04/06 20:12:30  oconnor
--| added pointer position features
--|
--| Revision 1.4  2000/02/22 18:39:45  oconnor
--| updated copyright date and formatting
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
