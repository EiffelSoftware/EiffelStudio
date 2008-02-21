indexing
	description: "Tool that displays the threads during a debugging session."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_THREADS_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			internal_recycle,
			on_before_initialize,
			on_after_initialized,
			show
		end

	EB_SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	DEBUGGING_UPDATE_ON_IDLE

create
	make

feature {NONE} -- Initialization

	on_before_initialize is
			-- <Precursor>
		do
			create notes_on_threads.make (3)

			row_highlight_bg_color := Preferences.debug_tool_data.row_highlight_background_color
			set_row_highlight_bg_color_agent := agent set_row_highlight_bg_color
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.extend (set_row_highlight_bg_color_agent)
		end

	build_tool_interface (a_widget: EV_VERTICAL_BOX) is
			-- <Precursor>
		local
			box: EV_VERTICAL_BOX
		do
			box := a_widget
			box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create grid
			grid.enable_single_row_selection
			grid.enable_border
			grid.set_column_count_to (4)
			grid.column (1).set_title (debugger_names.t_id)
			grid.column (2).set_title (debugger_names.t_name)
			grid.column (3).set_title (debugger_names.t_priority)
			grid.column (4).set_title (debugger_names.t_note)

			grid.pointer_double_press_item_actions.extend (agent on_item_double_clicked)
			grid.set_auto_resizing_column (1, True)
			grid.set_auto_resizing_column (2, True)

			box.extend (grid)

			grid.build_delayed_cleaning
		end

	on_after_initialized is
			-- <Precursor>
		do
			Precursor
			create_update_on_idle_agent
		end


feature -- Properties

	grid: ES_GRID
			-- Grid to display the threads

feature {NONE} -- Factory

    create_widget: EV_VERTICAL_BOX
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
        do
        	Create Result
        end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
		end

feature -- Status setting

	selected_row: EV_GRID_ROW is
		require
			single_row_selection_enabled: grid.is_single_row_selection_enabled
		local
			rows: LIST [EV_GRID_ROW]
		do
			rows := grid.selected_rows
			if not rows.is_empty then
				Result := rows.first
			end
		end

	on_item_double_clicked (ax,ay,abut: INTEGER; gi:EV_GRID_ITEM) is
		local
			gedit: EV_GRID_EDITABLE_ITEM
		do
			if gi /= Void and then gi.parent /= Void then
				gedit ?= gi
				if gedit /= Void then
					gedit.activate
				else
					on_row_double_clicked (gi.row)
				end
			end
		end

	on_row_double_clicked (a_row: EV_GRID_ROW) is
		local
			ir: INTEGER_REF
		do
			if a_row /= Void then
				ir ?= a_row.data
				if ir /= Void then
					set_callstack_thread (ir.item)
				end
			end
		end

	set_callstack_thread (tid: INTEGER) is
		do
				-- FIXME jfiat: check what happens if the application is not stopped ?
			if Debugger_manager.application_current_thread_id /= tid then
				Debugger_manager.change_current_thread_id (tid)
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
		end

	reset_tool is
		do
			reset_update_on_idle
			notes_on_threads.wipe_out
			clean_threads_info
		end

	show is
			-- <Precursor>
		do
			Precursor
			if grid.is_displayed and grid.is_sensitive then
				grid.set_focus
			end
		end

feature {NONE} -- Update

	on_update_when_application_is_executing (dbg_stopped: BOOLEAN) is
			-- Update when debugging
		do
			request_clean_threads_info
		end

	on_update_when_application_is_not_executing is
			-- Update when not debugging
		do
			request_clean_threads_info
		end

	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running			
		local
			l_status: APPLICATION_STATUS
		do
			if debugger_manager.application_is_executing then
				l_status := debugger_manager.application_status
				if dbg_was_stopped then
					l_status.update_on_stopped_state
				end
				refresh_threads_info
			end
		end

feature {NONE} -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			reset_tool
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.prune_all (set_row_highlight_bg_color_agent)
			Precursor
		end

