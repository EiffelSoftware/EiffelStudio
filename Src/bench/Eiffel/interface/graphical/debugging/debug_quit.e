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
			set_action ("!c<Btn1Down>", Current, kill_it)
		end;

	non_gui_make is
		do
			!!request.make (Rqst_quit)
		end;

	exit_now is
		do
			work (kill_it);
		end;
	
	recv_dead is
			-- Wait for the application to be killed.
		do
			if request.recv_dead then end
		end;

feature {NONE}

	work (argument: ANY) is
			-- Continue execution.
		do
			if Run_info.is_running then
				if argument /= kill_it then
					if not Run_info.is_stopped then
							-- Ask the application to interrupt ASAP.
						debug_window.clear_window;
						debug_window.put_string ("System is running%N");
						debug_window.put_string ("Interruption request%N");
						debug_window.display;
						request.make (Rqst_interrupt);
						request.send
					end
				elseif Run_info.is_stopped then
					request.make (Rqst_quit);
					request.send;
					if Run_info.feature_i /= Void then
						Run_info.set_is_stopped (False);
						Window_manager.routine_win_mgr.show_stoppoint
								(Run_info.feature_i, Run_info.break_index)
					end	
				else
					request.make (Rqst_kill);
					request.send
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
