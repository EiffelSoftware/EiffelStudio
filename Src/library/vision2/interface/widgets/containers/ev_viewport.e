indexing
	description:
		"Displays a single widget that may be larger that the container.%
		%Clipping may occur."
	appearance:
		" - - - - - - - - - - - - - - -  ^%N%
		%|             `item'          |`y_offset'%N%
		%                                v%N%
		%|          ---------------    |%N%
		%           |             |%N%
		%|          |  viewport   |    |%N%
		%           |             |%N%
		%|          ---------------    |%N%
		% - - - - - - - - - - - - - - -%N%
		%<`x_offset'>"
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
			create_implementation,
			make_for_test
		end

	DOUBLE_MATH
		undefine
			default_create
		end

create
	default_create,
	make_for_test

feature {NONE} -- Initialization

	make_for_test is
			-- Create and perform tests.
		local
			pixmap: EV_PIXMAP
			rotate_timer: EV_TIMEOUT
		do
			default_create
			create pixmap.make_for_test
			extend (pixmap)
			pixmap.set_minimum_width (pixmap.width)
			pixmap.set_minimum_height (pixmap.height)
			create rotate_timer.make_with_interval (1000 // 35)
			rotate_timer.actions.extend (~on_test_timer (rotate_timer))
		end

	on_test_timer (t: EV_TIMEOUT) is
			-- Move client area around.
		local
			cw, ch: INTEGER
		do
			cw := (item_width - client_width).max (0) // 2
			ch := (item_height - client_height).max (0) // 2
			if cw > 0 or ch > 0 then
				set_offset (
					(sine (t.count / 50 * Pi * 2) * cw).rounded + cw,
					(cosine (t.count / 50 * Pi * 2) * ch).rounded + ch
				)
			end
			if t.count = 50 then
				t.reset_count
			end
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
			Result := implementation.y_offset
		ensure
			bridge_ok: Result = implementation.y_offset
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Assign `an_x' to `x_offset'.
		require
			an_x_within_bounds: an_x >= 0 and then
				an_x <= (item_width - client_width).max (0)
		do
			implementation.set_x_offset (an_x)
		ensure
			assigned: x_offset = an_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Assign `a_y' to `y_offset'.
		require
			a_y_within_bounds: a_y >= 0 and then
				a_y <= (item_height - client_height).max (0)
		do
			implementation.set_y_offset (a_y)
		ensure
			assigned: y_offset = a_y
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		require
			an_x_within_bounds: an_x >= 0 and then
				an_x <= (item_width - client_width).max (0)
			a_y_within_bounds: a_y >= 0 and then
				a_y <= (item_height - client_height).max (0)
		do
			implementation.set_offset (an_x, a_y)
		ensure
			assigned: x_offset = an_x
			assigned: y_offset = a_y
		end

feature {NONE} -- Implementation

	implementation: EV_VIEWPORT_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VIEWPORT_IMP} implementation.make (Current)
		end

feature -- Contract support

	item_width: INTEGER is
			-- Width of `item'. Zero if `item' `Void'.
		do
			if readable then
				Result := item.width
			end
		end

	item_height: INTEGER is
			-- Height of `item'. Zero if `item' `Void'.
		do
			if readable then
				Result := item.height
			end
		end

invariant
	x_offset_non_negative: is_useable implies x_offset >= 0
	y_offset_non_negative: is_useable implies y_offset >= 0

	x_offset_smaller_than_item_width_minus_client_width: is_useable implies
		x_offset <= (item_width - client_width).max (0)
	y_offset_smaller_than_item_height_minus_client_height: is_useable implies
		y_offset <= (item_height - client_height).max (0)

	item_void_means_offset_zero: is_useable implies
		(item = Void implies x_offset = 0 and y_offset = 0)

	item_width_smaller_than_client_width_implies_x_offset_zero:
		is_useable implies (item_width < client_width) implies x_offset = 0
	item_height_smaller_than_client_height_implies_y_offset_zero:
		is_useable implies (item_height < client_height) implies y_offset = 0

end -- class EV_VIEWPORT

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/04/24 18:19:38  brendel
--| Corrected preconditions.
--|
--| Revision 1.12  2000/04/24 15:59:59  brendel
--| Coolified make_for_test.
--|
--| Revision 1.11  2000/04/22 00:05:22  brendel
--| Fixed contract suppport features.
--|
--| Revision 1.10  2000/04/21 22:37:20  brendel
--| Corrected imp of y_offset.
--|
--| Revision 1.9  2000/04/21 22:04:17  brendel
--| Corrected preconditions.
--|
--| Revision 1.8  2000/04/21 18:15:26  brendel
--| Reworked invariant.
--|
--| Revision 1.7  2000/04/21 00:39:39  brendel
--| Added make_for_test.
--|
--| Revision 1.6  2000/03/18 00:52:23  oconnor
--| formatting, layout and comment tweaks
--|
--| Revision 1.5  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.4  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.3  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/14 11:05:57  oconnor
--| makred invariant as needing more work
--|
--| Revision 1.1.2.4  2000/02/12 01:06:28  king
--| Removed client_equal invariant as this can never hold for items smaller
--| than the viewport, changed is_useable to is_displayed in offset invariants
--| as size is not calculated until realization (drawn on screen)
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
