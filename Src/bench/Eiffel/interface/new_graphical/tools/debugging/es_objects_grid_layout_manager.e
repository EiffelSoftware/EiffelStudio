indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_LAYOUT_MANAGER

inherit
	ES_GRID_LAYOUT_MANAGER
		redefine
			restore_row_layout_on_idle,
			grid
		end

create
	make

feature -- Properties

	grid: ES_OBJECTS_GRID

feature {NONE} -- restore

	restore_row_layout_on_idle (a_row: EV_GRID_ROW; lay: like layout; l_curr_pid: INTEGER) is
		local
			line: ES_OBJECTS_GRID_LINE
		do
			line ?= a_row.data
			if line /= Void then
				line.compute_grid_row_completed_action.extend_kamikaze (agent delayed_restore_row_layout (a_row, lay, l_curr_pid))
			else
				Precursor {ES_GRID_LAYOUT_MANAGER} (a_row, lay, l_curr_pid)
			end
		end
		
	delayed_restore_row_layout (a_row: EV_GRID_ROW; lay: like layout; l_curr_pid: INTEGER) is
		do
			debug ("es_grid_layout")
				print (generator + ".delayed_restore_row_layout : " + a_row.index.out + "%N")
			end
			restore_row_layout (a_row, lay, True, l_curr_pid)
			fixme ("remove this indirection when ready to be commited")
		end

end
