note
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

	EV_SHARED_APPLICATION

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_grid: like grid; a_name: STRING)
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

feature -- Layout access

	layout: detachable ES_GRID_LAYOUT_ITEM
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

	subrows (lay: attached like layout): detachable LIST [detachable ES_GRID_LAYOUT_ITEM]
		do
			Result := lay.subrows
		end

	set_layout (v: like layout)
		do
			layout := v
		end

feature -- Change

	enable
		do
			enabled := True
		end

	disable
		do
			enabled := False
			wipe_out
		end

	destroy
		do
			disable
			post_recording_actions.wipe_out
			pre_recording_actions.wipe_out
			pre_restoring_actions.wipe_out
		end

	enable_positioning
		do
			positioning_enabled := True
		end

	disable_positioning
		do
			positioning_enabled := False
		end

	reset_layout_recorded_values
		do
			debug ("es_grid_layout")
				print (":" + name + ": " + generator + ".reset_layout_recorded_values %N")
			end

			if attached layout as l_layout then
				reset_recorded_values_from (l_layout)
			end
		end

	wipe_out
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

	set_row_is_ready_for_identification_agent (a_agent: like row_is_ready_for_identification_agent)
		do
			row_is_ready_for_identification_agent := a_agent
		end

	set_row_is_ready_for_evaluation_agent (a_agent: like row_is_ready_for_evaluation_agent)
		do
			row_is_ready_for_evaluation_agent := a_agent
		end

	set_global_identification_agent (a_agent: like global_identification_agent)
		do
			global_identification_agent := a_agent
		end

	set_identification_agent (a_agent: like identification_agent)
		do
			identification_agent := a_agent
		end

	set_value_agent (a_agent: like value_agent)
		do
			value_agent := a_agent
		end

	set_on_difference_callback (a_agent: like on_difference_callback)
		do
			on_difference_callback := a_agent
		end

feature -- Access

	record
		local
			r: INTEGER
			lst: like subrows
			gid: STRING_32
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
						print ({STRING_32} ":" + name + ": record : session [" + gid + "] %N")
					end

					from
						create {ARRAYED_LIST [like subrows.item]} lst.make (grid.row_count)
						create layout.make_with_details (gid, lst, Void, False)
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
				post_recording_actions.call (Void)
				debug ("es_grid_layout")
					print (":" + name + ": record -> done%N")
				end
			end
		end

	restore
		local
			s: STRING_32
			r: INTEGER
			gid: STRING_32
		do
			if enabled then
				debug ("es_grid_layout")
					print (":" + name + ": restore -> begin%N")
					print (debug_output)
				end
				pre_restoring_actions.call (Void)
				if attached layout as l_layout and grid.row_count > 0 and grid.is_tree_enabled then
					if restorations_in_progress = 0 then
						current_processing_id := 1
					else
						current_processing_id := current_processing_id + 1
					end
					last_row_set_as_first_visible_row := Void
					restorations_in_progress := 0

					gid := global_identification
					debug ("es_grid_layout")
						print ({STRING_32} ":" + name + ": restore : session [" + gid + "] %N")
					end

					s := l_layout.id
					if not s.is_equal (gid) then
						debug ("es_grid_layout")
							print ({STRING_32} ":" + name + ": different session -> " + s + " /= " + gid + "%N")
						end
						wipe_out
					else
						if
							attached l_layout.subrows as lst and then
							not lst.is_empty
						then
							r := 1
							across
								 lst as lst_curs
							until
								r > grid.row_count
							loop
								if attached {like layout} lst_curs as t then
									process_row_layout_restoring (grid.row (r), t)
								end
								r := r + grid.row (r).subrow_count_recursive + 1
							end
						end
						if positioning_enabled and then attached last_row_set_as_first_visible_row as l_row then
							ev_application.do_once_on_idle (agent ensure_row_is_first_visible_row (l_row))
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

	last_row_set_as_first_visible_row: detachable EV_GRID_ROW
			-- Last row set as first visible row during layout restoring.

	ensure_row_is_first_visible_row (r: EV_GRID_ROW)
		do
			if r.parent /= Void then
				grid.set_first_visible_row (r.index)
			end
			debug ("es_grid_layout")
				print (":" + name + ": ensure_row_is_first_visible_row  (row.index="+ r.index.out +") %N")
				if grid.first_visible_row = Void or else attached grid.first_visible_row as fvr and then r.index /= fvr.index then
					print (":" + name + ": -> ERROR ... %N")
				end
			end
		end

	row_is_ready_for_identification (a_row: EV_GRID_ROW): BOOLEAN
		do
			Result :=
				if attached identification_agent and attached row_is_ready_for_identification_agent as l_row_is_ready_for_identification_agent then
					l_row_is_ready_for_identification_agent (a_row)
				else
					row_is_ready_for_default_identification (a_row)
				end
		end

	row_is_ready_for_evaluation (a_row: EV_GRID_ROW): BOOLEAN
		require
			value_agent /= Void
		do
			Result := attached row_is_ready_for_evaluation_agent as is_ready implies is_ready (a_row)
		end

	row_is_ready_for_default_identification (a_row: EV_GRID_ROW): BOOLEAN
		do
			Result := a_row.item (1) /= Void
		end

	global_identification: STRING_32
		do
			Result := name.twin
			if
				attached global_identification_agent as identification and then
				attached identification (Void) as s
			then
				Result.append_string_general ("::")
				Result.append_string (s)
			end
		end

	row_identification (a_row: EV_GRID_ROW): detachable STRING_32
		do
			if attached identification_agent as l_identification_agent then
				Result := l_identification_agent.item ([a_row])
			else
				Result := default_identification (a_row)
			end
		end

	default_identification (a_row: EV_GRID_ROW): detachable STRING_32
		require
			a_row /= Void
		do
			if attached {EV_GRID_LABEL_ITEM} a_row.item (1) as lab then
				Result := lab.text
			end
		end

	reset_recorded_values_from (lay: attached like layout)
		require
			lay /= Void
		do
			lay.value := Void
			if attached lay.subrows as lst then
				across
					lst as lst_curs
				loop
					if attached lst_curs as x then
						reset_recorded_values_from (x)
					end
				end
			end
		end

	recorded_row_layout (a_row: EV_GRID_ROW): like layout
			-- FIXME: compiler is complaining when using 'like layout' for Result type
		local
			r: INTEGER
			lst: like subrows
			l_val: detachable ANY
			l_fvr: BOOLEAN
			lay: like layout
		do
			if a_row /= Void then
				if attached row_identification (a_row) as l_id then
					if attached value_agent as l_value_agent then
						l_val := l_value_agent.item ([a_row, True])
					end
					debug ("es_grid_layout")
						print ({STRING_32} ":" + name + ": " + generator + ".recorded_row_layout : "  + a_row.index.out + " %"" + l_id + "%".%N")
					end
					if a_row.is_expanded then
						debug ("es_grid_layout")
							print (":" + name + ":                     : expanded .%N")
						end
						if a_row.subrow_count > 0 then
							debug ("es_grid_layout")
								print (":" + name + ":                     : -> " + a_row.subrow_count.out + " subrows %N")
							end
							create {ARRAYED_LIST [detachable ES_GRID_LAYOUT_ITEM]} lst.make (a_row.subrow_count)
							from
								r := 1
							until
								r > a_row.subrow_count
							loop
								lay := recorded_row_layout (a_row.subrow (r))
								if positioning_enabled and then lay /= Void then
									l_fvr := l_fvr or else lay.is_visible_row
								end
								lst.extend (lay)
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
					create Result.make_with_details (l_id, lst, l_val, l_fvr)
				end
			end
		end

	restore_row_layout_on_idle (a_row: EV_GRID_ROW; lay: attached like layout; l_curr_pid: INTEGER)
		do
			debug ("es_grid_layout")
				print ({STRING_32} ":" + name + ": " + generator + ".restore_row_layout_on_idle : " + a_row.index.out + " -> " + string_id_for_lay (lay) + ": BEGIN %N")
			end
