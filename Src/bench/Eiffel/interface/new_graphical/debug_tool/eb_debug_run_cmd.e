indexing
	description	: "Command to run the system while debugging."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEBUG_RUN_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	IPC_SHARED
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

	EIFFEL_ENV
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

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

	EB_SHARED_DEBUG_TOOLS
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
			initialize
			create run_request.make (Rqst_application)
			create cont_request.make (Rqst_cont)
		end

feature -- Callbacks

	execute_warner_help is
		do
		end

	execute_warner_ok (argument: ANY) is
		do
			if not launch_program then		
				Eiffel_project.call_finish_freezing (True)
			else
				launch_program := False
				start_program
			end
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
		do
			Result := {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} Precursor (display_text, use_gray_icons)
			Result.select_actions.put_front (~execute_from (Result))
		end

	new_menu_item: EB_COMMAND_MENU_ITEM is
		do
			Result := {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} Precursor
			Result.select_actions.put_front (~execute_from (Result))
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
			cd: EV_CONFIRMATION_DIALOG
		do
			Application.set_execution_mode (execution_mode)
			if
				Eiffel_project.initialized and then
				not Eiffel_project.Workbench.is_compiling
			then
				if not Eiffel_project.Workbench.successful then
						-- The last compilation was not successful.
						-- It is VERY dangerous to launch the debugger in these conditions.
						-- However, forbidding it completely may be too frustating.
					create cd.make_with_text (Warning_messages.w_Debug_not_compiled)
					cd.button ("OK").select_actions.extend (~launch_application)
					cd.show_modal_to_window (Window_manager.last_focused_window.window)
				elseif not Debugger_manager.can_debug then
						-- A class was removed since the last compilation.
						-- It is VERY dangerous to launch the debugger in these conditions.
						-- However, forbidding it completely may be too frustating.
					create cd.make_with_text (Warning_messages.w_Removed_class_debug)
					cd.button ("OK").select_actions.extend (~launch_application)
					cd.show_modal_to_window (Window_manager.last_focused_window.window)					
				else
					launch_application
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
				debugger_manager.set_debugging_window (
					window_manager.development_window_from_window (window)
				)
			else
				create wd.make_with_text ("Could not initialize debugging tools")
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	melt_and_execute is
			-- Melt system, then launch it.
		local
			melt_command: EB_MELT_PROJECT_COMMAND
		do
			if Eiffel_project.initialized then
--				melt_command ?= project_window.quick_melt_cmd
				melt_command.set_run_after_melt (True)
--				need_to_wait := True
--				melt_command.execute (Void, Void)
--				need_to_wait := False
				Application.set_execution_mode (User_stop_points)
				launch_application
--				melt_command.set_run_after_melt (false)
			end
		end

	c_compile is
			-- Freeze system.
		do
			if Eiffel_project.initialized then
				Eiffel_project.call_finish_freezing (True)
