indexing
	description: "Objects that draw the EV_GRID widget as required."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DRAWER_I
	
inherit
	REFACTORING_HELPER
	
create
	make_with_grid
	
feature {NONE} -- Initialization

	make_with_grid (a_grid: EV_GRID_I) is
			-- Create `Current' associated to `grid' `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		do
			grid := a_grid
		ensure
			grid_set: grid = a_grid
		end

feature -- Access

	grid: EV_GRID_I

feature -- Basic operations

	full_redraw is
			-- Redraw complete client area of `grid'.
		do
			to_implement ("EV_GRID_DRAWER_I.full_redraw")
		end
		
	partial_redraw (an_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw part of client area within `grid' specified by
			-- coordinates `an_x', `a_y', `a_width', `a_height'.
		require
			an_x_positive: an_x >= 0
			a_y_positive: a_y >= 0
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			to_implement ("EV_GRID_DRAWER_I.partial_redraw")
		end

feature {NONE} -- Implementation

invariant
	grid_not_void: grid /= Void

end
