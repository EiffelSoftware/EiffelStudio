indexing
	description: "Eiffel Vision viewport."
	status: "See notice at end of class"
	keywords: "container, virtual, display"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEWPORT

inherit
	EV_CELL
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature {NONE} -- Initialization

	create_implementation is
		do
			create {EV_VIEWPORT_IMP} implementation.make (Current)
		end

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			Result := implementation.x_offset
		ensure
			bridge_ok: Result = implementation.x_offset
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			Result := implementation.x_offset
		ensure
			bridge_ok: Result = implementation.x_offset
		end

feature -- Element change

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		require
			a_x_within_bounds: a_x >= 0 and then
				a_x <= (item.width - width)
		do
			implementation.set_x_offset (a_x)
		ensure
			assigned: x_offset = a_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		require
			a_y_within_bounds: a_y >= 0 and then
				a_y <= (item.height - height)
		do
			implementation.set_y_offset (a_y)
		ensure
			assigned: y_offset = a_y
		end

feature {NONE} -- Implementation

	implementation: EV_VIEWPORT_I

invariant
--|FIXME This invariant needs to be reworked.
--|FIXME	x_offset_within_bounds: is_displayed and item /= Void implies
--|FIXME		x_offset >= 0 and then x_offset <= (item.width - width)
--|FIXME	y_offset_within_bounds: is_displayed and item /= Void implies
--|FIXME		y_offset >= 0 and then y_offset <= (item.height - height)

end -- class EV_VIEWPORT

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
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/14 11:05:57  oconnor
--| makred invariant as needing more work
--|
--| Revision 1.1.2.4  2000/02/12 01:06:28  king
--| Removed client_equal invariant as this can never hold for items smaller than the viewport, changed is_useable to is_displayed in offset invariants as size is not calculated until realization (drawn on screen)
--|
--| Revision 1.1.2.3  2000/02/10 21:55:48  oconnor
--| added is_useable to invariants
--|
--| Revision 1.1.2.2  2000/01/28 20:00:15  oconnor
--| released
--|
--| Revision 1.1.2.1  2000/01/28 19:54:10  brendel
--| Initial.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
