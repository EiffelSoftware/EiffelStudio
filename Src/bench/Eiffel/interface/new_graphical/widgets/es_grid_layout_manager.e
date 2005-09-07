indexing
	description: "[
			Objects that manage the layout of a grid ...
			In fact, it will keep the expanded nodes layout on 'record'
			and restore this layout when 'restore' is called.
			It depends on first column's item text.
		]"
	author: ""
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

	record is
		local
			r: INTEGER
			lst: LINKED_LIST [TUPLE]
		do
			if grid.row_count > 0 and grid.is_tree_enabled then
				create lst.make
				grid_layout := [name, lst]
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
			t: like grid_layout
			r: INTEGER
			row: EV_GRID_ROW
		do
			debug ("es_grid_layout")
				print (debug_output)
			end
			if grid_layout /= Void and grid.row_count > 0 and grid.is_tree_enabled then
				lst ?= grid_layout.item (2)
				if lst /= Void and then not lst.is_empty then
					from
						lst.start
						r := 1
					until
						r > grid.row_count or lst.after
					loop
						t ?= lst.item
						if t /= Void then
							row := grid.row (r)
							if row /= Void then
								if grid.is_content_partially_dynamic then
									debug ("es_grid_layout")
										print (":"+name+": ")
										print ("restore -> on idle%N")
									end
									if row.count = 0 then
										row.redraw
										ev_application.idle_actions.extend_kamikaze (agent restore_row_layout (row, t))
									else
										row.redraw
										ev_application.idle_actions.extend_kamikaze (agent restore_row_layout (row, t))
									end
								else
									debug ("es_grid_layout")
										print (":"+name+": ")
									
										print ("restore -> now%N")
									end
									restore_row_layout (row, t)
								end
							end
						end
						lst.forth
						r := r + grid.row (r).subrow_count_recursive + 1
					end
				end
			end
		end

feature {NONE} -- Implementation

	recorded_row_layout (a_row: EV_GRID_ROW): like grid_layout is
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

	restore_row_layout (a_row: EV_GRID_ROW; lay: like grid_layout) is
		local
			lst: LIST [TUPLE]
			lab: EV_GRID_LABEL_ITEM
			ts, s: STRING
			r: INTEGER
			t: like grid_layout
			row: EV_GRID_ROW
		do
			if a_row /= Void then
				ts ?= lay.item (1)
				if ts /= Void then
					debug ("es_grid_layout")
						print (":"+name+": ")
						print ("restore_row_layout -> ["+ts+"] %N")
					end
					lab ?= a_row.item (1)
					if lab /= Void then
						s := lab.text
						debug ("es_grid_layout")
							print (":"+name+": ")
							print ("restore_row_layout -> ?["+s+"] %N")
						end
						
						if ts.is_equal (s) then
								--| Same text .. so maybe same row
							debug ("es_grid_layout")
								print (":"+name+": ")
								print ("restore_row_layout -> #[Matched] %N")
							end
							lst ?= lay.item (2)
							if lst /= Void then
									--| a non Void list, then should be expanded
								if a_row.is_expandable then --and a_row.subrow_count > 0 then
									debug ("es_grid_layout")
										print (":"+name+": ")
										print ("restore_row_layout -> ![expand] %N")
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
											row := a_row.subrow (r)
											if row /= Void then
												if grid.is_content_partially_dynamic then
													debug ("es_grid_layout")
														print (":"+name+": ")
														print ("restore_row_layout -> on idle%N")													
													end
													if row.count = 0 then
														row.redraw
														ev_application.idle_actions.extend_kamikaze (agent restore_row_layout (row, t))
													else
														row.redraw
														ev_application.idle_actions.extend_kamikaze (agent restore_row_layout (row, t))
													end
												else
													debug ("es_grid_layout")
														print (":"+name+": ")
														print ("restore_row_layout -> now%N")
													end
													restore_row_layout (row, t)
												end
											end
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
		end
		
	grid_layout: TUPLE [STRING, LIST [TUPLE]]
			--	TUPLE [STRING, LIST [like grid_layout]]]
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
			if grid_layout = Void then
				Result := "No layout"
			else
				Result := grid_layout_output (grid_layout, " : ")
			end
		end
		
	grid_layout_output (a_layout: like grid_layout; off: STRING): STRING is
		local
			tu: like grid_layout
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