--			a_row.parent.refresh_now
--			print ("Row after refresh_now => " + a_row.count.out + "%N")
			Ev_application.do_once_on_idle (agent delayed_restore_row_layout (a_row, lay, l_curr_pid))
			debug ("es_grid_layout")
				print ({STRING_32} ":" + name + ": " + generator + ".restore_row_layout_on_idle : " + a_row.index.out + " -> " + string_id_for_lay (lay) + " : FINISHED %N")
			end
		end

	delayed_restore_row_layout (a_row: EV_GRID_ROW; lay: attached like layout; l_curr_pid: INTEGER)
		do
			debug ("es_grid_layout")
				print ({STRING_32} ":" + name + ": " + generator + ".delayed_restore_row_layout : " + a_row.index.out + " -> " + string_id_for_lay (lay) +"%N")
			end
			if a_row.parent /= Void and lay /= Void and row_is_ready_for_identification (a_row) then
					--| `lay' should not be Void, but issue bug#10172 still occurs
				restore_row_layout (a_row, lay, True, l_curr_pid)
			else
				restorations_in_progress := restorations_in_progress - 1
			end
		end

	restore_row_layout (a_row: EV_GRID_ROW; lay: attached like layout; on_idle: BOOLEAN; l_pid: INTEGER)
			-- if on_idle is True, this means the feature is called on idle
			-- in this case, we identify the current processing id with `l_pid'
			-- if it is different from `current_processing_id', this operation is cancelled.
			-- (nota: if `on_idle' is False, the value of `l_pid' is ignored)
		require
			lay_not_void: lay /= Void
			row_is_ready_for_identification: row_is_ready_for_identification (a_row)
		local
			ts: STRING_32
			tv, l_val: detachable ANY
			tfvr: BOOLEAN
			r: INTEGER
			has_diff: BOOLEAN
			l_done: BOOLEAN
		do
			if on_idle and l_pid /= current_processing_id then
					--| Cancel this restoration operation
				debug ("es_grid_layout")
					print ({STRING_32} ":" + name + ": restore_row_layout -> cancelled : " + a_row.index.out + "[" + string_id_for_lay (lay) + "] %N")
				end
			elseif a_row /= Void then
				ts := lay.id
				if ts /= Void then
					debug ("es_grid_layout")
						print ({STRING_32}":" + name + ": restore_row_layout -> [" + ts + "] ")
					end
					if attached row_identification (a_row) as l_id then
						debug ("es_grid_layout")
							print ({STRING_32} " ?id[%"" + l_id + "%"]")
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
									ensure_row_is_first_visible_row (a_row)
								end
							end

								--| Let's check difference
							if attached value_agent as l_value_agent then
								tv := lay.value
								l_val := l_value_agent.item ([a_row, False])
								if tv = Void or l_val = Void then
									has_diff := tv /= Void or l_val /= Void
								else
									has_diff := not tv.is_equal (l_val)
								end
								if has_diff and then attached on_difference_callback as l_on_difference_callback then
									l_on_difference_callback.call ([a_row, tv])
								end
							end

							if
								attached lay.subrows as lst --| a non Void list, then should be expanded
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

								if attached a_row.parent as p then
									p.refresh_now
								else
									check a_row_parented: False end
								end
									--| We process in two steps
									--| first, let's restore the "first visible row's group"
									--| and then the others
									--| This will avoid processing too may rows
								l_done := False
								r := 1
								across
									lst as lst_curs
								until
									r > a_row.subrow_count or l_done
								loop
									if attached {like layout} lst_curs as t and then t.is_visible_row then
										process_row_layout_restoring (a_row.subrow (r), t)
										l_done := True --| "first visible row's group found"
									end
									r := r + 1
								end
									--| Now let's restore layout for other rows
								r := 1
								across
									lst as lst_curs
								until
									r > a_row.subrow_count
								loop
									if attached {like layout} lst_curs as t and then not t.is_visible_row then
										process_row_layout_restoring (a_row.subrow (r), t)
									end
									r := r + 1
								end
