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
	make

feature -- Initialization

	default_create is
			-- Default situation: pa and pb are both (0, 0).
		do
			Precursor
		end

	--| FIXME for all figures:
	--| We must be able to create a figure in a group for convenience.
	--| Let's not: instead provide something in group.
	--| make_in_group_fixed or something
	--| make_in_group_relative et cetera.

	make (p1, p2: EV_RELATIVE_POINT) is
			-- Create with points `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
		do
			default_create
			set_point_a (p1)
			set_point_b (p2)
		end

	make_fixed (x1, y1, x2, y2: INTEGER) is
			-- Create on (x1, y1)-(x2, y2).
		local
			base: EV_RELATIVE_POINT
		do
			default_create
			create base
			set_point_a (create {EV_RELATIVE_POINT}.make (base, x1, y1))
			set_point_b (create {EV_RELATIVE_POINT}.make (base, x2, y2))
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

	coordinates_a: EV_COORDINATES is
			-- get points a's position in the form of EV_COORDINATES.
		do
			create Result.set (point_a.x_abs, point_a.y_abs)
		end

	coordinates_b: EV_COORDINATES is
			-- get points b's position in the form of EV_COORDINATES.
		do
			create Result.set (point_b.x_abs, point_b.y_abs)
		end

end -- class EV_FIGURE_LINE
