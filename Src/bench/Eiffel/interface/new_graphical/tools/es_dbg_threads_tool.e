indexing
	description: "Tool that displays the threads during a debugging session."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DBG_THREADS_TOOL

inherit
	EB_TOOL
		redefine
			menu_name,
			pixmap
		end

	EB_RECYCLABLE

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	DEBUGGING_UPDATE_ON_IDLE
		redefine
			update,
			real_update
		end

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		local
			box: EV_VERTICAL_BOX
		do
			row_highlight_bg_color := Preferences.debug_tool_data.row_highlight_background_color
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.extend (agent set_row_highlight_bg_color)

			create box
			box.set_padding (3)

			create grid
			grid.enable_single_row_selection
			grid.enable_border
			grid.set_column_count_to (3)
			grid.column (1).set_title ("Id")
			grid.column (2).set_title ("Name")
			grid.column (3).set_title ("Priority")

			grid.pointer_double_press_actions.force_extend (agent on_row_double_clicked)
			grid.set_auto_resizing_column (1, True)
			grid.set_auto_resizing_column (2, True)

			box.extend (grid)

			create_update_on_idle_agent

			grid.build_delayed_cleaning
			widget := box
		end

--	build_mini_toolbar is
--			-- Build the associated tool bar
--		do
--			create mini_toolbar
--		ensure
--			mini_toolbar_exists: mini_toolbar /= Void
--		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
--			if mini_toolbar = Void then
--				build_mini_toolbar
--			end
--			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_mini_toolbar (explorer_bar, widget, title, False, mini_toolbar)

			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make (explorer_bar, widget, title, True)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Properties

	grid: ES_GRID

feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Associated mini toolbar.

	widget: EV_WIDGET
			-- Widget representing Current.

	title: STRING is
			-- Title of the tool.
		do
			Result := "Threads" -- Interface_names.t_Call_stack_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := "Threads" -- Interface_names.m_Call_stack_tool
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
--| To be done.
--			Result := Pixmaps.Icon_call_stack
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

	on_row_double_clicked is
		local
			row: EV_GRID_ROW
			ir: INTEGER_REF
		do
			row := selected_row
			if row /= Void then
				ir ?= row.data
				if ir /= Void then
					set_callstack_thread (ir.item)
				end
			end
		end

	set_callstack_thread (tid: INTEGER) is
		do
				-- FIXME jfiat: check what happens if the application is not stopped ?
			if application.status.current_thread_id /= tid then
				application.status.set_current_thread_id (tid)
				application.status.reload_current_call_stack
				Debugger_manager.set_current_thread_id (tid)
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
		end

	update is
			-- Refresh `Current's display.
		local
			l_status: APPLICATION_STATUS
		do
			cancel_process_real_update_on_idle
			request_clean_threads_info
			l_status := application.status
			if l_status /= Void then
				process_real_update_on_idle (l_status.is_stopped)
			end
		end

	change_manager_and_explorer_bar (a_manager: EB_TOOL_MANAGER; an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
		end

feature {NONE} -- Implementation

	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running			
		local
			l_status: APPLICATION_STATUS
		do
			if Application.is_running then
				l_status := application.status
				if dbg_was_stopped then
					l_status.update_on_stopped_state
				end
				refresh_threads_info
			end
		end

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
		local
			r: INTEGER
			row: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM

			tid: INTEGER
			i: INTEGER
			arr: ARRAY [INTEGER]
			l_status: APPLICATION_STATUS
			s: STRING
			prio: INTEGER
		do
			clean_threads_info
			l_status := Application.status
			if l_status /= Void and then l_status.is_stopped then
				arr := l_status.all_thread_ids
				if arr /= Void and then not arr.is_empty then
					from
						grid.insert_new_rows (arr.count, 1)
						r := 1
						i := arr.lower
					until
						i > arr.upper
					loop
						row := grid.row (r)
						tid := arr @ i
						create lab.make_with_text ("0x" + tid.to_hex_string)
						row.set_item (1, lab)
						if tid = l_status.current_thread_id then
							row.set_background_color (row_highlight_bg_color)
						end

						s := l_status.thread_name (tid)
						if s /= Void then
							create lab.make_with_text (s)
						else
							create lab.make_with_text ("")
						end
						row.set_item (2, lab)

						prio := l_status.thread_priority (tid)
						if prio > 0 then
							create lab.make_with_text (prio.out)
						else
							create lab.make_with_text ("")
						end
						row.set_item (3, lab)

						row.set_data (tid)
						r := r + 1
						i := i + 1
					end
				else
					grid.insert_new_row (1)
					create lab.make_with_text ("Sorry no information available on Threads for now")
					grid.set_item (1, 1, lab)
				end
			else
				grid.insert_new_row (1)
				create lab.make_with_text ("Sorry no information available on Threads for now")
				grid.set_item (1, 1, lab)
			end
			grid.request_columns_auto_resizing
		end

feature {NONE} -- Implementation, cosmetic

	set_row_highlight_bg_color (v: COLOR_PREFERENCE) is
		do
			row_highlight_bg_color := v.value
		end

	row_highlight_bg_color: EV_COLOR;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
