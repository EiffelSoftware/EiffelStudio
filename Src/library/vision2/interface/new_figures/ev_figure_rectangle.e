indexing
	description: "Figure that represents a rectangle by two positions."
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
			create position_a
			create position_b
			Precursor
		end

	make (p1, p2: EV_FIGURE_POSITION) is
			-- Create with position `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
		do
			default_create
			set_position_a (p1)
			set_position_b (p2)
		end

	make_dim (p: EV_FIGURE_POSITION; w, h: INTEGER) is
			-- Create on `p' with dimensions `w', `h'.
		require
			p_exists: p /= Void
			width_positive: w >= 0
			height_positive: h >= 0
		do
			default_create
			set_position_a (p)
			set_position_b (create {EV_FIGURE_POSITION}.make (p, w, h))
		end

	make_pos_dim (x, y, w, h: INTEGER) is
			-- Create on (x, y) with dimension `width', `height'.
		require
			width_positive: w >= 0
			height_positive: h >= 0
		local
			base: EV_FIGURE_POSITION
		do
			default_create
			create base
			set_position_a (create {EV_FIGURE_POSITION}.make (base, x, y))
			set_position_b (create {EV_FIGURE_POSITION}.make (position_a, w, h))
		end

feature -- Access

	position_a, position_b: EV_FIGURE_POSITION
			-- The position in the world.

feature -- Status setting

	set_position_a (p1: EV_FIGURE_POSITION) is
			-- Change the reference of `position' with `p'.
		require
			p1_exists: p1 /= Void
		do
			position_a := p1
		end

	set_position_b (p2: EV_FIGURE_POSITION) is
			-- Change the reference of `position' with `p'.
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

	width: INTEGER is
			-- The width of the rectangle.
		do
			Result := (position_a.x_abs - position_b.x_abs)
			if Result < 0 then
				Result := - Result
			end
		end

	height: INTEGER is
			-- The height of the rectangle.
		do
			Result := (position_a.y_abs - position_b.y_abs) 
			if Result < 0 then
				Result := - Result
			end
		end

	top_left: EV_COORDINATES is
			-- get the top_left coordinates of the rectangle.
		local
			top, left: INTEGER
		do
			if position_a.x_abs > position_b.x_abs then
				left := position_b.x_abs
			else
				left := position_a.x_abs
			end
			if position_a.y_abs > position_b.y_abs then
				top := position_b.y_abs
			else
				top := position_a.y_abs
			end
			create Result.set (left, top)
		end

invariant
	position_a_exists: position_a /= Void
	position_b_exists: position_b /= Void

end -- class EV_FIGURE_RECTANGLE
