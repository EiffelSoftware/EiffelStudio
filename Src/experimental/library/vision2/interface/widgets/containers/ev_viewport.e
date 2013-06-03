note
	description:
		"[
			Displays a single widget that may be larger than the container.
			Clipping may occur though item size is not effected by viewport.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
		 - - - - - - - - - - - - - - -  ^
		|             `item'          |`y_offset'
		                                v
		|          ---------------    |
		           |             |
		|          |  viewport   |    |
		           |             |
		|          ---------------    |
		 - - - - - - - - - - - - - - -
		<`x_offset'>
		]"
	status: "See notice at end of class."
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
			is_in_default_state
		end

create
	default_create

feature -- Access

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.x_offset
		ensure
			bridge_ok: Result = implementation.x_offset
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.y_offset
		ensure
			bridge_ok: Result = implementation.y_offset
		end

feature -- Element change

	set_x_offset (an_x: INTEGER)
			-- Assign `an_x' to `x_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_x_offset (an_x)
		ensure
			assigned: x_offset = an_x
		end

	set_y_offset (a_y: INTEGER)
			-- Assign `a_y' to `y_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_y_offset (a_y)
		ensure
			assigned: y_offset = a_y
		end

	set_offset (an_x, a_y: INTEGER)
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_offset (an_x, a_y)
		ensure
			assigned: x_offset = an_x
			assigned: y_offset = a_y
		end

	set_item_width (a_width: INTEGER)
			-- Assign `a_width' to `a_widget.width'.
		require
			not_destroyed: not is_destroyed
			has_item: item /= Void
			a_width_positive: a_width >= 0
			a_width_not_smaller_than_minimum_width:
				a_width >= item.minimum_width
		do
			implementation.set_item_width (a_width)
		ensure
			an_item_width_assigned: a_width > 0 implies item.width = a_width
		end

	set_item_height (a_height: INTEGER)
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			has_item: item /= Void
			a_height_positive: a_height >= 0
			a_height_not_smaller_than_minimum_height:
				a_height >= item.minimum_height
		do
			implementation.set_item_height ( a_height)
		ensure
			an_item_height_assigned: a_height > 0 implies item.height = a_height
		end

	set_item_size (a_width, a_height: INTEGER)
			-- Assign `_width' to `a_widget.width'.
			-- Assign `a_height' to `a_widget.height'.
		require
			not_destroyed: not is_destroyed
			has_item: item /= Void
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
			a_width_not_smaller_than_minimum_width:
				a_width >= item.minimum_width
			a_height_not_smaller_than_minimum_height:
				a_height >= item.minimum_height
		do
			implementation.set_item_size (a_width, a_height)
		ensure
			an_item_width_assigned: a_width > 0 implies item.width = a_width
			an_item_height_assigned: a_height > 0 implies item.height = a_height
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CELL} and x_offset = 0 and
				y_offset = 0
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_VIEWPORT_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VIEWPORT_IMP} implementation.make
		end

invariant

	item_void_means_offset_zero: is_usable implies
		(not readable implies x_offset = 0 and y_offset = 0)

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_VIEWPORT












