indexing
	description : "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_LAYOUT_MANAGER

inherit
	ES_GRID_LAYOUT_MANAGER
		redefine
			record,


			make,
			restore,
			restore_row_layout,
			restore_row_layout_on_idle,
			recorded_row_layout,
			grid,
			wipe_out,
			reset_layout_recorded_values
		end

create
	make

feature -- Initialization

	make (a_grid: like grid; a_name: STRING) is
		do
			Precursor {ES_GRID_LAYOUT_MANAGER} (a_grid, a_name)
			create row_ids.make (10)
			create delayed_layout_by_row.make (row_ids.capacity)
		end

feature -- Properties

	grid: ES_OBJECTS_GRID

feature -- Cleaning

	reset_layout_recorded_values is
		do
			Precursor
			row_ids.wipe_out
			delayed_layout_by_row.wipe_out
		end

	wipe_out is
		do
			Precursor
			clear_delayed_layout_data
		end

feature -- Access

	record is
		do
			if enabled then
				debug ("es_grid_layout")
					print (":" + name + ": start record -> delayed_layout_by_row.count = " + delayed_layout_by_row.count.out + "%N")
				end
				Precursor {ES_GRID_LAYOUT_MANAGER}
			end
		end

	restore is
		do
			clear_delayed_layout_data
			Precursor
		end

feature {NONE} -- record/restore

	recorded_row_layout (a_row: EV_GRID_ROW): like layout is
		local
			line: ES_OBJECTS_GRID_LINE
		do
			if
				has_saved_layout_for_row (a_row)
			then
				debug ("es_grid_layout")
					print (":" + name + ": " + generator + ".recorded_row_layout @" + a_row.index.out + " %N")
				end
				line ?= a_row.data
				if
					line /= Void
					and then line.compute_grid_display_done
				then
					debug ("es_grid_layout")
						print (":" + name + ": Saved layout AND line computed !!! BUG %N")
					end
				else
					debug ("es_grid_layout")
						print (":" + name + ": Reused saved layout for row " + a_row.index.out + " %N")
					end
				end
				Result := saved_layout_for_row (a_row, False)
			else
				Result := Precursor {ES_GRID_LAYOUT_MANAGER} (a_row)
			end
		end

	restore_row_layout_on_idle (a_row: EV_GRID_ROW; lay: like layout; l_curr_pid: INTEGER) is
		local
			line: ES_OBJECTS_GRID_LINE
		do
			line ?= a_row.data
			if line /= Void then
				save_layout_for_row (a_row, lay)
				debug ("es_grid_layout")
					print (":" + name + ":  request delayed_restore_line_layout %N")
				end
				line.compute_grid_row_completed_action.extend_kamikaze (agent delayed_restore_line_layout (a_row, l_curr_pid))
			else
				Precursor {ES_GRID_LAYOUT_MANAGER} (a_row, lay, l_curr_pid)
			end
		end

	delayed_restore_line_layout (a_row: EV_GRID_ROW; l_curr_pid: INTEGER) is
		local
			lay: like layout
		do
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".delayed_restore_line_layout : " + a_row.index.out + " : BEGIN %N")
			end
			lay := saved_layout_for_row (a_row, False)
			delayed_restore_row_layout (a_row, lay, l_curr_pid)
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".delayed_restore_line_layout : " + a_row.index.out + " : DONE %N")
			end
		end

	restore_row_layout (a_row: EV_GRID_ROW; lay: like layout; on_idle: BOOLEAN; l_pid: INTEGER) is
		do
			Precursor {ES_GRID_LAYOUT_MANAGER} (a_row, lay, on_idle, l_pid)
			if on_idle then
				remove_saved_layout_for_row (a_row)
			end
		end

feature {NONE} -- delayed restoring data

	clear_delayed_layout_data is
		do
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".clear_delayed_layout_data %N")
				print (":" + name + ": -> row_ids.count = " + row_ids.count.out + "%N")
				print (":" + name + ": -> delayed_layout_by_row.count = " + delayed_layout_by_row.count.out + "%N")
			end

			row_ids.wipe_out
			delayed_layout_by_row.wipe_out
		end

	save_layout_for_row (r: EV_GRID_ROW; lay: like layout) is
		local
			rid: like row_id
		do
			debug ("es_grid_layout")
				print (":" + name + ": save layout [" + string_id_for_lay (lay) + "] for " + r.index.out + "%N")
			end

			rid := row_id (r, True)
			delayed_layout_by_row.force (lay, rid)
		end

	has_saved_layout_for_row (r: EV_GRID_ROW): BOOLEAN is
		local
			rid: like row_id
		do
			rid := row_id (r, False)
			if rid > 0 and then delayed_layout_by_row.valid_key (rid) then
				Result := delayed_layout_by_row.has (rid)
			end
		end

	saved_layout_for_row (r: EV_GRID_ROW; removed_when_fetched: BOOLEAN): like layout is
		local
			rid: like row_id
		do
			rid := row_id (r, False)
			if rid > 0 and then delayed_layout_by_row.valid_key (rid) then
				Result := delayed_layout_by_row.item (rid)
				if removed_when_fetched then
					debug ("es_grid_layout")
						print (":" + name + ": removing saved layout for " + r.index.out + "%N")
					end
					delayed_layout_by_row.remove (rid)
				end
			end
		end

	remove_saved_layout_for_row (r: EV_GRID_ROW) is
		local
			rid: like row_id
		do
			rid := row_id (r, False)
			if rid > 0 and then delayed_layout_by_row.valid_key (rid) then
				debug ("es_grid_layout")
					print (":" + name + ": removing saved layout for " + r.index.out + "%N")
				end
				delayed_layout_by_row.remove (rid)
			end
		end

	delayed_layout_by_row: HASH_TABLE [like layout, INTEGER]

	row_ids: ARRAYED_LIST [EV_GRID_ROW]

	row_id (r: EV_GRID_ROW; create_if_not_found: BOOLEAN): INTEGER is
		local
			s,i: INTEGER
		do
			from
				s := row_ids.index
				i := s
			until
				i > row_ids.count or Result > 0
			loop
				if row_ids.valid_index (i) and then row_ids.i_th (i) = r then
					Result := i
				end
				i := i + 1
			end
			if Result = 0 and then s > 1 then
				from
					i := s
				until
					i <= 0 or Result > 0
				loop
					if row_ids.valid_index (i) and then row_ids.i_th (i) = r then
						Result := i
					end
					i := i - 1
				end
			end
			if create_if_not_found and Result = 0 then
				row_ids.force (r)
				Result := row_ids.count
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
