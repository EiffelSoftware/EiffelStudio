indexing
	description: "Projection of a world onto any device.%
		%This class is useless. Inherit from it and do your own%
		%projection or use EV_STANDARD_PROJECTION."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PROJECTION

create
	make

feature -- Initialization

	make (a_world: EV_FIGURE_WORLD) is
			-- Create projection with `a_world' and `a_device'.
		require
			a_world_not_void: a_world /= Void
		do
			world := a_world
		ensure
			world_assigned: world = a_world
		end

feature -- Status setting

	set_world (a_world: EV_FIGURE_WORLD) is
			-- Set `world' to `a_world'.
		require
			a_world_exists: a_world /= Void
		do
			world := a_world
		ensure
			world_assigned: world = a_world
		end

feature -- Access

	world: EV_FIGURE_WORLD
			-- The figure-world that will be projected.

invariant
	world_exists: world /= Void

end -- class EV_PROJECTION
