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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

