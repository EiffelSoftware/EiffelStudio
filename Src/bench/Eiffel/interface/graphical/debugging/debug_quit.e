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
					if Run_info.feature_i /= Void then
						Run_info.set_is_stopped (False);
						Window_manager.routine_win_mgr.show_stoppoint
								(Run_info.feature_i, Run_info.break_index)
					end	
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
