indexing

	description:	
		"Command to run the system while debugging.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_RUN 

inherit

	IPC_SHARED;
	SHARED_EIFFEL_PROJECT;
	PROJECT_CONTEXT
		export
			{NONE} all
		end;
	EIFFEL_ENV
		export
			{NONE} all
		end;
	ICONED_COMMAND
		redefine
			tool
		end;
	SHARED_APPLICATION_EXECUTION;
	WARNER_CALLBACKS

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_tool: PROJECT_W) is
			-- Initialize the command, create a couple of requests and windows.
			-- Add some actions as well.
		do
			init_from_tool (a_tool);
			!! run_request.make (Rqst_application);
			!! cont_request.make (Rqst_cont);
			argument_window.initialize (c, Current);
		end;

feature -- Callbacks

	execute_warner_help is
		do
		end;

	execute_warner_ok (argument: ANY) is
		do
			Eiffel_project.call_finish_freezing (True)
		end;

feature -- Properties

	tool: PROJECT_W;
			-- The text for the project tool.

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Debug_run 
		end;

feature -- Close window

	close is
			-- Close `argument_window'.
		do
			argument_window.close;
		end;

feature -- Execution

	work (argument: ANY) is
			-- Re-run the application
			-- FIXME*****************************************
			--		melt_only (no check for Makefile.SH)
		local
			makefile_sh_name: FILE_NAME;
			status: APPLICATION_STATUS;
			ok: BOOLEAN;
			uf: RAW_FILE;
			make_f: PLAIN_TEXT_FILE;
			kept_objects: LINKED_SET [STRING];
			debug_tool: PROJECT_W;
			ready_to_run: BOOLEAN;
			temp: STRING;
			update_command: UPDATE_PROJECT;
			project_w: PROJECT_W;
			mp: MOUSE_PTR
		do
			if argument = melt_and_run then
				update_command ?= tool.update_cmd_holder.associated_command;
				update_command.set_run_after_melt (true);
				update_command.execute (text_window);
				update_command.set_run_after_melt (false)
			elseif argument = specify_args then
				argument_window.call
			elseif 
				not tool.initialized or else 
				Eiffel_System.name = Void 
			then
				debug_window.clear_window;
				debug_window.put_string ("System not compiled");
				debug_window.new_line;
				debug_window.display
			elseif not Application.is_running then
					-- Application is not running. Start it.
debug
	io.error.putstring (generator);
	io.error.putstring (": Start execution%N");
end;
				!! mp.set_watch_cursor;
				!!makefile_sh_name.make_from_string (Workbench_generation_path);
				makefile_sh_name.set_file_name (Makefile_SH);

				!! uf.make (Eiffel_system.application_name (True));
				!! make_f.make (makefile_sh_name);
--!! FIXME: melt_only (no check for Makefile.SH)
--!! FIXME: ****************************************
--!! FIXME: ****************************************
--!! FIXME: ****************************************

				if uf.exists then
					if make_f.exists and then make_f.date > uf.date then
							-- The Makefile file is more recent than the 
							-- application
						warner (popup_parent).custom_call (Current, 
							w_Makefile_more_recent (Makefile_SH), 
							" OK ", Void, "Cancel")
					else
						mp.restore;
						debug_window.clear_window;
						debug_window.put_string ("Launching system...");
						debug_window.new_line;
						debug_window.display;
						mp.set_watch_cursor;
						Application.run (argument_window.argument_list);
						if Application.is_running then
							debug_window.clear_window;
							debug_window.put_string ("System is running");
							debug_window.new_line;
							debug_window.display
						else
								-- Something went wrong
							debug_window.clear_window;
							debug_window.put_string 
								(Application.eiffel_timeout_message);
						end;
						debug_window.display
					end
				elseif make_f.exists then
						-- There is no application
					warner (popup_parent).custom_call (Current, 
						w_No_system_generated, " OK ", Void, "Cancel");
				else
					warner (popup_parent).gotcha_call 
						(w_Must_compile_first)
				end;
				mp.restore
			else
				status := Application.status;
				if status.is_stopped then
					-- Application is stopped. Continue execution.
debug
	io.error.putstring (generator);
	io.error.putstring (": Contine execution%N");
end;
					!! mp.set_watch_cursor;
						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
					kept_objects := window_manager.object_win_mgr.objects_kept;
					debug_tool ?= Debug_window.tool;
					kept_objects.merge (debug_tool.kept_objects);
					Application.continue (kept_objects);
					Window_manager.object_win_mgr.hang_on;
					if status.e_feature /= Void then
						Window_manager.routine_win_mgr.show_stoppoint 
							(status.e_feature, status.break_index);
						tool.show_stoppoint
							(status.e_feature, status.break_index)
					end;
					debug_window.clear_window;
					debug_window.put_string ("System is running");
					debug_window.new_line;
					debug_window.display;
					mp.restore
				end
			end
		end;
 
feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := l_Debug_run
		end;

	run_request: RUN_REQUEST;
			-- Request for the run.

	cont_request: EWB_REQUEST
			-- Request for continuation.

end -- DEBUG_RUN