--								Note: this should be useless, since this is not anymore a Gobo cursor
--								from until lst_curs.after loop
--									lst_curs.forth
--								end
							else
								debug ("es_grid_layout")
									print ("%N")
								end
							end
						else
							debug ("es_grid_layout")
								print (" -> #[MisMatched] %N")
							end
						end
					end
				end
				if
					positioning_enabled
					and then not on_idle
					and then attached last_row_set_as_first_visible_row as l_last_row_set_as_first_visible_row
				then
					ensure_row_is_first_visible_row (l_last_row_set_as_first_visible_row)
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

	process_row_layout_restoring (a_row: EV_GRID_ROW; lay: attached like layout)
		require
			lay /= Void
		do
			if a_row /= Void then
				if grid.is_content_partially_dynamic then
					debug ("es_grid_layout")
						print ({STRING_32} ":" + name + ": process_row_layout_restoring -> [" + string_id_for_lay (lay) + "] %N")
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
					debug ("refactor_fixme")
						fixme ("[
									try to optimize the grid layout restoring,
									when we know the row has already been displayed
								]")
					end
				else
					debug ("es_grid_layout")
						print ({STRING_32} ":" + name + ": process_row_layout_restoring -> [" + string_id_for_lay (lay) + "] now%N")
					end
					restore_row_layout (a_row, lay, False, current_processing_id)
				end
			end
		end

feature {NONE} -- Debugging

	string_id_for_lay (lay: attached like layout): STRING_32
		do
			if attached lay.id as s then
				Result := s
			else
				create Result.make_empty
			end
		end

	debug_output: STRING
		do
			if attached layout as l_layout then
				Result := grid_layout_output (l_layout, " : ")
			else
				Result := ":" + name + ": No layout %N"
			end
		end

	grid_layout_output (a_layout: attached like layout; off: STRING): STRING
		local
			tu_s: STRING_32
			tu_v: detachable ANY
			tu_v_s: STRING
			tu_lst: like subrows
			tu_fvr: BOOLEAN
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
				across
					tu_lst as tu_lst_curs
				loop
					if attached {like layout} tu_lst_curs as tu then
						Result.append_string (grid_layout_output (tu, off + "  "))
					end
				end
			end
		end

feature -- Actions

	pre_recording_actions,
	post_recording_actions: ACTION_SEQUENCE [TUPLE]

	pre_restoring_actions: ACTION_SEQUENCE [TUPLE]

feature {NONE} -- Agent

	row_is_ready_for_identification_agent: detachable FUNCTION [EV_GRID_ROW, BOOLEAN]

	row_is_ready_for_evaluation_agent: detachable FUNCTION [EV_GRID_ROW, BOOLEAN]

	global_identification_agent: detachable FUNCTION [STRING_32]

	identification_agent: detachable FUNCTION [EV_GRID_ROW, STRING_32]

	value_agent: detachable FUNCTION [EV_GRID_ROW, BOOLEAN, ANY]

	on_difference_callback: detachable PROCEDURE [EV_GRID_ROW, detachable ANY];
			-- row and old value

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
