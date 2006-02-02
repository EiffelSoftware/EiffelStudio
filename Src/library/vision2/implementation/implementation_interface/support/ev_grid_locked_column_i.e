indexing
	description: "Class representing a locked column in an EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LOCKED_COLUMN_I

inherit
	EV_GRID_LOCKED_I
		redefine
			x_to_drawable_x
		end

create
	make

feature {NONE} -- Initialization

	make (a_grid: EV_GRID_I; an_offset: INTEGER; a_column: EV_GRID_COLUMN_I) is
			-- Create `Current' associated to grid `a_grid', with column `a_column' locked at position `an_offset'.
		require
			grid_not_void: a_grid /= Void
			a_column_not_void: a_column /= Void
		do
			initialize (a_grid, an_offset)
			column_i := a_column
		ensure
			grid_set: grid = a_grid
			offset_set: offset = an_offset
			column_set: column_i = a_column
		end

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_COLUMN_I} -- Implementation

	column_i: EV_GRID_COLUMN_I
		-- Locked column to which `Current' is associated.

feature {NONE} -- Implementation

	x_to_drawable_x (an_x: INTEGER): INTEGER is
			-- Result is a relative x coordinate for the drawable of the grid
			-- given a relative x coordinate to `drawing_area'.
		do
			Result := grid.viewport_x_offset + an_x + offset
		end

indexing
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end
