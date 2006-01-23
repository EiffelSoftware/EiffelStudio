indexing
	description:
		"[
			Container that allows custom placement of widgets. Widgets are
			placed relative to (`origin_x', `origin_y'). Clipping will be
			applied. Items are ordered in z-order with the last item as the
			topmost."
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+---------------------+
			|    +--------+       |
			|    |        |       |
			|  +-+ `last' +-------+
			|  | |        |`first'|
			|  +-+        +-------+
			+----+--------+-------+
		]"
	status: "See notice at end of class."
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

create
	default_create

feature -- Element change

	set_item_x_position (a_widget: EV_WIDGET; an_x: INTEGER) is
			-- Assign `an_x' to `a_widget.x_position'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
		do
			implementation.set_item_x_position (a_widget, an_x)
		ensure
			an_item_x_position_assigned: a_widget.x_position = an_x
		end

	set_item_y_position (a_widget: EV_WIDGET; a_y: INTEGER) is
			-- Assign `a_y' to `a_widget.y_position'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
		do
			implementation.set_item_y_position (a_widget, a_y)
		ensure
			an_item_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Assign `an_x' to `a_widget.x_position'.
			-- Assign `a_y' to `a_widget.y_position'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
		do
			implementation.set_item_position (a_widget, an_x, a_y)
		ensure
			an_item_x_position_assigned: a_widget.x_position = an_x
			an_item_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_width (a_widget: EV_WIDGET; a_width: INTEGER) is
			-- Assign `a_width' to `a_widget.width'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
		do
			implementation.set_item_width (a_widget, a_width)
		ensure
			an_item_width_assigned: a_widget.width = a_width
		end

	set_item_height (a_widget: EV_WIDGET; a_height: INTEGER) is
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			implementation.set_item_height (a_widget, a_height)
		ensure
			an_item_height_assigned: a_widget.height = a_height
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Assign `_width' to `a_widget.width'.
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			implementation.set_item_size (a_widget, a_width, a_height)
		ensure
			an_item_width_assigned: a_widget.width = a_width
			an_item_height_assigned: a_widget.height = a_height
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FIXED_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FIXED_IMP} implementation.make (Current)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FIXED

