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
		
	EV_GRID_HELPER
	
	EV_SHARED_APPLICATION

create 
	make

feature {NONE} -- Initialization

	make (a_grid: EV_GRID; a_name: STRING) is
		do
			grid := a_grid
			name := a_name
		end

	grid: EV_GRID

	name: STRING

feature -- Access

	wipe_out is
		do
			check
				restorations_in_progress = 0
			end
			layout := Void
		end

	record is
		local
			r: INTEGER
			lst: LINKED_LIST [TUPLE]
		do
			if grid.row_count > 0 and grid.is_tree_enabled then
				current_processing_id := 0 --| Cancel current restoration if any
				create lst.make
				layout := [name, lst]
				from
					r := 1
				until
					r > grid.row_count
				loop
					lst.extend (recorded_row_layout (grid.row (r)))
					r := r + grid.row (r).subrow_count_recursive + 1
				end
			end
			debug ("es_grid_layout")
				print (debug_output)			
			end
		end

	restore is
		local
			lst: LIST [TUPLE]
			t: like layout
			r: INTEGER
		do
			debug ("es_grid_layout")
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
						lst.start
						r := 1
					until
						r > grid.row_count or lst.after
					loop
						t ?= lst.item
						if t /= Void then
							process_row_layout_restoring (grid.row (r), t)
						end
						lst.forth
						r := r + grid.row (r).subrow_count_recursive + 1
					end
				end
			end
		end

feature {NONE} -- Implementation

	current_processing_id: INTEGER
			-- Current restoration processing id.

	recorded_row_layout (a_row: EV_GRID_ROW): like layout is
		local
			lab: EV_GRID_LABEL_ITEM
			r: INTEGER
			s: STRING
			lst: ARRAYED_LIST [TUPLE]			
		do
			if a_row /= Void then
				lab ?= a_row.item (1)
				if lab /= Void then
					s := lab.text
					if a_row.is_expanded and a_row.subrow_count > 0 then
						create lst.make (a_row.subrow_count)
						from
							r := 1
						until
							r > a_row.subrow_count
						loop
							lst.extend (recorded_row_layout (a_row.subrow (r)))
							r := r + 1
						end
					end
					Result := [s, lst]
				end
			end
		end		

	restore_row_layout (a_row: EV_GRID_ROW; lay: like layout; on_idle: BOOLEAN; l_pid: INTEGER) is
			-- if on_idle is True, this means the feature is called on idle
			-- in this case, we identify the current processing id with `l_pid'
			-- if it is different from `current_processing_id', this operation is cancelled.
			-- (nota: if `on_idle' is False, the value of `l_pid' is ignored)
		local
			lst: LIST [TUPLE]
			lab: EV_GRID_LABEL_ITEM
			ts, s: STRING
			r: INTEGER
			t: like layout
		do
			if on_idle and l_pid /= current_processing_id then
					--| Cancel this restoration operation
				debug ("es_grid_layout")
					print (":" + name + ": restore_row_layout -> cancelled %N")
				end
			elseif a_row /= Void then
				ts ?= lay.item (1)
				if ts /= Void then
					debug ("es_grid_layout")
						print (":" + name + ": restore_row_layout -> ["+ts+"] %N")
					end
					lab ?= a_row.item (1)
					if lab /= Void then
						s := lab.text
						debug ("es_grid_layout")
							print (":" + name + ": restore_row_layout -> ?["+s+"] %N")
						end
						
						if ts.is_equal (s) then
								--| Same text .. so maybe same row
							debug ("es_grid_layout")
								print (":" + name + ": restore_row_layout -> #[Matched] %N")
							end
							lst ?= lay.item (2)
							if lst /= Void then
									--| a non Void list, then should be expanded
								if a_row.is_expandable then --and a_row.subrow_count > 0 then
									debug ("es_grid_layout")
										print (":" + name + ": restore_row_layout -> ![expand] %N")
									end
									a_row.expand
									from
										lst.start
										r := 1
									until
										r > a_row.subrow_count or lst.after
									loop
										t ?= lst.item
										if t /= Void then
											process_row_layout_restoring (a_row.subrow (r), t)
										end
										lst.forth
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
			debug ("es_grid_layout")
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
					debug ("es_grid_layout")
						print (":" + name + ": process_row_layout_restoring -> on idle%N")
					end
						--| In this case, we need to force a redraw to be sure the first cell of the row
						--| get computed, then we'll be able to get the cell's text.
					if a_row.item (1) = Void then
						a_row.redraw
						restorations_in_progress := restorations_in_progress + 1
						debug ("es_grid_layout")
							print (":" + name + ": restoration requested [" + current_processing_id.out + " @ " + restorations_in_progress.out + "]%N")
						end
						ev_application.idle_actions.extend_kamikaze (agent restore_row_layout (a_row, lay, True, current_processing_id))
					else
						restore_row_layout (a_row, lay, False, current_processing_id)
					end
					fixme ("[ 
								try to optimize the grid layout restoring, 
								when we know the row has already been displayed
							]")

				else
					debug ("es_grid_layout")
						print (":" + name + ": process_row_layout_restoring -> now%N")
					end
					restore_row_layout (a_row, lay, False, current_processing_id)
				end
			end
		end
		
	restorations_in_progress: INTEGER
			
	layout: TUPLE [STRING, LIST [TUPLE]]
			--	TUPLE [STRING, LIST [like layout]]]
			-- ["A"
			--    {
			--       ["sub a" Void]
			--       ["sub b" {
			--                 ["sub sub b" Void]
			--                }
			--		 ]
			--    }
			-- ]
			
	debug_output: STRING is
		do
			print (":::" + name + "%N")
			if layout = Void then
				Result := "No layout"
			else
				Result := grid_layout_output (layout, " : ")
			end
		end
		
	grid_layout_output (a_layout: like layout; off: STRING): STRING is
		local
			tu: like layout
			tu_s: STRING
			tu_lst: LIST [TUPLE]
		do
			Result := ""
			tu_s ?= a_layout.item (1)
			tu_lst ?= a_layout.item (2)
			Result.append_string (off + " - [" + tu_s.out + "]%N")
			if tu_lst /= Void then
				from
					tu_lst.start
				until
					tu_lst.after
				loop
					tu ?= tu_lst.item
					if tu /= Void then
						Result.append_string (grid_layout_output (tu, off + "  "))
					end
					tu_lst.forth
				end
			end
		end

end
