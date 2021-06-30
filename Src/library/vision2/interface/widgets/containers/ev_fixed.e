note
	description:
		"[
			Container that allows custom placement of widgets. Widgets are
			placed relative to (`origin_x', `origin_y'). Clipping will be
			applied. Items are ordered in z-order with the last item as the
			topmost.
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
			implementation
		end

create
	default_create

feature -- Element change

	extend_with_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Add `a_widget' to `Current' with a position of `a_x', a_y' and a dimension of `a_width' and `a_height'.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			a_widget_not_void: a_widget /= Void
			a_widget_parent_void: a_widget.parent = Void
			a_widget_not_current: a_widget /= Current
			a_widget_not_parent_of_current: not is_parent_recursive (a_widget)
			a_widget_containable: may_contain (a_widget)
		do
			implementation.extend_with_position_and_size (a_widget, a_x, a_y,
				a_width.max (a_widget.minimum_width),
				a_height.max (a_widget.minimum_height))
		ensure
			has_a_widget: has (a_widget)
			parent_is_current: a_widget.parent = Current
			a_widget_is_last: a_widget = last
			count_increased: count = old count + 1
			cursor_not_moved: (index = old index) or (after and old after)
			an_item_x_position_assigned: a_widget.x_position = a_x
			an_item_y_position_assigned: a_widget.y_position = a_y
			an_item_width_assigned: a_width > 0 implies a_widget.width = a_width.max (a_widget.minimum_width)
			an_item_height_assigned: a_height > 0 implies a_widget.height = a_height.max (a_widget.minimum_height)
		end

	set_item_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Assign `a_widget' with a position of `a_x' and a_y', and a dimension of `a_width' and `a_height'.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
			has_a_widget: has (a_widget)
		do
			implementation.set_item_position_and_size (a_widget, a_x, a_y,
				a_width.max (a_widget.minimum_width),
				a_height.max (a_widget.minimum_height))
		ensure
			an_item_x_position_assigned: a_widget.x_position = a_x
			an_item_y_position_assigned: a_widget.y_position = a_y
			an_item_width_assigned: a_width > 0 implies a_widget.width = a_width.max (a_widget.minimum_width)
			an_item_height_assigned: a_height > 0 implies a_widget.height = a_height.max (a_widget.minimum_height)
		end

	set_item_x_position (a_widget: EV_WIDGET; an_x: INTEGER)
			-- Assign `an_x' to `a_widget.x_position'.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
			has_a_widget: has (a_widget)
		do
			implementation.set_item_x_position (a_widget, an_x)
		ensure
			an_item_x_position_assigned: a_widget.x_position = an_x
		end

	set_item_y_position (a_widget: EV_WIDGET; a_y: INTEGER)
			-- Assign `a_y' to `a_widget.y_position'.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
			has_a_widget: has (a_widget)
		do
			implementation.set_item_y_position (a_widget, a_y)
		ensure
			an_item_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER)
			-- Assign `an_x' to `a_widget.x_position'.
			-- Assign `a_y' to `a_widget.y_position'.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
			has_a_widget: has (a_widget)
		do
			implementation.set_item_position (a_widget, an_x, a_y)
		ensure
			an_item_x_position_assigned: a_widget.x_position = an_x
			an_item_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_width (a_widget: EV_WIDGET; a_width: INTEGER)
			-- Assign `a_width' to `a_widget.width'.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
			has_a_widget: has (a_widget)
			a_width_positive: a_width >= 0
		do
			implementation.set_item_width (a_widget, a_width.max (a_widget.minimum_width))
		ensure
			an_item_width_assigned: a_width > 0 implies a_widget.width = a_width.max (a_widget.minimum_width)
		end

	set_item_height (a_widget: EV_WIDGET; a_height: INTEGER)
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
			has_a_widget: has (a_widget)
			a_height_positive: a_height >= 0
		do
			implementation.set_item_height (a_widget, a_height.max (a_widget.minimum_height))
		ensure
			an_item_height_assigned: a_height > 0 implies a_widget.height = a_height.max (a_widget.minimum_height)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER)
			-- Assign `_width' to `a_widget.width'.
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
			has_a_widget: has (a_widget)
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			implementation.set_item_size (a_widget, a_width.max (a_widget.minimum_width), a_height.max (a_widget.minimum_height))
		ensure
			an_item_width_assigned: a_width > 0 implies a_widget.width = a_width.max (a_widget.minimum_width)
			an_item_height_assigned: a_height > 0 implies a_widget.height = a_height.max (a_widget.minimum_height)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FIXED_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FIXED_IMP} implementation.make
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
