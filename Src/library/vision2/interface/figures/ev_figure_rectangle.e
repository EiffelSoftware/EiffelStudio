indexing
	description: "EiffelVision2 new-style figure that represents a%
		% rectangle by two points."
		--| FIXME Improve descriptions of figure classes. Refer to EV_FIGURE etc.
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_RECTANGLE

inherit
	EV_CLOSED_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_points,
	make_with_point_and_dimensions,
	make_with_position_and_dimensions

feature -- Initialization

	default_create is
			-- Create in (0, 0) with dimensions 0.
		do
			Precursor
		end

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

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			--| FIXME Rotation?
			--| FIXME Not filled?
			Result := point_on_rectangle (x, y,
				point_a.x_abs, point_a.y_abs,
				point_b.x_abs, point_b.y_abs)
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
