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
	SHARED_DEBUG


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
			argument_window.close
		end;

	work (argument: ANY) is
			-- Re-run the application
		local
			application_path: STRING;
			application_name: STRING
			status: BOOLEAN
		do
			if Run_info.is_running then
				if Run_info.is_stopped then
debug
	io.error.putstring (generator);
	io.error.putstring (": Contine execution%N");
end;
						-- Application is running. Continue execution.
					status := cont_request.send_byte_code;
					if status then
						cont_request.send_breakpoints
					end;
					debug_info.tenure;
					cont_request.send_rqst_1 (Rqst_resume, Resume_cont);
				end;
			else
debug
	io.error.putstring (generator);
	io.error.putstring (": Start execution%N");
end;
					-- Application is not running. Start it.
				if project_tool.initialized and then 
					System.system_name /= Void 
				then
					if argument = specify_args then
						argument_window.call
					else
						!!application_path.make (50);
						!!application_name.make (20);
						application_path.append (Workbench_generation_path);
						application_path.append_character (Directory_separator);
						application_path.append (argument_window.application_name);
						run_request.set_application_name (application_path);
						run_request.send
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
