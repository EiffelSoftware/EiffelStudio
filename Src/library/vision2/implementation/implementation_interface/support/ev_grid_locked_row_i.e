indexing
	description: "Class representing a locked column in an EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LOCKED_ROW_I

inherit
	EV_GRID_LOCKED_I
		redefine
			y_to_drawable_y
		end

create
	make

feature {NONE} -- Initialization

	make (a_grid: EV_GRID_I; an_offset: INTEGER; a_row: EV_GRID_ROW_I) is
			-- Create `Current' associated to grid `a_grid', with row `a_row' locked at position `an_offset'.
		require
			grid_not_void: a_grid /= Void
			a_row_not_void: a_row /= Void
		do
			initialize (a_grid, an_offset)
			row_i := a_row
		ensure
			grid_set: grid = a_grid
			offset_set: offset = an_offset
			row_set: row_i = a_row
		end

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I} -- Implementation

	row_i: EV_GRID_ROW_I
		-- Locked row to which `Current' is associated.

feature {NONE} -- Implementation

	y_to_drawable_y (a_y: INTEGER): INTEGER is
			-- Result is a relative y coordinate for the drawable of the grid
			-- given a relative y coordinate to `drawing_area'.
		do
			Result := grid.viewport_y_offset + a_y + offset
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
