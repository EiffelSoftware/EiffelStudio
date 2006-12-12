indexing
	description	: "Command to run the system while debugging."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEBUG_RUN_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item,
			tooltext,
			is_tooltext_important
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	EB_SHARED_DEBUGGER_MANAGER

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		end

	EXEC_MODES
		export
			{NONE} all
		end

	SHARED_STATUS
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization	

	make is
			-- Initialize the command, create a couple of requests and windows.
			-- Add some actions as well.
		do
			is_sensitive := True
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.select_actions.put_front (agent execute_from (Result))
		end

	new_menu_item: EB_COMMAND_MENU_ITEM is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.select_actions.put_front (agent execute_from (Result))
		end

feature -- Execution

	execute is
			-- Launch program in debugger with mode `User_stop_points' (i.e "Run").
		do
			execute_with_mode (User_stop_points)
		end

	execute_with_mode (execution_mode: INTEGER) is
			-- Launch program in debugger with mode `execution_mode'.
		local
			wd: EV_WARNING_DIALOG
			l_dial: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			l_wb: WORKBENCH_I
		do
				--| At this point we define the 'type' on debug operation
				--| either step next, step into, step out, continue ...
				--| this will be used in APPLICATION_EXECUTION.continue_ignoring_kept_objects

			if debugger_manager.application_initialized then
				Debugger_manager.application.set_execution_mode (execution_mode)
			end

				--| Now let's check the application status
			if
				Eiffel_project.initialized and then
				not Eiffel_project.Workbench.is_compiling
			then
					--| Application is not yet launched |--
				if not debugger_manager.application_is_executing then
						-- ask to compile if we changed some classes inside eiffel studio
					l_wb := eiffel_project.workbench
					if l_wb.is_changed or window_manager.has_modified_windows then
						create l_dial.make_initialized (2, preferences.debug_tool_data.always_compile_before_debug_string, warning_messages.w_Compile_before_debug, interface_names.l_dont_ask_me_again, preferences.preferences)
						l_dial.set_ok_action (agent melt_project_cmd.execute_and_wait)
						l_dial.show_modal_to_window (window_manager.last_focused_development_window.window)
					end

					if not Eiffel_project.Workbench.successful then
							-- The last compilation was not successful.
							-- It is VERY dangerous to launch the debugger in these conditions.
							-- However, forbidding it completely may be too frustating.
						create wd.make_with_text (Warning_messages.w_Debug_not_compiled)
						wd.set_buttons (<<interface_names.b_ok, interface_names.b_cancel>>)
						wd.button (interface_names.b_ok).select_actions.extend (agent launch_application)
						wd.set_default_push_button (wd.button (interface_names.b_cancel))
						wd.show_modal_to_window (Window_manager.last_focused_window.window)
					elseif not Debugger_manager.can_debug then
							-- A class was removed since the last compilation.
							-- It is VERY dangerous to launch the debugger in these conditions.
							-- However, forbidding it completely may be too frustating.
						create wd.make_with_text (Warning_messages.w_Removed_class_debug)
						wd.set_buttons (<<interface_names.b_ok, interface_names.b_cancel>>)
						wd.button (interface_names.b_ok).select_actions.extend (agent launch_application)
						wd.set_default_push_button (wd.button (interface_names.b_cancel))
						wd.show_modal_to_window (Window_manager.last_focused_window.window)
					else
						launch_application (execution_mode)
					end
				elseif debugger_manager.safe_application_is_stopped then
						--| Application is already launched and is stopped |--
					resume_application
				end
			end
		end

	execute_from (widget: EV_CONTAINABLE) is
			-- Set widget's top-level window as the debugging window.
		local
			trigger: EV_CONTAINABLE
			cont: EV_ANY
			window: EV_WINDOW
			wd: EV_WARNING_DIALOG
		do
			from
				trigger := widget
				cont := trigger.parent
			until
				cont = Void
			loop
				trigger ?= cont
				if trigger /= Void then
					cont := trigger.parent
				else
					cont := Void
				end
			end
			window ?= trigger
			if window /= Void then
				Eb_debugger_manager.set_debugging_window (
					window_manager.development_window_from_window (window)
				)
			else
				create wd.make_with_text ("Could not initialize debugging tools")
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone: i.e. run to cursor.
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			old_bp_status: INTEGER
			wd: EV_WARNING_DIALOG
			cond: EB_EXPRESSION
			bp_exists: BOOLEAN
			dbg: DEBUGGER_MANAGER
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index
						-- Remember the status of the breakpoint
					dbg := Debugger_manager
					bp_exists := dbg.is_breakpoint_set (f, index)
					old_bp_status := dbg.breakpoint_status (f, index)
					if old_bp_status /= 0 then
						cond := dbg.condition (f, index)
					end
						-- Enable the breakpoint
					dbg.enable_breakpoint (f, index)
					dbg.remove_condition (f, index)
						-- Run the program
					execute
						-- Put back the status of the modified breakpoint This will prevent
						-- the display of the temporary breakpoint (if not already present
						-- at `index' in `f'.)
					if bp_exists then
						dbg.add_on_stopped_action (
							agent dbg.set_breakpoint_status (f, index, old_bp_status),	True
						)
						if old_bp_status /= 0 and cond /= Void then
								-- Restore condition after we stopped, otherwise if the evaluation
								-- does not evaluate to True then it will not stopped.
							dbg.add_on_stopped_action (
									agent dbg.set_condition (f, index, cond), True
								)
						end
					else
						dbg.add_on_stopped_action (
							agent dbg.remove_breakpoint (f, index), True
						)
					end
					dbg.add_on_stopped_action (agent dbg.notify_breakpoints_changes, True)
				end
			else
				create wd.make_with_text (Warning_messages.w_Cannot_debug)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	launch_application (a_execution_mode: INTEGER) is
			-- Launch the program from the project target.
		local
			ctlr: DEBUGGER_CONTROLLER
		do
			ctlr := debugger_manager.controller
			ctlr.set_param_arguments (current_cmd_line_argument)
			ctlr.set_param_working_directory (application_working_directory)
			ctlr.set_param_environment_variables (application_environment_variables)
			ctlr.debug_application (a_execution_mode)
			ctlr.clear_params
		end

	resume_application is
			-- Continue the execution of the program (stepping ...)
		do
			debugger_manager.controller.resume_workbench_application
		end

feature {NONE} -- Implementation / Attributes

	directory_exists (a_dirname: STRING): BOOLEAN is
			-- Is directory named `a_dirname' exists ?
		local
			d: DIRECTORY
		do
			create d.make (a_dirname)
			Result := d.exists
		end

	tooltext: STRING is
			-- Toolbar button text for the command
		do
			Result := Interface_names.b_Launch
		end

	tooltip: STRING is
			-- Tooltip for the command.
		do
			Result := Interface_names.f_Debug_run
		end

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	description: STRING is
			-- Description for the command.
		do
			Result := Interface_names.f_Debug_run
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_run
		end

	name: STRING is "Run"
			-- Name of the command. Used to store the command in the
			-- preferences.

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon
		end

	launch_program: BOOLEAN
			-- Are we currently trying to launch the program.

	need_to_wait: BOOLEAN
			-- Do we need to wait until the end of the compilation?

	dotnet_debugger: STRING is
			-- String indicating the .NET debugger to launch if specified in the
			-- Preferences Tool.
		do
			Result := preferences.debugger_data.dotnet_debugger.item (1)
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

end -- class EB_DEBUG_RUN_COMMAND
