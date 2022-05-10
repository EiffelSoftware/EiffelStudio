note
	description: "Shared object that manages all debugging actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_MANAGER

inherit
	ES_DEBUGGER_MANAGER
		redefine
			make,
			initialize,
			controller,
			confirm_ignore_all_breakpoints_preference_string,
			change_current_thread_id,
			activate_execution_replay_recording,
			disable_assertion_checking, restore_assertion_checking,
			set_execution_ignoring_breakpoints,
			on_application_before_launching,
			on_application_launched,
			on_application_before_resuming,
			on_application_resumed,
			on_application_just_stopped,
			on_debugging_terminated,
			on_breakpoints_change_event,
			process_breakpoint,
			set_maximum_stack_depth,
			debugger_output_message, debugger_warning_message, debugger_error_message, debugger_status_message,
			display_application_status, display_system_info, display_debugger_info,
			set_error_message,
			display_ignore_contract_violation_dialog,
			enable_ignore_contract_violation_if_possible,
			auto_import_debugger_profiles_enabled, auto_export_debugger_profiles_enabled
		select
			preferences
		end

	EB_SHARED_PREFERENCES
		rename
			preferences as eb_preferences
		end

	EB_CONSTANTS

	EB_SHARED_INTERFACE_TOOLS

	EB_SHARED_GRAPHICAL_COMMANDS

	EB_ERROR_MANAGER
		rename
			set_error_message as eb_set_error_message
		end

	EV_SHARED_APPLICATION

	EB_WINDOW_MANAGER_OBSERVER
		rename
			on_item_removed as on_window_removed
		redefine
			on_window_removed
		end

	ES_SHARED_DEBUGGER_OUTPUTS
		rename
			output_manager as output_manager_service
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			Precursor
			create_events_handler

				--| When compiling in batch mode with the graphical "ec"
			create debug_run_cmd.make

				--| Graphical Preferences settings
			objects_split_proportion := debug_tool_data.local_vs_object_proportion

			display_agent_details := debug_tool_data.display_agent_details
			debug_tool_data.display_agent_details_preference.typed_change_actions.extend (
					agent (b: BOOLEAN)
						do
							display_agent_details := b
						end
				)

				--| End of settings
			init_commands

			create {DEBUGGER_TEXT_FORMATTER_OUTPUT} text_formatter_visitor.make

			window_manager.add_observer (Current)
		end

	initialize
		local
			pbool: BOOLEAN_PREFERENCE
			prefs: EB_DEBUGGER_DATA
		do
			Precursor
			prefs := debugger_data
			if prefs /= Void then
				pbool := prefs.debug_output_evaluation_enabled_preference
			end
			dump_value_factory.set_debug_output_evaluation_enabled (pbool.value)
			pbool.typed_change_actions.extend (agent dump_value_factory.set_debug_output_evaluation_enabled)
		end

	init_commands
			-- Create a new project toolbar.
		local
			l_cmd: EB_STANDARD_CMD
		do
			create show_tool_commands.make (6)

				-- Show call stack command.
			l_cmd := new_std_cmd (  Interface_names.t_call_stack_tool,
									Pixmaps.icon_pixmaps.tool_call_stack_icon,
									misc_shortcut_data.shortcuts.item ("show_call_stack_tool"), False,
									agent show_call_stack_tool
								)
			show_tool_commands.extend (l_cmd)
			show_call_stack_tool_command := l_cmd

				-- Show objects tool command.
			l_cmd := new_std_cmd (  Interface_names.t_object_tool,
									Pixmaps.icon_pixmaps.tool_objects_icon,
									misc_shortcut_data.shortcuts.item ("show_objects_tool"), False,
									agent show_objects_tool
								)
			show_tool_commands.extend (l_cmd)
			show_objects_tool_command := l_cmd

				-- Show thread tool command.
			l_cmd := new_std_cmd (  Interface_names.t_threads_tool,
									Pixmaps.icon_pixmaps.tool_threads_icon,
									misc_shortcut_data.shortcuts.item ("show_threads_tool"), False,
									agent show_thread_tool
								)
			show_tool_commands.extend (l_cmd)
			show_thread_tool_command := l_cmd

				-- Show object viewer tool command.
			l_cmd := new_std_cmd (  Interface_names.t_Object_viewer_tool,
									Pixmaps.icon_pixmaps.debugger_object_expand_icon,
									misc_shortcut_data.shortcuts.item ("show_object_viewer_tool"), False,
									agent show_object_viewer_tool
								)
			show_tool_commands.extend (l_cmd)
			show_object_viewer_tool_command := l_cmd

				-- Create and show watch tool command.
			l_cmd := new_std_cmd (  Interface_names.f_create_new_watch,
									Pixmaps.icon_pixmaps.tool_watch_icon,
									show_watch_tool_preference, False, --| Only make use of shortcut displayed string.									
									agent create_and_show_new_watch_tool
								)
			show_tool_commands.extend (l_cmd)
			create_and_show_watch_tool_command := l_cmd

				-- Show watch tool command.
			l_cmd := new_std_cmd (  Interface_names.t_watch_tool,
									Pixmaps.icon_pixmaps.tool_watch_icon,
									show_watch_tool_preference, False,
									agent show_new_or_hidden_watch_tool
								)
			show_tool_commands.extend (l_cmd)
			show_watch_tool_command := l_cmd

--| FIXME XR: TODO: Add:
--| 3) edit feature, feature evaluation
			create toolbarable_commands.make (35)

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

			create set_critical_stack_depth_cmd.make
			set_critical_stack_depth_cmd.set_menu_name (Interface_names.m_Set_critical_stack_depth)
			set_critical_stack_depth_cmd.add_agent (agent change_critical_stack_depth)
			set_critical_stack_depth_cmd.enable_sensitive

			create exception_handler_cmd.make
			exception_handler_cmd.disable_sensitive
			toolbarable_commands.extend (exception_handler_cmd)

			create assertion_checking_handler_cmd.make
			assertion_checking_handler_cmd.disable_sensitive
			toolbarable_commands.extend (assertion_checking_handler_cmd)

			create force_debug_mode_cmd.make (Current)
			force_debug_mode_cmd.enable_sensitive
			toolbarable_commands.extend (force_debug_mode_cmd)

			create options_cmd.make
			toolbarable_commands.extend (options_cmd)
			create step_cmd.make
			toolbarable_commands.extend (step_cmd)
			create into_cmd.make
			toolbarable_commands.extend (into_cmd)
			create out_cmd.make
			toolbarable_commands.extend (out_cmd)
			create debug_cmd.make
			toolbarable_commands.extend (debug_cmd)
			create exec_workbench_cmd.make
			toolbarable_commands.extend (exec_workbench_cmd)
			create exec_finalized_cmd.make
			toolbarable_commands.extend (exec_finalized_cmd)
			create no_stop_cmd.make
			toolbarable_commands.extend (no_stop_cmd)
			create ignore_breakpoints_cmd.make
			toolbarable_commands.extend (ignore_breakpoints_cmd)
			create stop_cmd.make
			toolbarable_commands.extend (stop_cmd)
			create restart_cmd.make
			toolbarable_commands.extend (restart_cmd)
			create quit_cmd.make
			toolbarable_commands.extend (quit_cmd)
			create attach_cmd.make
			toolbarable_commands.extend (attach_cmd)
			create detach_cmd.make
			toolbarable_commands.extend (detach_cmd)

			create toggle_exec_replay_recording_mode_cmd.make
			toolbarable_commands.extend (toggle_exec_replay_recording_mode_cmd)

			create toggle_exec_replay_mode_cmd.make
			toolbarable_commands.extend (toggle_exec_replay_mode_cmd)
			create exec_replay_back_cmd.make_back
			toolbarable_commands.extend (exec_replay_back_cmd)
			create exec_replay_forth_cmd.make_forth
			toolbarable_commands.extend (exec_replay_forth_cmd)
			create exec_replay_left_cmd.make_left
			toolbarable_commands.extend (exec_replay_left_cmd)
			create exec_replay_right_cmd.make_right
			toolbarable_commands.extend (exec_replay_right_cmd)

			create ignore_contract_violation.make
			toolbarable_commands.extend (ignore_contract_violation)

			toggle_exec_replay_mode_cmd.disable_sensitive
			exec_replay_back_cmd.disable_sensitive
			exec_replay_forth_cmd.disable_sensitive
			exec_replay_left_cmd.disable_sensitive
			exec_replay_right_cmd.disable_sensitive

			step_cmd.enable_sensitive
			into_cmd.enable_sensitive
			out_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			exec_workbench_cmd.enable_sensitive
			exec_finalized_cmd.enable_sensitive
			no_stop_cmd.enable_sensitive
			stop_cmd.disable_sensitive
			quit_cmd.disable_sensitive
			attach_cmd.enable_sensitive
			detach_cmd.disable_sensitive
			restart_cmd.disable_sensitive
			ignore_breakpoints_cmd.disable_sensitive

			toolbarable_commands.extend (system_cmd)
			toolbarable_commands.extend (system_information_cmd)
			if show_cloud_account_cmd.is_supported then
				toolbarable_commands.extend (show_cloud_account_cmd)
			end
			if Source_control_cmd.is_supported then
				toolbarable_commands.extend (Source_control_cmd)
			end
			toolbarable_commands.extend (Melt_project_cmd)
			toolbarable_commands.extend (Freeze_project_cmd)
			toolbarable_commands.extend (Finalize_project_cmd)
			toolbarable_commands.extend (override_scan_cmd)
			toolbarable_commands.extend (discover_melt_cmd)
			toolbarable_commands.extend (clean_compile_project_cmd)

			toolbarable_commands.extend (analyze_cmd)
			toolbarable_commands.extend (analyze_editor_cmd)
			toolbarable_commands.extend (analyze_parent_cmd)
			toolbarable_commands.extend (analyze_target_cmd)
			toolbarable_commands.extend (analyzer_preferences_cmd)

				-- command not included in toolbars
				-- however let's initialize them for safety
			create object_viewer_cmd.make
			object_viewer_cmd.disable_sensitive
			create object_storage_management_cmd.make
			object_storage_management_cmd.disable_sensitive

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

