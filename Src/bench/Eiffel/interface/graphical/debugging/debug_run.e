indexing
	description	: "Command to run the system while debugging."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_RUN

inherit
	IPC_SHARED

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

	HOLE_COMMAND
		redefine
			tool, 
			compatible, 
			process_breakable,
			make
		end

	SHARED_APPLICATION_EXECUTION

	WARNER_CALLBACKS

	EXEC_MODES

creation
	make

feature -- Initialization

	make (a_tool: PROJECT_W) is
			-- Initialize the command, create a couple of requests and windows.
			-- Add some actions as well.
		do
			{HOLE_COMMAND} Precursor (a_tool)
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

feature -- Properties

	tool: PROJECT_W
			-- The text for the project tool.

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Debug_run 
		end

	parent: COMPOSITE
			-- Parent for the argument window

	melt_and_run: ANY is
			-- Third button action
		once
		 	create Result 
		end

	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
				-- We only accept breakable line stones.
			Result := dropped /= Void and then dropped.stone_type = Breakable_type
		end

feature -- Close window

feature -- Execution

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone: i.e. run to cursor.
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			old_bp_status: INTEGER
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					index := bs.index
					body_index := bs.body_index

						-- Remember the status of the breakpoint
					old_bp_status := Application.breakpoint_status (f, index)

						-- Enable the breakpoint
					Application.enable_breakpoint (f, index)
					
						-- Run the program
					work (tool)
	
						-- Put back the status of the modified breakpoint.
					Application.set_breakpoint_status (f, index, old_bp_status)
				end
			else
				warner (Project_tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_debug)
			end
		end

	work (argument: ANY) is
			-- What to do?
		local
			update_command: UPDATE_PROJECT
		do
			if Project_tool.initialized then
				if argument = melt_and_run then
					update_command ?= tool.update_cmd_holder.associated_command
					update_command.set_run_after_melt (True)
					update_command.set_quick_melt
					need_to_wait := True
					update_command.execute (tool)
					need_to_wait := False
					Application.set_execution_mode (User_stop_points)
					launch_application (tool)
					update_command.set_run_after_melt (false)
				else
					if argument /= tool  and then not need_to_wait then
							--| It means that the user clicked on the EXEC_STOP, EXEC_STEP,
							--| EXEC_NOSTOP or EXEC_LAST button and not on the RUN button
						launch_application (argument)
					elseif not need_to_wait then
							--| The user clicked on the Run button and since `execution_mode'
							--| is a shared variable, we need to update its value before
							--| launching the execution
						Application.set_execution_mode (User_stop_points)
						launch_application (argument)
					end
				end
			end
		end
		
	launch_application (argument: ANY) is
			-- Launch the program from the project tool.
		local
			makefile_sh_name: FILE_NAME
			uf				: RAW_FILE
			status			: APPLICATION_STATUS
			kept_objects	: LINKED_SET [STRING]
			mp				: MOUSE_PTR
			make_f			: PLAIN_TEXT_FILE
		do
			if 
				not tool.initialized or else
				not Eiffel_project.system_defined or else
				Eiffel_System.name = Void
			then
				debug_window.clear_window
				debug_window.put_string ("System not compiled")
				debug_window.new_line
				debug_window.display
			elseif not Application.is_running then
					-- Application is not running. Start it.
				debug("DEBUGGER") io.putstring (generator+"(DEBUG_RUN): Start execution%N"); end
				create makefile_sh_name.make_from_string (Workbench_generation_path)
				makefile_sh_name.set_file_name (Makefile_SH)

				create uf.make (Eiffel_system.application_name (True))
				create make_f.make (makefile_sh_name)

				if uf.exists then
					if make_f.exists and then make_f.date > uf.date then
							-- The Makefile file is more recent than the 
							-- application
						warner (popup_parent).custom_call (Current, 
							Warning_messages.w_Makefile_more_recent (Makefile_SH), 
							Interface_names.b_Ok, Void, Interface_names.b_Cancel)
					else
						launch_program := True
						if Application.has_breakpoints and then Application.is_ignoring_stop_points then	
							warner (popup_parent).custom_call (Current,
								Warning_messages.w_Ignoring_all_stop_points, Interface_names.b_Ok, Void, Interface_names.b_Cancel)
						else
							start_program
						end
					end
				elseif make_f.exists then
						-- There is no application
					warner (popup_parent).custom_call (Current, 
						Warning_messages.w_No_system_generated, Interface_names.b_Ok, Void, Interface_names.b_Cancel)
				else
					warner (popup_parent).gotcha_call 
						(Warning_messages.w_Must_compile_first)
				end
			else
				status := Application.status
				if status /= Void and then status.is_stopped then
					-- Application is stopped. Continue execution.
					debug("DEBUGGER") io.putstring (generator+": Continue execution%N"); end
					create mp.set_watch_cursor

						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
					kept_objects := window_manager.object_win_mgr.objects_kept
					kept_objects.merge (Project_tool.kept_objects)
					Application.continue (kept_objects)
					Window_manager.object_win_mgr.hang_on

						-- remove all arrows displayed (where we are stopped...)
						--
						-- update all opened feature tools by re-displaying the default
						-- text instead of the arrow if application is stopped inside feature
					tool.refresh_current_stoppoint
					Window_manager.routine_win_mgr.synchronize_with_callstack

					Project_tool.save_current_cursor_position
					debug_window.clear_window
					debug_window.put_string ("System is running")
					debug_window.new_line
					debug_window.display
					mp.restore
				end
			end
		end
 
	start_program is
			-- Launch the program to be debugged.
		local
			mp: MOUSE_PTR
		do
			debug_window.clear_window
			Project_tool.save_current_cursor_position
			debug_window.put_string ("Launching system...")
			debug_window.new_line
			create mp.set_watch_cursor
			Application.run (current_cmd_line_argument, application_working_directory)
			if Application.is_running then
				debug_window.clear_window
				debug_window.put_string ("System is running")
				debug_window.new_line
			else
					-- Something went wrong
				debug_window.clear_window
				debug_window.put_string (Application.eiffel_timeout_message)
			end
			debug_window.display
			mp.restore
		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Debug_run
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_run
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Debug_run
		end

	run_request: RUN_REQUEST
			-- Request for the run.

	cont_request: EWB_REQUEST
			-- Request for continuation.

	launch_program: BOOLEAN
			-- Are we currently trying to launch the program.
	
	need_to_wait: BOOLEAN
			-- Do we need to wait until the end of the compilation?

feature -- Property

	stone_type: INTEGER is do end

end -- DEBUG_RUN
