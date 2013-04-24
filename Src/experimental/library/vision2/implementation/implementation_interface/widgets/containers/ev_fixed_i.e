note
	description:
		"Eiffel Vision fixed. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	extend_with_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Add `a_widget' to `Current' with a position of `a_x', a_y' and a dimension of `a_width' and `a_height'.
		require
			a_widget_not_void: a_widget /= Void
			a_widget_parent_void: a_widget.parent = Void
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			extend (a_widget)
			set_item_position (a_widget, a_x, a_y)
			set_item_size (a_widget, a_width, a_height)
		ensure
			has_a_widget: has (a_widget)
			parent_is_current: a_widget.parent = interface
			count_increased: count = old count + 1
			an_item_x_position_assigned: a_widget.x_position = a_x
			an_item_y_position_assigned: a_widget.y_position = a_y
			an_item_width_assigned: a_widget.width = a_width
			an_item_height_assigned: a_widget.height = a_height
		end

	set_item_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Assign `a_widget' with a position of `a_x' and a_y', and a dimension of `a_width' and `a_height'.
		require
			a_widget_not_void: a_widget /= Void
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			set_item_position (a_widget, a_x, a_y)
			set_item_size (a_widget, a_width, a_height)
		ensure
			an_item_x_position_assigned: a_widget.x_position = a_x
			an_item_y_position_assigned: a_widget.y_position = a_y
			an_item_width_assigned: a_widget.width = a_width
			an_item_height_assigned: a_widget.height = a_height
		end

	set_item_x_position (a_widget: EV_WIDGET; an_x: INTEGER)
			-- Set `a_widget.x_position' to `an_x'.
		require
			has_a_widget: has (a_widget)
		do
			set_item_position (a_widget, an_x, a_widget.y_position)
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
		end

	set_item_y_position (a_widget: EV_WIDGET; a_y: INTEGER)
			-- Set `a_widget.y_position' to `a_y'.
		require
			has_a_widget: has (a_widget)
		do
			set_item_position (a_widget, a_widget.x_position, a_y)
		ensure
			a_widget_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER)
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		require
			has_a_widget: has (a_widget)
		deferred
		ensure
			a_widget_x_position_assigned: a_widget.x_position = an_x
			a_widget_y_position_assigned: a_widget.y_position = a_y
		end

	set_item_width (a_widget: EV_WIDGET; a_width: INTEGER)
			-- Set `a_widget.width' to `a_width'.
		require
			has_a_widget: has (a_widget)
			a_width_not_smaller_than_minimum_width:
				a_width >= a_widget.minimum_width
		do
			set_item_size (a_widget, a_width, a_widget.height)
		end

	set_item_height (a_widget: EV_WIDGET; a_height: INTEGER)
			-- Set `a_widget.height' to `a_height'.
		require
			has_a_widget: has (a_widget)
			a_height_not_smaller_than_minimum_height:
				a_height >= a_widget.minimum_height
		do
			set_item_size (a_widget, a_widget.width, a_height)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER)
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FIXED note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FIXED_I








