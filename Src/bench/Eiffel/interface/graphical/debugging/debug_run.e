class DEBUG_RUN 

inherit

	IPC_SHARED;
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
	ICONED_COMMAND;
	SHARED_DEBUG;
	OBJECT_ADDR


creation

	make

	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window);
			!!run_request.make (Rqst_application);
			!!cont_request.make (Rqst_cont);
			!!argument_window.make (c, Current);
			!!specify_args;
			add_button_press_action (3, Current, specify_args);
		end;
	
feature 

	argument_window: ARGUMENT_W;
	specify_args: ANY;

	close is
		do
			argument_window.close;
		end;

	work (argument: ANY) is
			-- Re-run the application
		local
			application_name: STRING;
			makefile_sh_name: STRING;
			status: BOOLEAN;
			uf: RAW_FILE;
			make_f: PLAIN_TEXT_FILE;
			message: STRING
		do
			if Run_info.is_running then
				if Run_info.is_stopped then
						-- Application is running. Continue execution.
debug
	io.error.putstring (generator);
	io.error.putstring (": Contine execution%N");
end;
						-- Ask the application to wean objects the
						-- debugger doesn't need anymore.
					keep_objects (window_manager.object_win_mgr.objects_kept);

					status := cont_request.send_byte_code;
					if status then
						cont_request.send_breakpoints
					end;
					debug_info.tenure;
						-- For `hang_on' to work properly, application 
						-- must not be stopped (is_stopped = False).
					Run_info.set_is_stopped (False);
					Window_manager.object_win_mgr.hang_on;
					if Run_info.feature_i /= Void then
						Window_manager.routine_win_mgr.show_stoppoint 
									(Run_info.feature_i, Run_info.break_index)
					end;
					cont_request.send_rqst_1 (Rqst_resume, Resume_cont);
					debug_window.clear_window;
					debug_window.put_string ("Application is running%N");
					debug_window.display
				end;
			else
					-- Application is not running. Start it.

debug
	io.error.putstring (generator);
	io.error.putstring (": Start execution%N");
end;

					-- Get rid of object stones from previous execution.
					-- (`is_running' must be false).
				window_manager.object_win_mgr.hang_on;

				if project_tool.initialized and then 
					System.system_name /= Void 
				then
					if argument = specify_args then
						argument_window.call
					elseif argument = warner then
						project_tool.update_command.finish_freezing
					else
						!!application_name.make (50);
						application_name.append (Workbench_generation_path);
						application_name.extend (Directory_separator);

						!!makefile_sh_name.make (50);
						makefile_sh_name.append (application_name);

						makefile_sh_name.append (Makefile_SH);
						application_name.append (System.system_name);
						application_name.append (Executable_suffix);

						!!uf.make (application_name);
						!!make_f.make (makefile_sh_name);
						if uf.exists then
							if make_f.exists and then make_f.date > uf.date then
									-- The Makefile file is more recent than the application
								!!message.make (0);
								message.append (Makefile_SH);
								message.append (" is more recent than the application.%N%
												%Do you want to compile the generated C code?");
								warner.custom_call (Current, message, " OK ", Void, "Cancel");
							else
								application_name.extend (' ');
								application_name.append (argument_window.argument_list);
								run_request.set_application_name (application_name);
								run_request.send
							end;
						elseif make_f.exists then
								-- There is no application
							warner.custom_call (Current, "No application was generated.%N%
										%Do you want to compile the generated C code?", " OK ", Void, "Cancel");
						else
							warner.gotcha_call ("You must compile a system first%N");
						end;
					end
				end
			end;
			Run_info.set_is_stopped (False);
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
