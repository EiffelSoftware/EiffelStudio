indexing
	description: "Command to run the system while debugging."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_RUN_CMD

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

	EB_EDITOR_COMMAND
		redefine
			tool, make
		end

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_INTERFACE_TOOLS

	NEW_EB_CONSTANTS

--	WARNER_CALLBACKS

	EXEC_MODES

creation
	make

feature -- Initialization

	make (a_tool: EB_DEBUG_TOOL) is
			-- Initialize the command, create a couple of requests and windows.
			-- Add some actions as well.
		do
			precursor (a_tool)
--			create run_request.make (Rqst_application)
--			create cont_request.make (Rqst_cont)
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

	tool: EB_DEBUG_TOOL
			-- The text for the project tool.

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Debug_run 
--		end

	parent: EV_CONTAINER
			-- Parent for the argument window

	melt_and_run: EV_ARGUMENT1 [ANY] is
			-- Third button action
		once
		 	create Result.make (Void)
		end

feature -- Close window

	close is
                        -- Close `argument_window'.
		obsolete
			"Use destroy or hide instead"
		do
--			argument_window.close
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- What to do?
		local
--			update_command: UPDATE_PROJECT
--			argument_window: EB_ARGUMENT_DIALOG
		do
			if Project_tool.initialized then
				if argument = melt_and_run then
--					update_command ?= project_tool.quick_melt_cmd
--					update_command.set_run_after_melt (True)
--					need_to_wait := True
--					update_command.execute (Void, Void)
--					need_to_wait := False
--					Application.set_execution_mode (User_stop_points)
--					launch_application
--					update_command.set_run_after_melt (false)
--				elseif argument = button_three_action then
--					if argument_window.destroyed then
--						argument_window.initialize (popup_parent, Current)
--						argument_window.call
--					else
--						argument_window.destroy
--					end
				else
					if argument = Void  and then not need_to_wait then
							--| It means that the user clicked on the EXEC_STOP, EXEC_STEP,
							--| EXEC_NOSTOP or EXEC_LAST button and not on the RUN button
						launch_application
					elseif not need_to_wait then
							--| The user clicked on the Run button and since `execution_mode'
							--| is a shared variable, we need to update its value before to
							--| launch the execution
						Application.set_execution_mode (User_stop_points)
						launch_application
					end
				end
			end
		end
		
	launch_application is
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
--			mp: MOUSE_PTR
			wd: EV_WARNING_DIALOG
		do
			if 
				not project_tool_is_valid or else
				not Eiffel_project.system_defined or else
				Eiffel_System.name = Void
			then
				tool.display_string ("System not compiled%N")
			elseif not Application.is_running then
					-- Application is not running. Start it.
debug
	io.error.putstring (generator)
	io.error.putstring (": Start execution%N")
end
				create makefile_sh_name.make_from_string (Workbench_generation_path)
				makefile_sh_name.set_file_name (Makefile_SH)

				create uf.make (Eiffel_system.application_name (True))
				create make_f.make (makefile_sh_name)

				if uf.exists then
					if make_f.exists and then make_f.date > uf.date then
							-- The Makefile file is more recent than the 
							-- application
--						create wd.make_with_text (tool.parent, Interface_names.t_Warning,
--							Warning_messages.w_Makefile_more_recent (Makefile_SH)) 
--							wd.show_ok_cancel_buttons
--							wd.add_ok_command (Current, Void)
--							wd.show
					else
						launch_program := True
						if Application.has_breakpoints and then Application.is_ignoring_stop_points then	
--							create wd.make_with_text (tool.parent, Interface_names.t_Warning,
--								Warning_messages.w_Ignoring_all_stop_points)
--							wd.show_ok_cancel_buttons
--							wd.add_ok_command (Current, Void)
--							wd.show
						else
							start_program
						end
					end
				elseif make_f.exists then
						-- There is no application
--					create wd.make_with_text (tool.parent, Interface_names.t_Warning,
--						Warning_messages.w_No_system_generated)
--					wd.show_ok_cancel_buttons
--					wd.add_ok_command (Current, Void)
--					wd.show
				else
					create wd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Must_compile_first)
				end
			else
				status := Application.status
				if status.is_stopped then
					-- Application is stopped. Continue execution.
debug
	io.error.putstring (generator)
	io.error.putstring (": Contine execution%N")
end
--					create mp.set_watch_cursor
						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
					kept_objects := tool_supervisor.object_tool_mgr.objects_kept
					kept_objects.merge (debug_tool.kept_objects)
					Application.continue (kept_objects)
					tool_supervisor.object_tool_mgr.hang_on
					if status.e_feature /= Void then
						tool_supervisor.feature_tool_mgr.show_stoppoint 
							(status.e_feature, status.break_index)
						tool.show_stoppoint
							(status.e_feature, status.break_index)
					end
					debug_tool.save_current_cursor_position
					debug_tool.display_string ("System is running%N")
--					mp.restore
				end
			end
		end
 
	start_program is
			-- Launch the program to be debugged.
		local
--			mp: MOUSE_PTR
		do
			tool.save_current_cursor_position
			tool.display_string ("Launching system...%N")
--			create mp.set_watch_cursor
			Application.run (Argument_list)
			if Application.is_running then
				debug_tool.display_string ("System is running%N")
			else
					-- Something went wrong
				debug_tool.display_string (Application.eiffel_timeout_message)
			end
--			mp.restore
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

--	run_request: RUN_REQUEST
			-- Request for the run.

--	cont_request: EWB_REQUEST
			-- Request for continuation.

	launch_program: BOOLEAN
			-- Are we currently trying to launch the program.
	
	need_to_wait: BOOLEAN
			-- Do we need to wait until the end of the compilation?

end -- class EB_DEBUG_RUN_CMD
