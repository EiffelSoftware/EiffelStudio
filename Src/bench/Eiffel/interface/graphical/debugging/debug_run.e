indexing

	description:	
		"Command to run the system while debugging."
	date: "$Date$"
	revision: "$Revision$"

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

	PIXMAP_COMMAND
		redefine
			tool
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
			init (a_tool)
			!! run_request.make (Rqst_application)
			!! cont_request.make (Rqst_cont)
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
		 	!! Result 
		end

feature -- Close window

	close is
			-- Close `argument_window'.
		do
			argument_window.close
		end

feature -- Execution

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
				elseif argument = button_three_action then
					if argument_window.destroyed then
						argument_window.initialize (popup_parent, Current)
						argument_window.call
					else
						argument_window.destroy
					end
				else
					if argument /= tool  and then not need_to_wait then
							--| It means that the user clicked on the EXEC_STOP, EXEC_STEP,
							--| EXEC_NOSTOP or EXEC_LAST button and not on the RUN button
						launch_application (argument)
					elseif not need_to_wait then
							--| The user clicked on the Run button and since `execution_mode'
							--| is a shared variable, we need to update its value before to
							--| launch the execution
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
			status: APPLICATION_STATUS
			ok: BOOLEAN
			uf: RAW_FILE
			make_f: PLAIN_TEXT_FILE
			kept_objects: LINKED_SET [STRING]
			ready_to_run: BOOLEAN
			temp: STRING
			project_w: PROJECT_W
			mp: MOUSE_PTR
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
debug
	io.error.putstring (generator)
	io.error.putstring (": Start execution%N")
end
				!!makefile_sh_name.make_from_string (Workbench_generation_path)
				makefile_sh_name.set_file_name (Makefile_SH)

				!! uf.make (Eiffel_system.application_name (True))
				!! make_f.make (makefile_sh_name)

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
				if status.is_stopped then
					-- Application is stopped. Continue execution.
debug
	io.error.putstring (generator)
	io.error.putstring (": Contine execution%N")
end
					!! mp.set_watch_cursor
						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
					kept_objects := window_manager.object_win_mgr.objects_kept
					kept_objects.merge (Project_tool.kept_objects)
					Application.continue (kept_objects)
					Window_manager.object_win_mgr.hang_on
					if status.e_feature /= Void then
						Window_manager.routine_win_mgr.show_stoppoint 
							(status.e_feature, status.break_index)
						tool.show_stoppoint
							(status.e_feature, status.break_index)
					end
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
			!! mp.set_watch_cursor
			Application.run (argument_window.argument_list)
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

end -- DEBUG_RUN
