class DEBUG_QUIT 

inherit

	ICONED_COMMAND;
	IPC_SHARED;
	SHARED_DEBUG

creation

	make, non_gui_make

feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window);
			!!request.make (Rqst_quit)
		end;

	non_gui_make is
		do
			!!request.make (Rqst_quit)
		end;

	exit_now is
		do
			work (void);
		end;
	
feature {NONE}

	work (argument: ANY) is
			-- Continue execution.
		local
			kill_request: EWB_REQUEST
		do
			if Run_info.is_running then
				if Run_info.is_stopped then
					request.send;
				else
					!! kill_request.make (Rqst_kill);
					kill_request.send
				end;
			end;
		end;

	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Debug_quit 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Debug_quit end;

	request: EWB_REQUEST;

end
