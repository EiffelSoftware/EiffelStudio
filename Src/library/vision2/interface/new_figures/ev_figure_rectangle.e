indexing
	description: "Figure that represents a rectangle by two points."
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
	make,
	make_dim,
	make_pos_dim

feature -- Initialization

	default_create is
			-- Create in (0, 0) with dimensions 0.
		do
			Precursor
		end

	make (p1, p2: EV_RELATIVE_POINT) is
			-- Create with position `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
		do
			default_create
			set_point_a (p1)
			set_point_b (p2)
		end

	make_dim (p: EV_RELATIVE_POINT; w, h: INTEGER) is
			-- Create on `p' with dimensions `w', `h'.
		require
			p_exists: p /= Void
			width_positive: w >= 0
			height_positive: h >= 0
		do
			default_create
			set_point_a (p)
			set_point_b (create {EV_RELATIVE_POINT}.make (p, w, h))
		end

	make_pos_dim (x, y, w, h: INTEGER) is
			-- Create on (x, y) with dimension `width', `height'.
		require
			width_positive: w >= 0
			height_positive: h >= 0
		local
			base: EV_RELATIVE_POINT
		do
			default_create
			create base
			set_point_a (create {EV_RELATIVE_POINT}.make (base, x, y))
			set_point_b (create {EV_RELATIVE_POINT}.make (point_a, w, h))
		end

feature -- Access

	point_count: INTEGER is
			-- A line consists of 2 points.
		once
			Result := 2
		end

	point_a: EV_RELATIVE_POINT is
			-- The first coordinates of the line.
		do
			Result := get_point (1)
		end

	point_b: EV_RELATIVE_POINT is
			-- The first coordinates of the line.
		do
			Result := get_point (2)
		end

feature -- Status setting

	set_point_a (p1: EV_RELATIVE_POINT) is
			-- Change the reference of `position_a' with `p1'.
		require
			p1_exists: p1 /= Void
		do
			set_point (1, p1)
		ensure
			point_a_assigned: p1 = point_a
		end

	set_point_b (p2: EV_RELATIVE_POINT) is
			-- Change the reference of `position_b' with `p2'.
		require
			p2_exists: p2 /= Void
		do
			set_point (2, p2)
		ensure
			point_a_assigned: p2 = point_b
		end

feature {EV_PROJECTION} -- Implementation

	width: INTEGER is
			-- The width of the rectangle.
		do
			Result := (point_a.x_abs - point_b.x_abs)
			if Result < 0 then
				Result := - Result
			end
		end

	height: INTEGER is
			-- The height of the rectangle.
		do
			Result := (point_a.y_abs - point_b.y_abs) 
			if Result < 0 then
				Result := - Result
			end
		end

	top_left: EV_COORDINATES is
			-- get the top_left coordinates of the rectangle.
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
