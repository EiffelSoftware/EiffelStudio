indexing
	description: "Figure that represents a line as two positions."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_LINE

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_points,
	make_with_positions

feature -- Initialization

	default_create is
			-- Default situation: pa and pb are both (0, 0).
		do
			Precursor
		end

	make_with_points (p1, p2: EV_RELATIVE_POINT) is
			-- Create with points `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p1_not_in_figure: p1.figure = Void
			p2_exists: p2 /= Void
			p2_not_in_figure: p2.figure = Void
		do
			default_create
			set_point_a (p1)
			set_point_b (p2)
		ensure
			point_a_assigned: point_a = p1
			point_b_assigned: point_b = p2
		end

	make_with_positions (x1, y1, x2, y2: INTEGER) is
			-- Create on (x1, y1)-(x2, y2).
		do
			default_create
			get_point_by_index (1).set_x (x1)
			get_point_by_index (1).set_y (y1)
			get_point_by_index (2).set_x (x2)
			get_point_by_index (2).set_y (y2)
		ensure
			point_a_x_assigned: point_a.x = x1
			point_a_y_assigned: point_a.y = y1
			point_b_x_assigned: point_b.x = x2
			point_b_y_assigned: point_b.y = y2
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
			p1_not_in_figure: p1.figure = Void
		do
			set_point_by_index (1, p1)
		ensure
			point_a_assigned: p1 = point_a
		end

	set_point_b (p2: EV_RELATIVE_POINT) is
			-- Change the reference of `position_b' with `p2'.
		require
			p2_exists: p2 /= Void
			p2_not_in_figure: p2.figure = Void
		do
			set_point_by_index (2, p2)
		ensure
			point_a_assigned: p2 = point_b
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := point_on_segment (x, y,
				point_a.x_abs, point_a.y_abs,
				point_b.x_abs, point_b.y_abs, line_width)
		end

end -- class EV_FIGURE_LINE
