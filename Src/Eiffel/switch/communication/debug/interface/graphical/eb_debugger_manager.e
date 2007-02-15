indexing
	description: "Shared object that manages all debugging actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_MANAGER

inherit

	DEBUGGER_MANAGER
		redefine
			make,
			controller,
			classic_debugger_timeout,
			classic_debugger_location,
			classic_close_dbg_daemon_on_end_of_debugging,
			dotnet_keep_stepping_info_non_eiffel_feature_pref,
			change_current_thread_id,
			on_application_before_launching,
			on_application_launched,
			on_application_before_resuming,
			on_application_resumed,
			on_application_before_stopped,
			on_application_just_stopped,
			on_application_quit,
			process_breakpoint,
			implementation,
			set_default_parameters,
			set_maximum_stack_depth,
			notify_breakpoints_changes,
			add_idle_action, remove_idle_action, new_timer,
			debugger_output_message, debugger_warning_message, debugger_status_message,
			display_application_status, display_system_info, display_debugger_info,
			set_error_message,
			windows_handle
		end

	EB_CONSTANTS

	EB_SHARED_INTERFACE_TOOLS

	EB_SHARED_GRAPHICAL_COMMANDS

	EB_SHARED_PREFERENCES

	EB_ERROR_MANAGER
		rename
			set_error_message as eb_set_error_message
		end

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			pbool: BOOLEAN_PREFERENCE
		do
			Precursor

			if not eiffel_project.batch_mode then
					--| When compiling in batch mode with the graphical "ec"
				create debug_run_cmd.make

					--| Graphical Preferences settings
				objects_split_proportion := preferences.debug_tool_data.local_vs_object_proportion

				display_agent_details := preferences.debug_tool_data.display_agent_details
				preferences.debug_tool_data.display_agent_details_preference.typed_change_actions.extend (
						agent (b: BOOLEAN)
							do
								display_agent_details := b
							end
					)

				pbool := preferences.debugger_data.debug_output_evaluation_enabled_preference
				dump_value_factory.set_debug_output_evaluation_enabled (pbool.value)
				pbool.typed_change_actions.extend (agent dump_value_factory.set_debug_output_evaluation_enabled)

					--| End of settings
				init_commands
				create watch_tool_list.make
			end

			create {DEBUGGER_TEXT_FORMATTER_OUTPUT} text_formatter_visitor.make
		end

	set_default_parameters
			-- Set hard coded default parameters values
			-- (export status {NONE})
		do
			Precursor {DEBUGGER_MANAGER}
			if preferences.debugger_data /= Void then
				set_slices (preferences.debugger_data.min_slice, preferences.debugger_data.max_slice)
				set_displayed_string_size (preferences.debugger_data.default_displayed_string_size)
				set_maximum_stack_depth (preferences.debugger_data.default_maximum_stack_depth)

				set_max_evaluation_duration (preferences.debugger_data.max_evaluation_duration)
				preferences.debugger_data.max_evaluation_duration_preference.typed_change_actions.extend (agent set_max_evaluation_duration)
			end
			check
				displayed_string_size: displayed_string_size = preferences.debugger_data.default_displayed_string_size
				max_evaluation_duration_set: preferences.debugger_data /= Void implies
						max_evaluation_duration = preferences.debugger_data.max_evaluation_duration
			end
		end

feature -- Settings

	classic_debugger_timeout: INTEGER is
		do
			if preferences.debugger_data /= Void then
				Result := preferences.debugger_data.classic_debugger_timeout
			end
		end

	classic_debugger_location: STRING is
		do
			if preferences.debugger_data /= Void then
				Result := preferences.debugger_data.classic_debugger_location
			end
		end

	classic_close_dbg_daemon_on_end_of_debugging: BOOLEAN is
		do
			if preferences.debugger_data /= Void then
				Result := preferences.debugger_data.close_classic_dbg_daemon_on_end_of_debugging
			end
		end

	dotnet_keep_stepping_info_non_eiffel_feature_pref: BOOLEAN_PREFERENCE is
		do
			if preferences.debugger_data /= Void then
				Result := preferences.debugger_data.keep_stepping_info_dotnet_feature_preference
			end
		end

feature -- Properties

	controller: EB_DEBUGGER_CONTROLLER

feature -- Access

	clear_bkpt: EB_CLEAR_STOP_POINTS_COMMAND
			-- Command that can remove one or more breakpoints from the system.

	enable_bkpt: EB_DEBUG_STOPIN_HOLE_COMMAND
			-- Command that can enable one or more breakpoints in the system.

	disable_bkpt: EB_DISABLE_STOP_POINTS_COMMAND
			-- Command that can disable one or more breakpoints in the system.

	debug_run_cmd: EB_DEBUG_RUN_CMD
		-- Command to run the project under debugger.

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_AND_MENUABLE_COMMAND]
			-- All commands that can be put in a toolbar.

feature -- tools

	call_stack_tool: EB_CALL_STACK_TOOL
			-- A tool that represents the call stack in a graphical display.

	threads_tool: ES_DBG_THREADS_TOOL
			-- A tool that represents the threads list in a graphical display.

	objects_tool: ES_OBJECTS_TOOL

	watch_tool_list: LINKED_SET [ES_WATCH_TOOL]

feature -- Output visitor

	text_formatter_visitor: DEBUGGER_TEXT_FORMATTER_VISITOR

