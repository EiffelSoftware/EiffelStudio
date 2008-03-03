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
			new_sd_toolbar_item,
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

	SHARED_STATUS
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

	ES_SHARED_DIALOG_BUTTONS
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

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
		local
			l_tool_bar: SD_TOOL_BAR
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			l_tool_bar := Result.tool_bar
			check not_void: l_tool_bar /= Void end

			Result.select_actions.put_front (agent execute_from (l_tool_bar))
		end

	new_menu_item: EB_COMMAND_MENU_ITEM is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.select_actions.put_front (agent execute_from (Result))
		end

feature -- Execution

	execute is
			-- Launch program in debugger with mode `Run' (i.e "Run").
		do
			execute_with_mode ({EXEC_MODES}.run)
		end

	execute_with_mode (execution_mode: INTEGER) is
			-- execute program in debugger with mode `Run' (i.e "Run").
		do
			if
				Eiffel_project.initialized and then
				not Eiffel_project.Workbench.is_compiling
			then
				if debugger_manager.application_is_executing then
					resume_with_mode (execution_mode)
				else -- not yet launched
					launch_with_mode (execution_mode, debugger_manager.current_execution_parameters)
				end
			end
		end

	launch_with_mode (execution_mode: INTEGER; params: DEBUGGER_EXECUTION_PARAMETERS) is
		require
			project_initialized: Eiffel_project.initialized
			not_compiling: not Eiffel_project.Workbench.is_compiling
			app_not_launched: not debugger_manager.application_is_executing
		local
			l_warning: ES_WARNING_PROMPT
			l_compile_request: ES_DISCARDABLE_QUESTION_PROMPT
			l_wb: WORKBENCH_I
			l_cancel_debug: BOOLEAN
		do
				-- ask to compile if we changed some classes inside eiffel studio
			l_wb := eiffel_project.workbench
			if l_wb.is_changed or window_manager.has_modified_windows then
				create l_compile_request.make_standard_with_cancel (warning_messages.w_compile_before_debug,
					interface_names.l_always_compile_before_debug,
					preferences.dialog_data.confirm_always_compile_before_executing_string)
				l_compile_request.set_title (interface_names.t_debugger_question)
				l_compile_request.set_button_action (dialog_buttons.yes_button, agent melt_project_cmd.execute_and_wait)
				l_compile_request.show_on_active_window
				if l_compile_request.dialog_result = dialog_buttons.cancel_button then
					l_cancel_debug := True
				end
			end

			if not l_cancel_debug then
				if not Eiffel_project.Workbench.successful then
						-- The last compilation was not successful.
						-- It is VERY dangerous to launch the debugger in these conditions.
						-- However, forbidding it completely may be too frustating.
					create l_warning.make_standard_with_cancel (warning_messages.w_debug_not_compiled)
					l_warning.set_title (interface_names.t_debugger_warning)
					l_warning.set_button_action (dialog_buttons.ok_button, agent launch_application (execution_mode, params))
					l_warning.show_on_active_window
				elseif not Debugger_manager.can_debug then
						-- A class was removed since the last compilation.
						-- It is VERY dangerous to launch the debugger in these conditions.
						-- However, forbidding it completely may be too frustating.
					create l_warning.make_standard_with_cancel (warning_messages.w_removed_class_debug)
					l_warning.set_title (interface_names.t_debugger_warning)
					l_warning.set_button_action (dialog_buttons.ok_button, agent launch_application (execution_mode, params))
					l_warning.show_on_active_window
				else
					launch_application (execution_mode, params)
				end
			end
		end

	resume_with_mode (execution_mode: INTEGER) is
			-- resume program in debugger with mode `execution_mode'.
		require
			project_initialized: Eiffel_project.initialized
			not_compiling: not Eiffel_project.Workbench.is_compiling
			app_initialized: debugger_manager.application_initialized
		do
				--| At this point we define the 'type' on debug operation
				--| either step next, step into, step out, continue ...
				--| this will be used in APPLICATION_EXECUTION.continue_ignoring_kept_objects

			Debugger_manager.application.set_execution_mode (execution_mode)

					--| Application is already launched (precondition) |--
			if debugger_manager.safe_application_is_stopped then
					--| Application is already launched and is stopped |--
				resume_application
			end
		end

	execute_from (widget: EV_CONTAINABLE) is
			-- Set widget's top-level window as the debugging window.
		local
			trigger: EV_CONTAINABLE
			cont: EV_ANY
			window: EV_WINDOW
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
				prompts.show_error_prompt ("Could not initialize debugging tools", Void, Void)
			end
		end

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone: i.e. run to cursor.
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			hbp_exists: BOOLEAN
			dbg: DEBUGGER_MANAGER
			bm: BREAKPOINTS_MANAGER
			hbp, nhbp: HIDDEN_BREAKPOINT
			loc: BREAKPOINT_LOCATION
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index

					dbg := Debugger_manager
					bm := debugger_manager.breakpoints_manager

						--| Remember the status of the breakpoint
					loc := bm.breakpoint_location (f, index, True)
					if bm.is_hidden_breakpoint_set_at (loc) then
						hbp := bm.hidden_breakpoint_at (loc)
						hbp_exists := hbp /= Void
					end

					if hbp_exists then
						hbp.enable_run_to_cursor_mode
					else
						nhbp := bm.new_hidden_breakpoint (loc)
						bm.add_breakpoint (nhbp)
					end
						-- Run the program
					execute
						-- Put back the status of the modified breakpoint This will prevent
						-- the display of the temporary breakpoint (if not already present
						-- at `index' in `f'.)
					if hbp_exists then
						dbg.add_on_stopped_action (
								agent (a_dbg: DEBUGGER_MANAGER; a_bp: HIDDEN_BREAKPOINT)
									do
										a_bp.disable_run_to_cursor_mode
									end (?, hbp)
								, True
							)
					else
						dbg.add_on_stopped_action (
								agent (a_dbg: DEBUGGER_MANAGER; a_bp: HIDDEN_BREAKPOINT)
									do
										a_dbg.breakpoints_manager.delete_breakpoint (a_bp)
									end (?, nhbp)
								, True
							)
					end
					dbg.add_on_stopped_action (
							agent (a_dbg: DEBUGGER_MANAGER)
								do
									a_dbg.breakpoints_manager.notify_breakpoints_changes
								end (?)
							, True
						)
				end
			else
				prompts.show_error_prompt (Warning_messages.w_Cannot_debug, Void, Void)
			end
		end

	launch_application (a_execution_mode: INTEGER; a_params: DEBUGGER_EXECUTION_PARAMETERS) is
			-- Launch the program from the project target.
		local
			ctlr: DEBUGGER_CONTROLLER
		do
			ctlr := debugger_manager.controller
			ctlr.debug_application (a_params, a_execution_mode)
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

	tooltext: STRING_GENERAL is
			-- Toolbar button text for the command
		do
			Result := Interface_names.b_Launch
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the command.
		do
			Result := Interface_names.f_Debug_run
		end

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	description: STRING_GENERAL is
			-- Description for the command.
		do
			Result := Interface_names.f_Debug_run
		end

	menu_name: STRING_GENERAL is
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

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon_buffer
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
