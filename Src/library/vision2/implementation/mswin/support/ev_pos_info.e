indexing
	description: "Keep information about sizing information of current widget."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POS_INFO

feature -- Access

	x: INTEGER
			-- Horizontal position.

	y: INTEGER
			-- Vertical position.

	width: INTEGER
			-- Current width

	height: INTEGER
			-- Current height

	minimum_width: INTEGER
			-- Minimum width.

	minimum_height: INTEGER
			-- Minimum height.

feature -- Status

	is_user_min_width_set: BOOLEAN
			-- Is `minimum_width' set by user.

	is_user_min_height_set: BOOLEAN
			-- Is `minimum_height' set by user.

	is_positioned: BOOLEAN
			-- True as soon as `x' or `y' are set by user.

	is_size_specified: BOOLEAN
			-- True as soon as `width' or `height' are set by user.

feature -- Resizing

	resize (a_width, a_height: INTEGER) is
			-- Resize to `a_width' and `a_height'.
		require
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			set_width (a_width)
			set_height (a_height)
		ensure
			width_assigned: width >= a_width
			height_assigned: height >= a_height
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
		ensure
			x_assigned: x = a_x
			y_assigned: y = a_y
			width_assigned: width >= a_width
			height_assigned: height >= a_height
		end

feature -- Settings

	set_width (new_width: INTEGER) is
			-- Set 'width' to `new_width'.
		require
			new_width_positive: new_width >= 0
		do
			is_size_specified := True
			width := new_width.max (minimum_width)
		ensure
			width_assigned: width >= new_width
			is_size_specified: is_size_specified
		end

	set_height (new_height: INTEGER) is
			-- Set `height' to `new_height'.
		require
			new_height_positive: new_height >= 0
		do
			is_size_specified := True
			height := new_height.max (minimum_height)
		ensure
			height_assigned: height >= new_height
			is_size_specified: is_size_specified
		end

	set_user_minimum_width (v: INTEGER) is
			-- Minimum width of rectangle as specified by user.
		require
			positive_v: v >= 0
		do
			is_user_min_width_set := True
			minimum_width := v
		ensure
			minimum_width_set: minimum_width = v
		end

	set_user_minimum_height (v: INTEGER) is
			-- Minimum height of rectangle as specified by user.
		require
			positive_v: v >= 0
		do
			is_user_min_height_set := True
			minimum_height := v
		ensure
			minimum_height_set: minimum_height = v
		end

	set_minimum_width (v: INTEGER) is
			-- Minimum width of rectangle.
		require
			positive_v: v >= 0
		do
			if not is_user_min_width_set then
				minimum_width := v
			end
		ensure
			minimum_width_set: not is_user_min_width_set implies minimum_width = v
		end

	set_minimum_height (v: INTEGER) is
			-- Minimum height of rectangle.
		require
			positive_v: v >= 0
		do
			if not is_user_min_height_set then
				minimum_height := v
			end
		ensure
			minimum_height_set: not is_user_min_height_set implies minimum_height = v
		end

	set_is_positioned is
			-- Set `is_positioned' to True.
		do
			is_positioned := True
		ensure
			is_positioned_set: is_positioned	
		end

invariant
	width_positive: width >= 0
	height_positive: height >= 0

end -- class EV_POS_INFO

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

