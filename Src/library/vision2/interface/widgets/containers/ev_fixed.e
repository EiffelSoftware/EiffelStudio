indexing
	description: 
		"Container that allows custom placement of widgets. Widgets are%N%
		%placed relative to (`origin_x', `origin_y'). Clipping will be%N%
		%applied. Items are ordered in z-order with the last item as the%N%
		%topmost."
	appearance:
		"+---------------------+%N%
		%|    +--------+       |%N%
		%|    |        |       |%N%
		%|  +-+ `last' +-------+%N%
		%|  | |        |`first'|%N%
		%|  +-+        +-------+%N%
		%+----+--------+-------+"
	status: "See notice at end of class"
	keywords: "container, fixed, custom"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FIXED

inherit
	EV_WIDGET_LIST
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

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FIXED_IMP} implementation.make (Current)
		end

	make_for_test is
			-- Create for testing purposes.
		local
			swap_timer: EV_TIMEOUT
			rotate_timer: EV_TIMEOUT
		do
			Precursor
			set_minimum_size (300, 100)
			from start until after loop
		--		set_item_position (item, index * 20, index * 10)
				set_item_size (item, 50, 20)
				forth
			end
		--	create swap_timer.make_with_interval (1000)
		--	swap_timer.actions.extend (~do_test)
			create rotate_timer.make_with_interval (1000 // 35)
			rotate_timer.actions.extend (~rotate_widgets (rotate_timer))
		end

	do_test is
			-- Cycle the first widget into the last position.
		local
			w: EV_WIDGET
		do
			w := first
			if w /= Void then
				prune_all (w)
				extend (w)
			end
		end

	rotate_widgets (t: EV_TIMEOUT) is
			-- Rotate children.
		do
			from start until after loop
				set_item_position (item,
					(sine ((t.count + (index * 10)) / 50 * 2 * Pi) * 30 + 30 + index * 20).rounded,
					(cosine ((t.count + (index * 10)) / 50 * 2 * Pi) * 30 + 30).rounded)
				forth
			end
		end

feature -- Element change

	set_item_x_position (a_widget: EV_WIDGET; an_x: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
		require
			has_a_widget: has (a_widget)
			an_x_non_negative: an_x >= 0
		do
			implementation.set_item_x_position (a_widget, an_x)
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
		end

	set_item_y_position (a_widget: EV_WIDGET; a_y: INTEGER) is
			-- Set `a_widget.y_position' to `a_y'.
		require
			has_a_widget: has (a_widget)
			a_y_non_negative: a_y >= 0
		do
			implementation.set_item_y_position (a_widget, a_y)
		ensure
			a_widget_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		require
			has_a_widget: has (a_widget)
			an_x_non_negative: an_x >= 0
			a_y_non_negative: a_y >= 0
		do
			implementation.set_item_position (a_widget, an_x, a_y)
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
			a_widget_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_width (a_widget: EV_WIDGET; a_width: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
		require
			has_a_widget: has (a_widget)
			a_width_non_negative: a_width >= 0
		do
			implementation.set_item_width (a_widget, a_width)
		ensure
			a_widget_width_assigned: a_widget.width = a_width
		end

	set_item_height (a_widget: EV_WIDGET; a_height: INTEGER) is
			-- Set `a_widget.height' to `a_height'.
		require
			has_a_widget: has (a_widget)
			a_height_non_negative: a_height >= 0
		do
			implementation.set_item_height (a_widget, a_height)
		ensure
			a_widget_height_assigned: a_widget.height = a_height
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		require
			has_a_widget: has (a_widget)
			a_width_non_negative: a_width >= 0
			a_height_non_negative: a_height >= 0
		do
			implementation.set_item_size (a_widget, a_width, a_height)
		ensure
			a_widget_width_assigned: a_widget.width = a_width
			a_widget_height_assigned: a_widget.height = a_height
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_FIXED_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_FIXED

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
--| Revision 1.14  2000/05/02 17:18:50  brendel
--| Widgets do not move together.
--|
--| Revision 1.13  2000/05/02 16:14:54  brendel
--| Temporary enhancement of make_for_test.
--|
--| Revision 1.12  2000/05/02 00:40:25  brendel
--| Reintroduced EV_FIXED.
--| Complete revision.
--|
--| Revision 1.11  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.4  2000/02/05 03:54:55  oconnor
--| unreelased
--|
--| Revision 1.9.6.3  2000/01/28 22:24:23  oconnor
--| released
--|
--| Revision 1.9.6.2  2000/01/27 19:30:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