feature -- tools management

	refresh_objects_grids is
			-- Refresh objects grids
			-- most likely due to display parameters changes
		do
			objects_tool.refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.refresh)
		end

	new_toolbar: ARRAYED_SET [SD_TOOL_BAR_ITEM] is
			-- Toolbar containing all debugging commands.
		do
			Result := preferences.debug_tool_data.retrieve_project_toolbar (toolbarable_commands)
		end

	new_debug_menu: EV_MENU is
			-- Generate a menu that can be displayed in development windows.
		require
			--| commands_initialized: toolbarable_commands /= Void
		local
			sep: EV_MENU_SEPARATOR
			mit: EV_MENU_ITEM
		do
			create Result.make_with_text (Interface_names.m_Debug)

			Result.extend (clear_bkpt.new_menu_item)
			Result.extend (disable_bkpt.new_menu_item)
			Result.extend (enable_bkpt.new_menu_item)
			Result.extend (bkpt_info_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (options_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (step_cmd.new_menu_item)
			Result.extend (into_cmd.new_menu_item)
			Result.extend (out_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (debug_cmd.new_menu_item)
			Result.extend (no_stop_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (stop_cmd.new_menu_item)
			Result.extend (quit_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (set_critical_stack_depth_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)
			Result.extend (exception_handler_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)
			Result.extend (assertion_checking_handler_cmd.new_menu_item)
			Result.extend (force_debug_mode_cmd.new_menu_item)

			debug ("DEBUGGER_INTERFACE")
					-- Separator.
				create sep
				Result.extend (sep)
				create mit.make_with_text ("raise")
				mit.select_actions.extend (agent force_raise)
				Result.extend (mit)
				create mit.make_with_text ("unraise")
				mit.select_actions.extend (agent force_unraise)
				Result.extend (mit)
			end

--| FIXME XR: TODO: Add:
--| 3) edit feature, feature evaluation
		end

	menuable_debugging_tools: ARRAY [EB_TOOL] is
			-- List of all debugging tools to be listed under the debug->tools menu.
		do
			Result := <<call_stack_tool, threads_tool>>
		end

	new_debugging_tools_menu: EV_MENU is
			-- New debugging tools menu.
		do
			create Result.make_with_text (Interface_names.m_Tools)
			Result.disable_sensitive
		ensure
			Result /= Void
		end

	update_debugging_tools_menu_from (w: EB_DEVELOPMENT_WINDOW) is
			-- Update the debugging_tools_menu related to `w'	
		require
			w /= Void
		local
			m: EV_MENU
			mit: EV_MENU_ITEM
			l_tools: ARRAY [EB_TOOL]
			l_tool: EB_TOOL
			i: INTEGER
		do
			m := w.menus.debugging_tools_menu
			m.wipe_out
			if raised or debug_mode_forced then
				l_tools := menuable_debugging_tools
				if not l_tools.is_empty then
					from
						i := l_tools.lower
					until
						i > l_tools.upper
					loop
						l_tool := l_tools [i]
						if l_tool /= Void then
							create mit.make_with_text (l_tool.menu_name)
							if l_tool.pixmap /= Void then
								mit.set_pixmap (l_tool.pixmap)
							end
							mit.select_actions.extend (agent show_hide_debugging_tools (mit))
							m.extend (mit)
						end
						i := i + 1
					end
					m.enable_sensitive
				end
			else
				m.disable_sensitive
			end
		end

	update_all_debugging_tools_menu is
			-- Update all debugging_tools_menu in all development windows
		do
			window_manager.for_all_development_windows (agent update_debugging_tools_menu_from)
		end

	show_hide_debugging_tools (mit: EV_MENU_ITEM) is
			-- Toggle display status of Tool related to `mit'
		require
			mit /= Void
		local
			l_tool: EB_TOOL
			l_tools: ARRAY [EB_TOOL]
			i: INTEGER
			s: STRING_GENERAL
		do
			if raised then
				l_tools := menuable_debugging_tools
				from
					s := mit.text
					i := l_tools.lower
				until
					i > l_tools.upper
				loop
					l_tool := l_tools [i]
					if l_tool /= Void and then s.is_equal (l_tool.menu_name) then
						if l_tool.shown then
							l_tool.close
						else
							l_tool.show
							if l_tool.widget.is_displayed then
								l_tool.widget.set_focus
							end
						end
					end
					i := i + 1
				end
			end
		end

	show_thread_tool is
			-- Show thread tool if any.
		do
			if threads_tool /= Void then
				threads_tool.show
			end
		end

	show_object_tool is
			-- Show object tool if any.
		do
			if objects_tool /= Void then
				objects_tool.show
			end
		end

	show_a_hidden_watch_tool is
			-- Show a hidden watch tool if any.
			-- If all shown, show next one.
		local
			l_watch_tools: like watch_tool_list
			l_shown: BOOLEAN
			l_watch_tool: ES_WATCH_TOOL
			l_focused_watch_index: INTEGER
		do
			l_watch_tools := watch_tool_list
			from
				l_watch_tools.start
			until
				l_watch_tools.after
			loop
				if l_watch_tools.item.content.has_focus then
					l_shown := True
					l_focused_watch_index := l_watch_tools.index
				end
				if l_watch_tool = Void and then not l_watch_tools.item.shown then
					l_watch_tool := l_watch_tools.item
				end
				l_watch_tools.forth
			end
			if l_watch_tool /= Void then
				l_watch_tool.show
			elseif not l_watch_tools.is_empty then
				if l_focused_watch_index = l_watch_tools.count then
					l_focused_watch_index := 1
				else
					l_focused_watch_index := l_focused_watch_index + 1
				end
				l_watch_tools.i_th (l_focused_watch_index).show
			end
		end

	create_new_watch_tool_inside_notebook (a_manager: EB_DEVELOPMENT_WINDOW; a_watch_tool: ES_WATCH_TOOL) is
			-- Create a new watch tool.
		require
			a_manager /= Void
		local
			l_watch_tool: ES_WATCH_TOOL
			i: INTEGER
		do
			i := new_watch_tool_number
			create l_watch_tool.make_with_title (a_manager, interface_names.t_watch_tool.as_string_32 + " #" + i.out, interface_names.to_watch_tool + " #")
			if a_watch_tool /= Void then
			 	l_watch_tool.attach_to_docking_manager_with (a_manager.docking_manager, a_watch_tool)
			else
				l_watch_tool.attach_to_docking_manager (a_manager.docking_manager)
			end
			watch_tool_list.extend (l_watch_tool)
			assgin_watch_tool_unique_titles
		end

	close_watch_tool (wt: ES_WATCH_TOOL) is
		require
			wt /= Void
		do
			wt.close
			watch_tool_list.prune_all (wt)
		end

feature -- Events helpers

	new_timer: EV_DEBUGGER_TIMER is
		do
			create Result
		end

	add_idle_action (v: PROCEDURE [ANY, TUPLE]) is
		do
			ev_application.add_idle_action (v)
		end

	remove_idle_action (v: PROCEDURE [ANY, TUPLE]) is
		do
			ev_application.remove_idle_action (v)
		end

feature -- GUI Access

	windows_handle: POINTER is
		do
			Result := implementation.ev_window_win32_handle (debugging_window.window)
		end

feature {NONE} -- watch tool numbering

	new_watch_tool_number: INTEGER is
		do
			last_watch_tool_number := last_watch_tool_number + 1
			Result := last_watch_tool_number
		end

	last_watch_tool_number: INTEGER

feature -- Status report

	debugging_window: EB_DEVELOPMENT_WINDOW
			-- Window in which the debugger was launched (via run...).

	raised: BOOLEAN
			-- Are the debugging tools currently raised?

	debug_mode_forced: BOOLEAN
			-- Do we force debugger interface to stay raised ?

	is_exiting_eiffel_studio: BOOLEAN
			-- Is exiting Eiffel Studio now?

feature -- Output

	debugger_output_message (m: STRING_GENERAL) is
		do
			check output_manager /= Void end
			output_manager.add_string (m)
			output_manager.add_new_line
		end

	debugger_warning_message (m: STRING_GENERAL) is
		local
			w_dlg: EV_WARNING_DIALOG
		do
			if ev_application = Void then
				Precursor {DEBUGGER_MANAGER} (m)
			else
				create w_dlg.make_with_text (m)
				if window_manager.last_focused_development_window /= Void then
					w_dlg.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
					w_dlg.show
				end
			end
		end

	debugger_status_message (m: STRING_GENERAL) is
		do
			window_manager.display_message (m)
		end

	display_application_status is
		do
			output_manager.display_application_status
		end

	display_system_info	is
		do
			output_manager.display_system_info
		end

	display_debugger_info is
		do
			text_formatter_visitor.append_debugger_information (Current, output_manager)
		end

	display_system_status is
		do
			if application_is_executing then
				display_debugger_info
			else
				display_system_info
			end
		end

feature -- Change

	set_error_message (s: STRING) is
		do
			eb_set_error_message (s)
		end

	toggle_display_breakpoints is
			-- Show or hide the breakpoint tool
		local
			bp_tool: ES_BREAKPOINTS_TOOL
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev := last_focused_development_window (False)
			if conv_dev /= Void then
				bp_tool := conv_dev.tools.breakpoints_tool
				if bp_tool /= Void then
					bp_tool.show
				end
			end
		end

	display_breakpoints (show_tool_if_closed: BOOLEAN) is
			-- Show the list of breakpoints (set and disabled) in the output manager.
		local
			bp_tool: ES_BREAKPOINTS_TOOL
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev := last_focused_development_window (False)
			if conv_dev /= Void then
				bp_tool := conv_dev.tools.breakpoints_tool
				if bp_tool /= Void then
					if show_tool_if_closed then
						bp_tool.show
					end
				end
			end
		end

	last_focused_development_window (create_if_void: BOOLEAN): EB_DEVELOPMENT_WINDOW is
		do
			Result := window_manager.last_focused_development_window
			if Result = Void and create_if_void then
				Result := window_manager.a_development_window
			end
		end

	notify_breakpoints_changes is
		do
			Precursor
			display_breakpoints (False)
			window_manager.synchronize_all_about_breakpoints
		end

feature -- Status setting

	force_debug_mode is
			-- Force debug mode
		do
			debug_mode_forced := True
			if not raised then
				raise
			end
		end

	unforce_debug_mode is
			-- unForce debug mode
		require
			debug_mode_forced = True
		do
			debug_mode_forced := False
			if raised
				and not application_launching_in_progress
				and not application_is_executing
			then
				unraise
			end
		end

	set_debugging_window (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Associate `Current' with `a_window'.
		do
			if not raised then
				debugging_window := a_window
			end
		end

	set_maximum_stack_depth (nb: INTEGER) is
			-- Set the maximum number of stack elements to be displayed to `nb'.
		local
			pos: INTEGER
			cst: CALL_STACK_STONE
			ecs: EIFFEL_CALL_STACK
			st: APPLICATION_STATUS
		do
			Precursor (nb)
			if application_is_executing then
				st := application_status
				st.set_max_depth (nb)
				if st.is_stopped then
					pos := application.current_execution_stack_number
					st.reload_current_call_stack
					ecs := st.current_call_stack
					if ecs = Void or else ecs.is_empty then
						--| Nothing to display, maybe debugger had an issue getting call stack ..
					else
						if pos > st.current_call_stack.count then
								-- We reloaded less elements than there were.
							pos := 1
						end
						call_stack_tool.update
						create cst.make (pos)
						if cst.is_valid then
							launch_stone (cst)
						end
					end
				end
			end
		end

	on_compile_start is
			-- A new compilation has started. Kill any debugged application and gray out all run* commands.
		do
			if application_is_executing then
				application.kill
			end
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			step_cmd.disable_sensitive
			out_cmd.disable_sensitive
			into_cmd.disable_sensitive
			assertion_checking_handler_cmd.disable_sensitive
		end

	on_compile_stop is
			-- A compilation is over. Make all run* commands sensitive.
		do
			if is_msil_dll_system then
				disable_debugging_commands (True)
			else
				if not process_manager.is_freezing_running then
					step_cmd.enable_sensitive
					into_cmd.enable_sensitive
					no_stop_cmd.enable_sensitive
					debug_cmd.enable_sensitive
					enable_debug
				end
			end
		end

	raise is
			-- Make the debug tools appear in `debugging_window'.
		require
			not_already_raised: not raised

		local
			split: EV_SPLIT_AREA
			i: INTEGER
			l_watch_tool: ES_WATCH_TOOL
			nwt: INTEGER
			l_unlock: BOOLEAN
		do
			force_debug_mode_cmd.disable_sensitive
			initialize_debugging_window
			check
				debugging_window_set: debugging_window /= Void
			end

				--| Switching popup
			popup_switching_mode

			if ev_application.locked_window = Void then
				l_unlock := True
				debugging_window.window.lock_update
			end
			debugging_window.save_tools_docking_layout

				-- Change the state of the debugging window.
			debugging_window.hide_tools

				--| Grid Objects Tool
			if objects_tool = Void then
				create objects_tool.make_with_debugger (debugging_window, Current)
			else
				objects_tool.set_manager (debugging_window)
			end
			objects_tool.attach_to_docking_manager (debugging_window.docking_manager)

			objects_tool.set_cleaning_delay (preferences.debug_tool_data.delay_before_cleaning_objects_grid)
			objects_tool.request_update

				--| Watches tool
			nwt := Preferences.debug_tool_data.number_of_watch_tools.max (1)
			if watch_tool_list.count < nwt  then
				from
					l_watch_tool := Void
					if not watch_tool_list.is_empty then
						l_watch_tool := watch_tool_list.last
					end
				until
					watch_tool_list.count >= nwt
				loop
					create_new_watch_tool_inside_notebook (debugging_window, l_watch_tool)
				end
			else
				from
					l_watch_tool := Void
					if not watch_tool_list.is_empty then
						l_watch_tool := watch_tool_list.last
					end
					watch_tool_list.start
				until
					watch_tool_list.after
				loop
					l_watch_tool := watch_tool_list.item
					if l_watch_tool /= Void then
						l_watch_tool.set_manager (debugging_window)
						l_watch_tool.attach_to_docking_manager_with (debugging_window.docking_manager, l_watch_tool)
					end
					watch_tool_list.forth
				end

			end

			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.prepare_for_debug)
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.request_update)

				--| Threads Tool
			if threads_tool = Void then
				create threads_tool.make (debugging_window)
			end
			threads_tool.attach_to_docking_manager (debugging_window.docking_manager)
			threads_tool.request_update

				--| Call Stack Tool
			if call_stack_tool = Void then
				create call_stack_tool.make (debugging_window)
			end
			call_stack_tool.attach_to_docking_manager (debugging_window.docking_manager)
			call_stack_tool.request_update

				-- Show Tools and final visual settings
			debugging_window.show_tools

			restore_debug_docking_layout

				--| Set the Grid Objects tool split position to 200 which is the default size of the local tree.
			split ?= objects_tool.widget
			if split /= Void then
				if 0 <= objects_split_proportion and objects_split_proportion <= 1 then
					split.set_proportion (objects_split_proportion)
				end
				split := Void
			end

			raised := True
			if l_unlock then
				debugging_window.window.unlock_update
			end
			unpopup_switching_mode
			force_debug_mode_cmd.enable_sensitive
		ensure
			raised
		end

	restore_debug_docking_layout is
			-- Restore debug docking layout
		local
			l_result: BOOLEAN
			l_file: RAW_FILE

		do
			create l_file.make (debugging_window.docking_debug_config_file)
			if l_file.exists then
				l_result := debugging_window.docking_manager.open_tools_config (debugging_window.docking_debug_config_file)
			end
			if not l_result then
				restore_standard_debug_docking_layout
			end
				-- FIXME: To be implemented.
--			debugging_window.update_items_states
--			debugging_window.update_menu_item_state

			refresh_breakpoints_tool
		end

	save_debug_docking_layout is
			-- Save debug docking layout
		do
			debugging_window.docking_manager.save_tools_config (debugging_window.docking_debug_config_file)
		end

	restore_standard_debug_docking_layout is
			-- Restore standard debug docking layout.
		local
			l_result: BOOLEAN
			l_file: RAW_FILE
			l_fn: FILE_NAME
		do
			l_fn := debugging_window.docking_standard_layout_path.twin
			l_fn.set_file_name (debugging_window.standard_tools_debug_layout_name)
			create l_file.make (l_fn)
			if l_file.exists then
				l_result := debugging_window.docking_manager.open_tools_config (l_fn)
			end
			if not l_result then
				restore_standard_debug_docking_layout_by_code
			end
		end

	unraise is
			-- Make the debug tools disappear from `a_window'.
		require
			debugger_raised: raised
		local
			i: INTEGER
			split: EV_SPLIT_AREA
			l_unlock: BOOLEAN
		do
			force_debug_mode_cmd.disable_sensitive

				--| Switching popup
			popup_switching_mode

			if ev_application.locked_window = Void then
				l_unlock := True
				debugging_window.window.lock_update
			end

			objects_tool.save_grids_preferences
			split ?= objects_tool.widget
			if split /= Void then
				objects_split_proportion := split.split_position / split.width
			end

			save_debug_docking_layout
			objects_tool.content.close
			Preferences.debug_tool_data.number_of_watch_tools_preference.set_value (watch_tool_list.count)
			from
				watch_tool_list.start
			until
				watch_tool_list.after
			loop
				watch_tool_list.item.content.close
				watch_tool_list.forth
			end

			call_stack_tool.content.close
			threads_tool.content.close

				-- Free and recycle tools
			raised := False

			debugging_window.restore_tools_docking_layout
			refresh_breakpoints_tool
			if l_unlock then
				debugging_window.window.unlock_update
			end
			unpopup_switching_mode
			force_debug_mode_cmd.enable_sensitive
		ensure
			not raised
		end

	reset_tools is
			-- Reset tools to free unused data
		do
			threads_tool.reset_tool
			call_stack_tool.reset_tool
			objects_tool.reset_tool
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.reset_tool)
			if application /= Void then
				destroy_application
			end
		end

	set_stone (st: STONE) is
			-- Propagate `st' to tools.
		local
			cst: CALL_STACK_STONE
			propagate_stone: BOOLEAN
		do
			if raised then
				cst ?= st
				if cst /= Void then
					if application_is_executing then
						propagate_stone := application.current_execution_stack_number /= cst.level_number
						application.set_current_execution_stack_number (cst.level_number)
					end
				end
				if propagate_stone then
					call_stack_tool.set_stone (st)
					objects_tool.set_stone (st)
					watch_tool_list.do_all (agent {ES_WATCH_TOOL}.set_stone (st))
				end
			end
		end

	change_current_thread_id (tid: INTEGER) is
			-- Set Current thread id to `tid'
		do
			Precursor (tid)
			if raised then
				call_stack_tool.update
				threads_tool.update
			end
		end

	save_interface (toolbar: EB_TOOLBAR) is
			-- Save the interface configuration using `toolbar'.
		do
			preferences.debug_tool_data.save_project_toolbar (toolbar)
		end

	assgin_watch_tool_unique_titles is
			-- Reassgn all unique titles of watch tools.
		do
			from
				watch_tool_list.start
			until
				watch_tool_list.after
			loop
				watch_tool_list.item.content.set_unique_title (once "watch_tool_" + watch_tool_list.index.out)
				watch_tool_list.forth
			end
		end

	enable_exiting_eiffel_studio is
			-- Set `is_exiting_eiffel_studio' with true.
		do
			is_exiting_eiffel_studio := True
		end

feature {NONE} -- Raise/unraise notification

	popup_switching_mode is
		local
			popup: EV_POPUP_WINDOW
			lab: EV_LABEL
			w,h, pw,ph: INTEGER
		do
			if debugging_window /= Void then
				create popup
				popup.enable_border
				create lab
				if raised then
					lab.set_text (interface_names.l_Switching_to_normal_mode)
				else
					lab.set_text (interface_names.l_Switching_to_debug_mode)
				end
				popup.extend (lab)
				lab.refresh_now
				w := debugging_window.window.width
				h := debugging_window.window.height
				pw := lab.font.string_width (lab.text) + 30
				ph := lab.font.height + 30
				popup.set_size (pw, ph)
				popup.set_position (debugging_window.window.x_position + (w - pw) // 2, debugging_window.window.y_position + (h - ph) // 2)
				popup.show_relative_to_window (debugging_window.window)
				popup.refresh_now
				switching_mode_popup := popup
			end
		end

	unpopup_switching_mode is
		do
			if switching_mode_popup /= Void then
				switching_mode_popup.destroy
			end
		end

	switching_mode_popup: EV_POPUP_WINDOW

feature -- Debugging events

	process_breakpoint (bp: BREAKPOINT): BOOLEAN is
		do
			Result := Precursor {DEBUGGER_MANAGER} (bp)
			if debugging_window /= Void then
				debugging_window.tools.breakpoints_tool.refresh
			end
		end

	resume_application is
			-- Quickly relaunch the application.
		require
			stopped: safe_application_is_stopped
		do
			application.continue
			if application_is_executing and then not application_is_stopped then
				application.on_application_resumed
			else
				debug ("debugger_trace")
					print ("Application is stopped, but it should not")
				end
			end
		end

	launch_stone (st: STONE) is
			-- Set `st' in the debugging window as the new stone.
		do
			debugging_window.tools.launch_stone (st)
		end

	on_application_before_launching is
			-- Application is about to be launched.
		do
			Precursor
			disable_debugging_commands (False)
		end

	on_application_launched is
			-- Application has just been launched.
		do
			update_all_debugging_tools_menu

			Precursor
			debug("debugger_trace_synchro")
				io.put_string (generator + ".on_application_launched %N")
			end

			debugging_window.tools.features_relation_tool.pop_feature_flat

				-- Modify the debugging window display.
			stop_cmd.enable_sensitive
			quit_cmd.enable_sensitive
			restart_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			debug_cmd.set_launched (True)
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			set_critical_stack_depth_cmd.disable_sensitive

			assertion_checking_handler_cmd.reset

			if dialog /= Void and then not dialog.is_destroyed then
				close_dialog
			end

				-- Update Watch tool
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.request_update)
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_launched : done%N")
			end
		end

	on_application_before_stopped is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		do
			Precursor
		end

	on_application_just_stopped is
			-- Application was just stopped (by a breakpoint, ...).
		local
			st: CALL_STACK_STONE
			cd: EB_CONFIRMATION_DIALOG
		do
			Precursor
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_just_stopped : start%N")
			end
			stop_cmd.disable_sensitive
			no_stop_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			step_cmd.enable_sensitive
			out_cmd.enable_sensitive
			into_cmd.enable_sensitive
			set_critical_stack_depth_cmd.enable_sensitive
			assertion_checking_handler_cmd.enable_sensitive

			debug ("debugger_interface")
				io.put_string ("Application Stopped (dixit EB_DEBUGGER_MANAGER)%N")
			end

			objects_tool.disable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.disable_refresh)
			if not application.current_call_stack_is_empty then
				st := first_valid_call_stack_stone
				if st /= Void then
					launch_stone (st)
					-- After launch_stone, the call stack tool will show something, so we want the feature relation tool show up too.
					if call_stack_tool.widget.is_displayed then
						debugging_window.tools.features_relation_tool.show
					end
				end
			end
			window_manager.quick_refresh_all_margins

				-- Fill in the threads tool.
			threads_tool.request_update
				-- Fill in the stack tool.
			call_stack_tool.request_update
				-- Fill in the objects tool.

			objects_tool.enable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.enable_refresh)

			objects_tool.request_update
				-- Update Watch tool
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.request_update)

			debugging_window.window.raise

			if application_status.reason_is_overflow then
				create cd.make_with_text_and_actions (Warning_messages.w_Overflow_detected, <<agent do_nothing, agent resume_application>>)
				cd.show_modal_to_window (debugging_window.window)
			end

			debug ("debugger_interface")
				io.put_string ("Application Stopped End (dixit EB_DEBUGGER_MANAGER)%N")
			end
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_just_stopped : done%N")
			end
		end

	on_application_before_resuming is
		do
			Precursor
			objects_tool.record_grids_layout
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.record_grid_layout)
		end

	on_application_resumed is
			-- Application was resumed after a stop.
		do
			Precursor

			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_resumed%N")
			end

			stop_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			step_cmd.disable_sensitive
			out_cmd.disable_sensitive
			into_cmd.disable_sensitive
			set_critical_stack_depth_cmd.disable_sensitive
			assertion_checking_handler_cmd.disable_sensitive

			objects_tool.disable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.disable_refresh)

				-- Fill in the threads tool.
			threads_tool.request_update
				-- Fill in the stack tool.
			call_stack_tool.request_update

			objects_tool.enable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.enable_refresh)

				-- Fill in the objects tool.
			objects_tool.request_update

				-- Update Watch tool
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.request_update)

			window_manager.quick_refresh_all_margins
			if dialog /= Void and then not dialog.is_destroyed then
				close_dialog
			end

			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_resumed : done%N")
			end
		end

	on_application_quit is
			-- Application just quit.
			-- This application means the debuggee.
		local
			was_executing: BOOLEAN
		do
			debug("debugger_trace_synchro")
				io.put_string (generator + ".on_application_quit %N")
			end
			was_executing := application_is_executing
			Precursor

			if was_executing then
					-- Modify the debugging window display.
				window_manager.quick_refresh_all_margins
				disable_debugging_commands (False)

					--| Clean and reset debugging tools
				reset_tools

					-- Make all debugging tools disappear.
				if debugging_window.destroyed then
					debugging_window := Void
					raised := False
					debug_mode_forced := False
					force_debug_mode_cmd.set_select (False)
				elseif is_exiting_eiffel_studio then
					save_debug_docking_layout
					debugging_window := Void
				elseif not debug_mode_forced then
					unraise
					debugging_window := Void
				end

				enable_debugging_commands
				update_all_debugging_tools_menu

					-- Make related buttons insensitive.
				stop_cmd.disable_sensitive
				quit_cmd.disable_sensitive
				restart_cmd.disable_sensitive
				debug_cmd.enable_sensitive
				debug_cmd.set_launched (False)
				no_stop_cmd.enable_sensitive

				step_cmd.enable_sensitive
				into_cmd.enable_sensitive
				out_cmd.disable_sensitive

				set_critical_stack_depth_cmd.enable_sensitive
				assertion_checking_handler_cmd.reset
			end

			debug("debugger_trace_synchro")
				io.put_string (generator + ".on_application_quit : done%N")
			end
		end

	first_valid_call_stack_stone: CALL_STACK_STONE is
			-- Stone of the first call stack valid for EiffelStudio.
		require
			Stopped: safe_application_is_stopped
			Call_stack_non_empty: not application.current_call_stack_is_empty
		local
			m, i: INTEGER
			st: CALL_STACK_STONE
		do
			from
				m := application.number_of_stack_elements
				i := 1
			until
				Result /= Void or i > m
			loop
				create st.make (i)
				if st.is_valid then
					Result := st
				else
					i := i + 1
				end
			end
		ensure
			result_is_valid: Result /= Void implies Result.is_valid
		end

