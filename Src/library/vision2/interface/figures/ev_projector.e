indexing
	description:
		"Viewers of EV_FIGURE_WORLDs."
	status: "See notice at end of class"
	keywords: "projector, world, figure"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROJECTOR
	
inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		end

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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

