class DEBUG_QUIT 

inherit

	ICONED_COMMAND;
	IPC_SHARED;
	SHARED_APPLICATION_EXECUTION;
	E_CMD
		rename
			execute as termination_processing
		end;

creation

	make, non_gui_make

feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window);
			!!request.make (Rqst_quit);
			set_action ("!c<Btn1Down>", Current, kill_it);
			Application.set_termination_command (Current)
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
		local
			status: APPLICATION_STATUS
		do
			status := Application.status;
			if status /= Void then
				if argument /= kill_it then
					if not status.is_stopped then
							-- Ask the application to interrupt ASAP.
						debug_window.clear_window;
						debug_window.put_string ("System is running%N");
						debug_window.put_string ("Interruption request%N");
						debug_window.display;
						Application.interrupt
					end
				else
					Application.kill;
				end;
			end;
		end;

feature -- Output

	termination_processing is
			-- Print the termination message to the debug_window
			-- and reset the object windows.
		do
			debug_window.clear_window;
			debug_window.put_string ("System terminated%N");
			debug_window.display;
			window_manager.object_win_mgr.reset
			if Application.status.e_feature /= Void then
				Application.status.set_is_stopped (False);
				-- *** FIXME
				-- To be fixed: remove above instruction
				-- and have extra routine named `remove_stoppoint'
				Window_manager.routine_win_mgr.show_stoppoint
						(Application.status.e_feature, Application.status.break_index)
			end
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