feature {EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_PART} -- Implementation

	system_info_cmd: EB_STANDARD_CMD
			-- Command that displays information about current system in the output tool.

	display_error_help_cmd: EB_ERROR_INFORMATION_CMD
			-- Command to pop up a dialog giving help on compilation errors.

feature -- Options

	display_agent_details: BOOLEAN
			-- Do we display extra agent information ?

feature {NONE} -- Implementation

	saved_minimized: BOOLEAN
			-- Was the editor in the debugging window minimized before the debug session started?

	objects_split_proportion: REAL
			-- Position of the splitter inside the object tool.

	bkpt_info_cmd: EB_STANDARD_CMD
			-- Command that can display info concerning the breakpoints in the system.

	set_critical_stack_depth_cmd: EB_STANDARD_CMD
			-- Command that changes the depth at which we warn the user against a stack overflow.

	exception_handler_cmd: EB_EXCEPTION_HANDLER_CMD

	assertion_checking_handler_cmd: EB_ASSERTION_CHECKING_HANDLER_CMD

	options_cmd: EB_DEBUG_OPTIONS_CMD

	force_debug_mode_cmd: EB_FORCE_DEBUG_MODE_CMD

	stop_cmd: EB_EXEC_STOP_CMD
			-- Command that can interrupt the execution.

	quit_cmd: EB_EXEC_QUIT_CMD
			-- Command that can kill the execution.

	step_cmd: EB_EXEC_STEP_CMD
			-- Step by step command.

	out_cmd: EB_EXEC_OUT_CMD
			-- Out of routine command.

	into_cmd: EB_EXEC_INTO_CMD
			-- Step into command.

	debug_cmd: EB_EXEC_DEBUG_CMD
			-- Run with stop points command.

	restart_cmd: EB_EXEC_RESTART_DEBUG_CMD
			-- Restart debugging without closing the interface.

	no_stop_cmd: EB_EXEC_NO_STOP_CMD
			-- Run without stop points command.

	init_commands is
			-- Create a new project toolbar.
		do
