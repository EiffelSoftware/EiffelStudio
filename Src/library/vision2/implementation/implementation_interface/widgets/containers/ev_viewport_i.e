indexing
	description: "Eiffel Vision viewport. Implementation interface."
	status: "See notice at end of class"
	keywords: "container, virtual, display"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VIEWPORT_I

inherit
	EV_CELL_I

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		deferred
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		deferred
		end

feature -- Element change

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		require
			a_x_within_bounds: a_x >= 0 and then
				a_x <= (item.width - width)
		deferred
		ensure
			assigned: x_offset = a_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		require
			a_y_within_bounds: a_y >= 0 and then
				a_y <= (item.height - height)
		deferred
		ensure
			assigned: y_offset = a_y
		end

end -- class EV_VIEWPORT_I

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.1.2.1  2000/01/28 19:29:01  brendel
--| Initial. New ancestor for EV_SCROLLABLE_AREA.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
