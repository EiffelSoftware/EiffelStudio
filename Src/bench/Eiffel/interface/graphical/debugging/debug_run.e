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
	SHARED_DEBUG;
	OBJECT_ADDR


creation

	make

	
feature 

	make (c: COMPOSITE; a_text_window: PROJECT_TEXT) is
		do
			init (c, a_text_window);
			!!run_request.make (Rqst_application);
			!!cont_request.make (Rqst_cont);
			!!argument_window.make (c, Current);
			add_button_click_action (3, Current, specify_args);
			set_action ("!c<Btn1Down>", Current, melt_and_run)
		end;
	
	text_window: PROJECT_TEXT;

feature 

	argument_window: ARGUMENT_W;

	close is
		do
			argument_window.close;
		end;

	work (argument: ANY) is
			-- Re-run the application
		local
			application_name: FILE_NAME;
			makefile_sh_name: FILE_NAME;
			status: BOOLEAN;
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
			elseif not Run_info.is_running then
					-- Application is not running. Start it.
debug
	io.error.putstring (generator);
	io.error.putstring (": Start execution%N");
end;
				set_global_cursor (watch_cursor);
				!!makefile_sh_name.make_from_string (Workbench_generation_path);
				makefile_sh_name.set_file_name (Makefile_SH);

				!!application_name.make_from_string (Workbench_generation_path);
				!!temp.make (0);
				temp.append (System.system_name);
				temp.append (Executable_suffix);
				application_name.set_file_name (temp);

				!!uf.make (application_name);
				!!make_f.make (makefile_sh_name);

--!! FIXME: melt_only (no check for Makefile.SH)
--!! FIXME: melt_only
--!! FIXME: melt_only
--!! FIXME: melt_only

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
						temp := clone (application_name);
						temp.extend (' ');
						temp.append (argument_window.argument_list);
						run_request.set_application_name (temp);
						run_request.send
					end
				elseif make_f.exists then
						-- There is no application
					warner (text_window).custom_call (Current, 
						w_No_system_generated, " OK ", Void, "Cancel");
				else
					warner (text_window).gotcha_call 
						(w_Must_compile_first)
				end;
				Run_info.set_is_stopped (False);
				restore_cursors
			elseif Run_info.is_stopped then
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
				keep_objects (kept_objects);

				status := cont_request.send_byte_code;
				if status then
					cont_request.send_breakpoints
				end;
				debug_info.tenure;
					-- For `hang_on' to work properly, application 
					-- must not be stopped (is_stopped = False).
				Run_info.set_is_stopped (False);
				Window_manager.object_win_mgr.hang_on;
				if Run_info.e_feature /= Void then
					Window_manager.routine_win_mgr.show_stoppoint 
						(Run_info.e_feature, Run_info.break_index)
				end;
				cont_request.send_rqst_1 (Rqst_resume, Resume_cont);
				debug_window.clear_window;
				debug_window.put_string ("System is running%N");
				debug_window.display;
				restore_cursors
			end
		end;

feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Debug_run 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Debug_run end;

	run_request: RUN_REQUEST;

	cont_request: EWB_REQUEST

end
