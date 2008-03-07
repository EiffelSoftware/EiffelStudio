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
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			positioning_enabled := True

			create pre_recording_actions
			create post_recording_actions

			create pre_restoring_actions
		end

feature {NONE} -- properties

	grid: EV_GRID

	name: STRING

	restorations_in_progress: INTEGER

	current_processing_id: INTEGER
			-- Current restoration processing id.

feature -- Status

	enabled: BOOLEAN

	positioning_enabled: BOOLEAN

feature -- Layout acces

	layout: TUPLE [id:STRING; subrows: DS_LIST [TUPLE]; value:ANY; is_visible_row: BOOLEAN]
			--	TUPLE [id=STRING, subrows=DS_LIST [like layout]], value=ANY, visible_row=BOOLEAN]
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

	set_layout (v: like layout) is
		do
			layout := v
		end

feature -- Change

	enable is
		do
			enabled := True
		end

	disable is
		do
			enabled := False
			wipe_out
		end

	enable_positioning is
		do
			positioning_enabled := True
		end

	disable_positioning is
		do
			positioning_enabled := False
		end

	reset_layout_recorded_values is
		do
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".reset_layout_recorded_values %N")
			end

			if layout /= Void then
				reset_recorded_values_from (layout)
			end
		end

	wipe_out is
		do
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".wipe_out %N")
			end

			if restorations_in_progress > 0 then
				current_processing_id := 0
			end
			layout := Void
		end

feature -- Change agents

	set_row_is_ready_for_identification_agent (a_agent: like row_is_ready_for_identification_agent) is
		do
			row_is_ready_for_identification_agent := a_agent
		end

	set_row_is_ready_for_evaluation_agent (a_agent: like row_is_ready_for_evaluation_agent) is
		do
			row_is_ready_for_evaluation_agent := a_agent
		end

	set_global_identification_agent (a_agent: like global_identification_agent) is
		do
			global_identification_agent := a_agent
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

feature -- Access

	record is
		local
			r: INTEGER
			lst: DS_LIST [TUPLE]
			gid: STRING
		do
			if enabled then
				debug ("es_grid_layout")
					print (":" + name + ": record -> begin%N")
				end
				pre_recording_actions.call (Void)
				if grid.row_count > 0 and grid.is_tree_enabled then
					debug ("es_grid_layout")
						print (":" + name + ": restoration_in_progress [id=" + current_processing_id.out + "] -> " + restorations_in_progress.out + "%N")
					end
					current_processing_id := 0 --| Cancel current restoration if any
					gid := global_identification
					debug ("es_grid_layout")
						print (":" + name + ": record : session [" + gid + "] %N")
					end

					from
						create {DS_ARRAYED_LIST [TUPLE]} lst.make (grid.row_count)
						layout := [gid, lst, Void, False]
						r := 1
					until
						r > grid.row_count
					loop
						lst.put_last (recorded_row_layout (grid.row (r)))
						r := r + grid.row (r).subrow_count_recursive + 1
					end
				end
				debug ("es_grid_layout")
					print (debug_output)
				end
				post_recording_actions.call (Void)
				debug ("es_grid_layout")
					print (":" + name + ": record -> done%N")
				end
			end
		end

	restore is
		local
			s: STRING
			lst: DS_LIST [TUPLE]
			lst_curs: DS_LIST_CURSOR [TUPLE]
			t: like layout
			r: INTEGER
			gid: STRING
		do
			if enabled then
				debug ("es_grid_layout")
					print (":" + name + ": restore -> begin%N")
					print (debug_output)
				end
				pre_restoring_actions.call (Void)
				if layout /= Void and grid.row_count > 0 and grid.is_tree_enabled then
					if restorations_in_progress = 0 then
						current_processing_id := 1
					else
						current_processing_id := current_processing_id + 1
					end
					last_row_set_as_first_visible_row := Void
					restorations_in_progress := 0

					gid := global_identification
					debug ("es_grid_layout")
						print (":" + name + ": restore : session [" + gid + "] %N")
					end

					s := layout.id
					if not s.is_equal (gid) then
						debug ("es_grid_layout")
							print (":" + name + ": different session -> " + s + " /= " + gid + "%N")
						end
						wipe_out
					else
						lst := layout.subrows
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
						if positioning_enabled and then last_row_set_as_first_visible_row /= Void then
							ev_application.do_once_on_idle (agent ensure_row_is_first_visible_row (last_row_set_as_first_visible_row))
							last_row_set_as_first_visible_row := Void
						end
					end
				end
				debug ("es_grid_layout")
					print (":" + name + ": restore -> END (restorations_in_progress=" + restorations_in_progress.out + ") %N")
				end
			end
		end