feature -- Properties

	controller: EB_DEBUGGER_CONTROLLER

feature -- Settings

	dialog_data: EB_DIALOGS_DATA
		do
			Result := eb_preferences.dialog_data
		end

	misc_shortcut_data: EB_MISC_SHORTCUT_DATA
		do
			Result := eb_preferences.misc_shortcut_data
		end

	debug_tool_data: EB_DEBUG_TOOL_DATA
		do
			Result := eb_preferences.debug_tool_data
		end

	confirm_ignore_all_breakpoints_preference_string: STRING
			-- <Precursor>
		local
			prefs: EB_DIALOGS_DATA
		do
			prefs := dialog_data
			if prefs /= Void then
				Result := prefs.confirm_ignore_all_breakpoints_string
			end
		end

	refresh_breakpoints_tool
			-- Refresh breakpoint tool if needed.
		do
			if debugging_window /= Void then
				if attached {ES_BREAKPOINTS_TOOL} debugging_window.shell_tools.tool ({ES_BREAKPOINTS_TOOL}) as l_tool then
					if l_tool.is_shown then
						l_tool.refresh
					end
				end
			end
		end

	auto_export_debugger_profiles_enabled: BOOLEAN
			-- Auto export debugger profiles if needed?
		do
			Result := debug_tool_data.auto_export_debugger_profiles_enabled
		end

	auto_import_debugger_profiles_enabled: BOOLEAN
			-- Auto import debugger profiles?
		do
			Result := debug_tool_data.auto_import_debugger_profiles_enabled
		end

feature -- Access

	clear_bkpt: EB_CLEAR_STOP_POINTS_COMMAND
			-- Command that can remove one or more breakpoints from the system.

	enable_bkpt: EB_DEBUG_STOPIN_HOLE_COMMAND
			-- Command that can enable one or more breakpoints in the system.

	disable_bkpt: EB_DISABLE_STOP_POINTS_COMMAND
			-- Command that can disable one or more breakpoints in the system.

	debug_run_cmd: EB_DEBUG_RUN_CMD
			-- Command to run the project under debugger.

	no_stop_cmd: EB_EXEC_NO_STOP_CMD
			-- Run without stop points command.

	ignore_breakpoints_cmd: EB_DBG_IGNORE_BREAKPOINTS_CMD
			-- Ignore breakpoint toggle command

	exception_handler_cmd: EB_EXCEPTION_HANDLER_CMD
			-- Exception handler command

	toggle_exec_replay_recording_mode_cmd: EB_DEBUG_TOGGLE_EXECUTION_REPLAY_RECORDING_MODE_CMD

	toggle_exec_replay_mode_cmd: EB_DEBUG_TOGGLE_EXECUTION_REPLAY_MODE_CMD

	exec_replay_back_cmd: EB_EXEC_DEBUG_REPLAY_CMD
			-- Command that can exec replay back the execution

	exec_replay_forth_cmd: EB_EXEC_DEBUG_REPLAY_CMD
			-- Command that can exec replay forth the execution

	exec_replay_left_cmd: EB_EXEC_DEBUG_REPLAY_CMD
			-- Command that can exec replay left the execution

	exec_replay_right_cmd: EB_EXEC_DEBUG_REPLAY_CMD
			-- Command that can exec replay right the execution			

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_AND_MENUABLE_COMMAND]
			-- All commands that can be put in a toolbar.

	show_tool_commands: ARRAYED_LIST [EB_STANDARD_CMD]
			-- Show tool commands.

	show_call_stack_tool_command: EB_STANDARD_CMD
			-- Show call stack command

	show_objects_tool_command: EB_STANDARD_CMD
			-- Show object tool command

	show_thread_tool_command: EB_STANDARD_CMD
			-- Show thread tool command

	show_object_viewer_tool_command: EB_STANDARD_CMD
			-- Show object viewer tool command			

	show_watch_tool_command: EB_STANDARD_CMD
			-- Show watch tool command

	create_and_show_watch_tool_command: EB_STANDARD_CMD
			-- Create and show watch tool.

	force_debug_mode_cmd: EB_FORCE_EXECUTION_MODE_CMD
			-- Force debug mode command.

feature {ES_OBJECTS_GRID_MANAGER, EB_CONTEXT_MENU_FACTORY, ES_DEBUGER_TOOLTIP_HANDLER} -- Command

	object_viewer_cmd: EB_OBJECT_VIEWER_COMMAND
			-- Command controlling the object viewer tools

	object_storage_management_cmd: ES_DBG_OBJECT_STORAGE_MANAGEMENT_COMMAND
			-- Command controlling the remove object storage operation

feature {EB_SHARED_DEBUGGER_MANAGER, EB_EXEC_FORMAT_CMD, EB_DOCKING_LAYOUT_MANAGER, ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND} -- Command

	bkpt_info_cmd: EB_STANDARD_CMD
			-- Command that can display info concerning the breakpoints in the system.

	set_critical_stack_depth_cmd: EB_STANDARD_CMD
			-- Command that changes the depth at which we warn the user against a stack overflow.

	assertion_checking_handler_cmd: EB_ASSERTION_CHECKING_HANDLER_CMD
			-- Command to disable/restore assertion checking on the debuggee

	options_cmd: EB_EXECUTION_PARAMETERS_CMD
			-- Command to open the execution parameter dialog

	stop_cmd: EB_EXEC_STOP_CMD
			-- Command that can interrupt the execution.

	quit_cmd: EB_EXEC_QUIT_CMD
			-- Command that can kill the execution.

	attach_cmd: EB_EXEC_ATTACH_CMD
			-- Command that can attach the debugger to a debuggee.

	detach_cmd: EB_EXEC_DETACH_CMD
			-- Command that can detach the execution.

	step_cmd: EB_EXEC_STEP_CMD
			-- Step by step command.

	out_cmd: EB_EXEC_OUT_CMD
			-- Out of routine command.

	into_cmd: EB_EXEC_INTO_CMD
			-- Step into command.

	debug_cmd: EB_EXEC_DEBUG_CMD
			-- Run with stop points command.

	exec_workbench_cmd: EB_EXEC_WORKBENCH_CMD
			-- Run workbench outside environment.

	exec_finalized_cmd: EB_EXEC_FINALIZED_CMD
			-- Run finalized outside environment.			

	restart_cmd: EB_EXEC_RESTART_DEBUG_CMD
			-- Restart debugging without closing the interface.

	ignore_contract_violation: EB_IGNORE_CONTRACT_VIOLATION_CMD
			-- Ignore current contract violation command