feature {NONE} -- Implementation		

	clean_threads_info is
		do
			grid.call_delayed_clean
		end

	request_clean_threads_info is
		do
			grid.request_delayed_clean
		end

	refresh_threads_info is
			-- Refresh thread info according to debugger data
		require
			application_is_executing: debugger_manager.application_is_executing
		local
			r: INTEGER
			row: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
			gedit: EV_GRID_EDITABLE_ITEM

			tid: INTEGER
			arr: LIST [INTEGER]
			l_status: APPLICATION_STATUS
			s: STRING
			prio: INTEGER
		do
			clean_threads_info
			l_status := debugger_manager.application_status
			if l_status /= Void and then l_status.is_stopped then
				arr := l_status.all_thread_ids
				if arr /= Void and then not arr.is_empty then
					from
						notes_on_threads.start
					until
						notes_on_threads.after
					loop
						tid := notes_on_threads.key_for_iteration
						if not arr.has (tid) then
							if notes_on_threads.valid_key (tid) then
								notes_on_threads.remove (tid)
							else
								notes_on_threads.forth
							end
						else
							notes_on_threads.forth
						end
					end
					from
						grid.insert_new_rows (arr.count, 1)
						r := 1
						arr.start
					until
						arr.after
					loop
						row := grid.row (r)
						tid := arr.item
						create lab.make_with_text ("0x" + tid.to_hex_string)
						if tid = l_status.active_thread_id then
							lab.set_font (active_thread_font)
							lab.set_tooltip (debugger_names.t_debuggees_active_thread)
						end

						row.set_item (1, lab)

						if tid = l_status.current_thread_id then
							row.set_background_color (row_highlight_bg_color)
							if row.is_displayed then
								row.ensure_visible
							end
						end

						s := l_status.thread_name (tid)
						if s /= Void then
							create lab.make_with_text (s)
						else
							create lab
						end
						row.set_item (2, lab)

						prio := l_status.thread_priority (tid)
						if prio > 0 then
							create lab.make_with_text (prio.out)
						else
							create lab
						end
						row.set_item (3, lab)

						if notes_on_threads.has (tid) then
							create gedit.make_with_text (notes_on_threads.item (tid))
						else
							create gedit
						end
						gedit.deactivate_actions.extend (agent update_notes_from_item (gedit))
						row.set_item (4, gedit)

						row.set_data (tid)
						r := r + 1
						arr.forth
					end
				else
					grid.insert_new_row (1)
					create lab.make_with_text (debugger_names.t_no_information_about_thread)
					grid.set_item (1, 1, lab)
				end
			else
				grid.insert_new_row (1)
				create lab.make_with_text (debugger_names.t_no_information_when_not_stopped)
				grid.set_item (1, 1, lab)
			end
			grid.request_columns_auto_resizing
		end

feature {NONE} -- Implementation note

	update_notes_from_item (gi: EV_GRID_EDITABLE_ITEM) is
			-- Update note attached to thread
		local
			tid: INTEGER_REF
		do
			if gi /= Void and then gi.parent /= Void and then gi.row /= Void then
				tid ?= gi.row.data
				if tid /= Void then
					notes_on_threads.force (gi.text, tid.item)
				end
			end
		end

	notes_on_threads: HASH_TABLE [STRING, INTEGER]
			-- Notes attached to thread

feature {NONE} -- Implementation, cosmetic

	set_row_highlight_bg_color_agent : PROCEDURE [ANY, TUPLE]
			-- Store agent for `set_row_highlight_bg_color' so that it gets properly removed
			-- when recycling.

	set_row_highlight_bg_color (v: COLOR_PREFERENCE) is
			-- set Background color for highlighted row.
		do
			row_highlight_bg_color := v.value
		end

	row_highlight_bg_color: EV_COLOR;
			-- Background color for highlighted row.

	active_thread_font: EV_FONT is
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
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