feature {NONE} -- Implementation

	last_row_set_as_first_visible_row: EV_GRID_ROW
			-- Last row set as first visible row during layout restoring.

	ensure_row_is_first_visible_row (r: EV_GRID_ROW) is
		do
			if r.parent /= Void then
				grid.set_first_visible_row (r.index)
			end
			debug ("es_grid_layout")
				print (":" + name + ": ensure_row_is_first_visible_row  (row.index="+ r.index.out +") %N")
				if r.index /= grid.first_visible_row.index then
					print (":" + name + ": -> ERROR ... %N")
				end
			end
		end

	row_is_ready_for_identification (a_row: EV_GRID_ROW): BOOLEAN is
		do
			if identification_agent /= Void and row_is_ready_for_identification_agent /= Void then
				Result := row_is_ready_for_identification_agent.item ([a_row])
			else
				Result := row_is_ready_for_default_identification (a_row)
			end
		end

	row_is_ready_for_evaluation (a_row: EV_GRID_ROW): BOOLEAN is
		require
			value_agent /= Void
		do
			if row_is_ready_for_evaluation_agent /= Void then
				Result := row_is_ready_for_evaluation_agent.item ([a_row])
			else
				Result := True
			end
		end

	row_is_ready_for_default_identification (a_row: EV_GRID_ROW): BOOLEAN is
		do
			Result := a_row.item (1) /= Void
		end

	global_identification: STRING is
		local
			s: STRING
		do
			Result := name.twin
			if global_identification_agent /= Void then
				s := global_identification_agent.item (Void)
				if s /= Void then
					Result.append_string ("::")
					Result.append_string (s)
				end
			end
		end

	row_identification (a_row: EV_GRID_ROW): STRING is
		do
			if identification_agent /= Void then
				Result := identification_agent.item ([a_row])
			else
				Result := default_identification (a_row)
			end
		end

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

	reset_recorded_values_from (lay: like layout) is
		require
			lay /= Void
		local
			lst: DS_LIST [like layout]
			lst_curs: DS_LIST_CURSOR [like layout]
		do
			lay.value := Void
			lst ?= lay.subrows
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

	recorded_row_layout (a_row: EV_GRID_ROW): TUPLE [id:STRING; subrows: DS_LIST [TUPLE]; value:ANY; is_visible_row: BOOLEAN] is
			-- FIXME: compiler is complaining when using 'like layout' for Result type
		local
			r: INTEGER
			lst: DS_LIST [TUPLE]
			l_id: STRING
			l_val: ANY
			l_fvr: BOOLEAN
			lay: like layout
		do
			if a_row /= Void then
				l_id := row_identification (a_row)
				if l_id /= Void then
					if value_agent /= Void then
						l_val := value_agent.item ([a_row, True])
					end
					debug ("es_grid_layout")
						print (":" + name + ": " + generator + ".recorded_row_layout : "  + a_row.index.out + " %"" + l_id + "%".%N")
					end
					if a_row.is_expanded then
						debug ("es_grid_layout")
							print (":" + name + ":                     : expanded .%N")
						end
						if a_row.subrow_count > 0 then
							debug ("es_grid_layout")
								print (":" + name + ":                     : -> " + a_row.subrow_count.out + " subrows %N")
							end
							create {DS_ARRAYED_LIST [TUPLE]} lst.make (a_row.subrow_count)
							from
								r := 1
							until
								r > a_row.subrow_count
							loop
								lay := recorded_row_layout (a_row.subrow (r))
								if positioning_enabled and then lay /= Void then
									l_fvr := l_fvr or else lay.is_visible_row
								end
								lst.put_last (lay)
								r := r + 1
							end
						else
							debug ("es_grid_layout")
								print (":" + name + ":                     : -> EMPTY but expanded !! %N")
							end
						end
					end
					if positioning_enabled and then not l_fvr then
						l_fvr := grid.is_displayed and then grid.first_visible_row = a_row
					end
					Result := [l_id, lst, l_val, l_fvr]
				end
			end
		end

	restore_row_layout_on_idle (a_row: EV_GRID_ROW; lay: like layout; l_curr_pid: INTEGER) is
		do
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".restore_row_layout_on_idle : " + a_row.index.out + " -> " + string_id_for_lay (lay) + ": BEGIN %N")
			end
