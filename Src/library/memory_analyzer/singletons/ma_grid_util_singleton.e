indexing
	description: "[
					Objects that offer grid utils to the whole system.
			     	Get the instance of this from SINGLETON_FACTORY
			     														]"
	date: "$Date$"
	revision: "$Revision$"

class
	MA_GRID_UTIL_SINGLETON

feature -- Grid Tools

	grid_remove_and_clear_all_rows (g: EV_GRID) is
		require
			g /= Void
		local
			rc: INTEGER
		do
				-- To speed up removal of all rows we ensure that the grid
				-- is displayed with cell of coordinate (1, 1) at the top.
			g.set_virtual_position (0, 0)
			from
				rc := g.row_count
			until
				rc = 0
			loop
				grid_clear_row (g.row (rc))
				g.remove_row (rc)
				rc := g.row_count				
			end
			g.clear
		ensure
			g.row_count = 0
			g.selected_rows.count = 0
		end

feature {NONE} -- Grid Tool Implementation

	grid_clear_row (row: EV_GRID_ROW) is
			-- Clear the row
		require
			row_not_void: row /= Void
		do
			row.set_data (Void)
			row.clear
		ensure
			row_cleared: row.index_of_first_item  = 0
		end

end
