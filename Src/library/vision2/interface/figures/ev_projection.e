indexing
	description: "Projection of a world onto any device.%
		%This class is useless. Inherit from it and do your own%
		%projection or use EV_STANDARD_PROJECTION."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PROJECTION

create
	default_create,
	make

feature -- Initialization

	make (a_world: EV_FIGURE_WORLD; a_device: EV_DRAWABLE) is
			-- Create projection with `a_world' and `a_device'.
		require
			a_world_not_void: a_world /= Void
			a_device_not_void: a_device /= Void
		do
			world := a_world
			device := a_device
		ensure
			world_assigned: world = a_world
			device_assigned: a_device = device
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

	set_device (a_device: EV_DRAWABLE) is
			-- Set `device' to `a_device'.
		require
			a_device_exists: a_device /= Void
		do
			device := a_device
		ensure
			device_assigned: device = a_device
		end

feature -- Access

	world: EV_FIGURE_WORLD
			-- The figure-world that will be projected.

	device: EV_DRAWABLE
			-- The device on which the figure-world is projected.

invariant
	world_exists: world /= Void
	device_exists: device /= Void

end -- class EV_PROJECTION
