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
			-- Default crappy situation: pa and pb are both (0, 0).
		do
			Precursor
			create position_a.default_create
			create position_b.default_create
		end

	make (p1, p2: EV_FIGURE_POSITION) is
			-- Create with points `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
		do
			default_create
			set_position_a (p1)
			set_position_b (p2)
		end

	make_fixed (x1, y1, x2, y2: INTEGER) is
			-- Create on (x1, y1)-(x2, y2).
		local
			base: EV_FIGURE_POSITION
		do
			default_create
			create base
			set_position_a (create {EV_FIGURE_POSITION}.make (base, x1, y2))
			set_position_b (create {EV_FIGURE_POSITION}.make (base, x2, y2))
		end

feature -- Access

	position_a, position_b: EV_FIGURE_POSITION
			-- The two coordinates of the line.

feature -- Status setting

	set_position_a (p1: EV_FIGURE_POSITION) is
			-- Change the reference of `position_a' with `p1'.
		require
			p1_exists: p1 /= Void
		do
			position_a := p1
		end

	set_position_b (p2: EV_FIGURE_POSITION) is
			-- Change the reference of `position_b' with `p2'.
		require
			p2_exists: p2 /= Void
		do
			position_b := p2
		end

feature -- Recomputation

	calculate_absolute_position is
			-- Recalculate abs. coords. of any position this figure may have.
			-- Not if absolute_position_valid is already True.
		do
			position_a.calculate_absolute_position
			position_b.calculate_absolute_position
		end

	invalidate_absolute_position is
			-- Invalidates the absolute positions of figures.
			-- Not if no positioner installed or position not changed.
		do
			position_a.invalidate_absolute_position
			position_b.invalidate_absolute_position
		end

feature {EV_PROJECTION} -- Implementation

	coordinates_a: EV_COORDINATES is
			-- get points a's position in the form of EV_COORDINATES.
		do
			create Result.set (position_a.x_abs, position_a.y_abs)
		end

	coordinates_b: EV_COORDINATES is
			-- get points b's position in the form of EV_COORDINATES.
		do
			create Result.set (position_b.x_abs, position_b.y_abs)
		end

invariant
	position_a_exists: position_a /= Void
	position_b_exists: position_b /= Void

end -- class EV_FIGURE_LINE