--| FIXME XR: TODO: Add:
--| 3) edit feature, feature evaluation
			create toolbarable_commands.make (20)

			create clear_bkpt
			clear_bkpt.enable_sensitive
			toolbarable_commands.extend (clear_bkpt)

			create enable_bkpt
			enable_bkpt.enable_sensitive
			toolbarable_commands.extend (enable_bkpt)

			create disable_bkpt
			disable_bkpt.enable_sensitive
			toolbarable_commands.extend (disable_bkpt)

			create bkpt_info_cmd.make
			bkpt_info_cmd.set_pixmap (pixmaps.icon_pixmaps.tool_breakpoints_icon)
			bkpt_info_cmd.set_pixel_buffer (pixmaps.icon_pixmaps.tool_breakpoints_icon_buffer)
			bkpt_info_cmd.set_tooltip (Interface_names.e_Bkpt_info)
			bkpt_info_cmd.set_menu_name (Interface_names.m_Bkpt_info)
			bkpt_info_cmd.set_tooltext (Interface_names.b_Bkpt_info)
			bkpt_info_cmd.set_name ("Bkpt_info")
			bkpt_info_cmd.add_agent (agent toggle_display_breakpoints)
			bkpt_info_cmd.enable_sensitive
			toolbarable_commands.extend (bkpt_info_cmd)

			create system_info_cmd.make
			system_info_cmd.set_pixmap (pixmaps.icon_pixmaps.command_system_info_icon)
			system_info_cmd.set_pixel_buffer (pixmaps.icon_pixmaps.command_system_info_icon_buffer)
			system_info_cmd.set_tooltip (Interface_names.e_Display_system_info)
			system_info_cmd.set_menu_name (Interface_names.m_Display_system_info)
			system_info_cmd.set_name ("System_info")
			system_info_cmd.set_tooltext (Interface_names.b_System_info)
			system_info_cmd.add_agent (agent display_system_status)
			toolbarable_commands.extend (system_info_cmd)

			create set_critical_stack_depth_cmd.make
			set_critical_stack_depth_cmd.set_menu_name (Interface_names.m_Set_critical_stack_depth)
			set_critical_stack_depth_cmd.add_agent (agent change_critical_stack_depth)
			set_critical_stack_depth_cmd.enable_sensitive

			create display_error_help_cmd.make
			toolbarable_commands.extend (display_error_help_cmd)

			create exception_handler_cmd.make
			exception_handler_cmd.enable_sensitive
			toolbarable_commands.extend (exception_handler_cmd)

			create assertion_checking_handler_cmd.make
			assertion_checking_handler_cmd.enable_sensitive
			toolbarable_commands.extend (assertion_checking_handler_cmd)
			create force_debug_mode_cmd.make (Current)
			force_debug_mode_cmd.enable_sensitive
			toolbarable_commands.extend (force_debug_mode_cmd)

			create options_cmd.make (Current)
			toolbarable_commands.extend (options_cmd)
			create step_cmd.make (Current)
			toolbarable_commands.extend (step_cmd)
			create into_cmd.make (Current)
			toolbarable_commands.extend (into_cmd)
			create out_cmd.make (Current)
			toolbarable_commands.extend (out_cmd)
			create debug_cmd.make (Current)
			toolbarable_commands.extend (debug_cmd)
			create no_stop_cmd.make (Current)
			toolbarable_commands.extend (no_stop_cmd)
			create stop_cmd.make (Current)
			toolbarable_commands.extend (stop_cmd)
			create restart_cmd.make (Current)
			toolbarable_commands.extend (restart_cmd)
			create quit_cmd.make (Current)
			toolbarable_commands.extend (quit_cmd)

			step_cmd.enable_sensitive
			into_cmd.enable_sensitive
			out_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			no_stop_cmd.enable_sensitive
			stop_cmd.disable_sensitive
			quit_cmd.disable_sensitive
			restart_cmd.disable_sensitive

			toolbarable_commands.extend (system_cmd)
			toolbarable_commands.extend (Melt_project_cmd)
			toolbarable_commands.extend (Freeze_project_cmd)
			toolbarable_commands.extend (Finalize_project_cmd)
			run_finalized_cmd.enable_sensitive
			toolbarable_commands.extend (run_finalized_cmd)
			toolbarable_commands.extend (override_scan_cmd)
			toolbarable_commands.extend (discover_melt_cmd)

				-- Disable commands if no project is loaded
			if not Eiffel_project.manager.is_project_loaded then
				if Eiffel_project.manager.is_created then
					enable_commands_on_project_created
				else
					disable_commands_on_project_unloaded
				end
			else
				enable_commands_on_project_loaded
			end

				-- Enable/Disable commands on project loading/unloading.
			Eiffel_project.manager.create_agents.extend (agent enable_commands_on_project_created)
			Eiffel_project.manager.load_agents.extend (agent enable_commands_on_project_loaded)
			Eiffel_project.manager.close_agents.extend (agent disable_commands_on_project_unloaded)
		end

	enable_commands_on_project_created is
			-- Enable commands when a new project has been created (not yet compiled)
		do
			display_error_help_cmd.enable_sensitive
		end

	enable_commands_on_project_loaded is
			-- Enable commands when a new project has been created and compiled
		do
			display_error_help_cmd.enable_sensitive
			enable_debugging_commands
		end

	enable_debugging_commands is
		do
			if is_msil_dll_system then
				disable_debugging_commands (True)
			else
				debug_cmd.enable_sensitive
				no_stop_cmd.enable_sensitive

				clear_bkpt.enable_sensitive
				enable_bkpt.enable_sensitive
				disable_bkpt.enable_sensitive
				bkpt_info_cmd.enable_sensitive
				assertion_checking_handler_cmd.disable_sensitive

				options_cmd.enable_sensitive
				step_cmd.enable_sensitive
				into_cmd.enable_sensitive
				out_cmd.disable_sensitive
			end
		end

	disable_commands_on_project_unloaded is
			-- Disable commands when a project has been closed.
		do
			clear_bkpt.disable_sensitive
			enable_bkpt.disable_sensitive
			disable_bkpt.disable_sensitive
			bkpt_info_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			no_stop_cmd.disable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			out_cmd.disable_sensitive

			display_error_help_cmd.disable_sensitive
			assertion_checking_handler_cmd.disable_sensitive

			options_cmd.disable_sensitive
		end

	disable_debugging_commands (full: BOOLEAN) is
			-- Disable commands related to debugging.
			-- If `full' disable also commands for manipulating breakpoints.
		do
			if full then
				clear_bkpt.disable_sensitive
				enable_bkpt.disable_sensitive
				disable_bkpt.disable_sensitive
				bkpt_info_cmd.disable_sensitive
			end

			debug_cmd.disable_sensitive
			no_stop_cmd.disable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			out_cmd.disable_sensitive
			assertion_checking_handler_cmd.disable_sensitive
		end

	force_raise is
			-- Debug feature.
		do
			if not raised then
					-- Update `Current'.
				if debugging_window = Void then
					debugging_window := last_focused_development_window (False)
				end
				raise
			end
		end

	force_unraise is
			-- Debug feature.
		do
			if raised then
				unraise
			end
		end

	change_critical_stack_depth is
			-- Display a dialog that lets the user change the critical stack depth.
		require
			not_running: not application_is_executing or else application_is_stopped
		local
			rb2: EV_RADIO_BUTTON
			l: EV_LABEL
			okb, cancelb: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
				-- Create widgets.
			create dialog
			create show_all_radio.make_with_text (Interface_names.l_Do_not_detect_stack_overflows)
			create rb2.make_with_text (Interface_names.l_Display_call_stack_warning)
			create l.make_with_text (Interface_names.l_Elements)
			create element_nb.make_with_value_range (1 |..| 30000)
			create okb.make_with_text (Interface_names.b_Ok)
			create cancelb.make_with_text (Interface_names.b_Cancel)

				-- Organize widgets.
			create vb
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.extend (show_all_radio)
			vb.extend (rb2)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (element_nb)
			hb.disable_item_expand (element_nb)
			hb.extend (l)
			hb.disable_item_expand (l)
			hb.extend (create {EV_CELL})
			vb.extend (hb)

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			hb.extend (create {EV_CELL})
			vb.extend (hb)

			dialog.extend (vb)

				-- Set widget properties.
			dialog.set_title (Interface_names.t_Set_critical_stack_depth)
			dialog.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			dialog.disable_user_resize
			rb2.enable_select
			Layout_constants.set_default_width_for_button (okb)
			Layout_constants.set_default_width_for_button (cancelb)
			if preferences.debugger_data.critical_stack_depth > 30000 then
				element_nb.set_value (30000)
			elseif preferences.debugger_data.critical_stack_depth = -1 then
				element_nb.set_value (1000)
				show_all_radio.enable_select
				element_nb.disable_sensitive
			else
				element_nb.set_value (preferences.debugger_data.critical_stack_depth)
			end
			element_nb.set_minimum_width (100)

				-- Set up actions.
			cancelb.select_actions.extend (agent close_dialog)
			okb.select_actions.extend (agent accept_dialog)
			show_all_radio.select_actions.extend (agent element_nb.disable_sensitive)
			rb2.select_actions.extend (agent element_nb.enable_sensitive)
			dialog.set_default_push_button (okb)
			dialog.set_default_cancel_button (cancelb)
			if element_nb.is_sensitive then
				dialog.show_actions.extend (agent element_nb.set_focus)
			end

			dialog.show_modal_to_window (last_focused_development_window (True).window)
		end

	element_nb: EV_SPIN_BUTTON
			-- Spin button that indicates the critical call stack depth.

	dialog: EV_DIALOG
			-- Dialog that lets the user choose the critical call stack depth.

	show_all_radio: EV_RADIO_BUTTON
			-- Radio button that indicates that stack overflows shouldn't be detected.

	close_dialog is
			-- Close `dialog' without doing anything.
		do
			dialog.destroy
			dialog := Void
			element_nb := Void
			show_all_radio := Void
		end

	accept_dialog is
			-- Close `dialog' and change the critical stack depth.
		local
			nb: INTEGER
		do
			if show_all_radio.is_selected then
				nb := -1
			else
				nb := element_nb.value
			end
			close_dialog
			preferences.debugger_data.critical_stack_depth_preference.set_value (nb)
			set_critical_stack_depth (nb)
		end

	initialize_debugging_window is
			-- Set `debugging_window' with window requesting a debug session.
		do
			if debugging_window = Void then
				debugging_window := last_focused_development_window (True)
			end
		ensure
			debugging_window_set: debugging_window /= Void
		end

	restore_standard_debug_docking_layout_by_code is
			-- Restore standard debug docking layout.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_tools: EB_DEVELOPMENT_WINDOW_TOOLS
		do
			l_tools := debugging_window.tools
			if
				l_tools.features_relation_tool.content.is_visible
				and l_tools.features_tool.content.state_value /= {SD_ENUMERATION}.auto_hide
			then
				-- But it is possible that is auto hide state.
				objects_tool.content.set_relative (debugging_window.tools.features_relation_tool.content, {SD_ENUMERATION}.bottom)
			else
				objects_tool.content.set_top ({SD_ENUMERATION}.bottom)
			end

			from
				watch_tool_list.start
			until
				watch_tool_list.after
			loop
				watch_tool_list.item.content.set_tab_with (objects_tool.content, False)
				watch_tool_list.forth
			end
			if objects_tool.content.is_visible then
				objects_tool.content.set_focus
			end

			if
				l_tools.features_tool.content.is_visible
				and l_tools.features_tool.content.state_value /= {SD_ENUMERATION}.auto_hide
			then
				call_stack_tool.content.set_relative (l_tools.features_tool.content, {SD_ENUMERATION}.bottom)
			elseif
				l_tools.cluster_tool.content.is_visible
				and l_tools.cluster_tool.content.state_value /= {SD_ENUMERATION}.auto_hide
			then
				call_stack_tool.content.set_relative (l_tools.cluster_tool.content, {SD_ENUMERATION}.bottom)
			else
				call_stack_tool.content.set_top ({SD_ENUMERATION}.left)
			end

				--| Minimize all editors
			from
				l_contents := debugging_window.docking_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				if l_contents.item.type = {SD_ENUMERATION}.editor then
					l_contents.item.minimize
				end
				l_contents.forth
			end
		end

	refresh_breakpoints_tool is
			-- Refresh breakpoint tool if needed.
		local
			l_tool: ES_BREAKPOINTS_TOOL
		do
			l_tool := debugging_window.tools.breakpoints_tool
			if l_tool.content.is_visible then
				l_tool.refresh
			end
		end

feature {NONE} -- MSIL system implementation

	is_msil_dll_system: BOOLEAN is
			-- Is a MSIL DLL system ?
		do
			Result := Eiffel_project.initialized
					and then Eiffel_project.system_defined
					and then Eiffel_system.System.il_generation
					and then equal (Eiffel_system.System.msil_generation_type, dll_type)
		end

	dll_type: STRING is "dll"
			-- DLL type constant for MSIL system

feature {NONE} -- specific implementation

	implementation: EB_DEBUGGER_MANAGER_IMP;

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

end -- class EB_DEBUGGER_MANAGER