--				Application.set_execution_mode (User_stop_points)
--				launch_application
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
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index
						-- Remember the status of the breakpoint
					old_bp_status := Application.breakpoint_status (f, index)
					if old_bp_status /= 0 then
						cond := Application.condition (f, index)
					end
						-- Enable the breakpoint
					Application.enable_breakpoint (f, index)
					Application.remove_condition (f, index)
						-- Run the program
					execute
						-- Put back the status of the modified breakpoint.
					Application.set_breakpoint_status (f, index, old_bp_status)
					if old_bp_status /= 0 then
						Application.set_condition (f, index, cond)
					end
				end
			else
				create wd.make_with_text (Warning_messages.w_Cannot_debug)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	launch_application is
			-- Launch the program from the project target.
		local
			makefile_sh_name: FILE_NAME
			status: APPLICATION_STATUS
			uf: RAW_FILE
			make_f: PLAIN_TEXT_FILE
			kept_objects: LINKED_SET [STRING]
			wd: EV_WARNING_DIALOG
			cd: EV_CONFIRMATION_DIALOG
			ignore_all_breakpoints_confirmation_dialog: EB_STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if  (not Eiffel_project.system_defined) or else (Eiffel_System.name = Void) then
				create wd.make_with_text (Warning_messages.w_No_system)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			elseif (not Application.is_running) then
				if
					Eiffel_project.initialized and then
					not Eiffel_project.Workbench.is_compiling
				then
						-- Application is not running. Start it.
	debug("DEBUGGER")
		io.error.putstring (generator)
		io.error.putstring ("(DEBUG_RUN): Start execution%N")
	end
					create makefile_sh_name.make_from_string (Workbench_generation_path)
					makefile_sh_name.set_file_name (Makefile_SH)
					
					create uf.make (Eiffel_system.application_name (True))
					create make_f.make (makefile_sh_name)
	
					if uf.exists then
						if Eiffel_system.system.il_generation then
							(create {COMMAND_EXECUTOR}).execute_with_args (eiffel_system.application_name (True),
								current_cmd_line_argument)
						else
							if make_f.exists and then make_f.date > uf.date then
									-- The Makefile file is more recent than the 
									-- application
								create cd.make_with_text_and_actions (Warning_messages.w_Makefile_more_recent (makefile_sh_name),
									<<~c_compile>>)
								cd.show_modal_to_window (window_manager.last_focused_development_window.window)
							else
								Output_manager.clear

								launch_program := True
								if Application.has_breakpoints and then Application.is_ignoring_stop_points then
									create ignore_all_breakpoints_confirmation_dialog.make_initialized (
										2, "confirm_ignore_all_breakpoints",
										Warning_messages.w_Ignoring_all_stop_points, Interface_names.l_Do_not_show_again
									)
									ignore_all_breakpoints_confirmation_dialog.set_ok_action (agent start_program)
									ignore_all_breakpoints_confirmation_dialog.show_modal_to_window (window_manager.last_focused_development_window.window)
								else
									start_program
								end
							end
						end
					elseif make_f.exists then
							-- There is no application.
						create wd.make_with_text (Warning_messages.w_No_system_generated)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					elseif Eiffel_project.Lace.compile_all_classes then
						create wd.make_with_text (Warning_messages.w_None_system)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					else
						create wd.make_with_text (Warning_messages.w_Must_compile_first)
						wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					end
				end
			else
				status := Application.status
				if status /= Void and then status.is_stopped then
					-- Application is stopped. Continue execution.
debug("DEBUGGER")
	io.error.putstring (generator)
	io.error.putstring (": Continue execution%N")
end
						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
--| FIXME ARNAUD
--					kept_objects := window_manager.object_tool_mgr.objects_kept
--					kept_objects.merge (debug_target.kept_objects)
					if debugger_manager /= Void then
						kept_objects := debugger_manager.kept_objects
					else
						create kept_objects.make
					end
					Application.continue (kept_objects)
--					window_manager.object_tool_mgr.hang_on
--					if status.e_feature /= Void then
--						window_manager.feature_tool_mgr.show_stoppoint 
--							(status.e_feature, status.break_index)
--						target.show_stoppoint
--							(status.e_feature, status.break_index)
--					end
--					target.refresh_current_stoppoint
--					Window_manager.feature_tool_mgr.synchronize_with_callstack
--					debug_target.save_current_cursor_position
--					debug_target.display_string ("System is running%N")
					if debugger_manager /= Void then
						debugger_manager.on_application_resumed
					end
--| END FIXME
				end
			end
		end
 
	start_program is
			-- Launch the program to be debugged.
		local
			output_text: STRUCTURED_TEXT
			wd: EV_WARNING_DIALOG
			working_dir: STRING
		do
			create output_text.make
			if not Application.is_running then
					-- First time we launch the program, we clear the output tool.
				output_manager.clear
			end
			output_text.add_string ("Launching system...")
			output_text.add_new_line
			
			working_dir := application_working_directory
			if not (create {DIRECTORY} .make (working_dir)).exists then
				create wd.make_with_text (Warning_messages.w_Invalid_working_directory (working_dir))
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				output_text.add_string (Warning_messages.w_Invalid_working_directory (working_dir))
			else
				Application.run (current_cmd_line_argument, working_dir)
				if Application.is_running then
					output_text.add_string ("System is running")
					output_text.add_new_line
					if debugger_manager /= Void then
						debugger_manager.on_application_launched
					end
				else
						-- Something went wrong
					create wd.make_with_text (Application.eiffel_timeout_message)
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
					output_text.add_string ("Could not launch system")
				end
			end
			output_manager.process_text (output_text)
		end

feature {NONE} -- Implementation / Attributes

	tooltip: STRING is
			-- Tooltip for the command.
		do
			Result := Interface_names.f_Debug_run
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

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_run
		end

	run_request: RUN_REQUEST
			-- Request for the run.

	cont_request: EWB_REQUEST
			-- Request for continuation.

	launch_program: BOOLEAN
			-- Are we currently trying to launch the program.
	
	need_to_wait: BOOLEAN
			-- Do we need to wait until the end of the compilation?

end -- class EB_DEBUG_RUN_COMMAND
