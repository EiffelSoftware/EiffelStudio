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
					hide_stopped_mark;
					request.send;
				else
					!! kill_request.make (Rqst_kill);
					kill_request.send
				end;
			end;
		end;

	hide_stopped_mark is
			-- Remove the stopped mark in the routine tools containing the 
			-- related routine and set with the `show_breakpoints' format.
		local
			 rout_wnds: LINKED_LIST [ROUTINE_W];
			 rout_text: ROUTINE_TEXT
		do
			from
				rout_wnds := window_manager.routine_win_mgr.active_editors;
				rout_wnds.start
			until
				rout_wnds.after
			loop
				rout_text := rout_wnds.item.text_window;
				if
					rout_text.root_stone.feature_i.body_id = Run_info.feature_i.body_id
					and rout_text.in_debug_format
				then
					rout_text.redisplay_breakable_mark (Run_info.break_index, False)
				end;
				rout_wnds.forth
			end
		end; -- hide_stopped_mark
	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Debug_quit 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Debug_quit end;

	request: EWB_REQUEST;

end
