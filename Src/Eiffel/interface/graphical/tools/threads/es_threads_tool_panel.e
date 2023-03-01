note
	description: "Tool that displays the threads during a debugging session."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_THREADS_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			internal_recycle,
			on_before_initialize,
			show
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	EB_SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	ES_DEBUGGING_UPDATE_ON_IDLE_TOOL_PANEL_I

create
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			create notes_on_threads.make (3)

			row_highlight_bg_color := Preferences.debug_tool_data.row_highlight_background_color
			set_row_highlight_bg_color_agent := agent set_row_highlight_bg_color
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.extend (set_row_highlight_bg_color_agent)
		end

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			box: EV_VERTICAL_BOX
			g: like grid
		do
			box := a_widget
			box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create g
			grid := g
			g.enable_single_row_selection
			g.enable_border
			g.enable_tree
			g.set_column_count_to (4)
			g.column (col_id_index).set_title (debugger_names.t_id)
			g.column (col_name_index).set_title (debugger_names.t_name)
			g.column (col_priority_index).set_title (debugger_names.t_priority)
			g.column (col_note_index).set_title (debugger_names.t_note)

			g.pointer_double_press_item_actions.extend (agent on_item_double_clicked)
			g.set_auto_resizing_column (col_id_index, True)
			g.set_auto_resizing_column (col_name_index, True)

			g.build_delayed_cleaning
			g.enable_partial_dynamic_content
			g.set_dynamic_content_function (agent dynamic_content_item)

			box.extend (g)
		end

feature -- Properties

	grid: ES_GRID
			-- Grid to display the threads

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "457B71DC-4609-DAC1-8458-CD9B64FD5945"
		end

feature {NONE} -- Factory

	dynamic_content_item (c,r: INTEGER): EV_GRID_ITEM
			-- Computed item at `(c,r)'
		local
			l_item: detachable EV_GRID_ITEM
		do
			l_item := grid.item (c, r)
			if l_item = Void then
				compute_row (r)
				l_item := grid.item (c, r)
			end
			if l_item = Void then
				create Result
			else
				Result := l_item
			end
		end

	compute_row (r: INTEGER)
			-- Compute the row indexed by `r'
			-- to fulfil the dynamic behavior
		local
			l_row: EV_GRID_ROW
			g: like grid
			tid: like thread_id_from_row
			lab: EV_GRID_LABEL_ITEM
			gedit: EV_GRID_EDITABLE_ITEM
			l_status: APPLICATION_STATUS
			prio: INTEGER
		do
			g := grid
			if r <= g.row_count then
				l_row := grid.row (r)
				if
					has_scoop_processor and then
					attached thread_id_and_scoop_processor_id_from_row (l_row) as tu_tid_scp
				then
					tid := tu_tid_scp.tid
					create lab.make_with_text (tid.out)
					l_row.set_item (col_id_index, lab)
					if tid /= Default_pointer then
						l_status := debugger_manager.application_status

						if tid = l_status.active_thread_id then
							lab.set_font (active_thread_font)
							lab.set_tooltip (debugger_names.t_debuggees_active_thread)
						end
						if tid = l_status.current_thread_id then
							l_row.set_background_color (row_highlight_bg_color)
							if l_row.is_displayed then
								l_row.ensure_visible
							end
						end

						if notes_on_threads.has (tid) then
							create gedit.make_with_text (notes_on_threads.item (tid))
						else
							create gedit
						end
						gedit.deactivate_actions.extend (agent update_notes_from_item (gedit))
						l_row.set_item (col_note_index, gedit)

					end

					l_row.set_item (col_priority_index, create {EV_GRID_LABEL_ITEM}.make_with_text (tu_tid_scp.scp.out))
				else
					tid := thread_id_from_row (l_row)
					if tid /= Default_pointer then
						l_status := debugger_manager.application_status

						create lab.make_with_text (tid.out)
						if tid = l_status.active_thread_id then
							lab.set_font (active_thread_font)
							lab.set_tooltip (debugger_names.t_debuggees_active_thread)
						end

						l_row.set_item (col_id_index, lab)

						if tid = l_status.current_thread_id then
							l_row.set_background_color (row_highlight_bg_color)
							if l_row.is_displayed then
								l_row.ensure_visible
							end
						end

						if attached l_status.thread_name (tid) as s then
							create lab.make_with_text (s)
						else
							create lab
						end
						l_row.set_item (col_name_index, lab)

						prio := l_status.thread_priority (tid)
						if prio > 0 then
							create lab.make_with_text (prio.out)
						else
							create lab
						end
						l_row.set_item (col_priority_index, lab)

						if notes_on_threads.has (tid) then
							create gedit.make_with_text (notes_on_threads.item (tid))
						else
							create gedit
						end
						gedit.deactivate_actions.extend (agent update_notes_from_item (gedit))
						l_row.set_item (col_note_index, gedit)
					end
				end
			end
		end

    create_widget: EV_VERTICAL_BOX
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
        do
        	create Result
        end

	create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
		end

