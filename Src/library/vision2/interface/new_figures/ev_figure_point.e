indexing
	description: "A figure that is a pixel or a dot."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POINT

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
			-- Create in (0, 0)
		do
			Precursor
			create position
		end

	make (p: EV_FIGURE_POSITION) is
			-- Create with position `p'.
		require
			p_exists: p /= Void
		do
			default_create
			set_position (p)
		end

feature -- Access

	position: EV_FIGURE_POSITION
			-- The position of this pixel or dot.

feature -- Status setting

	set_position (p: EV_FIGURE_POSITION) is
			-- Change the reference of `position' with `p'.
		require
			p_exists: p /= Void
		do
			position := p
		ensure
			position_assigned: position = p
		end

feature -- Recomputation

	calculate_absolute_position is
			-- Recalculate abs. coords. of any position this figure may have.
			-- Not if absolute_position_valid is already True.
		do
			position.calculate_absolute_position
		end

	invalidate_absolute_position is
			-- Invalidates the absolute positions of figures.
			-- Not if no positioner installed or position not changed.
		do
			position.invalidate_absolute_position
		end

feature {EV_PROJECTION} -- Implementation

	coordinates: EV_COORDINATES is
			-- get this points's position in the form of EV_COORDINATES.
		do
			create Result.set (position.x_abs, position.y_abs)
		end

invariant
	position_exists: position /= Void

end -- class EV_FIGURE_POINT