feature -- tools

	call_stack_tool: detachable ES_CALL_STACK_TOOL
			-- A tool that represents the call stack in a graphical display.
		do
			if attached debugging_window as w then
				Result := {ES_CALL_STACK_TOOL} / w.shell_tools.tool ({ES_CALL_STACK_TOOL})
			end
		ensure
			result_attached: Result /= Void
		end

	threads_tool: detachable ES_THREADS_TOOL
			-- A tool that represents the threads list in a graphical display.
		do
			if attached debugging_window as w then
				Result := {ES_THREADS_TOOL} / w.shell_tools.tool ({ES_THREADS_TOOL})
			end
		ensure
			result_attached: Result /= Void
		end

	objects_tool: detachable ES_OBJECTS_TOOL
		do
			if attached debugging_window as w then
				Result := {ES_OBJECTS_TOOL} / w.shell_tools.tool ({ES_OBJECTS_TOOL})
			end
		ensure
			result_attached: debugging_window /= Void implies Result /= Void
		end

	object_viewer_tool: detachable ES_OBJECT_VIEWER_TOOL
		do
			if attached debugging_window as w then
				Result := {ES_OBJECT_VIEWER_TOOL} / w.shell_tools.tool ({ES_OBJECT_VIEWER_TOOL})
			end
		ensure
			result_attached: Result /= Void
		end

	object_viewer_tool_panel: detachable ES_OBJECT_VIEWER_TOOL_PANEL
		do
			if attached debugging_window as w then
				Result := {ES_OBJECT_VIEWER_TOOL_PANEL} / w.shell_tools.tool ({ES_OBJECT_VIEWER_TOOL}).panel
			end
		ensure
			result_attached: Result /= Void
		end

	watch_tool_list: LINKED_SET [ES_WATCH_TOOL]
			-- List of watched tools
		do
			if attached debugging_window as w then
				create Result.make
				w.shell_tools.tools ({ES_WATCH_TOOL}).do_all (agent (a_tool: ES_TOOL [EB_TOOL]; a_result: LINKED_SET [ES_WATCH_TOOL])
						do
							if attached {ES_WATCH_TOOL} a_tool as l_watch_tool then
								a_result.extend (l_watch_tool)
							end
						end (?, Result)
					)
			else
				create Result.make --| Empty is better than Void
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Output visitor

	text_formatter_visitor: DEBUGGER_TEXT_FORMATTER_VISITOR
			-- Text formatter visitor attached to Current

feature -- tools management

	refresh_objects_grids
			-- Refresh objects grids
			-- most likely due to display parameters changes
		do
			objects_tool.refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.refresh)
		end

	record_objects_grids_layout
			-- Record objects grids layout
		do
			objects_tool.record_grids_layout
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.record_grid_layout)
		end

	new_toolbar (a_recycler: EB_RECYCLABLE): ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- Toolbar containing all debugging commands.
		require
			a_recycler_not_void: a_recycler /= Void
		do
			Result := debug_tool_data.retrieve_project_toolbar (toolbarable_commands)
			from
				Result.start
			until
				Result.after
			loop
				if attached {EB_SD_COMMAND_TOOL_BAR_BUTTON} Result.item as l_button then
					a_recycler.auto_recycle (l_button)
				end
				Result.forth
			end
		end

	new_debug_menu (dev_window: detachable EB_DEVELOPMENT_WINDOW): EV_MENU
			-- Generate a menu that can be displayed in development windows.
		require
			dev_window_not_void: dev_window /= Void
			--| commands_initialized: toolbarable_commands /= Void
		local
			a_recycler: EB_RECYCLABLE
			sep: EV_MENU_SEPARATOR
			l_item: EB_COMMAND_MENU_ITEM
			m: EV_MENU
		do
			a_recycler := dev_window
			create Result.make_with_text (Interface_names.m_Debug)

			l_item := force_debug_mode_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				-- Separator.
			create sep
			Result.extend (sep)

				--| Execution parameters
			l_item := options_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				--| Exception handler
			l_item := exception_handler_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				--| Overflow prevention
			l_item := set_critical_stack_depth_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				-- Separator.
			create sep
			Result.extend (sep)

			l_item := assertion_checking_handler_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				-- Separator.
			create sep
			Result.extend (sep)

				--| Breakpoints management
			create m.make_with_text (interface_names.m_Bkpt_management)
			Result.extend (m)
			a_recycler.auto_recycle (m)

			l_item := bkpt_info_cmd.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := clear_bkpt.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := disable_bkpt.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := enable_bkpt.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			if dev_window /= Void then
					--| Breakpoint here menu items
				create m.make_with_text (interface_names.m_Bkpt_operations)
				Result.extend (m)

				l_item := dev_window.commands.edit_bp_here_command.new_menu_item
				m.extend (l_item)
				a_recycler.auto_recycle (l_item)


				l_item := dev_window.commands.enable_disable_bp_here_command.new_menu_item
				m.extend (l_item)
				a_recycler.auto_recycle (l_item)

				l_item := dev_window.commands.enable_remove_bp_here_command.new_menu_item
				m.extend (l_item)
				a_recycler.auto_recycle (l_item)
			end


				-- Separator.
			create sep
			Result.extend (sep)

			l_item := exec_workbench_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := exec_finalized_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				-- Separator.
			create sep
			Result.extend (sep)

			l_item := debug_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := no_stop_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := ignore_contract_violation.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := ignore_breakpoints_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				-- Separator.
			create sep
			Result.extend (sep)

			if dev_window /= Void then
				l_item := dev_window.commands.run_to_this_point_command.new_menu_item
				Result.extend (l_item)
				a_recycler.auto_recycle (l_item)
			end

			l_item := step_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := into_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := out_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				-- Separator.
			create sep
			Result.extend (sep)

			l_item := restart_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := stop_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := quit_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := attach_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := detach_cmd.new_menu_item
			Result.extend (l_item)
			a_recycler.auto_recycle (l_item)

				-- Separator.
			create sep
			Result.extend (sep)

			--| Execution Record/Replay

			create m.make_with_text (interface_names.m_execution_record_and_replay)
			Result.extend (m)

			l_item := toggle_exec_replay_recording_mode_cmd.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := toggle_exec_replay_mode_cmd.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := exec_replay_back_cmd.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := exec_replay_forth_cmd.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := exec_replay_right_cmd.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

			l_item := exec_replay_left_cmd.new_menu_item
			m.extend (l_item)
			a_recycler.auto_recycle (l_item)