feature -- Status setting

	selected_row: EV_GRID_ROW
		require
			single_row_selection_enabled: grid.is_single_row_selection_enabled
		do
			if grid.has_selected_row then
				Result := grid.selected_rows.first
			end
		end

	on_item_double_clicked (ax,ay,abut: INTEGER; gi:EV_GRID_ITEM)
		do
			if gi /= Void and then gi.parent /= Void then
				if attached {EV_GRID_EDITABLE_ITEM} gi as gedit then
					gedit.activate
				else
					on_row_double_clicked (gi.row)
				end
			end
		end

	on_row_double_clicked (a_row: EV_GRID_ROW)
		local
			tid: like thread_id_from_row
			tu_tid_scp: like thread_id_and_scoop_processor_id_from_row
		do
			if a_row /= Void then
				if has_scoop_processor then
					tu_tid_scp := thread_id_and_scoop_processor_id_from_row (a_row)
				end
				if tu_tid_scp /= Void then
					tid := tu_tid_scp.tid
				else
					tid := thread_id_from_row (a_row)
				end
				if tid /= Default_pointer then
					set_callstack_thread (tid)
				end
			end
		end

	set_callstack_thread (tid: POINTER)
		do
				-- FIXME jfiat: check what happens if the application is not stopped ?
			if Debugger_manager.application_current_thread_id /= tid then
				Debugger_manager.change_current_thread_id (tid)
			end
		end

	refresh
			-- Class has changed in `development_window'.
		do
		end

	reset_tool
		do
			reset_update_on_idle
			if notes_on_threads /= Void then
				notes_on_threads.wipe_out
			end
			clean_threads_info
		end

	show
			-- <Precursor>
		do
			Precursor
			if grid.is_displayed and grid.is_sensitive then
				grid.set_focus
			end
			request_update
		end

feature {NONE} -- Update

	on_update_when_application_is_executing (dbg_stopped: BOOLEAN)
			-- Update when debugging
		do
			request_clean_threads_info
		end

	on_update_when_application_is_not_executing
			-- Update when not debugging
		do
			request_clean_threads_info
		end

	real_update (dbg_was_stopped: BOOLEAN)
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running			
		local
			l_status: APPLICATION_STATUS
		do
			if debugger_manager.application_is_executing then
				l_status := debugger_manager.application_status
				if dbg_was_stopped or l_status.break_on_assertion_violation_pending then
					l_status.update_on_stopped_state
				end
				refresh_threads_info
			end
		end

feature {NONE} -- Memory management

	internal_recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			reset_tool
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.prune_all (set_row_highlight_bg_color_agent)
			Precursor
		end

feature {NONE} -- Implementation

	has_scoop_processor: BOOLEAN
			-- Is there any SCOOP processor thread displayed?

	threads_expanded: BOOLEAN
			-- Is threads row expanded?

	scoop_processors_expanded: BOOLEAN
			-- Is SCOOP Processor row expanded?	

	clean_threads_info
		do
			if attached grid as g then
				g.call_delayed_clean
			end
		end

	request_clean_threads_info
		do
			if attached grid as g then
				g.request_delayed_clean
			end
		end

	refresh_threads_info
			-- Refresh thread info according to debugger data
		require
			application_is_executing: debugger_manager.application_is_executing
		local
			g: like grid
			r: INTEGER
			row: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM

			tid: POINTER
			arr: LIST [POINTER]
			scp: ARRAY [POINTER]
			l_status: APPLICATION_STATUS
			i: INTEGER
			l_notes_on_threads: like notes_on_threads
		do
			g := grid
			clean_threads_info
			g.disable_tree
			l_status := debugger_manager.application_status
			if l_status /= Void and then l_status.is_stopped then
				arr := l_status.all_thread_ids.twin
				if arr /= Void and then not arr.is_empty then
					from
						l_notes_on_threads := notes_on_threads
						l_notes_on_threads.start
					until
						l_notes_on_threads.after
					loop
						tid := l_notes_on_threads.key_for_iteration
						if arr.has (tid) then
							l_notes_on_threads.forth
						elseif l_notes_on_threads.has (tid) then
							l_notes_on_threads.remove (tid)
						else
							l_notes_on_threads.forth
						end
					end

					scp := l_status.all_scoop_processor_thread_ids
					if scp = Void or else scp.is_empty then
						has_scoop_processor := False
						g.show_header
					else
						has_scoop_processor := True
						g.hide_header
						g.enable_tree

							-- Remove scoop processors
						from
							i := scp.lower
						until
							i > scp.upper
						loop
							arr.prune_all (scp [i])
							check removed: not arr.has (scp [i]) end
							i := i + 1
						end

							-- Add SCOOP processors
						r := g.row_count + 1
						g.insert_new_row (r)
						row := g.row (r)
						create lab.make_with_text (debugger_names.t_scoop_processors_title (scp.count))
						lab.set_font (group_thread_font)
						row.set_item (1, lab)

						if scoop_processors_expanded then
							fill_with_scoop_processors (row, scp, l_status)
							row.expand
						else
							row.expand_actions.extend_kamikaze (agent fill_with_scoop_processors (row, scp, l_status))
							row.ensure_expandable
						end
						row.expand_actions.extend (agent do scoop_processors_expanded := True end)
						row.collapse_actions.extend (agent do scoop_processors_expanded := False end)
					end

					if arr.count > 0 then
						if has_scoop_processor then
							r := g.row_count + 1
							g.insert_new_row (r)
							row := g.row (r)
							create lab.make_with_text (debugger_names.t_threads_title (arr.count))
							lab.set_font (group_thread_font)
							row.set_item (1, lab)

							if threads_expanded then
								fill_with_threads (arr, row, True, l_status)
								if row.is_expandable then
									row.expand
								end
							else
								row.expand_actions.extend_kamikaze (agent fill_with_threads (arr, row, True, l_status))
								row.ensure_expandable
							end

							row.expand_actions.extend (agent do threads_expanded := True end)
							row.collapse_actions.extend (agent do threads_expanded := False end)
						else
							--| no tree, flat grid
							fill_with_threads (arr, Void, False, l_status)
						end
					end
				else
					g.insert_new_row (1)
					create lab.make_with_text (debugger_names.t_no_information_about_thread)
					g.set_item (1, 1, lab)
				end
			else
				g.insert_new_row (1)
				create lab.make_with_text (debugger_names.t_no_information_when_not_stopped)
				g.set_item (1, 1, lab)
			end
			g.request_columns_auto_resizing
		end

	fill_with_threads (arr: LIST [POINTER]; a_row: detachable EV_GRID_ROW; a_is_tree_enabled: BOOLEAN; a_appstatus: APPLICATION_STATUS)
			-- Add threads infos (from `arr') to the grid
		require
			a_appstatus_attached: a_appstatus /= Void and then a_appstatus.is_stopped
			arr_non_empty: arr /= Void and then not arr.is_empty
		local
			g: like grid
			r: INTEGER
			l_row: EV_GRID_ROW
			tid: POINTER
			lab: EV_GRID_LABEL_ITEM
		do
			g := grid
			if a_row /= Void then
				create lab.make_with_text (debugger_names.t_name)
				lab.set_font (group_thread_font)
				a_row.set_item (col_name_index, lab)

				create lab.make_with_text (debugger_names.t_priority)
				lab.set_font (group_thread_font)
				a_row.set_item (col_priority_index, lab)

				create lab.make_with_text (debugger_names.t_note)
				lab.set_font (group_thread_font)
				a_row.set_item (col_note_index, lab)
			end
			if a_is_tree_enabled and a_row /= Void then
				r := a_row.index + 1
				g.insert_new_rows_parented (arr.count, r, a_row)
			else
				r := g.row_count + 1
				g.insert_new_rows (arr.count, r)
			end
			across
				arr as a
			loop
				l_row := g.row (r)
				tid := a.item
				l_row.set_data (tid)
				if tid = a_appstatus.active_thread_id then
					ev_application.add_idle_action_kamikaze (agent (irow: EV_GRID_ROW)
						do
							if not irow.is_destroyed and then irow.parent /= Void and then irow.is_displayed then
								irow.ensure_visible
							end
						end(l_row))
				end
				r := r + 1
			end
		end

	fill_with_scoop_processors (a_row: EV_GRID_ROW; a_scp: ARRAY [POINTER]; a_appstatus: APPLICATION_STATUS)
		require
			has_scoop_processor: has_scoop_processor
			a_appstatus_attached: a_appstatus /= Void and then a_appstatus.is_stopped
			a_row_attached: a_row /= Void and then a_row.parent /= Void
			a_scp_non_empty: a_scp /= Void and then not a_scp.is_empty
		local
			g: like grid
			l_tid: POINTER
			l_scp: NATURAL_16
			j,sr: INTEGER
			l_lab: EV_GRID_LABEL_ITEM
		do
			g := grid

