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
			create_implementation
		end

	DOUBLE_MATH
		undefine
			default_create, is_equal,
			copy
		end

create
	default_create

feature -- Element change

	set_item_x_position (a_widget: like item; an_x: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			an_x_non_negative: an_x >= 0
		do
			implementation.set_item_x_position (a_widget, an_x)
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
		end

	set_item_y_position (a_widget: like item; a_y: INTEGER) is
			-- Set `a_widget.y_position' to `a_y'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			a_y_non_negative: a_y >= 0
		do
			implementation.set_item_y_position (a_widget, a_y)
		ensure
			a_widget_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_position (a_widget: like item; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			an_x_non_negative: an_x >= 0
			a_y_non_negative: a_y >= 0
		do
			implementation.set_item_position (a_widget, an_x, a_y)
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
			a_widget_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_width (a_widget: like item; a_width: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
		do
			implementation.set_item_width (a_widget, a_width)
		end

	set_item_height (a_widget: like item; a_height: INTEGER) is
			-- Set `a_widget.height' to `a_height'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			implementation.set_item_height (a_widget, a_height)
		end

	set_item_size (a_widget: like item; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			implementation.set_item_size (a_widget, a_width, a_height)
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_FIXED_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FIXED_IMP} implementation.make (Current)
		end

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
