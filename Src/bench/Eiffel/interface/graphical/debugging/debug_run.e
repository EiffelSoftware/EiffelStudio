indexing

	description:	
		"Command to run the system while debugging.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_RUN 

inherit

	IPC_SHARED;
	SHARED_EIFFEL_PROJECT;
	SHARED_WORKBENCH
		export
			{NONE} all
		end;
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
			text_window
		end;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: PROJECT_TEXT) is
			-- Initialize the command, create a couple of requests and windows.
			-- Add some actions as well.
		do
			init (c, a_text_window);
			!!run_request.make (Rqst_application);
			!!cont_request.make (Rqst_cont);
			!!argument_window.make (c, Current);
			add_button_click_action (3, Current, specify_args);
			set_action ("!c<Btn1Down>", Current, melt_and_run)
		end;

feature -- Properties

	text_window: PROJECT_TEXT;
			-- The text for the project tool.

	argument_window: ARGUMENT_W;
			-- Window where the user can specify the arguments.

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
			debug_text: TEXT_WINDOW;
			ready_to_run: BOOLEAN;
			temp: STRING;
			update_command: UPDATE_PROJECT
		do
			if argument = melt_and_run then
				update_command := text_window.tool.update_command;
				update_command.set_run_after_melt (true);
				update_command.execute (text_window);
				update_command.set_run_after_melt (false)
			elseif argument = specify_args then
				argument_window.call
			elseif last_warner /= Void and argument = last_warner then
				Eiffel_project.call_finish_freezing (True)
			elseif 
				not project_tool.initialized or else 
				System.system_name = Void 
			then
				debug_window.clear_window;
				debug_window.put_string ("System not compiled%N");
				debug_window.display
			elseif not Application.is_running then
					-- Application is not running. Start it.
debug
	io.error.putstring (generator);
	io.error.putstring (": Start execution%N");
end;
				set_global_cursor (watch_cursor);
				!!makefile_sh_name.make_from_string (Workbench_generation_path);
				makefile_sh_name.set_file_name (Makefile_SH);

				!! uf.make (Application.name);
				!! make_f.make (makefile_sh_name);
					--!! FIXME: ****************************************
				if uf.exists then
					if make_f.exists and then make_f.date > uf.date then
							-- The Makefile file is more recent than the 
							-- application
						warner (text_window).custom_call (Current, 
							w_Makefile_more_recent (Makefile_SH), 
							" OK ", Void, "Cancel")
					else
						restore_cursors;
						debug_window.clear_window;
						debug_window.put_string ("Launching system...%N");
						debug_window.display;
						set_global_cursor (watch_cursor);
						Application.run (argument_window.argument_list);
						if Application.is_running then
							debug_window.clear_window;
							debug_window.put_string ("System is running%N");
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
					warner (text_window).custom_call (Current, 
						w_No_system_generated, " OK ", Void, "Cancel");
				else
					warner (text_window).gotcha_call 
						(w_Must_compile_first)
				end;
				restore_cursors
			else
				status := Application.status;
				if status.is_stopped then
					-- Application is stopped. Continue execution.
debug
	io.error.putstring (generator);
	io.error.putstring (": Contine execution%N");
end;
					set_global_cursor (watch_cursor);
						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
					kept_objects := window_manager.object_win_mgr.objects_kept;
					debug_text ?= debug_window;
					kept_objects.merge (debug_text.kept_objects);
					Application.continue (kept_objects);
					Window_manager.object_win_mgr.hang_on;
					if status.e_feature /= Void then
						Window_manager.routine_win_mgr.show_stoppoint 
							(status.e_feature, status.break_index)
					end;
					debug_window.clear_window;
					debug_window.put_string ("System is running%N");
					debug_window.display;
					restore_cursors
				end
			end
		end;
 
feature {NONE} -- Attributes

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Debug_run
		end;

	run_request: RUN_REQUEST;
			-- Request for the run.

	cont_request: EWB_REQUEST
			-- Request for continuation.

end -- DEBUG_RUN
