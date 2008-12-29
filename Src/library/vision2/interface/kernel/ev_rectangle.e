note
	description: "Rectangular areas."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RECTANGLE

inherit
	DEBUG_OUTPUT
		redefine
			out
		end

create
	default_create,
	make,
	set

feature {NONE} -- Initialization

	make, set (a_x, a_y, a_width, a_height: INTEGER)
			-- Initialize with `a_x', `a_y', `a_width', `a_height'.
		require
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			x := a_x
			y := a_y
			width := a_width
			height := a_height
		end

feature -- Access

	x: INTEGER
			-- Horizontal position.

	y: INTEGER
			-- Vertical position.

	width: INTEGER
			-- Width of `Current'.

	height: INTEGER
			-- Height of `Current'.

	left: INTEGER
			-- Horizontal position of left side
		do
			Result := x
		end

	top: INTEGER
			-- Vertical position of top.
		do
			Result := y
		end

	right: INTEGER
			--  Horizontal position of right side.
		do
			Result := x + width
		end

	bottom: INTEGER
			-- Vertical position of bottom.
		do
			Result := y + height
		end

feature -- Status report

	upper_left: EV_COORDINATE
			-- Upper-left corner of `Current'.
		do
			create Result.set (left, top)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x and then Result.y = y
		end

	upper_right: EV_COORDINATE
			-- Upper-right corner of `Current'.
		do
			create Result.set (right, top)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x + width and then Result.y = y
		end

	lower_left: EV_COORDINATE
			-- Lower-left corner of `Current'.
		do
			create Result.set (left, bottom)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x and then Result.y = y + height
		end

	lower_right: EV_COORDINATE
			-- Lower-right corner of `Current'.
		do
			create Result.set (right, bottom)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x + width and then Result.y = y + height
		end

feature -- Status report

	has (c: EV_COORDINATE): BOOLEAN
			-- Is `c' inside `Current'?
		require
			c_not_void: c /= Void
		do
			Result :=
				c.x >= left and then
				c.x <= right and then
				c.y >= top and then
				c.y <= bottom
		end

	has_x_y (a_x, a_y: INTEGER): BOOLEAN
			-- Is (`a_x', `a_y') inside `Current'?
		local
			l_x, l_y: INTEGER
		do
			l_x := x
			l_y := y
			Result :=
				a_x >= l_x and then
				a_x <= l_x + width and then
				a_y >= l_y and then
				a_y <= l_y + height
		end

	intersects (other: like Current): BOOLEAN
			-- Does `other' at least partially overlap `Current'?
		require
			other_not_void: other /= Void
		do
			Result := not (left >= other.right or right <= other.left or top >= other.bottom or bottom <= other.top)
		end

	intersection (other: like Current): like Current
			-- Intersection of `other' with `Current'.
			-- If there is not intersection `Result' has default values.
		require
			other_not_void: other /= Void
		local
			l_top, l_bottom, l_left, l_right: INTEGER
		do
			create Result
			if intersects (other) then
				l_top := top.max (other.top)
				l_bottom := bottom.min (other.bottom)
				l_left := left.max (other.left)
				l_right := right.min (other.right)
				if l_top < 0 then
					Result.set_top (l_top)
					Result.set_bottom (l_bottom)
				else
					Result.set_bottom (l_bottom)
					Result.set_top (l_top)
				end

				if l_left < 0 then
					Result.set_left (l_left)
					Result.set_right (l_right)
				else
					Result.set_right (l_right)
					Result.set_left (l_left)
				end
			end
		ensure
			result_not_void: Result /= Void
			result_intersects_if_not_default: Result.width /= 0 or else Result.height /= 0 implies Result.intersects (other)
			result_default_if_no_intersection: Result.width = 0 or else Result.height = 0 implies not Result.intersects (other)
		end

feature -- Element change

	include_point (c: EV_COORDINATE)
			-- Enlarge so that `c' is in `Current'.
		require
			c_not_void: c /= Void
		do
			include (c.x, c.y)
		ensure
			has_c: has (c)
		end

	include (a_x, a_y: INTEGER)
			-- Enlarge so that `a_x', `a_y' is in `Current'.
		do
			set_left (left.min (a_x))
			set_top (top.min (a_y))
			set_right (right.max (a_x))
			set_bottom (bottom.max (a_y))
		end

	merge (other: like Current)
			-- Enlarge `Current' so that `other' fits inside.
		require
			other_not_void: other /= Void
		do
			set_left (left.min (other.left))
			set_top (top.min (other.top))
			set_right (right.max (other.right))
			set_bottom (bottom.max (other.bottom))
		end

	grow_left (i: INTEGER)
			-- Increment size by `i' to west.
		require
			width + i > 0
		do
			x := x - i
			width := width + i
		end

	grow_right (i: INTEGER)
			-- Increment size by `i' to east.
		do
			width := width + i
		end

	grow_top (i: INTEGER)
			-- Increment size by `i' to north.
		require
			height + i > 0
		do
			y := y - i
			height := height + i
		end

	grow_bottom (i: INTEGER)
			-- Increment size by `i' to south.
		do
			height := height + i
		end

	set_left (i: INTEGER)
			-- Assign `i' to `left'.
		require
			i <= right
		do
			width := width - i + x
			x := i
		ensure
			assigned: left = i
			right_same: right = old right
		end

	set_right (i: INTEGER)
			-- Assign `i' to `right'.
		require
			i - x >= 0
		do
			width := i - x
		ensure
			assigned: right = i
		end

	set_top (i: INTEGER)
			-- Assign `i' to `top'.
		require
			i <= bottom
		do
			height := height - i + y
			y := i
		ensure
			assigned: top = i
			bottom_same: bottom = old bottom
		end

	set_bottom (i: INTEGER)
			-- Assign `i' to `bottom'.
		require
			i - y >= 0
		do
			height := i - y
		ensure
			assigned: bottom = i
		end

	set_x (new_x: INTEGER)
			-- Assign `new_x' to `x'.
		do
			x := new_x
		ensure
			x_set: x = new_x
		end

	set_y (new_y: INTEGER)
			-- Assign `new_y' to `y'.
		do
			y := new_y
		ensure
			y_set: y = new_y
		end

	set_width (new_width: INTEGER)
			-- Assign `new_width' to 'width'.
		require
			new_width_positive: new_width >= 0
		do
			width := new_width
		ensure
			width_assigned: width = new_width
		end

	set_height (new_height: INTEGER)
			-- Assign `new_height' to `height'.
		require
			new_height_positive: new_height >= 0
		do
			height := new_height
		ensure
			height_assigned: height = new_height
		end

	resize (a_width, a_height: INTEGER)
			-- Resize to `a_width' and `a_height'.
		require
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			width := a_width
			height := a_height
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

	move (a_x, a_y: INTEGER)
			-- Move to `a_x' and `a_y'.
		do
			x := a_x
			y := a_y
		ensure
			x_assigned: x = a_x
			y_assigned: y = a_y
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER)
			-- Move to `a_x' and `a_y' and resize to `a_width' and `a_height'.
		require
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			move (a_x, a_y)
			resize (a_width, a_height)
		end

feature -- Output

	debug_output, out: STRING
			-- Return readable string.
		do
			Result := "(X: " + x.out + ", Y: " + y.out +
				", Width: " + width.out +
				", Height: " + height.out + ")"
		end

invariant
	width_positive: width >= 0
	height_positive: height >= 0

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




end -- class EV_RECTANGLE