--| FIXME XR: TODO: Add:
--| 3) edit feature, feature evaluation
		end

	new_debugging_tools_menu: EV_MENU
			-- New debugging tools menu.
		do
			create Result.make_with_text (Interface_names.m_Tools)
		ensure
			Result /= Void
		end

	update_debugging_tools_menu_from (w: EB_DEVELOPMENT_WINDOW)
			-- Update the debugging_tools_menu related to `w'	
		require
			w /= Void
		local
			m: EV_MENU
			mi: EB_COMMAND_MENU_ITEM
			mn: STRING_GENERAL
			wt: ES_WATCH_TOOL
			l_show_cmd: ES_SHOW_TOOL_COMMAND
			l_wt_lst: like watch_tool_list
		do
			m := w.menus.debugging_tools_menu

				-- Recycle existing menu items.
			from
				m.start
			until
				m.after
			loop
				if attached {EB_RECYCLABLE} m.item as l_recyclable then
					l_recyclable.recycle
				end
				m.forth
			end
			m.wipe_out

				-- Breakpoint tool
			if debugging_window /= Void then
				l_show_cmd := debugging_window.commands.show_shell_tool_commands.item (debugging_window.shell_tools.tool ({ES_BREAKPOINTS_TOOL}))
				mi := l_show_cmd.new_menu_item
				m.extend (mi)
				w.auto_recycle (mi)
			end

				-- Callstack tool
			mi := show_call_stack_tool_command.new_menu_item
			m.extend (mi)
			if raised then
				mi.enable_sensitive
			else
				mi.disable_sensitive
			end
			w.auto_recycle (mi)

				-- Thread tool
			mi := show_thread_tool_command.new_menu_item
			m.extend (mi)
			if raised then
				mi.enable_sensitive
			else
				mi.disable_sensitive
			end
			w.auto_recycle (mi)

				-- Object tool
			mi := show_objects_tool_command.new_menu_item
			m.extend (mi)
			if raised then
				mi.enable_sensitive
			else
				mi.disable_sensitive
			end
			w.auto_recycle (mi)

				-- Object viewer
			mi := show_object_viewer_tool_command.new_menu_item
			m.extend (mi)
			if raised then
				mi.enable_sensitive
			else
				mi.disable_sensitive
			end
			w.auto_recycle (mi)

				-- Create Watch tool
			l_wt_lst := watch_tool_list
				-- Do not display shortcut if any watch tool exists.
			if not l_wt_lst.is_empty then
				create_and_show_watch_tool_command.set_referred_shortcut (Void)
			else
				create_and_show_watch_tool_command.set_referred_shortcut (show_watch_tool_preference)
			end
			mi := create_and_show_watch_tool_command.new_menu_item
			m.extend (mi)
			w.auto_recycle (mi)
			if raised then
				mi.enable_sensitive
			else
				mi.disable_sensitive
			end

				-- Watch tools
			if l_wt_lst /= Void and then not l_wt_lst.is_empty then
				m.extend (create {EV_MENU_SEPARATOR})
				from
					l_wt_lst.start
				until
					l_wt_lst.after
				loop
					wt := l_wt_lst.item
					if wt.is_tool_instantiated then
						mn := wt.edition_title.twin
						if show_watch_tool_command.shortcut_available then
							mn.append ("%T")
							mn.append (show_watch_tool_command.shortcut_string)
						end
						mi := show_watch_tool_command.new_menu_item
						mi.set_text (mn)
						mi.select_actions.wipe_out
						mi.select_actions.extend (agent wt.show (True))
						m.extend (mi)
						if raised then
							mi.enable_sensitive
						else
							mi.disable_sensitive
						end
						w.auto_recycle (mi)
					end

					l_wt_lst.forth
				end
			end
		end

	update_all_debugging_tools_menu
			-- Update all debugging_tools_menu in all development windows
		do
			if update_all_debugging_tools_menu_delayed_action = Void then
				create update_all_debugging_tools_menu_delayed_action.make (agent
						do
							if update_all_debugging_tools_menu_delayed_action /= Void then
								update_all_debugging_tools_menu_delayed_action.destroy
								update_all_debugging_tools_menu_delayed_action := Void
							end
							window_manager.for_all_development_windows (agent update_debugging_tools_menu_from)
						end
					, 100)
				update_all_debugging_tools_menu_delayed_action.request_call
			else
				update_all_debugging_tools_menu_delayed_action.request_call
			end
		end

	update_all_debugging_tools_menu_delayed_action: ES_DELAYED_ACTION
			-- Delayed action for effective `update_all_debugging_tools_menu'

	show_call_stack_tool
			-- Show call stack tool if any.
		do
			if call_stack_tool /= Void and raised then
				call_stack_tool.show (True)
			end
		end

	show_thread_tool
			-- Show thread tool if any.
		do
			if threads_tool /= Void and raised then
				threads_tool.show (True)
			end
		end

	show_objects_tool
			-- Show object tool if any.
		do
			if objects_tool /= Void and raised then
				objects_tool.show (True)
			end
		end

	show_object_viewer_tool
			-- Show object viewer tool if any.
		do
			if object_viewer_tool /= Void and raised then
				object_viewer_tool.show (True)
			end
		end

	show_new_or_hidden_watch_tool
			-- Show a hidden watch tool if any.
			-- If all shown, show next one.
		local
			l_wt_lst: like watch_tool_list
			l_watch_tool: ES_WATCH_TOOL
			l_focused_watch_index: INTEGER
		do
			if raised then
				l_wt_lst := watch_tool_list
				if l_wt_lst.is_empty then
					create_and_show_new_watch_tool
				else
					from
						l_wt_lst.start
					until
						l_wt_lst.after
					loop
						if l_wt_lst.item.has_focus then
							l_focused_watch_index := l_wt_lst.index
						end
						if l_watch_tool = Void and then not l_wt_lst.item.is_shown then
							l_watch_tool := l_wt_lst.item
						end
						l_wt_lst.forth
					end
					if l_watch_tool /= Void then
						l_watch_tool.show (True)
					else
						if l_focused_watch_index = l_wt_lst.count then
							l_focused_watch_index := 1
						else
							l_focused_watch_index := l_focused_watch_index + 1
						end
						l_wt_lst.i_th (l_focused_watch_index).show (True)
					end
				end
			end
		end

	create_and_show_new_watch_tool
			-- Create a new watch tool attached to current debugging window
		do
			if debugging_window /= Void then
				create_new_watch_tool_tabbed_with (debugging_window, Void)
				watch_tool_list.last.show (False)
			end
		end

	create_new_watch_tool_tabbed_with (a_window: EB_DEVELOPMENT_WINDOW; a_tool: detachable ES_TOOL [EB_TOOL])
			-- Create a new watch tool and set it tabbed with `a_tool'
			-- if `a_tool' is not Void
			-- Note: the new watch tool is not shown yet.
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		local
			l_watch_tool: ES_WATCH_TOOL
		do
			l_watch_tool := create_new_watch_tool (a_window)
			if a_tool /= Void then
				l_watch_tool.content.set_tab_with (a_tool.content, False)
			else
				l_watch_tool.show (False)
			end
		end

	create_new_watch_tool (a_window: EB_DEVELOPMENT_WINDOW): ES_WATCH_TOOL
			-- Create a new watch tool
		require
			a_window_attached: a_window /= Void
		local
			l_count: NATURAL_8
		do
			l_count := a_window.shell_tools.editions_of_tool ({ES_WATCH_TOOL}, False) + 1
			if attached {ES_WATCH_TOOL} a_window.shell_tools.tool_edition ({ES_WATCH_TOOL}, l_count) as l_watch_tool then
			 	Result := l_watch_tool
			 else
			 	check False end
			 end
		ensure
			not_void: Result /= Void
		end

feature -- Windows observer

	on_window_removed (a_item: EB_WINDOW)
			-- `a_item' has been removed.
		do
				-- We don't care the last window,
				-- nor non-`debugging_window'.
			if window_manager.development_windows_count > 0 and then a_item = debugging_window then
				check
					-- We should make sure that it is unraised.
					-- Then change an instance of `debugging_window'.
					unraised: not raised
				end
				recycle_items_from_window
				set_debugging_window (window_manager.last_focused_development_window)
				if debugging_window /= Void and then debug_mode_forced and not raised then
					force_execution_mode (True)
				end
			end
		end

feature -- Events helpers

	create_events_handler
			-- Create `events_handler'
		do
			set_events_handler (create {EB_DEBUGGER_EVENTS_HANDLER}.make (agent debugging_window))
		end

feature -- Status report

	debugging_window: EB_DEVELOPMENT_WINDOW
			-- Window in which the debugger was launched (via run...).

	raised: BOOLEAN
			-- Are the debugging tools currently raised?

	resynchronization_requested: BOOLEAN
			-- resynchronization requested

	debug_mode_forced: BOOLEAN
			-- Do we force debugger interface to stay raised ?

	is_exiting_eiffel_studio: BOOLEAN
			-- Is exiting Eiffel Studio now?