--			create l_lab.make_with_text (debugger_names.t_name)
--			l_lab.set_font (group_thread_font)
--			a_row.set_item (col_name_index, l_lab)			
			a_row.set_item (col_name_index, create {EV_GRID_ITEM})

			create l_lab.make_with_text (debugger_names.t_id)
			l_lab.set_font (group_thread_font)
			a_row.set_item (col_priority_index, l_lab)

			create l_lab.make_with_text (debugger_names.t_note)
			l_lab.set_font (group_thread_font)
			a_row.set_item (col_note_index, l_lab)

			from
				sr := a_row.index
				g.insert_new_rows_parented (a_scp.count, sr + 1, a_row)
				j := a_scp.lower
			until
				j > a_scp.upper
			loop
				l_tid := a_scp.item (j)
				l_scp := a_appstatus.scoop_processor_id (l_tid)
				sr := sr + 1
				set_row_data (g.row (sr), l_tid, l_scp)
				j := j + 1
			end
		end

	set_row_data (r: EV_GRID_ROW; tid: POINTER; scp: NATURAL_16)
		do
			r.set_data ([tid, scp])

		end

feature {NONE} -- Implementation note

	update_notes_from_item (gi: EV_GRID_EDITABLE_ITEM)
			-- Update note attached to thread
		local
			tid: like thread_id_from_row
		do
			if gi /= Void and then gi.parent /= Void and then gi.row /= Void then
				tid := thread_id_from_row (gi.row) --| for thread and scoop processor
				if tid /= Default_pointer then
					notes_on_threads.force (gi.text, tid)
				end
			end
		end

	notes_on_threads: HASH_TABLE [READABLE_STRING_GENERAL, POINTER]
			-- Notes attached to thread

