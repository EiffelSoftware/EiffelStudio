indexing
	description: "Figure that represents an ellipse as a center and 2 radiuses."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_ELLIPSE

inherit
	EV_CLOSED_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make

feature -- Initialization

	default_create is
			-- Create in (0, 0) with dimensions 0.
		do
			Precursor
			create position_a.default_create
			create position_b.default_create
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

	--| FIXME NB: These features only make sense when x_abs and y_abs are up-to-date!

	radius1: INTEGER is
			-- The horizontal component of the radius.
		do
			Result := (position_a.x_abs - position_b.x_abs) // 2
			if Result < 0 then
				Result := - Result
			end
		end

	radius2: INTEGER is
			-- The vertical component of the radius.
		do
			Result := (position_a.y_abs - position_b.y_abs) // 2
			if Result < 0 then
				Result := - Result
			end
		end

	center: EV_COORDINATES is
			-- get the center point of the ellipse.
		do
			create Result.set (
				(position_a.x_abs + position_b.x_abs) // 2,
				(position_a.y_abs + position_b.y_abs) // 2)
		end

invariant
	position_a_exists: position_a /= Void
	position_b_exists: position_b /= Void

end -- class EV_FIGURE_ELLIPSE
