indexing
	description:
		"Rectangular area defined by `point_a' and `point_b'."
	status: "See notice at end of class"
	keywords: "figure, rectangle, square"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_RECTANGLE

inherit
	EV_CLOSED_FIGURE
		redefine
			bounding_box
		end

	EV_DOUBLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_points

feature -- Events

	polygon_array: ARRAY [EV_COORDINATE] is
			-- Array with four absolute corner points.
		local
			sin_a, cos_a: DOUBLE
			w, h: INTEGER
			xa, ya: INTEGER
			c: EV_COORDINATE
			counter: INTEGER
		do
			sin_a := sine (point_a.angle_abs)
			cos_a := cosine (point_a.angle_abs)
			xa := point_a.x_abs
			ya := point_a.y_abs
			if point_b.relative_to (point_a) then
				w := point_b.x
				h := point_b.y
			else
				w := (point_b.x_abs - point_a.x_abs)
				h := (point_b.y_abs - point_a.y_abs)
			end

			create Result.make (1, 4)
			create c.set (xa, ya)
			Result.force (c, 1)
			create c.set ((cos_a * w).rounded + xa,
				(sin_a * w).rounded + ya)
			Result.force (c, 2)
			create c.set ((cos_a * w - sin_a * h).rounded + xa,
				(sin_a * w + cos_a * h).rounded + ya)
			Result.force (c, 3)
			create c.set ((- sin_a * h).rounded + xa,
				(cos_a * h).rounded + ya)
			Result.force (c, 4)
		end

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
		do
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
			-- Width of rectangle.
		do
			if point_b.relative_to (point_a) then
				Result := point_b.x_rel_to (point_a)
			else
				Result := (point_b.x_abs - point_a.x_abs)
			end
			if Result < 0 then
				Result := - Result
			end
			Result := Result + 1
		end

	height: INTEGER is
			-- Height of rectangle.
		do
			if point_b.relative_to (point_a) then
				Result := point_b.y_rel_to (point_a)
			else
				Result := (point_b.y_abs - point_a.y_abs)
			end
			if Result < 0 then
				Result := - Result
			end
			Result := Result + 1
		end

	center: EV_COORDINATE is
			-- Center point of rectangle.
		do
			create Result.set (
				(point_a.x_abs + point_b.x_abs) // 2,
				(point_a.y_abs + point_b.y_abs) // 2)
		end

	top_left: EV_COORDINATE is
			-- Top-left coordinates of rectangle.
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
		
	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			first, second: EV_RELATIVE_POINT
			point1: EV_RELATIVE_POINT
			point2: EV_RELATIVE_POINT
			parray: ARRAY [EV_COORDINATE]
			coor: EV_COORDINATE
		do
			if points.is_empty then
				create Result
			else
				parray := polygon_array
				coor := parray @ 1
				create Result.make (coor.x, coor.y, 1, 1)
				coor := parray @ 2
				Result.include (coor.x, coor.y)
				coor := parray @ 3
				Result.include (coor.x, coor.y)
				coor := parray @ 4
				Result.include (coor.x, coor.y)
					 -- We must increase the rectangle size by one pixel
					 -- as an EV_RECTANGLE does not include the last pixel to the
					 -- right and bottom.
					 --| FIXME Find a standard for EV_RECTANGLE so this does not have to
					 --| be performed.
				Result.set_width (Result.width + 1)
				Result.set_height (Result.height + 1)
			end
		end

end -- class EV_FIGURE_RECTANGLE

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