feature {NONE} -- Implementation, cosmetic

	thread_id_and_scoop_processor_id_from_row (r: EV_GRID_ROW): detachable TUPLE [tid: POINTER; scp: NATURAL_16]
			-- Thread id and SCOOP Processor id related to `r'
		do
			if
				has_scoop_processor and then
				attached r and then
				attached r.parent and then
				attached {like thread_id_and_scoop_processor_id_from_row} r.data as tu
			then
				Result := tu
			end
		end

	thread_id_from_row (r: EV_GRID_ROW): POINTER
			-- Thread id related to `r'
		do
			if r.parent /= Void and then r /= Void then
				if attached {POINTER_REF} r.data as tid then
					Result := tid.item
				elseif has_scoop_processor and then attached {like thread_id_and_scoop_processor_id_from_row} r.data as tu then
					Result := tu.tid
				end
			end
		end

	set_row_highlight_bg_color_agent : PROCEDURE
			-- Store agent for `set_row_highlight_bg_color' so that it gets properly removed
			-- when recycling.

	set_row_highlight_bg_color (v: COLOR_PREFERENCE)
			-- set Background color for highlighted row.
		do
			row_highlight_bg_color := v.value
		end

	row_highlight_bg_color: EV_COLOR;
			-- Background color for highlighted row.

	group_thread_font: EV_FONT
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

	active_thread_font: EV_FONT
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

feature {NONE} -- Constants

	col_id_index: 		INTEGER = 1
	col_name_index: 	INTEGER = 2
	col_priority_index: INTEGER = 3
	col_note_index: 	INTEGER = 4

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
