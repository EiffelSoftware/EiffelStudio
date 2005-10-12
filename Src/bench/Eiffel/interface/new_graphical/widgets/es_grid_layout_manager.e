indexing
	description: "[
			Objects that manage the layout of a grid ...
			In fact, it will keep the expanded nodes layout on 'record'
			and restore this layout when 'restore' is called.
			It depends on first column's item text.
			
			Nota: This can be optimize to update only visual area, 
			      or maybe restoring only when asked.
			      This will be a further step of grid layout managing.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_LAYOUT_MANAGER
	
inherit
	DEBUG_OUTPUT
		redefine
			debug_output
		end
		
	EV_SHARED_APPLICATION
	
	REFACTORING_HELPER

create 
	make

feature {NONE} -- Initialization

	make (a_grid: like grid; a_name: STRING) is
		do
			grid := a_grid
			name := a_name
			enabled := True
		end

	grid: EV_GRID

	name: STRING
	
feature -- Status

	enabled: BOOLEAN
	
feature -- Access

	enable is
		do
			enabled := True
		end
		
	disable is
		do
			enabled := False
			wipe_out
		end

	set_identification_agent (a_agent: like identification_agent) is
		do
			identification_agent := a_agent
		end
		
	set_value_agent (a_agent: like value_agent) is
		do
			value_agent := a_agent
		end		

	set_on_difference_callback (a_agent: like on_difference_callback) is
		do
			on_difference_callback := a_agent
		end
		
	reset_layout_recorded_values is
		do
			if layout /= Void then
				reset_recorded_values_from (layout)
			end
		end

	wipe_out is
		do
			if restorations_in_progress > 0 then
				current_processing_id := 0
			end
			layout := Void
		end

	record is
		local
			r: INTEGER
			lst: DS_LIST [TUPLE]
		do
			if enabled then
				if grid.row_count > 0 and grid.is_tree_enabled then
					current_processing_id := 0 --| Cancel current restoration if any
					from
						create {DS_ARRAYED_LIST [TUPLE]} lst.make (grid.row_count)
						layout := [name, lst, Void]
						
						r := 1
					until
						r > grid.row_count
					loop
						lst.put_last (recorded_row_layout (grid.row (r)))
						r := r + grid.row (r).subrow_count_recursive + 1
					end
				end
				debug ("grid_layout")
					print (debug_output)			
				end
			end
		end

	restore is
		local
			lst: DS_LIST [TUPLE]
			lst_curs: DS_LIST_CURSOR [TUPLE]
			t: like layout
			r: INTEGER
		do
			if enabled then
				debug ("grid_layout")
					print (debug_output)
				end
				if layout /= Void and grid.row_count > 0 and grid.is_tree_enabled then
					if restorations_in_progress = 0 then
						current_processing_id := 1
					else
						current_processing_id := current_processing_id + 1
					end
					restorations_in_progress := 0
					lst ?= layout.item (2)
					if lst /= Void and then not lst.is_empty then
						from
							lst_curs := lst.new_cursor
							lst_curs.start
							r := 1
						until
							r > grid.row_count or lst_curs.after
						loop
							t ?= lst_curs.item
							if t /= Void then
								process_row_layout_restoring (grid.row (r), t)
							end
							lst_curs.forth
							r := r + grid.row (r).subrow_count_recursive + 1
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	default_identification (a_row: EV_GRID_ROW): STRING is
		require
			a_row /= Void
		local
			lab: EV_GRID_LABEL_ITEM
		do
			lab ?= a_row.item (1)
			if lab /= Void then
				Result := lab.text
			end
		end

	identification_agent: FUNCTION [ANY, TUPLE [EV_GRID_ROW], STRING]
	value_agent: FUNCTION [ANY, TUPLE [EV_GRID_ROW], ANY]
	on_difference_callback: PROCEDURE [ANY, TUPLE [EV_GRID_ROW, ANY]]
			-- row and old value

	reset_recorded_values_from (lay: like layout) is
		require
			lay /= Void
		local
			lst: DS_LIST [like layout]
			lst_curs: DS_LIST_CURSOR [like layout]
		do
			lay.put_reference (Void, 3)
			lst ?= lay.item (2)
			if lst /= Void then
				lst_curs := lst.new_cursor
				from
					lst_curs.start
				until
					lst_curs.after
				loop
					reset_recorded_values_from (lst_curs.item)
					lst_curs.forth
				end
			end
		end

	current_processing_id: INTEGER
			-- Current restoration processing id.

	recorded_row_layout (a_row: EV_GRID_ROW): like layout is
		local
			r: INTEGER
			lst: DS_LIST [TUPLE]
			l_id: STRING
			l_val: ANY			
		do
			if a_row /= Void then
				if identification_agent /= Void then
					l_id := identification_agent.item ([a_row])
				else
					l_id := default_identification (a_row)
				end
				if l_id /= Void then
					if value_agent /= Void then
						l_val := value_agent.item ([a_row])
					end
					
					if a_row.is_expanded and a_row.subrow_count > 0 then
						create {DS_ARRAYED_LIST [TUPLE]} lst.make (a_row.subrow_count)
						from
							r := 1
						until
							r > a_row.subrow_count
						loop
							lst.put_last (recorded_row_layout (a_row.subrow (r)))
							r := r + 1
						end
					end
					Result := [l_id, lst, l_val]
				end
			end
		end		

	restore_row_layout_on_idle (a_row: EV_GRID_ROW; lay: like layout; l_curr_pid: INTEGER) is
		do
			a_row.redraw
			Ev_application.idle_actions.extend_kamikaze (agent restore_row_layout (a_row, lay, True, l_curr_pid))
		end

	restore_row_layout (a_row: EV_GRID_ROW; lay: like layout; on_idle: BOOLEAN; l_pid: INTEGER) is
			-- if on_idle is True, this means the feature is called on idle
			-- in this case, we identify the current processing id with `l_pid'
			-- if it is different from `current_processing_id', this operation is cancelled.
			-- (nota: if `on_idle' is False, the value of `l_pid' is ignored)
		local
			lst: DS_LIST [TUPLE]
			lst_curs: DS_LIST_CURSOR [TUPLE]
			ts, l_id: STRING
			tv, l_val: ANY
			r: INTEGER
			t: like layout
			has_diff: BOOLEAN
		do
			if on_idle and l_pid /= current_processing_id then
					--| Cancel this restoration operation
				debug ("grid_layout")
					print (":" + name + ": restore_row_layout -> cancelled %N")
				end
			elseif a_row /= Void then
				ts ?= lay.item (1)
				if ts /= Void then
					debug ("grid_layout")
						print (":" + name + ": restore_row_layout -> [" + ts + "] %N")
					end
					if identification_agent /= Void then
						l_id := identification_agent.item ([a_row])
					else
						l_id := default_identification (a_row)
					end
					if l_id /= Void then
						debug ("grid_layout")
							print (":" + name + ": restore_row_layout -> ?[" + l_id + "] %N")
						end
						if ts.is_equal (l_id) then
								--| Same identification text .. so we suppose same row ...
							debug ("grid_layout")
								print (":" + name + ": restore_row_layout -> #[Matched] %N")
							end
							if value_agent /= Void then
								tv := lay.item (3)
								has_diff := False
								l_val := value_agent.item ([a_row])
								if tv = Void or l_val = Void then
									has_diff := tv /= Void or l_val /= Void
								else 
									has_diff := not tv.is_equal (l_val)
								end
								if has_diff and then on_difference_callback /= Void then
									on_difference_callback.call ([a_row, tv])
								end
							end

							lst ?= lay.item (2)
							if lst /= Void then
									--| a non Void list, then should be expanded
								if a_row.is_expandable then --and a_row.subrow_count > 0 then
									debug ("grid_layout")
										print (":" + name + ": restore_row_layout -> ![expand] %N")
									end
									a_row.expand
									from
										lst_curs := lst.new_cursor
										lst_curs.start
										r := 1
									until
										r > a_row.subrow_count or lst_curs.after
									loop
										t ?= lst_curs.item
										if t /= Void then
											process_row_layout_restoring (a_row.subrow (r), t)
										end
										lst_curs.forth
										r := r + 1
									end
								end
							end
						end
					end
				end
			end
			if on_idle then
				restorations_in_progress := restorations_in_progress - 1
			end
			debug ("grid_layout")
				if restorations_in_progress = 0 then
					print ("all restorations completed %N")
				else
					print (restorations_in_progress.out + " restorations are processing %N")
				end
			end
		end

	process_row_layout_restoring (a_row: EV_GRID_ROW; lay: like layout) is
		require
			lay /= Void
		do
			if a_row /= Void then
				if grid.is_content_partially_dynamic then
					debug ("grid_layout")
						print (":" + name + ": process_row_layout_restoring -> on idle%N")
					end
						--| In this case, we need to force a redraw to be sure the first cell of the row
						--| get computed, then we'll be able to get the cell's text.
					if a_row.item (1) = Void or (value_agent /= Void and a_row.item (2) = Void) then
						restorations_in_progress := restorations_in_progress + 1
						debug ("grid_layout")
							print (":" + name + ": restoration requested [" + current_processing_id.out + " @ " + restorations_in_progress.out + "]%N")
						end
						restore_row_layout_on_idle (a_row, lay, current_processing_id)
					else
						restore_row_layout (a_row, lay, False, current_processing_id)
					end
					fixme ("[ 
								try to optimize the grid layout restoring, 
								when we know the row has already been displayed
							]")
				else
					debug ("grid_layout")
						print (":" + name + ": process_row_layout_restoring -> now%N")
					end
					restore_row_layout (a_row, lay, False, current_processing_id)
				end
			end
		end
		
	restorations_in_progress: INTEGER
			
	layout: TUPLE [STRING, DS_LIST [TUPLE], ANY]
			--	TUPLE [STRING, DS_LIST [like layout]], ANY]
			-- ["A"
			--    {
			--       ["sub a" Void `value`]
			--       ["sub b" {
			--                 ["sub sub b" Void]
			--                }
			--		   `value`
			--		 ]
			--    }
			-- ]
			
	debug_output: STRING is
		do
			Result := ":::" + name + "%N"
			if layout = Void then
				Result.append_string ("No layout")
			else
				Result.append_string (grid_layout_output (layout, " : "))
			end
		end
		
	grid_layout_output (a_layout: like layout; off: STRING): STRING is
		local
			tu: like layout
			tu_s: STRING
			tu_v: ANY
			tu_v_s: STRING
			tu_lst: DS_LIST [TUPLE]
			tu_lst_curs: DS_LIST_CURSOR [TUPLE]
		do
			Result := ""
			tu_s ?= a_layout.item (1)
			tu_lst ?= a_layout.item (2)
			tu_v := a_layout.item (3)
			if tu_v /= Void then
				tu_v_s := tu_v.out
				tu_v_s.keep_head (20)
			else
				tu_v_s := ""
			end
			Result.append_string (off + " - [" + tu_s.out + "] :: " + tu_v_s + "%N")
			if tu_lst /= Void then
				from
					tu_lst_curs := tu_lst.new_cursor
					tu_lst_curs.start
				until
					tu_lst_curs.after
				loop
					tu ?= tu_lst_curs.item
					if tu /= Void then
						Result.append_string (grid_layout_output (tu, off + "  "))
					end
					tu_lst_curs.forth
				end
			end
		end

end
