indexing
	description:
		"Viewers of EV_FIGURE_WORLDs."
	status: "See notice at end of class"
	keywords: "projector, world, figure"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROJECTOR

feature {NONE} -- Initialization

	make_with_world (a_world: EV_FIGURE_WORLD) is
			-- Create with `a_world'.
		require
			a_world_not_void: a_world /= Void
		do
			set_world (a_world)
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
			-- Figure-world that will be projected.

invariant
	world_exists: world /= Void

end -- class EV_PROJECTOR

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
