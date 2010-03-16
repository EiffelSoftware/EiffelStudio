note
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
	default_create

feature {EV_GRID_I} -- Initialization

	set_grid (a_grid: EV_GRID_I)
			-- Create and associate `Current' with `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		do
			grid := a_grid
		end

feature {NONE} -- Implementation

	grid: detachable EV_GRID_I note option: stable attribute end
		-- Grid to which `Current' is associated with.

invariant
	grid_parented_implies_header_parented: attached grid as l_grid and then l_grid.parent /= Void implies parent /= Void

note
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







