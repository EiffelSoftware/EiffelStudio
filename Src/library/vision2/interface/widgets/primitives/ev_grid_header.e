indexing
	description: "Objects that represent a header control for an EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_HEADER

inherit
	EV_HEADER

create {EV_GRID_I}
	make_with_grid

feature {NONE} -- Initialization

	make_with_grid (a_grid: EV_GRID_I) is
			-- Create and associate `Current' with `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		do
			default_create
			grid := a_grid
		end

feature {NONE} -- Implementation

	grid: EV_GRID_I
		-- Grid to which `Current' is associated with.

invariant
	grid_not_void: grid /= Void
	grid_parented_implies_header_parented: grid.parent /= Void implies parent /= Void

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




end