--			a_row.parent.refresh_now
--			print ("Row after refresh_now => " + a_row.count.out + "%N")
			Ev_application.do_once_on_idle (agent delayed_restore_row_layout (a_row, lay, l_curr_pid))
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".restore_row_layout_on_idle : " + a_row.index.out + " -> " + string_id_for_lay (lay) + " : FINISHED %N")
			end
		end

	delayed_restore_row_layout (a_row: EV_GRID_ROW; lay: like layout; l_curr_pid: INTEGER) is
		do
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".delayed_restore_row_layout : " + a_row.index.out + " -> " + string_id_for_lay (lay) +"%N")
			end
			if a_row.parent /= Void and lay /= Void and row_is_ready_for_identification (a_row) then
					--| `lay' should not be Void, but issue bug#10172 still occurs
				restore_row_layout (a_row, lay, True, l_curr_pid)
			else
				restorations_in_progress := restorations_in_progress - 1
			end
		end

	restore_row_layout (a_row: EV_GRID_ROW; lay: like layout; on_idle: BOOLEAN; l_pid: INTEGER) is
			-- if on_idle is True, this means the feature is called on idle
			-- in this case, we identify the current processing id with `l_pid'
			-- if it is different from `current_processing_id', this operation is cancelled.
			-- (nota: if `on_idle' is False, the value of `l_pid' is ignored)
		require
			lay_not_void: lay /= Void
			lay_not_empty: not lay.is_empty
			row_is_ready_for_identification: row_is_ready_for_identification (a_row)
		local
			lst: DS_LIST [TUPLE]
			lst_curs: DS_LIST_CURSOR [TUPLE]
			ts, l_id: STRING
			tv, l_val: ANY
			tfvr: BOOLEAN
			r: INTEGER
			t: like layout
			has_diff: BOOLEAN
		do
			if on_idle and l_pid /= current_processing_id then
					--| Cancel this restoration operation
				debug ("es_grid_layout")
					print (":" + name + ": restore_row_layout -> cancelled : " + a_row.index.out + "[" + string_id_for_lay (lay) + "] %N")
				end
			elseif a_row /= Void then
				ts := lay.id
				if ts /= Void then
					debug ("es_grid_layout")
						print (":" + name + ": restore_row_layout -> [" + ts + "] ")
					end
					l_id := row_identification (a_row)
					if l_id /= Void then
						debug ("es_grid_layout")
							print (" ?id[%"" + l_id + "%"]")
						end
						if ts.is_equal (l_id) then
								--| Same identification text .. so we suppose same row ...
							debug ("es_grid_layout")
								print (" -> [Matched]")
							end

								--| Is part of first visible row ?
							if positioning_enabled then
								tfvr := lay.is_visible_row
								if tfvr and grid.is_displayed then
									debug ("es_grid_layout", "es_grid_layout_positioning")
										print (" FirstVisibleRow[" + a_row.index.out + "] ")
									end
									last_row_set_as_first_visible_row := a_row
									ensure_row_is_first_visible_row (last_row_set_as_first_visible_row)
								end
							end

								--| Let's check difference
							if value_agent /= Void then
								tv := lay.value
								has_diff := False
								l_val := value_agent.item ([a_row, False])
								if tv = Void or l_val = Void then
									has_diff := tv /= Void or l_val /= Void
								else
									has_diff := not tv.is_equal (l_val)
								end
								if has_diff and then on_difference_callback /= Void then
									on_difference_callback.call ([a_row, tv])
								end
							end

							lst := lay.subrows
							if
								lst /= Void --| a non Void list, then should be expanded
								and then a_row.is_expandable
								-- and then a_row.subrow_count > 0 then
							then
								debug ("es_grid_layout")
									print (" -> [expand]")
								end
								a_row.expand
								debug ("es_grid_layout")
									if not a_row.is_expanded then
										print (" : ERROR not expanded after 'expand' ")
									else
										print (" : " + a_row.subrow_count.out + " subrows. ")
									end
									print ("%N")
								end

								a_row.parent.refresh_now
								lst_curs := lst.new_cursor
									--| We process in two steps
									--| first, let's restore the "first visible row's group"
									--| and then the others
									--| This will avoid processing too may rows
								from
									lst_curs.start
									r := 1
								until
									r > a_row.subrow_count or lst_curs.after
								loop
									t ?= lst_curs.item
									if t /= Void and then t.is_visible_row then
										process_row_layout_restoring (a_row.subrow (r), t)
										lst_curs.finish --| "first visible row's group found"
									end
									lst_curs.forth
									r := r + 1
								end
									--| Now let's restore layout for other rows
								from
									lst_curs.start
									r := 1
								until
									r > a_row.subrow_count or lst_curs.after
								loop
									t ?= lst_curs.item
									if t /= Void and then not t.is_visible_row then
										process_row_layout_restoring (a_row.subrow (r), t)
									end
									lst_curs.forth
									r := r + 1
								end
							else
								debug ("es_grid_layout")
									print ("%N")
								end
							end
						else
							debug ("es_grid_layout")
								print (" -> #[MissMatched] %N")
							end
						end
					end
				end
				if
					positioning_enabled
					and then not on_idle
					and then last_row_set_as_first_visible_row /= Void
				then
					ensure_row_is_first_visible_row (last_row_set_as_first_visible_row)
				end
			end
			if on_idle then
				restorations_in_progress := restorations_in_progress - 1
			end
			debug ("es_grid_layout")
				if restorations_in_progress = 0 then
					print (":" + name + ": all restorations completed %N")
				else
					print (":" + name + ": " + restorations_in_progress.out + " restorations are processing %N")
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
						print (":" + name + ": process_row_layout_restoring -> [" + string_id_for_lay (lay) + "] %N")
					end
						--| In this case, we need to force a redraw to be sure the first cell of the row
						--| get computed, then we'll be able to get the cell's text.
					if not row_is_ready_for_identification (a_row) then
						grid.refresh_now
					end
					if
						row_is_ready_for_identification (a_row)
						and then (value_agent /= Void and then row_is_ready_for_evaluation (a_row))
					then
						restore_row_layout (a_row, lay, False, current_processing_id)
					else
						restorations_in_progress := restorations_in_progress + 1
						debug ("es_grid_layout")
							print (":" + name + ": restoration requested [#" + restorations_in_progress.out + " @id=" +  current_processing_id.out + "]%N")
						end
						restore_row_layout_on_idle (a_row, lay, current_processing_id)
					end
					fixme ("[
								try to optimize the grid layout restoring,
								when we know the row has already been displayed
							]")
				else
					debug ("es_grid_layout")
						print (":" + name + ": process_row_layout_restoring -> [" + string_id_for_lay (lay) + "] now%N")
					end
					restore_row_layout (a_row, lay, False, current_processing_id)
				end
			end
		end

