indexing
	description: "Rectangular areas."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RECTANGLE

inherit
	ANY
		redefine
			out
		end

create
	default_create,
	make,
	set

feature {NONE} -- Initialization

	make, set (a_x, a_y, a_width, a_height: INTEGER) is
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

	x, left: INTEGER
			-- Horizontal position.

	y, top: INTEGER
			-- Vertical position.

	width: INTEGER
			-- Width of the clip area

	height: INTEGER
			-- Height of the clip area.

	right: INTEGER is
			--  Horizontal position of right side.
		do
			Result := x + width
		end

	bottom: INTEGER is
			-- Vertical position of bottom.
		do
			Result := y + height
		end

feature -- Status report

	upper_left: EV_COORDINATE is
			-- Upper-left corner of the clip area.
		do
			create Result.set (left, top)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x and then Result.y = y
		end

	upper_right: EV_COORDINATE is
			-- Upper-right corner of the clip area.
		do
			create Result.set (right, top)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x + width and then Result.y = y
		end

	lower_left: EV_COORDINATE is
			-- Lower-left corner of the clip area.
		do
			create Result.set (left, bottom)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x and then Result.y = y + height
		end

	lower_right: EV_COORDINATE is
			-- Lower-right corner of the clip area.
		do
			create Result.set (right, bottom)
		ensure
			Result_exists: Result /= Void
			Result_assigned: Result.x = x + width and then Result.y = y + height
		end

feature -- Status report

	has (c: EV_COORDINATE): BOOLEAN is
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

	has_x_y (a_x, a_y: INTEGER): BOOLEAN is
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

	intersects (other: like Current): BOOLEAN is
			-- Does `other' at least partially overlap `Current'?
		local
			y_test: BOOLEAN
		do
			if left <= other.left then
				y_test := right >= other.left
			else
				y_test := left <= other.right
			end
			if y_test then
				if top <= other.bottom then
					Result := bottom >= other.top
				else
					Result := top <= other.bottom
				end
			end
		end

feature -- Element change

	include_point (c: EV_COORDINATE) is
			-- Enlarge so that `c' is in `Current'.
		require
			c_not_void: c /= Void
		do
			include (c.x, c.y)
		ensure
			has_c: has (c)
		end

	include (a_x, a_y: INTEGER) is
			-- Enlarge so that `a_x', `a_y' is in `Current'.
		do
			set_left (left.min (a_x))
			set_top (top.min (a_y))
			set_right (right.max (a_x))
			set_bottom (bottom.max (a_y))
		end

	merge (other: like Current) is
			-- Enlarge `Current' so that `other' fits inside.
		require
			other_not_void: other /= Void
		do
			set_left (left.min (other.left))
			set_top (top.min (other.top))
			set_right (right.max (other.right))
			set_bottom (bottom.max (other.bottom))
		end

	grow_left (i: INTEGER) is
			-- Increment size by `i' to west.
		require
			width + i > 0
		do
			x := x - i
			width := width + i
		end

	grow_right (i: INTEGER) is
			-- Increment size by `i' to east.
		do
			width := width + i
		end

	grow_top (i: INTEGER) is
			-- Increment size by `i' to north.
		require
			height + i > 0
		do
			y := y - i
			height := height + i
		end

	grow_bottom (i: INTEGER) is
			-- Increment size by `i' to south.
		do
			height := height + i
		end

	set_left (i: INTEGER) is
			-- Set `left' to `i'.
		require
			i <= right
		do
			width := width - i + x
			x := i
		ensure
			assigned: left = i
			right_same: right = old right
		end

	set_right (i: INTEGER) is
			-- Set `right' to `i'.
		require
			i - x >= 0
		do
			width := i - x
		ensure
			assigned: right = i
		end

	set_top (i: INTEGER) is
			-- Set `top' to `i'.
		require
			i <= bottom
		do
			height := height - i + y
			y := i
		ensure
			assigned: top = i
			bottom_same: bottom = old bottom
		end

	set_bottom (i: INTEGER) is
			-- Set `bottom' to `i'.
		require
			i - y >= 0
		do
			height := i - y
		ensure
			assigned: bottom = i
		end

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			x := new_x
		ensure
			x_set: x = new_x
		end

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			y := new_y
		ensure
			y_set: y = new_y
		end

	set_width (new_width: INTEGER) is
			-- Set 'width' to `new_width'.
		require
			new_width_positive: new_width >= 0
		do
			width := new_width
		ensure
			width_assigned: width = new_width
		end

	set_height (new_height: INTEGER) is
			-- Set `height' to `new_height'.
		require
			new_height_positive: new_height >= 0
		do
			height := new_height
		ensure
			height_assigned: height = new_height
		end

	resize (a_width, a_height: INTEGER) is
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

	move (a_x, a_y: INTEGER) is
			-- Move to `a_x' and `a_y'.
		do
			x := a_x
			y := a_y
		ensure
			x_assigned: x = a_x
			y_assigned: y = a_y
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Move to `a_x' and `a_y' and resize to `a_width' and `a_height'.
		require
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			move (a_x, a_y)
			resize (a_width, a_height)
		end

feature -- Output

	out: STRING is
			-- Return readable string.
		do
			Result := "(X: " + x.out + ", Y: " + y.out +
				", Width: " + width.out +
				", Height: " + height.out + ")"
		end

invariant
	width_positive: width >= 0
	height_positive: height >= 0

end -- class EV_RECTANGLE

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
