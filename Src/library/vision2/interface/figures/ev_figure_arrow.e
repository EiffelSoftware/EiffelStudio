indexing
	description: "EiffelVision2 arrow figure. Represented by two points: a is%
		% the origin of the arrow and b is the point it points to."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_ARROW

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_points

feature -- Initialization

	default_create is
			-- Default situation: pa and pb are both (0, 0).
		do
			Precursor
		end

	make_with_points (source, target: EV_RELATIVE_POINT) is
			-- Create with points `source' and `target'.
		require
			source_exists: source /= Void
			source_not_in_figure: source.figure = Void
			target_exists: target /= Void
			target_not_in_figure: target.figure = Void
		do
			default_create
			set_point_a (source)
			set_point_b (target)
		ensure
			point_a_assigned: point_a = source
			point_b_assigned: point_b = target
		end

feature -- Access

	point_count: INTEGER is
			-- An arrow consists of 2 points.
		once
			Result := 2
		end

	point_a: EV_RELATIVE_POINT is
			-- The source coordinates of the arrow.
		do
			Result := get_point_by_index (1)
		end

	point_b: EV_RELATIVE_POINT is
			-- The target coordinates of the arrow.
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
			--| FIXME We might want to click on the target-point of
			--| the arrow as well! Maybe this function should be in
			--| EV_PROJECTION.... Maybe? Definitely. Not right now, though.
		end

end -- class EV_FIGURE_ARROW