feature -- Output

	debugger_output_message (m: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_formatter: like debugger_formatter
		do
			l_formatter := debugger_formatter
			if attached debugger_output as l_output then
				l_output.lock
			end
			l_formatter.add_string (m)
			l_formatter.add_new_line
			if attached debugger_output as l_output then
				l_output.unlock
			end
		end

	debugger_warning_message (m: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if ev_application = Void then
				Precursor (m)
			else
				prompts.show_warning_prompt (m, Void, Void)
			end
		end

	debugger_error_message (m: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if ev_application = Void then
				Precursor (m)
			else
				prompts.show_error_prompt (m, Void, Void)
			end
		end

	debugger_status_message (m: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if m.index_of_code (('%N').natural_32_code, 1) = 0 then
				window_manager.display_message (m)
			end
		end

	display_system_info
			-- <Precursor>
		do
			if attached system_information_cmd as c and then c.executable then
				c.execute
			end
		end

	display_application_status
			-- <Precursor>
		local
			l_formatter: like debugger_formatter
			l_auto_scrolled_changed: BOOLEAN
		do
			if attached debugger_output as l_output then
				l_formatter := debugger_formatter
				l_output.activate (False)

				if attached {ES_OUTPUT_PANE_I} l_output as l_output_pane then
					if not l_output_pane.is_auto_scrolled then
						l_output_pane.is_auto_scrolled := True
						l_auto_scrolled_changed := True
					end
				end

					-- Build the text
				if application_is_executing then
					text_formatter_visitor.append_status (application_status, l_formatter)
				else
					l_formatter.add ("No debugger information because the system has not be launched.")
					l_formatter.add_new_line
				end

				if l_auto_scrolled_changed and then attached {ES_OUTPUT_PANE_I} l_output as l_output_pane then
					l_output_pane.is_auto_scrolled := True
				end
			else
				check False end
			end
		end

	display_debugger_info (param: detachable DEBUGGER_EXECUTION_RESOLVED_PROFILE)
			-- <Precursor>
		local
			l_formatter: like debugger_formatter
			l_auto_scrolled_changed: BOOLEAN
		do
			if attached debugger_output as l_output then
				l_formatter := debugger_formatter

				if attached {ES_OUTPUT_PANE_I} l_output as l_output_pane then
					if not l_output_pane.is_auto_scrolled then
						l_output_pane.is_auto_scrolled := True
						l_auto_scrolled_changed := True
					end
				end

				l_output.activate (False)
				l_output.lock
				text_formatter_visitor.append_debugger_information (Current, param, l_formatter)
				l_output.unlock

				if l_auto_scrolled_changed and then attached {ES_OUTPUT_PANE_I} l_output as l_output_pane then
					l_output_pane.is_auto_scrolled := False
				end
			else
				check False end
			end
		end

	display_system_status
			-- <Precursor>
		do
			if application_is_executing and then attached debugger_output as l_output then
				l_output.activate (True)
				if attached debugging_window as l_window then
					l_window.shell_tools.show_tool ({ES_OUTPUTS_TOOL}, False)
				end
			end
			display_system_info
			if application_is_executing then
				display_debugger_info (application.parameters)
			end
		end

feature -- Change

	set_error_message (s: STRING)
		do
			eb_set_error_message (s)
		end

	toggle_display_breakpoints
			-- Show breakpoints tool
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev := last_focused_development_window (False)
			if conv_dev /= Void then
				conv_dev.shell_tools.tool ({ES_BREAKPOINTS_TOOL}).show (True)
			end
		end

	display_breakpoints (show_tool_if_closed: BOOLEAN)
			-- Show the list of breakpoints (set and disabled) in the output manager.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev := last_focused_development_window (False)
			if conv_dev /= Void then
				if show_tool_if_closed then
					conv_dev.shell_tools.tool ({ES_BREAKPOINTS_TOOL}).show (False)
				end
			end
		end

	last_focused_development_window (create_if_void: BOOLEAN): EB_DEVELOPMENT_WINDOW
		do
			Result := window_manager.last_focused_development_window
			if Result = Void and create_if_void then
				Result := window_manager.a_development_window
			end
		end

	refresh_commands (a_window: EB_DEVELOPMENT_WINDOW)
			-- Refresh commands with their interfaces/shortcuts.
		require
			a_window_not_void: a_window /= Void
		local
			l_cmds: like show_tool_commands
			w: EB_VISION_WINDOW
		do
			w := a_window.window
			bkpt_info_cmd.update (w)
			set_critical_stack_depth_cmd.update (w)
			exception_handler_cmd.update (w)
			assertion_checking_handler_cmd.update (w)
			options_cmd.update (w)
			force_debug_mode_cmd.update (w)
			stop_cmd.update (w)
			quit_cmd.update (w)
			attach_cmd.update (w)
			detach_cmd.update (w)
			step_cmd.update (w)
			out_cmd.update (w)
			into_cmd.update (w)
			debug_cmd.update (w)
			exec_workbench_cmd.update (w)
			exec_finalized_cmd.update (w)
			restart_cmd.update (w)
			no_stop_cmd.update (w)
			ignore_breakpoints_cmd.update (w)
			ignore_contract_violation.update (w)
			toggle_exec_replay_recording_mode_cmd.update (w)

			from
				l_cmds := show_tool_commands
				l_cmds.start
			until
				l_cmds.after
			loop
				l_cmds.item.update (w)
				l_cmds.forth
			end

			update_debugging_tools_menu_from (a_window)
		end

feature -- Status setting

	force_execution_mode (a_save_tools_layout: BOOLEAN)
			-- Force debug mode
		do
			debug_mode_forced := True
			if not raised then
				raise_saving_layout (a_save_tools_layout)
			end
		end

	unforce_execution_mode
			-- unForce debug mode
		require
			debug_mode_forced
		do
			debug_mode_forced := False
			if raised
				and not application_launching_in_progress
				and not application_is_executing
			then
				unraise
			end
		end

	update_execution_replay
			-- Update execution replay commands and widgets
		local
			xr: BOOLEAN
			lev, m: INTEGER
		do
			if safe_application_is_stopped then
				xr := application_status.replay_activated
				if xr then
					exec_replay_left_cmd.enable_sensitive
					exec_replay_right_cmd.enable_sensitive

					objects_tool.request_update
					object_viewer_tool.request_update
					watch_tool_list.do_all (agent {ES_WATCH_TOOL}.request_update)

					if attached application_status.current_replayed_call as rep then
						lev := application_status.current_call_stack_depth - rep.depth + 1
						m := application_status.replay_level_limit
						--| FIXME: jfiat: improve this part to control left,right ...
						if 1 <= lev and lev <= m then
							if lev < m then
								exec_replay_back_cmd.enable_sensitive
							else
								exec_replay_back_cmd.disable_sensitive
							end
							if 1 < lev then
								exec_replay_forth_cmd.enable_sensitive
							else
								exec_replay_forth_cmd.disable_sensitive
							end
						else
							exec_replay_back_cmd.disable_sensitive
							exec_replay_forth_cmd.disable_sensitive
						end
						call_stack_tool.set_execution_replay_level (lev, m, rep)
					else
						check should_not_occurs: False end
					end
				else
					exec_replay_back_cmd.disable_sensitive
					exec_replay_forth_cmd.disable_sensitive
					exec_replay_left_cmd.disable_sensitive
					exec_replay_right_cmd.disable_sensitive

					application.set_current_execution_stack_number (0)
					call_stack_tool.set_execution_replay_level (0, 0, Void)
				end
			end
		end

	activate_execution_replay_mode (b: BOOLEAN)
			-- Activate or Deactivate execution replay mode
		require
			valid_exec_recording_context: b implies rt_extension_available and is_classic_project
		local
			levlim: INTEGER
			status_changed: BOOLEAN
		do
			if safe_application_is_stopped then
				if application_status.replay_activated /= b then
					status_changed := True
					application.activate_execution_replay_mode (b)
				end
				levlim := application.status.replay_level_limit
			else
				status_changed := True
			end
			if status_changed then
				toggle_exec_replay_mode_cmd.set_select (b)
				if b then
					disable_debugging_commands (False)
					toggle_exec_replay_recording_mode_cmd.disable_sensitive
					toggle_exec_replay_mode_cmd.enable_sensitive
				else
					enable_debugging_commands

					toggle_exec_replay_recording_mode_cmd.enable_sensitive
					toggle_exec_replay_mode_cmd.enable_sensitive
				end
				if call_stack_tool /= Void then
					call_stack_tool.activate_execution_replay_mode (b, levlim)
				end
				update_execution_replay
			end
		end

	set_debugging_window (a_window: EB_DEVELOPMENT_WINDOW)
			-- Associate `Current' with `a_window'.
		do
			if not raised then
				debugging_window := a_window
			end
		end

	set_maximum_stack_depth (nb: INTEGER)
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
					st.force_reload_current_call_stack
					ecs := st.current_call_stack
					if ecs = Void or else ecs.is_empty then
						--| Nothing to display, maybe debugger had an issue getting call stack ..
					else
						if pos > st.current_call_stack.count then
								-- We reloaded less elements than there were.
							pos := 1
						end
						call_stack_tool.reset
						call_stack_tool.request_update
						create cst.make (pos)
						if cst.is_valid then
							launch_stone (cst)
						end
					end
				end
			end
		end

	on_compile_start
			-- A new compilation has started. Kill any debugged application and gray out all run* commands.
		do
			if application_is_executing then
				application.kill
			end
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			exec_workbench_cmd.disable_sensitive
			exec_finalized_cmd.disable_sensitive
			step_cmd.disable_sensitive
			out_cmd.disable_sensitive
			into_cmd.disable_sensitive
			ignore_breakpoints_cmd.disable_sensitive

			assertion_checking_handler_cmd.disable_sensitive
		end

	on_compile_stop
			-- A compilation is over. Make all run* commands sensitive.
		do
			if is_msil_dll_system then
				disable_debugging_commands (True)
			else
				if not process_manager.is_freezing_running then
					step_cmd.enable_sensitive
					into_cmd.enable_sensitive
					exec_workbench_cmd.enable_sensitive
					exec_finalized_cmd.enable_sensitive
					no_stop_cmd.enable_sensitive
					debug_cmd.enable_sensitive
					attach_cmd.enable_sensitive
					ignore_breakpoints_cmd.enable_sensitive
					enable_debug
				end
			end
		end

	raise
			-- Make the debug tools appear in `debugging_window'.
			-- Save tools layout.
		do
			raise_saving_layout (True)
				--| process graphical events before trying to start the execution
				--| this way, the UI does not look frozen for too long.
			ev_application.process_graphical_events
		end

	raise_saving_layout (a_save: BOOLEAN)
			-- Make the debug tools appear in `debugging_window'.
			-- If `a_save' True, then save tools layout, otherwise not save.
		require
			not_already_raised: not raised
		local
			l_watch_tool: ES_WATCH_TOOL
			l_wt_lst: like watch_tool_list
			l_tool: ES_WATCH_TOOL
			nwt: INTEGER
			l_unlock: BOOLEAN
			l_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
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

			if a_save then
				debugging_window.docking_layout_manager.save_tools_docking_layout
			end

				-- Change the state of the debugging window.
			debugging_window.hide_tools

				--| Before any objects and watches tools
			object_viewer_cmd.enable_sensitive
			object_storage_management_cmd.disable_sensitive

				--| Grid Objects Tool
			objects_tool.update_cleaning_delay (debug_tool_data.delay_before_cleaning_objects_grid)
			objects_tool.request_update

				--| Watches tool
			l_wt_lst := watch_tool_list
				--| At least one watch tool
			nwt := debug_tool_data.number_of_watch_tools
			if l_wt_lst.count < nwt  then
				from
					l_tool := Void
					if not l_wt_lst.is_empty then
						l_watch_tool := l_wt_lst.last
						if l_watch_tool.is_visible then
							l_tool := l_watch_tool
						end
					end
				until
					watch_tool_list.count >= nwt --| Be sure to use `watch_tool_list' and not the cached list
				loop
					l_tool := create_new_watch_tool (debugging_window)
				end
					-- `watch_tool_list' has changed, so fetch a new cache
				l_wt_lst := watch_tool_list
			end

			l_wt_lst.do_all (agent (ewt: ES_WATCH_TOOL)
						do
							if ewt.is_tool_instantiated and then ewt.panel.is_initialized then
								ewt.prepare_for_debug
								ewt.request_update
							end
						end
					)

				--| Threads Tool
			threads_tool.request_update

				--| Call Stack Tool
			call_stack_tool.request_update

				-- Show Tools and final visual settings
			debugging_window.show_tools

			-- We have to set `raised' True before restoring layout, otherwise ES_BREAKPOINT_TOOL
			-- will be ignored in {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER}.retrieve_docking_content
			-- See bug#13935
			raised := True

			debugging_window.docking_layout_manager.restore_debug_docking_layout

				--| Set the Grid Objects tool split position to 200 which is the default size of the local tree.
			if objects_tool.is_interface_usable and then objects_tool.is_tool_instantiated then
				if objects_tool.split_exists then
					if 0 <= objects_split_proportion and objects_split_proportion <= 1 then
						objects_tool.set_split_proportion (objects_split_proportion)
					end
				end
			end

			if l_unlock then
				debugging_window.window.unlock_update
			end
			update_all_debugging_tools_menu
			unpopup_switching_mode
			force_debug_mode_cmd.enable_sensitive

			create l_builder.make (debugging_window)
			l_builder.update_exist_layouts_menu
		ensure
			raised
		end

	unraise
			-- Make the debug tools disappear from `a_window'.
		require
			debugger_raised: raised
			not_application_launching_in_progress: not application_launching_in_progress
			not_application_is_executing: not application_is_executing
		local
			l_unlock: BOOLEAN
		do
			force_debug_mode_cmd.disable_sensitive

				--| Switching popup
			popup_switching_mode

			if ev_application.locked_window = Void then
				l_unlock := True
				debugging_window.window.lock_update
			end
			save_specific_debugger_settings
			debugging_window.docking_layout_manager.save_debug_docking_layout
			debug_tool_data.number_of_watch_tools_preference.set_value (watch_tool_list.count)

				-- Free and recycle tools
			raised := False

			debugging_window.docking_layout_manager.restore_tools_docking_layout
			refresh_breakpoints_tool
			if l_unlock then
				debugging_window.window.unlock_update
			end

			update_all_debugging_tools_menu
			unpopup_switching_mode
			force_debug_mode_cmd.enable_sensitive

			ev_application.process_graphical_events
		ensure
			not raised
		end

	reset_tools
			-- Reset tools to free unused data
		do
			threads_tool.reset
			call_stack_tool.reset
			objects_tool.reset

			object_viewer_cmd.end_debug
			object_storage_management_cmd.end_debug
			if object_viewer_tool /= Void then
				object_viewer_tool.reset
			end
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.reset)
			if application /= Void then
				destroy_application
			end
		end

	set_stone (st: STONE)
			-- Propagate `st' to tools.
		local
			propagate_stone: BOOLEAN
		do
			if raised then
				if attached {CALL_STACK_STONE} st as cst then
					if application_is_executing then
						propagate_stone := application.current_execution_stack_number /= cst.level_number
						application.set_current_execution_stack_number (cst.level_number)
					end
				end
				if resynchronization_requested or propagate_stone then
					resynchronization_requested := False
					call_stack_tool.set_stone (st)
					objects_tool.set_stone (st)
					watch_tool_list.do_all (agent {ES_WATCH_TOOL}.set_stone (st))
				end
			end
		end

	change_current_thread_id (tid: like application_current_thread_id)
			-- Set Current thread id to `tid'
		local
			tid_changed: BOOLEAN
		do
			tid_changed := application_current_thread_id /= tid
			Precursor (tid)
			if tid_changed and raised then
				resynchronization_requested := True
				call_stack_tool.force_update
				threads_tool.force_update
			end
		end

	enable_exiting_eiffel_studio
			-- Set `is_exiting_eiffel_studio' with true.
		do
			is_exiting_eiffel_studio := True
			save_specific_debugger_settings
		end

feature {NONE} -- Raise/unraise notification

	popup_switching_mode
		local
			l_popup: ES_POPUP_TRANSITION_WINDOW
			l_message: STRING_32
			l_icon: EV_PIXEL_BUFFER
		do
			if debugging_window /= Void and then (attached debugging_window.window as l_window) then
				if raised then
					create l_message.make_from_string (interface_names.l_Switching_to_normal_mode.as_string_32)
					l_icon := pixmaps.icon_pixmaps.view_editor_icon_buffer
				else
					create l_message.make_from_string (interface_names.l_Switching_to_execution_mode.as_string_32)
					l_icon := pixmaps.icon_pixmaps.debugger_environment_force_execution_mode_icon_buffer
				end
				if l_window.is_displayed and then l_window.screen_x + l_window.width > 0 and l_window.screen_y + l_window.height > 0 then
						-- When window is off-screen, prevent the transition window from being shown.
					create l_popup.make_with_icon (l_message, l_icon)
					l_popup.show_relative_to_window (l_window)
					switching_mode_popup := l_popup
				end

			end
		end

	unpopup_switching_mode
		do
			if attached switching_mode_popup as pop then
				pop.hide
				switching_mode_popup := Void
			end
		end

	switching_mode_popup: ES_POPUP_TRANSITION_WINDOW
			-- Popup used when switching to or from debug mode.

feature -- Debugging events

	process_breakpoint (bp: BREAKPOINT): BOOLEAN
		do
			Result := Precursor (bp)
			if debugging_window /= Void then
				refresh_breakpoints_tool
			end
		end

	resume_application
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

	launch_stone (st: STONE)
			-- Set `st' in the debugging window as the new stone.
		do
			record_objects_grids_layout
			if debugging_window /= Void then
				if attached application_status as appstatus then
					if
						appstatus.replay_activated and then
						(attached {REPLAYED_CALL_STACK_STONE} st as rep)
					then
						appstatus.set_replayed_call ([rep.e_feature, rep.call_position.line])
					else
						appstatus.set_replayed_call (Void)
					end
				end
				if attached {ES_FEATURE_RELATION_TOOL} debugging_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) as feat_tool then
					feat_tool.set_mode ({ES_FEATURE_RELATION_TOOL_VIEW_MODES}.flat)
					feat_tool.show (False)
				end
				safe_launch_stone_on_tools (st)
			end
		end

	safe_launch_stone_on_tools (st: STONE)
		local
			retried: BOOLEAN
		do
			if not retried then
				if attached debugging_window as w then
					w.tools.launch_stone (st)
				end
			end
		rescue
			retried := True
			retry
		end

	on_application_before_launching
			-- Application is about to be launched.
		do
			Precursor
			assertion_checking_handler_cmd.reset
			disable_debugging_commands (False)
			breakpoints_manager.notify_breakpoints_changes
		end

	on_application_launched
			-- Application has just been launched.
		do
			update_all_debugging_tools_menu

			Precursor
			debug("debugger_trace_synchro")
				io.put_string (generator + ".on_application_launched %N")
			end

			if
				attached debugging_window as w and then
				attached {ES_FEATURE_RELATION_TOOL} w.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) as feat_tool
			then
				feat_tool.set_mode ({ES_FEATURE_RELATION_TOOL_VIEW_MODES}.flat)
				feat_tool.show (False)
			end

				-- Modify the debugging window display.
			stop_cmd.enable_sensitive
			quit_cmd.enable_sensitive
			attach_cmd.disable_sensitive
			detach_cmd.enable_sensitive
			restart_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			debug_cmd.set_launched (True)
			exec_workbench_cmd.enable_sensitive
			exec_finalized_cmd.enable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			set_critical_stack_depth_cmd.disable_sensitive

			toggle_exec_replay_recording_mode_cmd.disable_sensitive
			toggle_exec_replay_mode_cmd.disable_sensitive
			object_storage_management_cmd.disable_sensitive


			if dialog /= Void and then not dialog.is_destroyed then
				close_dialog
			end

				-- Update Watch tool
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.request_update)
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_launched : done%N")
			end
		end

	on_application_just_stopped
			-- Application was just stopped (by a breakpoint, ...).
		local
			st: CALL_STACK_STONE
		do
			Precursor
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_just_stopped : start%N")
			end
			stop_cmd.disable_sensitive
			no_stop_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			exec_workbench_cmd.enable_sensitive
			exec_finalized_cmd.enable_sensitive
			step_cmd.enable_sensitive
			out_cmd.enable_sensitive
			into_cmd.enable_sensitive
			set_critical_stack_depth_cmd.enable_sensitive
			assertion_checking_handler_cmd.enable_sensitive

 			if rt_extension_available then
				if is_classic_project then --| For now only classic
					toggle_exec_replay_recording_mode_cmd.enable_sensitive
					if application_status.replay_recording then
						toggle_exec_replay_mode_cmd.enable_sensitive
					end
				end
				object_storage_management_cmd.enable_sensitive
			end

			debug ("debugger_interface")
				io.put_string ("Application Stopped (dixit EB_DEBUGGER_MANAGER)%N")
			end

			objects_tool.disable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.disable_refresh)
			if not application.current_call_stack_is_empty then
				st := first_valid_call_stack_stone
				if st /= Void then
					launch_stone (st)
						--| After launch_stone, the call stack tool will show something,
					if call_stack_tool.is_visible then
							-- Show it, only if the tool is visible (in the UI)
						if eb_preferences.debug_tool_data.always_show_callstack_tool_when_stopping then
							call_stack_tool.show (False)
						end
					end
					if call_stack_tool.is_shown then
						debugging_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}).show (False)
					end
				end
			end
			object_viewer_cmd.refresh
			window_manager.quick_refresh_all_margins

				-- Fill in the threads tool.
			threads_tool.request_update
				-- Fill in the stack tool.
			call_stack_tool.request_update
				-- Fill in the objects tool.
			objects_tool.enable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.enable_refresh)

			objects_tool.request_update
			object_viewer_tool.request_update
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.request_update)

			debugging_window.window.raise

			if application_status.reason_is_overflow then
				on_overflow_detected
			end

			enable_ignore_contract_violation_if_possible

			debug ("debugger_interface")
				io.put_string ("Application Stopped End (dixit EB_DEBUGGER_MANAGER)%N")
			end
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_just_stopped : done%N")
			end
		end

	on_overflow_detected
			-- OVERFLOW detected
		do
			--| Fixme: we might try to prevent debugging tools to refresh before poping up this dialog...				
			ev_application.do_once_on_idle (agent
					local
						l_warning: ES_WARNING_PROMPT
					do
						create l_warning.make_standard_with_cancel (Warning_messages.w_Overflow_detected)
						l_warning.set_button_text (l_warning.dialog_buttons.ok_button, interface_names.b_ok)
						l_warning.set_button_text (l_warning.dialog_buttons.cancel_button, interface_names.b_ignore)
						l_warning.set_button_action (l_warning.dialog_buttons.cancel_button, agent resume_application)
						l_warning.show_on_active_window
					end
				)
		end

	on_application_before_resuming
		do
			Precursor
			toggle_exec_replay_mode_cmd.reset
			objects_tool.record_grids_layout
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.record_grid_layout)
		end

	on_application_resumed
			-- Application was resumed after a stop.
		do
			Precursor

			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_resumed%N")
			end

			stop_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			exec_workbench_cmd.disable_sensitive
			exec_finalized_cmd.disable_sensitive
			step_cmd.disable_sensitive
			out_cmd.disable_sensitive
			into_cmd.disable_sensitive
			set_critical_stack_depth_cmd.disable_sensitive
			assertion_checking_handler_cmd.disable_sensitive

			toggle_exec_replay_recording_mode_cmd.disable_sensitive
			toggle_exec_replay_mode_cmd.disable_sensitive
			object_storage_management_cmd.disable_sensitive
			ignore_contract_violation.disable_sensitive

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

	on_debugging_terminated (was_executing: BOOLEAN)
			-- Application just quit.
			-- This application means the debuggee.
		do
				-- Modify the debugging window display.
			window_manager.quick_refresh_all_margins
			disable_debugging_commands (False)

				--| Clean and reset debugging tools
			reset_tools
			assertion_checking_handler_cmd.reset
			if rt_extension_available and is_classic_project then
				activate_execution_replay_mode (False)
				toggle_exec_replay_mode_cmd.reset
				toggle_exec_replay_recording_mode_cmd.enable_sensitive
			else
				toggle_exec_replay_mode_cmd.disable_sensitive
				toggle_exec_replay_recording_mode_cmd.disable_sensitive
			end

			if was_executing then
					-- Make all debugging tools disappear.
				if debugging_window.destroyed then
					debugging_window := Void
					raised := False
					debug_mode_forced := False
					force_debug_mode_cmd.set_select (False)
				elseif is_exiting_eiffel_studio then
					debugging_window.docking_layout_manager.save_debug_docking_layout
					debugging_window := Void
				elseif not debug_mode_forced then
					unraise
					debugging_window := Void
				end
			end
			enable_debugging_commands
			update_all_debugging_tools_menu

				-- Make related buttons insensitive.
			stop_cmd.disable_sensitive
			quit_cmd.disable_sensitive
			attach_cmd.enable_sensitive
			detach_cmd.disable_sensitive
			restart_cmd.disable_sensitive
			debug_cmd.enable_sensitive
			debug_cmd.set_launched (False)
			exec_workbench_cmd.enable_sensitive
			exec_finalized_cmd.enable_sensitive
			no_stop_cmd.enable_sensitive

			step_cmd.enable_sensitive
			into_cmd.enable_sensitive
			out_cmd.disable_sensitive

			set_critical_stack_depth_cmd.enable_sensitive

			toggle_exec_replay_mode_cmd.disable_sensitive
			exec_replay_back_cmd.disable_sensitive
			exec_replay_forth_cmd.disable_sensitive
			exec_replay_left_cmd.disable_sensitive
			exec_replay_right_cmd.disable_sensitive
			object_storage_management_cmd.disable_sensitive


			Precursor (was_executing)
		end

	first_valid_call_stack_stone: CALL_STACK_STONE
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

feature {NONE} -- Breakpoints events

	on_breakpoints_change_event
		do
			Precursor
			display_breakpoints (False)
			window_manager.synchronize_all_about_breakpoints
		end

feature -- Application change

	set_execution_ignoring_breakpoints (b: like execution_ignoring_breakpoints)
			-- <Precursor>
		local
			was_ignoring_bp: BOOLEAN
		do
			was_ignoring_bp := execution_ignoring_breakpoints
			Precursor (b)
			if was_ignoring_bp /= execution_ignoring_breakpoints then
				ignore_breakpoints_cmd.set_select (execution_ignoring_breakpoints)
			end
		end

	activate_execution_replay_recording (b: BOOLEAN)
			-- Activate or Deactivate execution recording
		local
			was_enabled: BOOLEAN
			error_occurred: BOOLEAN
		do
			was_enabled := execution_replay_recording_enabled
			Precursor (b)
			error_occurred := b /= execution_replay_recording_enabled
			if error_occurred then
				debugger_warning_message ("Execution recording operation failed")
			end
			if
				was_enabled /= execution_replay_recording_enabled or
				error_occurred
			then
				toggle_exec_replay_recording_mode_cmd.set_select (execution_replay_recording_enabled)
			end

			if not b then
				activate_execution_replay_mode (False)
			end
			if
				execution_replay_recording_enabled and then
				safe_application_is_stopped and then
				application_status.replay_recording
			then
				toggle_exec_replay_mode_cmd.enable_sensitive
			else
				toggle_exec_replay_mode_cmd.disable_sensitive
			end
			if
				application_is_executing and then
				execution_replay_recording_enabled /= application_status.replay_recording and then
				not application_is_stopped
			then
				debugger_warning_message (interface_names.l_only_available_for_stopped_application)
			end
		end

	disable_assertion_checking
			-- Disable assertion checking
		do
			Precursor
			assertion_checking_handler_cmd.set_select (True)
		end

	restore_assertion_checking
			-- Enable assertion checking	
		do
			Precursor
			assertion_checking_handler_cmd.set_select (False)
		end

feature -- Options

	display_agent_details: BOOLEAN
			-- Do we display extra agent information ?

feature {NONE} -- Implementation

	save_specific_debugger_settings
			-- Save specific graphical debugger settings
		do
			if
				attached objects_tool as l_objects_tool and then
				l_objects_tool.is_interface_usable and then
				l_objects_tool.is_tool_instantiated and then
				l_objects_tool.panel.is_initialized
			then
				l_objects_tool.panel.save_grids_preferences
				if l_objects_tool.split_exists then
					objects_split_proportion := l_objects_tool.split_proportion
				end
			end
			debug_tool_data.local_vs_object_proportion_preference.set_value (objects_split_proportion.out)
		end

	new_std_cmd (a_menu_name: STRING_GENERAL; a_pixmap: EV_PIXMAP;
					a_shortcut_pref: SHORTCUT_PREFERENCE; a_use_acc: BOOLEAN;
					a_action: PROCEDURE): EB_STANDARD_CMD
		local
			l_cmd: EB_STANDARD_CMD
			l_acc: EV_ACCELERATOR
		do
			create l_cmd.make
			l_cmd.enable_sensitive
			l_cmd.set_menu_name (a_menu_name)
			l_cmd.set_pixmap (a_pixmap)
			l_cmd.add_agent (a_action)
			if a_shortcut_pref /= Void then
				l_cmd.set_referred_shortcut (a_shortcut_pref)
				if a_use_acc then
					create l_acc.make_with_key_combination (a_shortcut_pref.key, a_shortcut_pref.is_ctrl, a_shortcut_pref.is_alt, a_shortcut_pref.is_shift)
					l_acc.actions.extend (agent l_cmd.execute)
					l_cmd.set_accelerator (l_acc)
				end
			end
			Result := l_cmd
		end

	objects_split_proportion: REAL
			-- Position of the splitter inside the object tool.

	enable_commands_on_project_created
			-- Enable commands when a new project has been created (not yet compiled)
		do
		end

	enable_commands_on_project_loaded
			-- Enable commands when a new project has been created and compiled
		do
			rt_extension_available := eiffel_system.system.rt_extension_class /= Void and then
						Eiffel_system.system.rt_extension_class.is_compiled

			enable_debugging_commands
				-- Except those 2 commands, which are valid only during execution.
			object_storage_management_cmd.disable_sensitive
			assertion_checking_handler_cmd.disable_sensitive
		end

	enable_debugging_commands
		do
			if is_msil_dll_system then
				disable_debugging_commands (True)
			else
				clear_bkpt.enable_sensitive
				enable_bkpt.enable_sensitive
				disable_bkpt.enable_sensitive
				bkpt_info_cmd.enable_sensitive
				force_debug_mode_cmd.enable_sensitive
				ignore_breakpoints_cmd.enable_sensitive
				if rt_extension_available and is_classic_project then
					toggle_exec_replay_recording_mode_cmd.enable_sensitive
				end

				assertion_checking_handler_cmd.disable_sensitive
				object_storage_management_cmd.enable_sensitive

				options_cmd.enable_sensitive
				exception_handler_cmd.enable_sensitive

				debug_cmd.enable_sensitive
				attach_cmd.enable_sensitive
				exec_workbench_cmd.enable_sensitive
				exec_finalized_cmd.enable_sensitive

				no_stop_cmd.enable_sensitive
				step_cmd.enable_sensitive
				into_cmd.enable_sensitive
				out_cmd.enable_sensitive
			end
		end

	disable_commands_on_project_unloaded
			-- Disable commands when a project has been closed.
		do
			clear_bkpt.disable_sensitive
			enable_bkpt.disable_sensitive
			disable_bkpt.disable_sensitive
			bkpt_info_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			attach_cmd.disable_sensitive
			exec_workbench_cmd.disable_sensitive
			exec_finalized_cmd.disable_sensitive
			no_stop_cmd.disable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			out_cmd.disable_sensitive
			ignore_breakpoints_cmd.disable_sensitive

			assertion_checking_handler_cmd.disable_sensitive
			options_cmd.disable_sensitive
			exception_handler_cmd.disable_sensitive
		end

	disable_debugging_commands (full: BOOLEAN)
			-- Disable commands related to debugging.
			-- If `full' disable also commands for manipulating breakpoints.
		do
			if full then
				clear_bkpt.disable_sensitive
				enable_bkpt.disable_sensitive
				disable_bkpt.disable_sensitive
				bkpt_info_cmd.disable_sensitive
				force_debug_mode_cmd.disable_sensitive
			end
			toggle_exec_replay_recording_mode_cmd.disable_sensitive

			debug_cmd.disable_sensitive
			attach_cmd.disable_sensitive
			exec_workbench_cmd.disable_sensitive
			exec_finalized_cmd.disable_sensitive
			no_stop_cmd.disable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			out_cmd.disable_sensitive
			assertion_checking_handler_cmd.disable_sensitive
			toggle_exec_replay_mode_cmd.disable_sensitive
			object_storage_management_cmd.disable_sensitive
		end

	change_critical_stack_depth
			-- Display a dialog that lets the user change the critical stack depth.
		require
			not_running: not application_is_executing or else application_is_stopped
		local
			rb2: EV_RADIO_BUTTON
			l: EV_LABEL
			okb, cancelb: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb_top, vb: EV_VERTICAL_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
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
			create vb_top
			create vb
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.extend (show_all_radio)
			vb.disable_item_expand (show_all_radio)
			vb.extend (rb2)
			vb.disable_item_expand (rb2)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (element_nb)
			hb.disable_item_expand (element_nb)
			hb.extend (l)
			hb.disable_item_expand (l)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.disable_item_expand (hb)

				-- Separator with Ok/Cancel button
			vb_top.extend (vb)
			vb_top.extend (create {EV_CELL})
			create l_sep
			vb_top.extend (l_sep)
			vb_top.disable_item_expand (l_sep)

			create hb
			hb.set_border_width (layout_constants.default_border_size)
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			hb.extend (create {EV_CELL})
			vb_top.extend (hb)
			vb_top.disable_item_expand (hb)

			dialog.extend (vb_top)

				-- Set widget properties.
			dialog.set_title (Interface_names.t_Set_critical_stack_depth)
			dialog.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			rb2.enable_select
			Layout_constants.set_default_width_for_button (okb)
			Layout_constants.set_default_width_for_button (cancelb)
			if attached debugger_data as prefs then
				if prefs.critical_stack_depth > 30000 then
					element_nb.set_value (30000)
				elseif prefs.critical_stack_depth = -1 then
					element_nb.set_value (1000)
					show_all_radio.enable_select
					element_nb.disable_sensitive
				else
					element_nb.set_value (prefs.critical_stack_depth)
				end
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

	close_dialog
			-- Close `dialog' without doing anything.
		do
			dialog.destroy
			dialog := Void
			element_nb := Void
			show_all_radio := Void
		end

	accept_dialog
			-- Close `dialog' and change the critical stack depth.
		local
			nb: INTEGER
			prefs: EB_DEBUGGER_DATA
		do
			if show_all_radio.is_selected then
				nb := -1
			else
				nb := element_nb.value
			end
			close_dialog
			prefs := debugger_data
			if prefs /= Void then
				prefs.critical_stack_depth_preference.set_value (nb)
			end
			set_critical_stack_depth (nb)
		end

	initialize_debugging_window
			-- Set `debugging_window' with window requesting a debug session.
		do
			if debugging_window = Void then
				debugging_window := last_focused_development_window (True)
			end
		ensure
			debugging_window_set: debugging_window /= Void
		end

	show_watch_tool_preference: SHORTCUT_PREFERENCE
			-- Show watch tool preference
		do
			Result := misc_shortcut_data.shortcuts.item ("show_watch_tool")
		end

	display_ignore_contract_violation_dialog
		local
			l_confirm: ES_DISCARDABLE_WARNING_PROMPT
			l_buttons: ES_DIALOG_BUTTONS
		do
			create l_buttons
			create l_confirm.make (ignore_contract_violation.description, l_buttons.yes_no_cancel_buttons,
					l_buttons.yes_button, l_buttons.yes_button, l_buttons.yes_button,
					interface_names.l_Discard_ignore_contract_violation_dialog,
					create {ES_BOOLEAN_PREFERENCE_SETTING}.make (dialog_data.confirm_ignore_contract_violation_preference, True)
				)
			l_confirm.set_button_text (l_buttons.yes_button, interface_names.b_break)
			l_confirm.set_button_text (l_buttons.no_button, interface_names.b_continue)
			l_confirm.set_button_text (l_buttons.cancel_button, interface_names.b_ignore)
			l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent
					do
						if attached application_status as l_status then
							l_status.set_break_on_assertion_violation_pending (True)
						end
					end
				)
			l_confirm.set_button_action (l_confirm.dialog_buttons.no_button, agent debug_run_cmd.execute)
			l_confirm.set_button_action (l_confirm.dialog_buttons.cancel_button, agent ignore_contract_violation.execute)
			l_confirm.show_on_active_window
		end

	enable_ignore_contract_violation_if_possible
			-- Enable/disable ignore contract violation command base on debuggee statues
		do
			if attached application_status as l_status and then l_status.exception_occurred then
				if is_dotnet_project then
					-- Have to update exception info with following two lines. Otherwise the value is void
					l_status.update_on_stopped_state
				end
				if l_status.assertion_violation_occurred	then
					ignore_contract_violation.enable_sensitive

					-- Display ignore contract violation dialog
					do_once_on_idle (agent display_ignore_contract_violation_dialog)
				else
					ignore_contract_violation.disable_sensitive
				end
			else
				ignore_contract_violation.disable_sensitive
			end
		end

feature {NONE} -- Memory management

	recycle_items_from_window
			-- Disconnect possible items and `debugging_window'.
		do
		end

feature {NONE} -- MSIL system implementation

	is_msil_dll_system: BOOLEAN
			-- Is a MSIL DLL system ?
		do
			Result := Eiffel_project.initialized
					and then Eiffel_project.system_defined
					and then Eiffel_system.System.il_generation
					and then attached Eiffel_system.System.msil_generation_type as l_type and then l_type.same_string (dll_type)
		end

	dll_type: STRING_32 = "dll";
			-- DLL type constant for MSIL system

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
