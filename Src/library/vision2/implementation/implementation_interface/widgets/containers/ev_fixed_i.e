indexing
	description: 
		"Eiffel Vision fixed. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_FIXED_I
	
inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end

feature -- Element change

	set_item_x_position (a_widget: EV_WIDGET; an_x: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
		require
			has_a_widget: has (a_widget)
			an_x_non_negative: an_x >= 0
		do
			set_item_position (a_widget, an_x, a_widget.y_position)
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
		end

	set_item_y_position (a_widget: EV_WIDGET; a_y: INTEGER) is
			-- Set `a_widget.y_position' to `a_y'.
		require
			has_a_widget: has (a_widget)
			a_y_non_negative: a_y >= 0
		do
			set_item_position (a_widget, a_widget.x_position, a_y)
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
		deferred
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
			a_widget_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_width (a_widget: EV_WIDGET; a_width: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
		require
			has_a_widget: has (a_widget)
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
		do
			set_item_size (a_widget, a_width, a_widget.height)
		end

	set_item_height (a_widget: EV_WIDGET; a_height: INTEGER) is
			-- Set `a_widget.height' to `a_height'.
		require
			has_a_widget: has (a_widget)
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			set_item_size (a_widget, a_widget.width, height)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		require
			has_a_widget: has (a_widget)
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FIXED
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_FIXED_I

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
--| Revision 1.9  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.3  2000/05/05 23:37:23  brendel
--| Strengthened preconditions.
--|
--| Revision 1.3.4.2  2000/05/04 19:01:37  brendel
--| Removed impossible postconditions.
--|
--| Revision 1.3.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/05/02 00:40:26  brendel
--| Reintroduced EV_FIXED.
--| Complete revision.
--|
--| Revision 1.6  2000/03/21 16:52:26  oconnor
--| removed invisible container
--|
--| Revision 1.5  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.4  2000/02/05 03:54:55  oconnor
--| unreelased
--|
--| Revision 1.3.6.3  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.3.6.2  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