feature {NONE} -- Debugging

	string_id_for_lay (lay: like layout): STRING is
		do
			Result := lay.id
			if Result = Void then
				Result := ""
			end
		end

	debug_output: STRING is
		do
			if layout = Void then
				Result := ":" + name + ": No layout %N"
			else
				Result := grid_layout_output (layout, " : ")
			end
		end

	grid_layout_output (a_layout: like layout; off: STRING): STRING is
		local
			tu: like layout
			tu_s: STRING
			tu_v: ANY
			tu_v_s: STRING
			tu_lst: DS_LIST [TUPLE]
			tu_fvr: BOOLEAN
			tu_lst_curs: DS_LIST_CURSOR [TUPLE]
		do
			Result := ":" + name + ": "
			tu_s := a_layout.id
			tu_lst := a_layout.subrows
			tu_v := a_layout.value
			tu_fvr := a_layout.is_visible_row
			if tu_v /= Void then
				tu_v_s := tu_v.out
				tu_v_s.keep_head (20)
			else
				tu_v_s := ""
			end
			Result := ":" + name + ": " + off
			if tu_fvr then
				Result.append_string (" # ")
			else
				Result.append_string (" - ")
			end
			Result.append_string ("[" + tu_s.out + "] :: " + tu_v_s + "%N")
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

feature -- Actions

	pre_recording_actions,
	post_recording_actions: ACTION_SEQUENCE [TUPLE]

	pre_restoring_actions: ACTION_SEQUENCE [TUPLE]

feature {NONE} -- Agent

	row_is_ready_for_identification_agent: FUNCTION [ANY, TUPLE [EV_GRID_ROW], BOOLEAN]

	row_is_ready_for_evaluation_agent: FUNCTION [ANY, TUPLE [EV_GRID_ROW], BOOLEAN]

	global_identification_agent: FUNCTION [ANY, TUPLE, STRING]

	identification_agent: FUNCTION [ANY, TUPLE [EV_GRID_ROW], STRING]

	value_agent: FUNCTION [ANY, TUPLE [EV_GRID_ROW, BOOLEAN], ANY]

	on_difference_callback: PROCEDURE [ANY, TUPLE [EV_GRID_ROW, ANY]];
			-- row and old value

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
