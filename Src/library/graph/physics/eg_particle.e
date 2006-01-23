indexing
	description: "[
			An EG_PARTICLE has a mass and a position. Plus three values dx, dy and dt
			which can be used to solve differential equations.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_PARTICLE

create
	make

feature {NONE} -- Initialization

	make (ax, ay: INTEGER; a_mass: like mass) is
			-- Make a particle with `a_mass' at position (`ax', `ay').
		do
			internal_x := ax
			internal_y := ay
			mass := a_mass
		ensure
			set: x = ax and y = ay and mass = a_mass
		end

feature -- Access

	x: INTEGER is
			-- x position of particle.
		do
			Result := internal_x
		end

	y: INTEGER is
			-- y position of particle.
		do
			Result := internal_y
		end

	mass: DOUBLE
			-- The mass of the particle.

	dx: DOUBLE
			-- Delta to x direction.

	dy: DOUBLE
			-- Delta to y direction.

	dt: DOUBLE
			-- Delta time.

feature -- Element change

	set_delta (a_dx, a_dy: DOUBLE) is
			-- Set `dx' to `a_dx' and `dy' to `a_dy'
		do
			dx := a_dx
			dy := a_dy
		ensure
			set: dx = a_dx and dy = a_dy
		end

	set_dt (a_dt: DOUBLE) is
			-- Set `dt' to `a_dt'
		do
			dt := a_dt
		ensure
			set: dt = a_dt
		end

feature {NONE} -- Implementation

	internal_x: INTEGER
			-- internal `x' position.

	internal_y: INTEGER;
			-- internal `y' position.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_PARTICLE

