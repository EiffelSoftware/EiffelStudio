indexing
	description:
		"A figure that is a rectangle defined by 2 points."
	status: "See notice at end of file"
	keywords: "figure, rectangle, square"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_RECTANGLE

inherit
	EV_CLOSED_FIGURE

create
	default_create,
	make_with_points,
	make_with_point_and_dimensions,
	make_with_position_and_dimensions,
	make_for_test

feature {NONE} -- Initialization

	make_with_points (p1, p2: EV_RELATIVE_POINT) is
			-- Create with position `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
		do
			default_create
			set_point_a (p1)
			set_point_b (p2)
		end

	make_with_point_and_dimensions (p: EV_RELATIVE_POINT; w, h: INTEGER) is
			-- Create on `p' with dimensions `w', `h'.
		require
			p_exists: p /= Void
			width_positive: w >= 0
			height_positive: h >= 0
		do
			default_create
			set_point_a (p)
			set_point_b (p.get_relative_point (w, h))
		end

	make_with_position_and_dimensions (x, y, w, h: INTEGER) is
			-- Create on (x, y) with dimension `width', `height'.
		require
			width_positive: w >= 0
			height_positive: h >= 0
		local
			base: EV_RELATIVE_POINT
		do
			default_create
			create base
			set_point_a (base.get_relative_point (x, y))
			set_point_b (point_a.get_relative_point (w, h))
		end

	make_for_test is
			-- Create interesting to display.
		do
			default_create
			get_point_by_index (1).set_x (3)
			get_point_by_index (1).set_y (3)
			get_point_by_index (2).set_x (97)
			get_point_by_index (2).set_y (197)
			set_foreground_color (create {EV_COLOR}.make_with_rgb (
				0.5, 0.0, 0.5))
			set_fill_color (create {EV_COLOR}.make_with_rgb (0.5, 1.0, 0.5))
			set_line_width (1)
		end

feature -- Status report

	point_count: INTEGER is
			-- A line consists of 2 points.
		once
			Result := 2
		end

	point_a: EV_RELATIVE_POINT is
			-- The first coordinates of the line.
		do
			Result := get_point_by_index (1)
		end

	point_b: EV_RELATIVE_POINT is
			-- The first coordinates of the line.
		do
			Result := get_point_by_index (2)
		end

feature -- Status setting

	set_point_a (p1: EV_RELATIVE_POINT) is
			-- Change the reference of `position_a' with `p1'.
		require
			p1_exists: p1 /= Void
		do
			set_point_by_index (1, p1)
		ensure
			point_a_assigned: p1 = point_a
		end

	set_point_b (p2: EV_RELATIVE_POINT) is
			-- Change the reference of `position_b' with `p2'.
		require
			p2_exists: p2 /= Void
		do
			set_point_by_index (2, p2)
		ensure
			point_a_assigned: p2 = point_b
		end

feature -- Events

	polygon_array: ARRAY [EV_COORDINATES] is
			-- Return an array with the four absolute corner points.
		local
			sin_a, cos_a: REAL
			w, h: REAL
			c: EV_COORDINATES
		do
			sin_a := sine (point_a.angle_abs)
			cos_a := cosine (point_a.angle_abs)

			if point_b.relative_to (point_a) then
				w := point_b.x_rel_to (point_a)
			else
				w := (point_a.x_abs - point_b.x_abs)
			end

			if point_b.relative_to (point_a) then
				h := point_b.y_rel_to (point_a)
			else
				h := (point_a.y_abs - point_b.y_abs)
			end

			create Result.make (1, 4)
			create c.set (point_a.x_abs, point_a.y_abs)
			Result.force (c, 1)
			create c.set (point_a.x_abs + (cos_a * w).rounded,
				point_a.y_abs + (sin_a * w).rounded)
			Result.force (c, 2)
			create c.set (point_b.x_abs, point_b.y_abs)
			Result.force (c, 3)
			create c.set (point_a.x_abs - (sin_a * h).rounded,
				point_a.y_abs + (cos_a * h).rounded)
			Result.force (c, 4)
		end

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			--| FIXME Always filled? No!
			if point_a.angle_abs = 0.0 then
				Result := point_on_rectangle (x, y,
					point_a.x_abs, point_a.y_abs,
					point_b.x_abs, point_b.y_abs)
			else
				Result := point_on_polygon (x, y, polygon_array)
			end
		end

feature -- Status report

	--| See comment in class EV_RELATIVE_POINT (Implementation)
	--| If point b originated from point a then we take the relative
	--| position of b from a as dimensions.
	--| If not, we take the difference between the absolute coordinates as
	--| dimensions. If the angle is not zero on point a, this might look
	--| strange.

	width: INTEGER is
			-- The width of the rectangle.
		do
			if point_b.relative_to (point_a) then
				Result := point_b.x_rel_to (point_a)
			else
				Result := (point_a.x_abs - point_b.x_abs)
			end
			if Result < 0 then
				Result := - Result
			end
		end

	height: INTEGER is
			-- The height of the rectangle.
		do
			if point_b.relative_to (point_a) then
				Result := point_b.y_rel_to (point_a)
			else
				Result := (point_a.y_abs - point_b.y_abs)
			end
			if Result < 0 then
				Result := - Result
			end
		end

	center: EV_COORDINATES is
			-- get the center point of the rectangle.
		do
			create Result.set (
				(point_a.x_abs + point_b.x_abs) // 2,
				(point_a.y_abs + point_b.y_abs) // 2)
		end

	top_left: EV_COORDINATES is
			-- Get the top-left coordinates of the rectangle.
		local
			top, left: INTEGER
		do
			if point_a.x_abs > point_b.x_abs then
				left := point_b.x_abs
			else
				left := point_a.x_abs
			end
			if point_a.y_abs > point_b.y_abs then
				top := point_b.y_abs
			else
				top := point_a.y_abs
			end
			create Result.set (left, top)
		end

end -- class EV_FIGURE_RECTANGLE

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/04/26 15:56:34  brendel
--| Added CVS Log.
--| Added copyright notice.
--| Improved description.
--| Added keywords.
--| Formatted for 80 columns.
--| Added make_for_test.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
